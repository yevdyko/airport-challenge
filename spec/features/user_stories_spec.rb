describe 'User stories' do
  let(:airport) { Airport.new(weather, 25) }
  let(:plane) { Plane.new }
  let(:weather) { Weather.new }

  context 'when not stormy' do
    before do
      allow(weather).to receive(:stormy?).and_return false
    end

    # As an air traffic controller
    # So planes can land safely at my airport
    # I would like to instruct a plane to land
    it 'so planes land at airport, instruct a plane to land' do
      expect { airport.land(plane) }.not_to raise_error
    end

    # As an air traffic controller
    # So planes can take off safely from my airport
    # I would like to instruct a plane to take off
    it 'so planes take off from airport, instruct a plane to take off' do
      airport.land(plane)
      expect { airport.take_off(plane) }.not_to raise_error
    end

    # As an air traffic controller
    # So that I can ensure safe take off procedures
    # I want planes only to take off from the airport they are at
    it 'takes off plane from the airport they are not' do
      other_airport = Airport.new(weather, 25)
      other_airport.land(plane)
      expect { airport.take_off(plane) }.to raise_error 'Plane cannot take off. Wrong airport!'
    end

    # As the system designer
    # So that the software can be used for many different airports
    # I would like a default airport capacity that can be overridden as appropriate
    it 'airport has a default capacity' do
      default_airport = Airport.new(weather)
      Airport::DEFAULT_CAPACITY.times do
        other_plane = Plane.new
        default_airport.land(other_plane)
      end
      expect { default_airport.land(plane) }.to raise_error 'Plane cannot land. Airport is full!'
    end

    # As an air traffic controller
    # So the system is consistent and correctly reports plane status and location
    # I want to ensure a flying plane cannot take off and cannot be in an airport
    it 'flying plane cannot take off' do
      expect { plane.take_off }.to raise_error 'Plane cannot take off. Plane already flying!'
    end

    it 'flying plane cannot be in an airport' do
      expect { plane.airport }.to raise_error 'Plane cannot be at an airport. Plane already flying!'
    end

    # As an air traffic controller
    # So the system is consistent and correctly reports plane status and location
    # I want to ensure a plane that is not flying cannot land and must be in an airport
    it 'non-flying plane cannot land' do
      airport.land(plane)
      expect { plane.land(airport) }.to raise_error 'Plane cannot land. Plane already landed!'
    end

    it 'non-flying plane must be in an airport' do
      airport.land(plane)
      expect(plane.airport).to eq airport
    end

    # As an air traffic controller
    # So the system is consistent and correctly reports plane status and location
    # I want to ensure a plane that has taken off from an airport is no longer in that airport
    it 'taking off a plane removes it from that airport' do
      airport.land(plane)
      airport.take_off(plane)
      expect(airport.planes).not_to include plane
    end

    # As an air traffic controller
    # So that I can avoid collisions
    # I want to prevent airplanes landing when my airport if full
    context 'when airport is full' do
      it 'does not allow planes to land' do
        25.times do
          other_plane = Plane.new
          airport.land(other_plane)
        end
        expect { airport.land(plane) }.to raise_error 'Plane cannot land. Airport is full!'
      end
    end
  end

  # As an air traffic controller
  # So that I can avoid accidents
  # I want to prevent airplanes landing or taking off when the weather is stormy
  context 'when weather is stormy' do
    before do
      allow(weather).to receive(:stormy?).and_return true
    end

    it 'does not allow planes to land' do
      expect { airport.land(plane) }.to raise_error 'Plane cannot land. Weather is stormy!'
    end

    it 'does not allow planes to take_off' do
      expect { airport.take_off(plane) }.to raise_error 'Plane cannot take off. Weather is stormy!'
    end
  end
end
