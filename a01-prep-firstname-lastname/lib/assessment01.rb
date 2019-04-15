require 'byebug'
class Array

  # Monkey patch the Array class and add a my_inject method. If my_inject receives
  # no argument, then use the first element of the array as the default accumulator.

  def my_inject(accumulator = nil, &prc)
    i = 0
    if accumulator == nil
      accumulator = self.first
      i = 1
    end

    (i...self.length).each do |i|
      accumulator = prc.call(accumulator, self[i])
    end

    accumulator
  end


end

# primes(num) returns an array of the first "num" primes.
# You may wish to use an is_prime? helper method.

def is_prime?(num)
  return false if num < 2
  (2...num).each { |factor| return false if num % factor == 0}
  true
end

def primes(num)
  prime_arr = []

  i = 2
  while prime_arr.length < num
    prime_arr << i if is_prime?(i)
    i += 1
  end

  prime_arr
end

# Write a recursive method that returns the first "num" factorial numbers.
# Note that the 1st factorial number is 0!, which equals 1. The 2nd factorial
# is 1!, the 3rd factorial is 2!, etc.

def factorials_rec(num)

  return [1] if num == 1

  prev_facs = factorials_rec(num - 1)
  prev_facs << (num - 1) * prev_facs[-1]
end

p factorials_rec(2)
p factorials_rec(3)

class Array

  # Write an Array#dups method that will return a hash containing the indices of all
  # duplicate elements. The keys are the duplicate elements; the values are
  # arrays of their indices in ascending order, e.g.
  # [1, 3, 4, 3, 0, 3, 0].dups => { 3 => [1, 3, 5], 0 => [4, 6] }

  def dups
    hash = Hash.new { |h, k| h[k] = []}
  
    self.each.with_index do |ele, idx|
      hash[ele] << idx
    end
    
    hash.select {|k, v| v.length > 1}
  end
end


class String

  # Write a String#symmetric_substrings method that returns an array of substrings
  # that are palindromes, e.g. "cool".symmetric_substrings => ["oo"]
  # Only include substrings of length > 1.

  def symmetric_substrings
    subs = []

    (0...self.length - 1).each do |idx_1|
      (idx_1 + 1...self.length).each do |idx_2|
        sub = self[idx_1..idx_2]
        subs << sub if sub == sub.reverse && !subs.include?(sub)
      end
    end

    subs
  end

end

class Array

  # Write an Array#merge_sort method; it should not modify the original array.

  def merge_sort(&prc)
    prc ||= Proc.new { |a, b| a <=> b }
    return self if self.length <= 1
    mid = self.length / 2
    left = self[0...mid].merge_sort(&prc)
    right = self[mid..-1].merge_sort(&prc)

    Array.merge(left, right, &prc)
  end

  private
  def self.merge(left, right, &prc)
    merged = []

    until left.empty? || right.empty?
      if prc.call(left.first, right.first) <= 0
        merged << left.shift
      else
        merged << right.shift
      end
    end

    merged + left + right
  end

end
