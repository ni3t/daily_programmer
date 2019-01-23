# [2019-01-14] Challenge #372 [Easy] Perfectly balanced
# Given a string containing only the characters x and y, find whether there are the same number of
# xs and ys.
#
# balanced("xxxyyy") => true
# balanced("yyyxxx") => true
# balanced("xxxyyyy") => false
# balanced("yyxyxxyxxyyyyxxxyxyx") => true
# balanced("xyxxxxyyyxyxxyxxyy") => false
# balanced("") => true
# balanced("x") => false
#
#  Optional bonus
#
# Given a string containing only lowercase letters, find whether every letter that appears in the
# string appears the same number of times. Don't forget to handle the empty string ("") correctly!
#
# balanced_bonus("xxxyyyzzz") => true
# balanced_bonus("abccbaabccba") => true
# balanced_bonus("xxxyyyzzzz") => false
# balanced_bonus("abcdefghijklmnopqrstuvwxyz") => true
# balanced_bonus("pqq") => false
# balanced_bonus("fdedfdeffeddefeeeefddf") => false
# balanced_bonus("www") => true
# balanced_bonus("x") => true
# balanced_bonus("") => true
#
# Note that balanced_bonus behaves differently than balanced for a few inputs, e.g. "x".

def balanced(string)
  string.split("").instance_eval { count("x") == count("y") }
end

def balanced_bonus(string)
  string.split("").instance_eval { uniq.map { |l| count(l) }.uniq.count == 1 || length == 0 }
end

puts [balanced("xxxyyy") == true,
      balanced("yyyxxx") == true,
      balanced("xxxyyyy") == false,
      balanced("yyxyxxyxxyyyyxxxyxyx") == true,
      balanced("xyxxxxyyyxyxxyxxyy") == false,
      balanced("") == true,
      balanced("x") == false,
      balanced_bonus("xxxyyyzzz") == true,
      balanced_bonus("abccbaabccba") == true,
      balanced_bonus("xxxyyyzzzz") == false,
      balanced_bonus("abcdefghijklmnopqrstuvwxyz") == true,
      balanced_bonus("pqq") == false,
      balanced_bonus("fdedfdeffeddefeeeefddf") == false,
      balanced_bonus("www") == true,
      balanced_bonus("x") == true,
      balanced_bonus("") == true].all?(true) ? "Yes" : "No"
