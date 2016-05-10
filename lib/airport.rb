require_relative 'weather'

class Airport
  DEFAULT_CAPACITY = 25
  attr_reader :planes

  def initialize(weather, capacity = DEFAULT_CAPACITY)
    @weather = weather
    @capacity = capacity
    @planes = []
  end

  def land(plane)
    raise 'Plane cannot land. Airport is full!' if full?
    raise 'Plane cannot land. Weather is stormy!' if stormy?
    plane.land(self)
    add_plane(plane)
  end

  def take_off(plane)
    raise 'Plane cannot take off. Weather is stormy!' if stormy?
    raise 'Plane cannot take off. Wrong airport!' unless wrong_airport?(plane)
    plane.take_off
    remove_plane(plane)
    plane
  end

  private

  attr_reader :capacity, :weather

  def full?
    planes.length >= capacity
  end

  def stormy?
    weather.stormy?
  end

  def wrong_airport?(plane)
    planes.include?(plane)
  end

  def add_plane(plane)
    planes << plane
  end

  def remove_plane(plane)
    planes.delete(plane)
  end
end
