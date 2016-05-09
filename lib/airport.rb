require 'weather'

class Airport
  DEFAULT_CAPACITY = 25

  attr_accessor :capacity

  def initialize(weather, capacity = DEFAULT_CAPACITY)
    @weather = weather
    @capacity = capacity
    @planes = []
  end

  def land(plane)
    raise 'Plane cannot land. Airport is full!' if full?
    raise 'Plane cannot land. Weather is stormy!' if stormy?
    @planes << plane
  end

  def take_off(plane)
    raise 'Plane cannot take off. Weather is stormy!' if stormy?
    raise 'Plane cannot take off. Wrong airport!' unless wrong_airport?(plane)
    @planes.delete(plane)
  end

  private

  def full?
    @planes.length >= capacity
  end

  def stormy?
    @weather.stormy?
  end

  def wrong_airport?(plane)
    @planes.include?(plane)
  end
end
