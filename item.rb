class Item

  attr_reader :title, :deadline, :description, :done
  attr_writer :title, :description

  def initialize(title, deadline, description)
    if !Item.valid_date?(deadline)
      raise RuntimeError, "deadline is not valid"
    end

    @title = title
    @deadline = deadline
    @description = description
    @done = false
  end

  def self.valid_date?(date_str)
    date_arr = date_str.split("-").map { |ele| ele.to_i }
    if date_arr[1] < 1 || date_arr[1] > 12
        return false
    elsif date_arr[2] < 1 || date_arr[2] > 31
        return false
    end
    true
  end

  def deadline=(new_deadline)
    if Item.valid_date?(new_deadline)
      @deadline = new_deadline
    else
      raise RuntimeError, "deadline is not valid"
    end
  end

  def toggle
    @done = !@done
  end

end