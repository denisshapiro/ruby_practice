require './lib/caesar_cipher.rb'

RSpec.describe Caesar do
  describe '#caesar_cipher' do
    it 'shifts forward' do
      caesar = Caesar.new
      expect(caesar.caesar_cipher('hello', 3)).to eql('khoor')
    end

    it 'wraps around' do
      caesar = Caesar.new
      expect(caesar.caesar_cipher('abc', 26)).to eql('abc')
    end

    it 'wraps around a lot' do
      caesar = Caesar.new
      expect(caesar.caesar_cipher('abc', 53)).to eql('bcd')
    end

    it 'keeps non alphanumeric' do
      caesar = Caesar.new
      expect(caesar.caesar_cipher('word 123 ...', 1)).to eql('xpse 123 ...')
    end
  end
end
