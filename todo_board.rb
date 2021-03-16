require_relative "list"
require_relative "item"

class TodoBoard

  def initialize(label)
    @board = { }
  end

  def get_command
    print "\nEnter a command: "
    cmd, *args = gets.chomp.split(" ")

    case cmd
    when 'mklist'
        @board[*args] = List.new(*args)
    when 'ls'
        @board.each_key { |label| puts label }
        nil
    when 'showall'
        @board.each_value { |list| list.printer }
        nil
    when 'mktodo'
        @board[args[0]].add_item(*args[1..-1])
    when 'toggle'
        @board[args[0]].toggle_item(args[1].to_i)
    when 'rm'
        @board[args[0]].remove_item(args[1].to_i)
    when 'purge'
        @board[*args].purge
    when 'up'
        @board[args[0]].up(*args[1..-1].map { |ele| ele.to_i })
    when 'down'
        @board[args[0]].down(*args[1..-1].map { |ele| ele.to_i })
    when 'swap'
        @board[args[0]].swap(*args[1..-1].map { |ele| ele.to_i })
    when 'sort'
        @board[*args].sort_by_date!
    when 'priority'
        @board[*args].print_priority
    when 'print'
        if args[1] != nil
          @board[args[0]].print_full_item(args[1].to_i)
        else
          @board[args[0]].printer
        end
    when 'quit'
        return false
    else
        print "Sorry, that command is not recognized."
    end

    true
  end

  def run
    status = true
    while status == true
      status = get_command
    end
  end

end

my_board = TodoBoard.new("Nat's Board")
my_board.run