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
    it { should validate_presence_of(:meal) }
    it { should validate_presence_of(:latitude) }
    it { should validate_presence_of(:longitude) }
  end

  describe "associations" do
    it { should have_many(:activity_plans) }
    it { should have_many(:plans).through(:activity_plans) }
  end

  context "before save callbacks" do
    let(:activity) { build(:activity, :city => "undefined",
                           :state => "undefined", :title => "undefined") }

    it "undefined attributes are not saved to the database" do
      expect {
        activity.save
      }.to change(activity, :title).from("undefined").to("")

      expect {
        activity.save
      }.to_not change(activity, :latitude)

      expect {
        activity.save
      }.to_not change(activity, :longitude)
    end
  end
end
