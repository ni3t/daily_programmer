require "minitest/autorun"

# Description
# You are give a list of blobs, each having an initial position in an discrete grid, and a size.
# Blobs try to eat each other greedily and move around accordingly.
#
# During each cycle, all blobs move one step (Moore neighborhood) towards another blob of smaller
# size (if any). This blob is chosen as the closest one, with a preference for larger ones,
# breaking ties as clockwise (11H < 12H > 01H).
#
# At the end of each cycle, blobs merge (with summed size) if they are on the same location.
#
# Return the final state of the blobs.
#
# Example:
# Given: [(0,2,1),(2,1,2)] as a list of (x,y and size)
#
# ..1    ..1    ..3
# ...    ..2    ...
# .2.    ...    ...
#
# Solution: [(0,2)]
#
# Challenge
# [(0,1,2),
#  (10,0,2)]
#
# [(4, 3, 4),
#  (4, 6, 2),
#  (8, 3, 2),
#  (2, 1, 3)]
#
# [(-57, -16, 10),
#  (-171, -158, 13),
#  (-84, 245, 15),
#  (-128, -61, 16),
#  (65, 196, 4),
#  (-221, 121, 8),
#  (145, 157, 3),
#  (-27, -75, 5)]
#
# Bonus
# Help the blobs break out of flatland.
#
# Given: [(1,2),(4,2)]
#
# .1..2    .1.2.    .12..    .3...
# A solution: [(1,3)]
#
# Given [(0,2,0,1),(1,2,1,2)]
#
# ..1    .21    ..3
# ...    ...    ...
# /      /      /
# ...    ...    ...
# 2..    ...    ...
# A solution [(0,2,0)]
#
# Bonus 2
# Mind that the distances can be long. Try to limit run times.
#
# Bonus Challenges
# [(6,3),
#  (-7,4),
#  (8,3),
#  (7,1)]
#
# [(-7,-16,-16,4),
#  (14,11,12,1),
#  (7,-13,-13,4),
#  (-9,-8,-11,3)]
# .
#
# [(-289429971, 243255720, 2),
#  (2368968216, -4279093341, 3),
#  (-2257551910, -3522058348, 2),
#  (2873561846, -1004639306, 3)]

class Blobs
  Blob = Struct.new(:y, :x, :size, :next_x, :next_y) do
    def seek(blobs)
      self.next_x, self.next_y = blobs
        .filter { |b| b.size < self.size && b != self }
        .sort_by { |b| b.m_dist(self) }
        &.first&.instance_eval { [x, y] } || []
    end

    def m_dist(other)
      (self.x - other.x).abs + (self.y - other.y).abs
    end

    def move
      return if next_x.nil?

      case x - next_x
      when 1..Float::INFINITY
        self.x -= 1
      when -Float::INFINITY..-1
        self.x += 1
      end

      case y - next_y
      when 1..Float::INFINITY
        self.y -= 1
      when -Float::INFINITY..-1
        self.y += 1
      end
      next_x = nil
      next_y = nil
    end

    def merge(other)
      blobs = yield
      self.size += other.size
      blobs.delete(other)
    end
  end

  def initialize(blobs)
    @blobs = blobs.split(",")
      .map(&:strip)
      .map { |i| i.gsub(/\[|\(|\)|\]/, "") }
      .map(&:to_i)
      .each_slice(3)
      .map { |set| Blob.new(*set) }
  end

  def play
    @blobs.each { |b| b.seek(@blobs) }
      .each { |b| b.move }
    @stop = @blobs.map(&:next_x)
      .compact
      .empty?
    @blobs.group_by { |g| [g.x, g.y] }
      .filter { |k, v| v.count >= 2 }
      .map { |p| p[1] }
      .map { |pair| pair[0].merge(pair[1]) { @blobs } }
  end

  def solution
    play until @blobs.size == 0 || @stop
    "[" + @blobs.map { |b| "(#{b.y},#{b.x})" }.join(",") + "]"
  end
end

class TestBlobs < MiniTest::Unit::TestCase
  def setup; end

  def test_simple
    assert_equal(
      "[(0,2)]",
      Blobs.new(
        "[(0,2,1),(2,1,2)]"
      ).solution
    )
  end

  def test_simple_2
    assert_equal(
      Blobs.new(
        "[(0,1,2),(10,0,2)]"
      ).solution,
      "[(0,1),(10,0)]"
    )
  end

  def test_simple_3
    assert_equal(
      Blobs.new(
        "[(4, 3, 4),(4, 6, 2),(8, 3, 2),(2, 1, 3)]"
      ).solution,
      "[(8,3)]"
    )
  end

  def test_simple_4
    assert_equal(
      Blobs.new(
        <<~EOS
          [(-57, -16, 10),
          (-171, -158, 13),
          (-84, 245, 15),
          (-128, -61, 16),
          (65, 196, 4),
          (-221, 121, 8),
          (145, 157, 3),
          (-27, -75, 5)]"
        EOS

      
).solution,
      "[(114,127)]"
    )
  end
end
