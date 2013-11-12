# Idea:

# track the bat from the upper left corner.  All other points are calculated from that point * the rotate angle

class Bat
  attr_reader :rotate_angle

  WIDTH = 16
  HEIGHT = 100
  EDGE_SIZE = 50


  def initialize(window, space)
    @window = window
    @rotate_angle = 90
    @static_body = CP::BodyStatic.new

    mass = 10.0

    inertia = CP.moment_for_poly(mass, vertices, CP::ZERO_VEC_2)
    @body = CP::Body.new(mass, inertia)
    @body.p = CP::Vec2.new(Baseball::WIDTH / 2 - 40, Baseball::HEIGHT - HEIGHT)

    # This put the pivot at the very top middle of the bat
    pivot_location = @body.p + CP::Vec2.new(0, ( - HEIGHT / 2))

    pj = CP::PivotJoint.new @body, @static_body, pivot_location

    @shape = CP::Shape::Poly.new(@body, vertices, CP::ZERO_VEC_2)

    @image = polygon_image(vertices)
    @shape.collision_type = :bat

    space.add_constraint(pj)
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
    - WIDTH / 2
  end

  def y1
    - HEIGHT / 2
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

  def swing!
    return if moving?

    # Apply 100 force the left to 100 pixels past end of the bat
    @body.apply_impulse(CP::Vec2.new(-100, 0), CP::Vec2.new(0, - HEIGHT - 100))
  end

  # @body.v = velocity
  def moving?
    @body.v.x != 0 || @body.v.y != 0
  end
end
