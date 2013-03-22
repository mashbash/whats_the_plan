describe Route do
  before do
    @los_angeles     = FakeLocation.new 34.080185,        -118.4692524, 0
    @san_francisco_m = FakeLocation.new 37.7935572,       -122.4218255, 1
    @seattle_m       = FakeLocation.new 47.6218387802915, -122.3482996197085, 1 
    @vancouver       = FakeLocation.new 49.2776215,       -123.1061451, 0
    @austin          = FakeLocation.new 30.2760276802915, -97.73898386970849, 0
    @boulder_m       = FakeLocation.new 39.9128860000000, -105.6943651, 1
    @newark          = FakeLocation.new 39.669686,        -75.753513, 0
    @washington_dc_m = FakeLocation.new 38.8807776,       -77.05124459999999, 1
  end

  let(:route) { Route.new [@los_angeles, @san_francisco_m, @vancouver, @seattle_m]}

  it { route.should respond_to(:dest_count) }
  it { route.should respond_to(:total_distance) }

  context '.new' do
    it 'takes an array' do
      expect {
        Route.new
      }.to raise_error(ArgumentError)

      expect {
        Route.new(@los_angeles, @san_francisco_m)
      }.to raise_error(ArgumentError)

      expect {
        Route.new([])
      }.to raise_error(ArgumentError)
    end
  end

  context '#dest_count' do 
    it 'returns the number of destinations' do
      route.dest_count.should eq(4)
    end

    it 'does not count nil destiantions' do
      route = Route.new [@boulder_m, nil, @san_francisco_m, nil]
      route.dest_count.should eq(2)
    end
  end

  context '#total_distance' do
    it 'will be a float' do
      route.total_distance.should be_a(Float)
    end

    it 'returns the sum of the distances between destinations' do
      route.total_distance.should be_between(1000, 1500)
    end

    it 'returns the distance with nil destinations' do
      route = Route.new [@boulder_m, nil, @san_francisco_m, nil]
      route.total_distance.should be_a(Float)
    end
  end

  context '#preferred' do
    it 'requires a route as an argument' do
      expect {
        route.preferred "pants"
      }.to raise_error(ArgumentError)
    end

    it 'prioritizes total destinations over distance' do
      other_route = Route.new [@los_angeles, nil, @san_francisco_m, nil]
      (route.preferred other_route).should eq route
    end

    it 'returns the route with the shortest distance' do
      other_route = Route.new [@los_angeles, @boulder_m, @vancouver, @san_francisco_m]
      (route.preferred other_route).should eq route
    end
  end
end
