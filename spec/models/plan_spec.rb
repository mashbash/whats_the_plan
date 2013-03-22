require 'spec_helper'
require 'user'
  
describe Plan do
  describe "#valid?" do
    it { should validate_presence_of(:user_id) }
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
end
