class Plane
  def take_off
    raise 'Plane cannot take off. Plane already flying!'
  end

  def airport
    raise 'Plane cannot be at an airport. Plane already flying!'
  end
end
