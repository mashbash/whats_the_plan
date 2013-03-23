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
      it { should have_selector('.activity', text: plan.activities.first.title) }
      it { should have_selector('.activity', text: plan.activities.last.title) }
    end
  end
end
