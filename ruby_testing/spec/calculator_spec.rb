#spec/calculator_spec.rb
require './lib/calculator'

RSpec.describe Calculator do
  describe '#add' do
    it 'returns the sum of two numbers' do
      calculator = Calculator.new
      expect(calculator.add(5, 2)).to eql(7)
    end

    it 'returns the sum of more than two numbers' do
      calculator = Calculator.new
      expect(calculator.add(2, 5, 7)).to eql(14)
    end
  end

  describe '#multiply' do
    it 'returns product of two numbers' do
      calculator = Calculator.new
      expect(calculator.multiply(2, 3)).to eql(6)
    end

    it 'returns product of more than two numbers' do
      calculator = Calculator.new
      expect(calculator.multiply(2, 2, 7)).to eql(28)
    end
  end
end
