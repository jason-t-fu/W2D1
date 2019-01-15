require 'singleton'
class Board

    attr_reader :rows

    def initialize
        @rows = create_board 
        @sentinel = NullPiece
    end

    def move_piece(start_pos, end_pos)
        raise NoPieceException if self[start_pos].nil?
        raise InvalidMoveException unless self[end_pos].nil? && in_range?(end_pos)

        self[start_pos], self[end_pos] = self[end_pos], self[start_pos]
    end

    def [](pos)
        x, y = pos 
        self.rows[x][y]
    end

    def []=(pos, value)
        x, y = pos 
        self.rows[x][y] = value
    end



    private 
    attr_reader :sentinel

    def in_range?(pos)
        x, y = pos 
        x.between?(0,7) && y.between?(0,7)
    end

    def create_board
        row = Array.new(8) {Array.new(8) {nil} }
        row.length.times do |row_index|
            if row_index < 2 || row_index > 5
                row.length.times do |col_index|
                    row[row_index][col_index] = Piece.new
                end
            end
        end
        row
    end

end

class NoPieceException < StandardError; end 
class InvalidMoveException < StandardError; end

class Piece

end

class NullPiece < Piece
    include Singleton
end