def translate(str)
    arr = str.split
    vowels = ["a", "e", "i", "o", "u"]
    first = arr[0]
    arr.shift
    sentence = ""

    if vowels.include?(first[0])
        sentence += first + "ay"
    else
        sentence += consonant2(first) + consonant1(first) + "ay" 
    end
    
    arr.each do |word|
        if vowels.include?(word[0])
            sentence += " " + word + "ay"
        else
            letter = word[0]
            sentence += " " + consonant2(word) + consonant1(word) + "ay" 
        end
    end
    
    return sentence

end


def consonant1(str)
    vowels = ["a", "e", "i", "o", "u"]
    x = 0
    newStr = ""
    while not(vowels.include?(str[x])) or str[x..x+1] == "qu"
        if str[x] == "q"
            newStr += str[x..x+1]
        else
            newStr += str[x]
        end
        x += 1
    end
    return newStr
end

def consonant2(str)
    vowels = ["a", "e", "i", "o", "u"]

    while not(vowels.include?(str[0])) or str[0..1] == "qu"
        if str[0] == "q"
            str = str[2..str.length-1]
        else
            str = str[1..str.length-1]
        end
    end
    return str
end

puts translate("banana")