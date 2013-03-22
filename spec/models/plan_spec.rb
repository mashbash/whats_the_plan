#attributes - validations
##test that user_id is not blank
##test that user_id is an actual user_id
##title cannot be blank
#location cannot be blank if there are activities
#start_date cannot be later than end date
#end_date cannot be earlier than start_date

#association
#test that it has many activities through activity_plans
#test that it belongs to user
require 'spec_helper'
require 'user'
  
describe Plan do

  let(:user) { create(:user) }

  subject { Plan.create :title => "asd", :user_id => user.id+1,
            :start_date  => Time.now, :end_date => 1.day.ago }  # BugBug Why can't we use let

  describe "#valid?" do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:title) }
  end  

  describe "the user_id should belong to an actual user" do

    let(:plan) { create(:plan, :user_id => user.id+1) }
    it "should state that user is invalid" do
      expect {
        User.find(plan.user_id)
      }.to raise_error
    end  

    let(:plan) { create(:plan, :user_id => nil) }
    it "should raise an error if plan.user_id is nil" do
      expect {
        plan.save
        }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe "start date cannot be later than end_date" do
    let(:plan) { create(:plan, :start_date => DateTime.now, :end_date => 1.day.ago, :user_id => user.id, :title => "blabla") }
    it "start_date cannot be later than end_date" do
      expect {
        plan.save
        }.to raise_error
    end  
  end
end



