class Timer
  attr_accessor :seconds, :time_string, :padded

  def initialize
    @seconds = 0
  end

  def time_string
    hours = @seconds / 3600
    minutes = (@seconds % 3600) / 60
    seconds = @seconds % 60

    return padded(hours) + ":" + padded(minutes) + ":" + padded(seconds)
   end

  def padded(n)
    if n < 10
      return "0" + n.to_s
    else
      return n.to_s
    end
  end
end
