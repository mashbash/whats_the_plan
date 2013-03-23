require 'spec_helper'

describe "Plan Page" do #, :js => true do

  subject { page }

  describe  "visit individual plan page from root path" do

    let!(:plan) { create(:plan_with_activities) }
    before do
      visit root_path  
    end

    it { should have_selector('h2', text: "Recently Added Plans") }

    describe "should go the correct plans page" do
      before { click_link plan.title }

      it { should have_selector('h1', text: plan.title) }
      it { should have_selector(".plan-activities li:nth-child(1)", id: "activity position 1") }
      it { should have_selector(".plan-activities li:nth-child(2)", id: "activity position 2") }
      it { should have_selector(".plan-activities li:nth-child(3)", id: "activity position 3") }
      it { should have_selector(".plan-activities li:nth-child(4)", id: "activity position 4") }
      it { should_not have_selector(".plan-activities li:nth-child(5)") }
    end
  end
end
