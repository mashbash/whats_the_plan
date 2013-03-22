require 'spec_helper'

describe Activity do

  describe "#valid?" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:street) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip_code) }
    it { should validate_presence_of(:country) }
    it { should validate_presence_of(:longitude) }
    it { should validate_presence_of(:latitude) }
    it { should validate_presence_of(:meal) }
  end

  describe "associations" do
    it { should have_many(:activity_plans) }
    it { should have_many(:plans).through(:activity_plans) }
  end


end

#latitude and longitude should be float numbers
