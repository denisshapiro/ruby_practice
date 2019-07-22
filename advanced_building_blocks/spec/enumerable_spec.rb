require './lib/enumerable.rb'

RSpec.describe Enumerable do
  describe '#my_count' do
    it 'works with blocks' do
      expect([1, 2, 3].my_count { |elem| elem == 2}).to eql(1)
    end

    it 'counts when 0 elements' do
      expect([].my_count(2)).to eql(0)
    end

    it 'counts strings' do
      expect(%w[hello bye string hello hello].my_count('hello')).to eql(3)
    end
  end
end