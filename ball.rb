class Ball
  attr_reader :body

  SIZE = 50

  def initialize(space, image)
    mass = 1.0
    inertia = CP.moment_for_circle(mass, 0, SIZE / 2, CP::Vec2.new(0,0))
    @body = CP::Body.new(mass, inertia)
    @shape = CP::Shape::Circle.new(@body, SIZE / 2, CP::Vec2.new(0, 0))

    @shape.body.pos = CP::Vec2.new(Baseball::WIDTH / 2, 30) #position
    @shape.e = 1.0 #elasticity
    @shape.u = 0.1 #friction
    @shape.collision_type = :ball

    # Just a little smack downward to send it moving offset a tiny bit to give it a spin
    @shape.body.apply_impulse(CP::Vec2.new(0, 10), CP::Vec2.new(10, 0))

    @image = image

    space.add_body(@body)
    space.add_shape(@shape)
  end

  def draw
    @image.draw_rot(@body.pos.x, @body.pos.y, 1, @body.a.radians_to_gosu)
  end

end