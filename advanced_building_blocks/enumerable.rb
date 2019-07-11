module Enumerable
	def my_each
		for i in (0..self.size-1)
				yield(self[i])
		end 
	end

	def my_each_with_index
		for i in (0..self.size-1)
				yield(self[i], i)
		end 
	end

	def my_select
		result = Array.new
		self.my_each do |e|
				result.push(e) if yield(e)
		end
  result
	end

	def my_all?
		self.my_each do |e|
				return false unless yield(e)
		end
		return true
	end

	def my_any?
		self.my_each do |e|
				return true if yield(e)
		end
		return false
	end

	def my_none?
		self.my_each do |e|
				return false if yield(e)
		end
		return true
	end

	def my_count(num = nil)
		counter = 0
		if num 
				self.my_each do |e|
						counter += 1 if num == e
				end
		else
				self.my_each do |e|
						counter +=1 if yield(e)
				end
		end
		return counter
	end

	def my_map(proc = nil)
		arr = Array.new
		if proc
				self.my_each do |e|
						arr.push(proc.call(e))
				end
		else
				self.my_each do |e|
						arr.push(yield(e))
				end
		end
		return arr
	end

	def my_inject(start = nil)
		total = 0
		if start
				total = start 
				self.my_each do |e|
						total = yield(total, e)
				end
		else
				total = self[0]
				self.my_each do |e|
						total = yield(total, e)
				end
		end
		return total
	end
end

def multiply_els(arr)
    arr.my_inject(1){|memo, value| memo * value}
end

my_array = (1..4).to_a

# EACH
my_array.each{ |e| p e }
my_array.my_each{ |e| p e }

# EACH_WITH_INDEX
my_array.each_with_index{ |e, i| p "element: #{e}, index: #{i}" }
my_array.my_each_with_index{ |e, i| p "element: #{e}, index: #{i}" }

# SELECT
p my_array.select{ |item| item%2==0}
p my_array.my_select{ |item| item%2==0}

# ALL?
p my_array.all?{ |e| e > 1 }
p my_array.my_all?{ |e| e > 1 }

# ANY?
p my_array.any?{ |e| e < 1 }
p my_array.my_any?{ |e| e < 1 }

# NONE?
p my_array.none?{ |e| e > 1 }
p my_array.my_none?{ |e| e > 1 } 

# COUNT
p my_array.count { |e| e%2 == 1 }
p my_array.my_count { |e| e%2 == 1 }
p my_array.count 3
p my_array.my_count 3

# MAP
p my_array.map { |e| e ** 2 }
p my_array.my_map { |e| e ** 2 }
proc = Proc.new { |e| e ** 2 }
p my_array.my_map(proc)

# INJECT
p multiply_els([2,4,5])