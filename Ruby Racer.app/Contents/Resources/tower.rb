class Tower
  attr_reader :board, :brick, :offset, :speed, :coins, :background
  def initialize(window)
    @window = window
    @brick = Gosu::Image.new(@window, "tiles/red.png", true)
    @coins = []
    @background = make_background([], 150)
    @board = make_row([], 400, 0)
    @offset = 0
    @speed = 3
  end

  def update(seconds, frames)
    if seconds % 10 == 0 && seconds > 0 && frames == 0
      @speed += 1
    end
    @offset -= @speed
  end

  def make_row(board, rows, multiplier)
    y = multiplier
    row = 1
    rows.times do |j|
      num = (rand(14) + 1) * @brick.width
      x = 0
      if row % 2 == 0
        17.times do
          board << Tile.new(@window, x, y) unless (x == num || x == num + @brick.width)
          x += @brick.width
        end
        if row % 4 == 0 && j >= 8
          num1 = (rand(15) + 1)
          while num1 == num / @brick.width || num1 == num / @brick.width + 1
            num1 = (rand(15) + 1)
          end
          @coins << Coin.new(@window, num1 * @brick.width + 8, y - @brick.height + 8)
          end
        y += @brick.height
      else
        2.times do
          board << Tile.new(@window, 0, y)
          board << Tile.new(@window, @window.width - @brick.width, y)
          y += @brick.height
        end
      end
      row += 1
    end
    board
  end

  def make_background(array, rows)
    y = 0
    rows.times do |i|
      array << Background.new(@window, y)
      y += 622
    end
    array
  end
end
