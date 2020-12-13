require './seat_set'
require 'pry'
class AirPlane
	attr_accessor :sets

	def initialize(input)
		@input = input
		@sets = []
		define_sets
		allocate_seat(30)
	end

	def define_sets
		final_set_index = @input.length - 1
		@input.each_with_index do |set_dimension, index|
			@sets << SeatSet.new(set_dimension, index, final_set_index == index)
		end
	end

	def allocate_seat(number)
		allocation_seats = sets.map{|set| set.seats_by('Aisle')}
										  .flatten.sort_by{|seat| [seat.row, seat.set_pos, seat.col]}
		allocation_seats += sets.map{|set| set.seats_by('Window')}
											 .flatten.sort_by{|seat| [seat.row, seat.set_pos, seat.col]}
		allocation_seats  += sets.map{|set| set.seats_by('Middle')}
											  .flatten.sort_by{|seat| [seat.row, seat.set_pos, seat.col]}
		(1..number).each_with_index.map{|passenger_number, index| allocation_seats[index].passenger_number = passenger_number }
	end

	def draw_seat
		total_number_cols = @input.inject(0){|sum, e| sum+e[0]}
		require 'tempfile'
		Tempfile.create(['hello', '.html']) do |html_file|
		  html_file.write "<table style='border-collapse: collapse; width:100%;'><tr>#{sets.map{|set| set.draw((@input.length + 1), total_number_cols) }.join('')}</tr></table>"
		  html_file.close
		  pdf_file = Tempfile.new(['hello', '.pdf'])
		  system('wkhtmltopdf', html_file.path, pdf_file.path)
		  system('open', pdf_file.path)
		end
	end

end


ap = AirPlane.new([[3,2], [4,3], [2,3], [3,4]])
ap.draw_seat