require 'spec_helper'
  
describe Plan do

  it { should respond_to(:sequenced)}
  it { should respond_to(:start_date)}
  it { should respond_to(:end_date)}
  it { should respond_to(:title)}

  describe "#valid?" do
    it { should validate_presence_of(:title) }

    describe 'start_date and end_date values' do
      let(:plan) { create(:plan_with_activities, :start_date => nil, :end_date => nil) }

      it 'sets default start_date and end_date to today and tomorrow if none are provided' do
        plan.start_date.should eq Date.today
        plan.end_date.should eq Date.tomorrow
      end
    end
  end  

  describe "associations" do
    it { should belong_to(:user) }
    it { should have_many(:activity_plans) }
    it { should have_many(:activities).through(:activity_plans) }
  end

  describe "start date cannot be later than end_date" do
    let(:plan) { FactoryGirl.build(:plan, :end_date => 1.year.ago, :start_date => 1.day.ago) }

    it "start_date cannot be later than end_date" do
      plan.save
      plan.should have(1).errors_on(:start_date)
    end  
  end

  context '#best_route' do
    let(:plan) { create(:plan_with_activities) }
    let(:plan_worker) { PlanWorker.new}

    it { should respond_to(:best_route) }

    it 'returns an array of activities' do
      plan_worker.perform(plan.id)
      plan.reload
      plan.best_route.should be_an(Array)
    end

    it 'returns a four element array' do
      plan_worker.perform(plan.id)
      plan.reload
      plan.best_route.length.should eq(4)
    end

    context 'meals and non-meals' do
      let(:plan) { create(:plan_with_activities) }

      it 'all elements are Activities' do
        plan_worker.perform(plan.id)
        plan.reload
        # plan.best_route.should be_all { |e| e.is_an? Activity }
        plan.best_route.all? { |e| e.is_a?(Activity) }.should be_true
      end
    end

    context 'all meals' do
      let(:plan) { create(:plan_with_all_meals) }
      it 'elements are nil then activity' do
        plan_worker.perform(plan.id)
        plan.reload
        plan.best_route.map {|element| element.class}.
          should eq([NilClass, Activity, NilClass, Activity])
      end
    end

    context 'no meals' do
      let(:plan) { create(:plan_with_no_meals) }
      it 'elements are activity then nil' do
        plan_worker.perform(plan.id)
        plan.reload
        plan.best_route.map {|element| element.class}.
          should eq([Activity, NilClass, Activity, NilClass])
      end
    end

    context 'plan worker' do 
      let(:plan) { create(:plan_with_activities) }

      it 'sets sequence to true when finished' do
        plan.sequenced.should be_false
        plan_worker.perform(plan.id)
        plan.reload
        plan.sequenced.should be_true
      end
    end
  end
end
