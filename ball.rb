class Ball
  attr_reader :x, :y, :angle, :speed

  SIZE = 15

  def initialize
    @x = Baseball::WIDTH / 2
    @y = 30

    @angle = 180
    @speed = 6
  end

  def draw(window)
    color = Gosu::Color::WHITE

    window.draw_quad(
      x1, y1, color,
      x1, y2, color,
      x2, y2, color,
      x2, y1, color
    )
  end

  def dx; Gosu.offset_x(angle, speed); end
  def dy; Gosu.offset_y(angle, speed); end

  def move!
    @x += dx
    @y += dy
  end

  def intersect?(surface)
    x1 < surface.x2 &&
      x2 > surface.x1 &&
      y1 < surface.y2 &&
      y2 > (surface.y1 - 90)
  end

  def bounce_off!(surface)
    surface_angle = surface.rotate_angle

    @angle = @angle - (surface_angle * 2)
  end

  def x1
    @x - SIZE / 2
  end

  def x2
    @x + SIZE / 2
  end

  def y1
    @y - SIZE / 2
  end

  def y2
    @y + SIZE / 2
  end
end