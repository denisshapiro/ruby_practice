def substrings(sentence, dictionary)
    h = Hash.new(0)
    sentArr = sentence.split

    sentArr.map! do |word|
        word = word.gsub(/[^a-z0-9\s]/i, '').downcase
    end

    sentArr.each do |word|
        dictionary.each do |val|
            if word.include?val
                h[val]+=1
            end
        end 
    end
    return h
end


dict = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
#puts substrings("below", dict)
puts substrings("Howdy partner, sit down! How's it going?", dict)