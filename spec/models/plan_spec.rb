require 'spec_helper'
  
describe Plan do
  describe "#valid?" do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
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

      it 'elements are either nil or Activities' do
        plan.best_route.should eq 1
      end
    end

    context 'all meals' do
      let(:plan) { create(:plan_with_all_meals) }
      it 'elements are either nil or Activities' do
        plan.best_route.should eq 1
      end
    end

    context 'no meals' do
      let(:plan) { create(:plan_with_no_meals) }
      it 'elements are either nil or Activities' do
        plan.best_route.should eq 1
      end
    end

  end

end
