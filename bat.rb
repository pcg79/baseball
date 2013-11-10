# Idea:

# track the bat from the upper left corner.  All other points are calculated from that point * the rotate angle

class Bat
  attr_reader :x, :y, :rotate_angle

  WIDTH = 100
  HEIGHT = 15

  def initialize
    @x = Baseball::WIDTH / 2
    @y = Baseball::HEIGHT - (HEIGHT * 2)
    @rotate_angle = 90
  end

  def draw(window)
    color = Gosu::Color::RED

    window.draw_quad(
      upper_left[0],  upper_left[1],  Gosu::Color::RED,
      lower_left[0],  lower_left[1],  Gosu::Color::WHITE,
      lower_right[0], lower_right[1], Gosu::Color::BLUE,
      upper_right[0], upper_right[1], Gosu::Color::YELLOW
    )

    @rotate_angle -= 1
  end

  def upper_left
    ul = [
      x1,
      y1
    ]

    # puts "*** ul = #{ul}"
    ul
  end

  def lower_left
    ll = [
      x1 + Gosu.offset_x(rotate_angle + 90, HEIGHT),
      y1 + Gosu.offset_y(rotate_angle + 90, HEIGHT)
    ]

    # puts "*** ll = #{ll}"
    ll
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
    # 100
  end

  def y1
    @y - HEIGHT / 2
    300
  end
end
