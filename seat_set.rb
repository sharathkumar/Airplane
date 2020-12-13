require './seat'
class SeatSet
	attr_accessor :set_pos, :rows, :cols, :seats, :is_last

	def initialize(dimension, index, is_last)
		@is_last = is_last
		@set_pos = index
		@rows = dimension[1]
		@cols = dimension[0]
		@seats = []
		create_seats
		define_seats
	end

	def create_seats
		(0..rows - 1).each do |row|
			seat_row = []
			(0..cols - 1).each do |col|
				seat_row << Seat.new(row, col, set_pos)
			end
			@seats << seat_row
		end
	end

	def define_seats
		seats.transpose.each_with_index.each do |transpose_seats, index|
			if (index == 0 || index == (cols - 1))
				type = ((set_pos == 0 && index == 0) || (is_last && index == (cols - 1))) ? 'Window' : 'Aisle'
				transpose_seats.map{|seat| seat.type =type }
			else
				transpose_seats.map{|seat| seat.type = 'Middle' }
			end
		end  
	end

	def seats_by(type)
		seats.flatten.map{|seat| seat if seat.type == type}.compact
	end

	def draw(margin, total_rows)
		"<td style='width:#{(cols.to_f/(total_rows + margin).to_f)*100}%; vertical-align: top; margin-right: 20px;'><table border=1 style='border-collapse: collapse; width:100%;'>#{seats.map{|seats_batch| "<tr>#{seats_batch.map{|seat| "<td style='background-color: #{seat.colour_code}; text-align:center; width: 30px; height:30px'>#{seat.passenger_number}</td>" }.join('')}</tr>"}.join('')}</table></td>"
	end
end