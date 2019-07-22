class Caesar
  def caesar_cipher(str, shift)
    alph = ('a'..'z').to_a
    str.downcase!
    str2 = str.split('')
    str3 = ''

    str2.each do |letter|
      if alph.include? letter
        index = (((alph.index(letter) + shift) % 26))
        str3 += alph[index]
      else
        str3 += letter
      end
    end
    str3
  end
end
