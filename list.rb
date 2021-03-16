require_relative "item"

class List

  attr_accessor :label

  def initialize(label)
    @label = label
    @items = []
  end

  def add_item(title, deadline, description = "")
    if Item.valid_date?(deadline)
      @items << Item.new(title, deadline, description)
      return true
    end
    false
  end

  def size
    @items.size
  end

  def valid_index?(index)
    if index < 0
      return false
    elsif index >= @items.size
      return false
    end
    true
  end

  def swap(index_1, index_2)
    if !(valid_index?(index_1) && valid_index?(index_2))
      return false
    end
    @items[index_1], @items[index_2] = @items[index_2], @items[index_1]
    true
  end

  def [](index)
    if !valid_index?(index)
      return nil
    end
    @items[index]
  end

  def priority
    @items[0]
  end

  def printer
    n = 50
    n.times { |i| print "-" }
    puts
    puts @label.center(n)
    n.times { |i| print "-" }
    puts
    puts "Index".ljust(6) + "| " + "Item".ljust(20) + "| " + "Deadline".ljust(12) + "| " + "Done?".ljust(6)
    n.times { |i| print "-" }
    puts
    @items.each_with_index do |item, idx|
      completed_sym = " "
      if item.done == true
        completed_sym = "\u2713"
      end
      puts "#{idx}".ljust(6) + "| " + "#{item.title}".ljust(20) + "| " + "#{item.deadline}".ljust(12) + "| " + "[#{completed_sym}]".ljust(6)
    end
    nil
  end

  def print_full_item(index)
    n = 50
    completed_sym = " "
    if @items[index].done == true
      completed_sym = "\u2713"
    end
    n.times { |i| print "-" }
    puts
    puts "#{@items[index].title}".ljust(30) + "#{@items[index].deadline}" + "[#{completed_sym}]".rjust(10)
    puts "#{@items[index].description}".ljust(42)
    n.times { |i| print "-" }
    puts
  end

  def print_priority
    self.print_full_item(0)
  end

  def up(index, amount = 1)
    if !valid_index?(index)
      return false
    end
    if index == 0 || amount == 0
      return true
    else
      swap(index, index - 1)
      up(index - 1, amount - 1)
    end
    true
  end

  def down(index, amount = 1)
    if !valid_index?(index)
      return false
    end
    if index == @items.size || amount == 0
      return true
    else
      swap(index, index + 1)
      down(index + 1, amount - 1)
    end
    true
  end

  def sort_by_date!
    @items.sort_by! { |item| item.deadline }
  end

  def toggle_item(index)
    @items[index].toggle
  end

  def remove_item(index)
    if !valid_index?(index)
      return false
    end
    @items.delete_at(index)
    true
  end

  def purge
    completed_indices = []
    idx = 0
    while idx < size
      if @items[idx].done
        remove_item(idx)
      else
        idx += 1
      end  
    end
    
    # @items.each_with_index do |item, idx|
    #   if item.done
    #     remove_item(idx)
    #   end
    # end
  end

end