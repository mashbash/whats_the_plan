class InvalidAddressError < StandardError
end

class NoStreetError < StandardError
end

class Location
  attr_reader :street, :city, :country, :zip_code, :state, :longitude, :latitude
  def initialize(address)
    @street    = address[:street] 
    @city      = address[:city]
    @country   = address[:country]
    @zip_code  = address[:zip_code]
    @state     = address[:state]

    raise NoStreetError unless @street
    geocode
  end

  private
  def address_string
    "#{street}, #{city}, #{state} #{zip_code} #{country}"
  end

  def geocode
    api_details = Geocoder.search(address_string).first 
    raise InvalidAddressError if api_details.nil?

    @latitude  = api_details.data["geometry"]["location"]["lat"]
    @longitude = api_details.data["geometry"]["location"]["lng"]
  end
end

class FakeLocation 
  attr_reader :meal

  def initialize(latitude, longitude, meal)
    @latitude  = latitude
    @longitude = longitude
    @meal      = meal
  end

  def to_coordinates
    [@latitude, @longitude]
  end
end


describe Location do
  let(:address) {  {:street => "717 California St.", 
                    :city =>  "San Francisco", 
                    :country => "USA", 
                    :zip_code => "94108", 
                    :state => "CA"}  }
  let(:location) { Location.new(address) }
 
  context '.new' do
    it { location.should be_a(Location) }
    it { location.should respond_to(:street) }
    it { location.should respond_to(:city) }
    it { location.should respond_to(:country) }
    it { location.should respond_to(:zip_code) }
    it { location.should respond_to(:state) }
    it { location.should respond_to(:longitude) }
    it { location.should respond_to(:latitude) }

    context 'arguments' do
      it 'accepts one argument hash' do  
        expect {
          Location.new
        }.to raise_error(ArgumentError)
      end

      let(:invalid_address) {  { :city =>  "San Francisco", 
                                 :country => "USA", 
                                 :zip_code => "94108", 
                                 :state => "CA"}  }

      it 'must have a street' do
        expect {
          Location.new(invalid_address)
        }.to raise_error(NoStreetError)
      end
    end

    context 'invalid address' do
      let(:address) {  {:street => ""}}
      it "raises an invalid addres error" do
        expect { 
          Location.new(address)
        }.to raise_error(InvalidAddressError)
      end
    end

    context 'longitude and latitude should be calculated' do
      it { location.longitude.should_not be_nil }
      it { location.latitude.should_not be_nil }
    end
  end

end
