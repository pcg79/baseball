# Idea:

# track the bat from the upper left corner.  All other points are calculated from that point * the rotate angle

class Bat
  attr_reader :x, :y, :rotate_angle

  WIDTH = 100
  HEIGHT = 16
  EDGE_SIZE = 50


  def initialize(window, space)
    @window = window
    @x = 0
    @y = 0
    @rotate_angle = 90

    mass = 10.0

    inertia = CP.moment_for_poly(mass, vertices, CP.vzero)
    @body = CP::Body.new(mass, inertia)
    @body.p = CP::Vec2.new(Baseball::WIDTH / 2, Baseball::HEIGHT - (HEIGHT * 2))

    @shape = CP::Shape::Poly.new(@body, vertices, CP.vzero)

    # @shape.body.apply_impulse(CP::Vec2.new(0, -40), CP::Vec2.new(0, 0))

    @image = polygon_image(vertices)
    @shape.collision_type = :bat

    space.add_body(@body)
    space.add_shape(@shape)
  end

  def draw(window)
    color = Gosu::Color::RED

    @image.draw_rot(@body.pos.x, @body.pos.y, 1, @body.a.radians_to_gosu)
  end

  def upper_left
    [
      x1,
      y1
    ]
  end

  def lower_left
    [
      x1 + Gosu.offset_x(rotate_angle + 90, HEIGHT),
      y1 + Gosu.offset_y(rotate_angle + 90, HEIGHT)
    ]
  end

  def upper_right
    [
      x1 + Gosu.offset_x(rotate_angle, WIDTH),
      y1 + Gosu.offset_y(rotate_angle, WIDTH)
    ]
  end

  def lower_right
    urx, ury = upper_right
    [
      urx + Gosu.offset_x(rotate_angle + 90, HEIGHT),
      ury + Gosu.offset_y(rotate_angle + 90, HEIGHT)
    ]
  end

  def x1
    @x - WIDTH / 2
  end

  def y1
    @y - HEIGHT / 2
  end

  def polygon_image(vertices)
    img = Magick::Image.new(HEIGHT + 1, WIDTH + 1) { self.background_color = 'transparent' }
    gc = Magick::Draw.new
    gc.stroke('red')
    # gc.fill('plum')
    draw_vertices = vertices.map { |v| [v.y + (HEIGHT / 2), v.x + (WIDTH / 2)] }.flatten
    gc.polygon(*draw_vertices)
    gc.draw(img)
    Gosu::Image.new(@window, img, false)
  end

  def vertices
    @vertices ||= [
      CP::Vec2.new(*lower_left),
      CP::Vec2.new(*lower_right),
      CP::Vec2.new(*upper_right),
      CP::Vec2.new(*upper_left)
    ]
  end

  def swinging?
    false
  end
end
