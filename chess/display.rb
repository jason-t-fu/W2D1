require 'colorize'
require_relative 'board'
require_relative 'cursor'

class Display

    attr_reader :board, :cursor
    def initialize(board)
        @board = board
        @cursor = Cursor.new([0, 0], board)
    end

    def render 
        puts "|-|-|-|-|-|-|-|-|"
        board.rows.each_with_index do |row, x|
            row_values = row.map { |el| el.value }
            # puts "|#{row_values.join('|')}|"
            print "|"
            row_values.each_with_index do |piece_val, y|
                if [x,y] == cursor.cursor_pos
                    print piece_val.colorize(:background => :yellow)
                else
                    print piece_val 
                end
                print "|"
            end
            puts
        end
        puts "|-|-|-|-|-|-|-|-|"
    end

    def test_move
        while true
            render 
            cursor.get_input
        end
    end
end