describe 'User stories' do
  let(:airport) { Airport.new(25, weather) }
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
      expect { airport.take_off(plane) }.not_to raise_error
    end

    # As an air traffic controller
    # So that I can avoid collisions
    # I want to prevent airplanes landing when my airport if full
    context 'when airport is full' do
      it 'does not allow planes to land' do
        25.times do
          airport.land(plane)
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
