require 'airport'

describe Airport do
  subject(:airport) { described_class.new(weather, 25) }
  let(:plane) { double :plane, land: nil, take_off: nil }
  let(:weather) { double :weather }

  describe '#land' do
    context 'when not stormy' do
      before do
        allow(weather).to receive(:stormy?).and_return false
      end

      it 'lands a plane' do
        expect(plane).to receive(:land)
        airport.land(plane)
      end

      context 'when full' do
        it 'raises an error' do
          described_class::DEFAULT_CAPACITY.times { airport.land(plane) }
          expect { airport.land(plane) }.to raise_error 'Plane cannot land. Airport is full!'
        end
      end
    end

    context 'when stormy' do
      it 'raises an error' do
        allow(weather).to receive(:stormy?).and_return true
        expect { airport.land(plane) }.to raise_error 'Plane cannot land. Weather is stormy!'
      end
    end
  end

  describe '#take_off' do
    context 'when not stormy' do
      before do
        allow(weather).to receive(:stormy?).and_return false
      end

      it 'takes off a plane' do
        airport.land(plane)
        expect(plane).to receive(:take_off)
        airport.take_off(plane)
      end

      it 'returns the plane that took off' do
        airport.land(plane)
        expect(airport.take_off(plane)).to eq plane
      end

      it 'raises an error when a plane tries to take off from another airport' do
        other_airport = described_class.new(weather, 25)
        other_airport.land(plane)
        expect { airport.take_off(plane) }.to raise_error 'Plane cannot take off. Wrong airport!'
      end
    end

    context 'when stormy' do
      before do
        allow(weather).to receive(:stormy?).and_return true
      end

      it 'raises an error' do
        expect { airport.take_off(plane) }.to raise_error 'Plane cannot take off. Weather is stormy!'
      end
    end
  end

  describe '#planes' do
    before do
      allow(weather).to receive(:stormy?).and_return false
    end

    it 'returns planes at the aitrport' do
      airport.land(plane)
      expect(airport.planes).to include plane
    end

    it 'does not return planes that have taken off' do
      airport.land(plane)
      airport.take_off(plane)
      expect(airport.planes).not_to include plane
    end
  end

  context 'defaults' do
    subject(:default_airport) { described_class.new(weather) }

    it 'has a default capacity' do
      allow(weather).to receive(:stormy?).and_return false
      described_class::DEFAULT_CAPACITY.times { default_airport.land(plane) }
      expect { default_airport.land(plane) }.to raise_error 'Plane cannot land. Airport is full!'
    end
  end
end
