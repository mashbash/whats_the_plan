require 'spec_helper'

describe User do
  describe "#valid?" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_format_of(:email) }
    it { should_not allow_value("blah").for(:email) }
    it { should allow_value("jim@gmail.com").for(:email) }
    it { should_not allow_value("123").for(:password) }
    it { should allow_value("123abc345").for(:password) }
    
    context 'when a user already exists' do
      it { should validate_uniqueness_of(:email)}
    end
  end

  describe "associations" do
    it { should have_many(:plans).dependent(:destroy) }
  end

  describe "#valid_password?" do
    let(:user) { create(:user) }
    # user = (:user)

    it 'logs in with the correct password' do
      user.valid_password?("password").should be_true
    end

    it 'can not log in with the incorrect password' do
      user.valid_password?("blabla").should be_false
    end
  end
end


