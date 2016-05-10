class Plane
  def initialize
    @flying = true
  end

  def land(airport)
    raise 'Plane cannot land. Plane already landed!' unless @flying
    @flying = false
    @airport = airport
  end

  def take_off
    raise 'Plane cannot take off. Plane already flying!' if @flying
  end

  def airport
    raise 'Plane cannot be at an airport. Plane already flying!' if @flying
    @airport
  end
end
