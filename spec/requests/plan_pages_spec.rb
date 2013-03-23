require 'spec_helper'

describe "Plan Page" do

  subject { page }

  describe  "visit individual plan page from root path" do
    let(:plan) { create(:plan) } 
    before do
      visit root_path  
    end

    it "should go the correct plans page" do
      click_link plan.title
      it { should have_selector('h1', text: plan.title) }
      it { should have_selector('.activity', text:plan.activities.first.title) }
    end
  end
end
