require 'spec_helper'

describe Activity do

  let(:params) {  { :title    => "Coit Tower",
                    :street   => "San Francisco",
                    :meal     => 0 } }
  let(:activity) { Activity.new(params) }

  context '.new' do
    it { activity.should respond_to(:street) }
    it { activity.should respond_to(:city) }
    it { activity.should respond_to(:country) }
    it { activity.should respond_to(:zip_code) }
    it { activity.should respond_to(:state) }
    it { activity.should respond_to(:longitude) }
    it { activity.should respond_to(:latitude) }
    it { activity.should respond_to(:title) }
    it { activity.should respond_to(:image_url) }
  end

  describe "#valid?" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:street) }
    it { should validate_presence_of(:meal) }
  end

  describe "associations" do
    it { should have_many(:activity_plans) }
    it { should have_many(:plans).through(:activity_plans) }
  end

  context 'longitude and latitude should be calculated after creation' do
    it 'has nil coordinates before creation' do
      activity.longitude.should be_nil
      activity.latitude.should  be_nil
    end

    it 'has populated coordinates before creation' do
      activity.save
      activity.longitude.should_not be_nil
      activity.latitude.should_not  be_nil
    end
  end

  context 'invalid address' do
    let(:params) {  { :title    => "Study really hard",
                      :street   => "askjdfajk",
                      :meal     => 0 } }
    let(:activity) {Activity.new(params) }
    it "raises an invalid address error" do
      expect {
        activity.save
      }.to raise_error(Exceptions::InvalidAddressError)
    end
  end

  context 'creating populates address details' do
    let(:params) {  { :title    => "Study really hard",
                      :street   => "Coit Tower",
                      :meal     => 0 } }
    let(:activity) {Activity.create(params) }

    it { activity.street.should eq("1 Telegraph Hill Boulevard") }
    it { activity.city.should eq("San Francisco") }
    it { activity.state.should eq("CA") }
    it { activity.zip_code.should eq(94133) }
    it { activity.country.should eq("United States") }
  end

end
