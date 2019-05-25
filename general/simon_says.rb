def echo(str)#write your code here
    return str
end

def shout(str)
    return str.upcase
end

def repeat(str, n = 2)
    return ((str + " ") * (n-1)) + str
end

def start_of_word(str, n = 1)
    word = ""
    n.times do |x|
        word += str[x]
    end
    return word
end

def first_word(str)
    word = ""
    x = 0

    while str[x] != " " and x < str.length
        word += str[x]
        x += 1
    end

    return word
end

def titleize(str)
    arr = str.split
    little_words = ["and", "over", "the"]
    result = arr[0].capitalize
    arr.shift

    arr.each do |word|
        if little_words.include?(word)
            result += " " + word
        else
            result += " " + word.capitalize
        end
    end
    return result
end
