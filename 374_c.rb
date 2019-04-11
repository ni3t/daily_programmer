require "minitest/autorun"
require "purdytest"

class NonogramSolver
  attr_accessor :numcols, :numrows, :cols, :rows

  def initialize(numcols, numrows, cols, rows)
    @cols = process(cols)
    @rows = process(rows)
    @numcols = numcols || @cols.length
    @numrows = numrows || @rows.length
    @grid = Array.new(@numrows) { Array.new(@numcols) { "?" } }
    @rotated = false
    puts self.inspect
  end

  def process(raw)
    if raw =~ /[AZ]/
      raw.split(" ").map { |c| c.each_byte.map { |b| b - 64 } }
    else
      raw.split(?")
        .map { |c| c.scan(/\d+/) }
        .reject(&:empty?)
        .map { |g| g.map(&:to_i) }
    end
  end

  def to_s
    count = 0
    print_grid
    puts "-" * 25
    changed = nil
    until count == 8
      rows.map.with_index do |row, i|
        mark(row, i)
      end
      print_grid
      puts "-" * 25
      if !@rotated
        if check_satisfied
          break
        end
      end
      transpose
      count += 1
    end
    @grid.map { |r| r.map { |c| c || " " }.join(" ") }.join("\n") + "\n"
  end

  def check_satisfied
    @grid.map.with_index do |row, i|
      return false if row.count("*") != rows[i].sum
    end
    transpose
    @grid.map.with_index do |row, i|
      return false if row.count("*") != rows[i].sum
    end
    transpose
    @grid = @grid.map { |r| r.map { |c| c == "*" ? "*" : " " } }
    print_grid
    puts "ALL GOOD"
    true
  end

  def possible(slice, i)
    current = @grid[i].map { |c| c == "*" ? 1 : nil }
    spaces_count = numcols - slice.sum
    slot_count = slice.size + 1
    (0..spaces_count).to_a.repeated_permutation(slot_count).select do |a|
      a.sum == spaces_count &&
      a[1..-2].none?(0)
    end.map do |poss|
      poss.map { |e| [0] * e }.zip(slice.map { |r| [1] * r }).flatten.compact
    end.select do |a|
      a.map.with_index do |pv, j|
        current[j].nil? || pv == current[j]
      end.all?(true)
    end.compact.map(&:join)
  end

  def mark(slice, i)
    current = @grid[i].map { |c| c == "*" ? 1 : 0 }.join("")
    puts "current  - #{current}"
    poss = possible(slice, i)
    poss.map { |po| puts "possible - #{po} " }
    if poss.size == 1
      poss.first.split("").map.with_index { |c, j| @grid[i][j] = c == "0" ? "." : "*" }
    else
      poss.reduce((2 ** numcols - 1).to_s(2)) do |acc, s|
        (s.to_i(2) & acc.to_i(2)).to_s(2).rjust(s.split("").length, "0")
      end.split("").map.with_index do |cell, j|
        @grid[i][j] = "*" if cell == "1"
      end
    end
    final = @grid[i].map { |c| c == "*" ? 1 : 0 }.join("")
    puts "final    - #{final}"
    puts "-" * 25
  end

  def transpose
    @grid = @grid.transpose
    @numcols, @numrows, @cols, @rows = @numrows, @numcols, @rows, @cols
    @rotated = !@rotated
  end

  def print_grid
    if @rotated
      transpose
      puts @grid.map { |r| r.map { |c| c || " " }.join(" ") }.join("\n") + "\n"
      transpose
    else
      puts @grid.map { |r| r.map { |c| c || " " }.join(" ") }.join("\n") + "\n"
    end
  end
end

class TestCases < MiniTest::Test
  # def test_simple
  #   puts ""
  #   assert_equal(EXP1, NonogramSolver.new(5, 5, '"5","2,2","1,1","2,2","5"', '"5","2,2","1,1","2,2","5"').to_s)
  # end

  def test_two
    puts ""
    assert_equal(EXP2, NonogramSolver.new(nil, nil, "AB CA AE GA E C D C", "C BA CB BB F AE F A B").to_s)
  end
end

EXP1 = <<EXP
* * * * *
* *   * *
*       *
* *   * *
* * * * *
EXP

EXP2 = <<EXP
  * * *        
* *   *        
  * * *     * *
    * *     * *
    * * * * * *
*   * * * * *  
* * * * * *    
        *      
      * *      
EXP

EXP3 = <<EXP
                    * * * * * *        
                * * *   *     * * *    
      *     * * *       *         * * *
    * * *   * * * * * * * * * * * * * *
      *     *                         *
    *   *   * *                     * *
* * * * *     * *                 * *  
* * * * *       *                 *    
* * * * *     * * *   * * *   * * *    
* * * * * * * *   * * *   * * *   * * *
EXP

EXP4 = <<EXP
        * * *   *                      
        * *   * * * *   *              
        *   * * *   * * *              
    * *   * * * *                      
  * * *   * * *   *         * * *      
* * *     * *   * *       *   * * *    
* *     * *   * *         * *   * *    
        * *   *   *     * *   *   *    
        *   * *   *       * * * *      
        *   *   * *           * *      
          * *   * *     * * * * * * * *
        * *   * *       * *     * * * *
        *   * *   * *   *       *     *
* * *     * * *   * * * * *           *
*   *   * * *   *         *         * *
* *     * * *   *         * * *   * * *
  *   * * *   * *   * * * * * * * *    
  * * * *   * * *   * * * * * * * *    
      *   * * * *   * *   * * * * *    
      *   * * * *   * *       * *      
        * * * *     * *       * * * * *
      * * * * *   * * *       * * * * *
      * * * *   *                     *
    * * * *   * *                      
    * * *   * * *                      
EXP

EXP5 = <<EXP
                                        * * * * *
    * *                             * * *     * *
  * *                             * * * * *     *
* *                           * * * * * * * *    
* *         * * * * *   * * * * * * * * * * *    
*   *     * *         *         * * * * * *      
*     * *           *               * * *        
* *                 *                           *
  * *           * * * * * *                   * *
    * * * * * * * * * * * * * * *         * * * *
          * * * * * * * * * *     * * * * * * * *
        * *   *   * * * *   * * *     * * * * * *
                * * * * * * * * * * * * * * * * *
                * * * * * * * * * * * * * * * * *
              * * * * * * * * * * * * * * * * * *
              *       * * * * * * * * * * * * * *
              *   *   * * * * * * * * * * * * * *
                * * * * *       * * * * * * * * *
                                  * * * * * * * *
                                    * * * * * * *
EXP
