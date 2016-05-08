require 'airport'

describe Airport do
  subject(:airport) { described_class.new(25) }
  let(:plane) { double :plane }

  describe '#initialization' do
    it 'has a default capacity' do
      expect(airport.capacity).to eq described_class::DEFAULT_CAPACITY
    end

    it 'has a variable capacity when specified' do
      airport = Airport.new(25)
      expect(airport.capacity).to eq 25
    end
  end

  describe '#land' do
    context 'when not stormy' do
      before do
        allow(airport).to receive(:stormy?).and_return false
      end

      it 'lands a plane' do
        expect(airport).to respond_to(:land).with(1).argument
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
        allow(airport).to receive(:stormy?).and_return true
        expect { airport.land(plane) }.to raise_error 'Plane cannot land. Weather is stormy!'
      end
    end
  end

  describe '#take_off' do
    context 'when not stormy' do
      before do
        allow(airport).to receive(:stormy?).and_return false
      end

      it 'takes off a plane' do
        expect(airport).to respond_to(:take_off).with(1).argument
      end

      it 'raises an error when a plane tries to take off from another airport' do
        expect { airport.take_off(plane) }.to raise_error 'Plane cannot take off. Wrong airport!'
      end
    end

    context 'when stormy' do
      before do
        allow(airport).to receive(:stormy?).and_return true
      end

      it 'raises an error' do
        expect { airport.take_off(plane) }.to raise_error 'Plane cannot take off. Weather is stormy!'
      end
    end
  end
end
