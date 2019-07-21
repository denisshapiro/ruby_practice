# Calculator class
class Calculator
  def add(*args)
    args.inject(0) { |sum, x| sum + x }
  end

  def multiply(*args)
    args.inject(1) { |product, x| product * x }
  end
end
