class Seat
	attr_accessor :set_pos, :row, :col, :type, :passenger_number

	def initialize(row, col, set_pos)
		@set_pos = set_pos
		@row = row
		@col = col
		@type = nil
		@passenger_number = nil
	end

	def colour_code
		case @type
		when 'Window'
			'#bbd187'
		when 'Aisle'
			'#6ca4c9'
		when 'Middle'
			'#ad5d5d'
		else
			nil
		end
	end
end