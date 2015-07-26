###### ALGS WEEK 2 #################################
### knapsack- how many different ways can you sum the 
## elements in a knapsack to equal the target
def knapsack(elements, target)
	seen_remaining = Hash.new { 0 }
	seen_remaining[target] = 0

	elements.each do |el|
		seen_remaining.keys.each do |k| 
			seen_remaining[k - el] += 1 if k - el >= 0
		end
	end

	seen_remaining[0]
end

# puts knapsack([10, 5, 2, 3, 1, 15, 5, 4], 15)

## rectangleSummer- given the bottom right corner coordinate in a rectangle,
## can you return the sum of all elements in that rectangle on O(1), and then
## can you do it for an arbitrary rectangle (upper left and lower right corner)
 class RectangleSummer
  def initialize(matrix)
    @sum_matrix = dp_sum(matrix)
    # @sum_matrix.each { |row| puts row.join(' ') }
  end

  def sum(x, y)
    @sum_matrix[x][y]
  end

  def rect_sum(upper_left, lower_right)
  	sum(*lower_right) - sum(*upper_left)
  end

  private

  ## each coordinate point is mapped to the sum of the points above and to the left of it
  ## the sum of the point at [row - 1, col - 1] is subtracted because it has already been 
  ## accounted for in the current pts sum
  def dp_sum(matrix)
  	sum_matrix = Array.new(matrix.length) { Array.new(matrix.length) { 0 } }
  	matrix.each_with_index do |row, row_i|
  		row.each_with_index do |spot, col_i|
  			total = spot
  			total += sum_matrix[row_i - 1][col_i] unless row_i == 0
  			total += sum_matrix[row_i][col_i - 1] unless col_i == 0
  			total -= sum_matrix[row_i - 1][col_i - 1] if row_i > 0 && col_i > 0
  			sum_matrix[row_i][col_i] = total 
  		end
  	end

  	sum_matrix
  end
 end

  mat = [
          [1, 1, 1, 0, 0, 1, 0],
          [1, 0, 1, 1, 1, 0, 1],
          [1, 0, 1, 1, 1, 1, 0],
          [1, 1, 1, 0, 1, 1, 1],
          [0, 1, 1, 1, 0, 1, 1],
          [0, 1, 1, 1, 0, 1, 0],
          [1, 0, 1, 1, 1, 1, 1]
        ]
matrix = RectangleSummer.new(mat)
pt1 = [6, 5]
pt2 = [3, 3] 
puts matrix.sum(*pt1)
puts matrix.sum(*pt2)
puts matrix.rect_sum(pt2, pt1)