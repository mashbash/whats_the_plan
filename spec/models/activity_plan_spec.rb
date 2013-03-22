require 'spec_helper'

describe ActivityPlan do

  describe "#valid?" do
    it { should validate_presence_of(:sequence) }
    
    let(:activityplan) { create(:activity_plan) }
    it "sequence should be an integer" do
      activityplan.sequence.should be_a(Integer)
    end
  end

  describe "associations" do
    it { should belong_to(:plan) }
    it { should belong_to(:activity) }
  end
end
