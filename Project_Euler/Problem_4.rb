def largest_palindrome_prod(num1 = 999, num2 = 999, largest_so_far = 0)
  prod = num1 * num2
  largest_so_far = prod if prod > largest_so_far && check_pal(prod)

  if num2 == 100
    return largest_so_far
  elsif num1 == 100
    largest_palindrome_prod(num1 = 999, num2 -= 1, largest_so_far)
  else
    largest_palindrome_prod(num1 -= 1, num2, largest_so_far)
  end
end

def check_pal(num)
  num = num.to_s if num.is_a? Integer
  if num.length < 2
    true
  else
    num[0] == num[-1] ? check_pal(num[1..-2]) : false
  end
end

p largest_palindrome_prod

