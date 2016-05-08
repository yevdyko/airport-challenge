class Airport
  DEFAULT_CAPACITY = 25

  attr_accessor :capacity

  def initialize(capacity=DEFAULT_CAPACITY)
    @planes = []
    @capacity = capacity
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
    rand(0..100) > 95
  end

  def wrong_airport?(plane)
    @planes.include?(plane)
  end
end
