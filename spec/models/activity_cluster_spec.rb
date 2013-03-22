describe ActivityCluster do
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

  let(:activity_cluster) { ActivityCluster.new [@los_angeles, 
                                               @san_francisco_m, 
                                               @seattle_m, 
                                               @vancouver, 
                                               @austin, 
                                               @boulder_m]}

  context ".new" do
    it 'requires an array of destinations' do
      expect {
        ActivityCluster.new
      }.to raise_error(ArgumentError)

      expect {
        ActivityCluster.new(@los_angeles)
      }.to raise_error(ArgumentError)

      expect {
        ActivityCluster.new(@los_angeles, @seattle_m)
      }.to raise_error(ArgumentError)

      expect {
        ActivityCluster.new([])
      }.to raise_error(ArgumentError)
    end
  end

  context "#closest_location" do
    it "returns a location" do
      activity_cluster.closest_location(@los_angeles, [@san_francisco_m, @seattle_m, @vancouver]).
        should be_a(FakeLocation)
    end

    it "knows the nearest location" do
      activity_cluster.
        closest_location(@san_francisco_m, [@los_angeles, @seattle_m, @vancouver]).
        should eq @los_angeles
    end

    it 'returns nil if it receives an empty array' do
      activity_cluster.closest_location(@los_angeles, []).should be_nil
    end

    it 'returns nil if no locations are within max distance' do
      activity_cluster.closest_location(@los_angeles, [@washington_dc_m, @newark]).should be_nil
    end

    it 'does not return locations out of range of max distance' do
      activity_cluster.closest_location(@los_angeles, [@san_francisco_m, @newark]).
        should eq @san_francisco_m
    end
  end

  context '#shortest_route' do
    context 'returns ordered array' do
      it 'returns an array object' do
        activity_cluster.shortest_route(@san_francisco_m).should be_a(Array)
      end

      it 'returns a valid route if no meals are present' do
        activity_cluster =  ActivityCluster.new [@los_angeles, @vancouver, @austin]
        activity_cluster.shortest_route(@los_angeles).length.should eq 4
      end

      it 'alternating meal, non-meal' do
        activity_cluster.shortest_route(@los_angeles).
          map { |destination| destination.meal }.should eq [0, 1, 0, 1]
      end

      it 'of locations ordered by shortest distance start to finish' do
        activity_cluster.shortest_route(@los_angeles).
          should eq [@los_angeles, @san_francisco_m, @vancouver, @seattle_m]
      end

      it 'does not include the starting point twice in the resulting array' do
        shortest_route = activity_cluster.shortest_route(@los_angeles)
        shortest_route.length.should eq(shortest_route.uniq.length)
      end

    end   
  end

  context "#best_cluster_and_route" do
    it 'returns a route' do
      activity_cluster.best_cluster_and_route.should be_a(Route)
    end

    it 'returns the best route out of many possible routes' do
      activity_cluster.best_cluster_and_route.destinations.
        should eq(Route.new([@los_angeles, @san_francisco_m, @vancouver, @seattle_m]).destinations)
    end
  end

end
