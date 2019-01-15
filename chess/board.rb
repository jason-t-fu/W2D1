require 'singleton'
class Board

    attr_reader :rows

    def initialize
        @rows = create_board 
        @sentinel = NullPiece
    end

    def move_piece(start_pos, end_pos)
        raise NoPieceException if self[start_pos].is_a?(NullPiece)
        raise InvalidMoveException unless self[end_pos].is_a?(NullPiece) && Board.valid_pos?(end_pos)

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

    def self.valid_pos?(pos)
        x, y = pos 
        x.between?(0,7) && y.between?(0,7)
    end

    def create_board
        row = Array.new(8) {Array.new(8) {NullPiece.instance} }
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
    attr_reader :value
    
    def initialize
        @value = "x"
    end
end

class NullPiece < Piece
    include Singleton
    def initialize 
        @value = " " 
    end
end