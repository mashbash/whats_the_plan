require 'spec_helper'

describe "Plan Page", :js => true do

  subject { page }

  describe  "visit individual plan page from root path" do

    let!(:plan) { create(:plan_with_activities) }
    before do
      # create(:plan_with_activities)
      visit root_path  
    end

    

    it { should have_selector('h2', text: "Recently Added Plans") }

    describe "should go the correct plans page" do
      before { click_link plan.title }

      it { should have_selector('h1', text: plan.title) }
      it { should have_selector(".plan-activities li:nth-child(1)", text: "1") }
      it { should have_selector(".plan-activities li:nth-child(2)", text: "2") }
      it { should have_selector(".plan-activities li:nth-child(3)", text: "3") }
      it { should have_selector(".plan-activities li:nth-child(4)", text: "4") }
      it { should_not have_selector(".plan-activities li:nth-child(5)") }

    end
  end
end
