# Description
# A number is input in computer then a new no should get printed by adding one to each of its
# digit. If you encounter a 9, insert a 10 (don't carry over, just shift things around).
#
# For example, 998 becomes 10109.
#
# Bonus
# This challenge is trivial to do if you map it to a string to iterate over the input, operate,
# and then cast it back. Instead, try doing it without casting it as a string at any point, keep
# it numeric (int, float if you need it) only.

require "minitest/autorun"

def simple(n)
  n.to_s.each_char.map(&:to_i).map { |i| i + 1 }.map(&:to_s).join.to_i
end

def int_only(n)
  ten_shift = 0
  n.digits.map.with_index do |digit, index|
    res = (digit + 1) * (10 ** (index + ten_shift))
    ten_shift += 1 if digit == 9
    res
  end.sum
end

class TestCases < Minitest::Test
  def test_simple
    assert_equal(10109, simple(998))
  end

  def test_int_only
    assert_equal(10109, int_only(998))
  end
end
