require 'spec_helper'
  
describe Plan do
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

    it { should respond_to(:best_route) }

    it 'returns an array of activities' do
      plan.best_route.should be_an(Array)
    end

    it 'returns a four element array' do
      plan.best_route.length.should eq(4)
    end

    context 'meals and non-meals' do
      let(:plan) { create(:plan_with_activities) }

      it 'all elements are Activities' do
        plan.best_route.each do |element|
          element.should be_an(Activity)
        end
      end
    end

    context 'all meals' do
      let(:plan) { create(:plan_with_all_meals) }
      it 'elements are nil then activity' do
        plan.best_route.map {|element| element.class}.
          should eq([NilClass, Activity, NilClass, Activity])
      end
    end

    context 'no meals' do
      let(:plan) { create(:plan_with_no_meals) }
      it 'elements are activity then nil' do
        plan.best_route.map {|element| element.class}.
          should eq([Activity, NilClass, Activity, NilClass])
      end
    end
  end
end
