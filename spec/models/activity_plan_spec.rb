require 'spec_helper'

describe ActivityPlan do
  describe "associations" do
    it { should belong_to(:plan) }
    it { should belong_to(:activity) }
  end
end
