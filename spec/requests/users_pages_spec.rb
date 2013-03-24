require 'spec_helper'

describe "Users Pages" do

  subject { page }

  before { visit new_user_registration_path }

  let(:submit) { "Sign up"}

  describe "signup page" do
    it { should have_selector('h1', text:"Sign up") }
  end

  describe "signup with invalid information" do
    it "should not create a user" do
      expect { click_button submit }.not_to change(User, :count)
    end 
  end

  describe "error messages" do
    before { click_button submit }

    it { should have_selector('h1', text:"Sign up") }
    it { should have_content('error') }
  end

  describe "with valid information" do
    before do
      fill_in "Name",                  with: "Example User"
      fill_in "Email",                 with: "user@example.com"
      fill_in "Password",              with: "12345678"
      fill_in "Password confirmation", with: "12345678"
    end

    it "should create a user" do
      expect { click_button submit }.to change(User, :count).by(1)
    end

    describe  "after saving the user" do
      before { click_button submit }

      let(:user) { User.find_by_email('user@example.com') }

      it { should have_selector('h2', text: "Recently Added Plans") }
      it { should have_selector('div.welcome-message',
                                text: "Welcome #{user.name}") }
      it { should have_button('Create new plan') }
      it { should have_link('logout', href: destroy_user_session_path) }

      let(:create_new_plan) { "Create new plan"}

      describe "after clicking the 'Create new plan button'" do
        before { click_button create_new_plan }

        it { should have_selector('h1', text: "Create new plan") }
        it { should have_selector('.new_plan') }
      end
    end
  end
end
