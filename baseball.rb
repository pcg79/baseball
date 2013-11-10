require "bundler/setup"
require "hasu"

class Baseball < Hasu::Window
  Hasu.load "ball.rb"
  Hasu.load "bat.rb"

  WIDTH = 640
  HEIGHT = 480

  def initialize
    super(WIDTH, HEIGHT, false)
  end

  def reset
    @ball = Ball.new
    @bat  = Bat.new
  end

  def update
    @ball.move!
    # @bat.move!

    # if button_down?(Gosu::KbSpace) && !@bat.swinging?
    # end

    if button_down?(Gosu::KbEscape)
      exit
    end
  end

  def draw
    @ball.draw(self)
    @bat.draw(self)

    # if @ball.intersect?(@bat)
    #   @ball.bounce_off!(@bat)
    # end
  end
end

Baseball.run