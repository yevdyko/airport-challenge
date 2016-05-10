require 'plane'

describe Plane do
  subject(:plane) { described_class.new }
  let(:airport) { double :airport }

  describe '#land' do
    it 'stores the airport the plane landed at' do
      plane.land(airport)
      expect(plane.airport).to eq airport
    end

    context 'if already landed' do
      it 'raises an error' do
        plane.land(airport)
        expect { plane.land(airport) }.to raise_error 'Plane cannot land. Plane already landed!'
      end
    end
  end

  describe '#take_off' do
    it 'can take off' do
      expect(plane).to respond_to :take_off
    end

    context 'if already flying' do
      it 'raises an error' do
        expect { plane.take_off }.to raise_error 'Plane cannot take off. Plane already flying!'
      end
    end
  end

  describe '#airport' do
    it 'can be at an airport' do
      expect(plane).to respond_to :airport
    end

    context 'if already flying' do
      it 'raises an error' do
        expect { plane.airport }.to raise_error 'Plane cannot be at an airport. Plane already flying!'
      end
    end
  end
end
