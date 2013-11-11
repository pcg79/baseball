require "bundler/setup"
require "hasu"
require 'chipmunk'

class Baseball < Hasu::Window
  Hasu.load "ball.rb"
  Hasu.load "bat.rb"

  WIDTH = 640
  HEIGHT = 480

  SUBSTEPS = 10

  def initialize
    super(WIDTH, HEIGHT, false)

    self.caption = "Baseball"

    setup_space
  end

  def setup_space
    @space = CP::Space.new
    # @space.damping = 0.001
    # @space.gravity = CP::Vec2.new(0.0, 100.0)
    # @space.elastic_iterations = 3

    # @static_body = CP::Body.new((1.0/0.0), (1.0/0.0))

    @dt = (1.0/60.0)
  end

  def reset
    setup_space

    ball_image = Gosu::Image.new(self, "imgs/rsz_baseball_50x50.png", true)
    @ball = Ball.new(@space, ball_image)
    @bat  = Bat.new
  end

  def update
    # if button_down?(Gosu::KbSpace) && !@bat.swinging?
    # end

    SUBSTEPS.times do
      @ball.body.reset_forces
      @space.step(@dt)
    end

    if button_down?(Gosu::KbEscape)
      exit
    end
  end

  def draw
    @ball.draw
    @bat.draw(self)
  end
end

Baseball.run