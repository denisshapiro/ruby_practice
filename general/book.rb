class Book
    attr_accessor :title

    def title
        lower_case = ["in", "the", "of", "an", "a", "and"]
        @title = @title.split

       @title = @title.map do |word|
            if lower_case.include?(word)
                word
            else
                word.capitalize
            end
        end
        @title[0] = @title[0].capitalize
        @title.join(" ")
    end
end
