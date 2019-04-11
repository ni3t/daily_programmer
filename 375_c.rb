require "ostruct"
VERBOSE = ARGV.delete("-v")

EASY = <<EASY
Nick ++ Elizabeth
Nick ++ Tom
Nick ++ Alex
Elizabeth ++ Tom
Elizabeth ++ Alex
Tom ++ Alex
EASY

TEST = <<TEST
Superman ++ Green Lantern
Superman ++ Wonder Woman
Superman -- Sinestro
Superman -- Cheetah
Superman -- Lex Luthor
Green Lantern ++ Wonder Woman
Green Lantern -- Sinestro
Green Lantern -- Cheetah
Green Lantern -- Lex Luthor
Wonder Woman -- Sinestro
Wonder Woman -- Cheetah
Wonder Woman -- Lex Luthor
Sinestro ++ Cheetah
Sinestro ++ Lex Luthor
Cheetah ++ Lex Luthor
TEST

(ARGV.delete("-e") ? EASY : ARGV.delete("-t") ? TEST : DATA).each_line.map(&:strip).map do |line|
end

GRAPH.mark_teams

pp GRAPH.teams.map(&:nodes)

__END__
Daenerys Targaryen ++ Jon Snow
Daenerys Targaryen ++ Tyrion Lannister
Daenerys Targaryen ++ Varys
Daenerys Targaryen ++ Jorah Mormont
Daenerys Targaryen ++ Beric Dondarrion
Daenerys Targaryen ++ Sandor “the Hound” Clegane
Daenerys Targaryen ++ Theon and Yara Greyjoy
Daenerys Targaryen -- Sansa Stark
Daenerys Targaryen -- Arya Stark
Daenerys Targaryen -- Bran Stark
Daenerys Targaryen -- The Lords of the North and the Vale
Daenerys Targaryen -- Littlefinger
Daenerys Targaryen -- Cersei Lannister
Daenerys Targaryen -- Jaime Lannister
Daenerys Targaryen -- Euron Greyjoy
Jon Snow ++ Tyrion Lannister
Jon Snow ++ Varys
Jon Snow ++ Jorah Mormont
Jon Snow ++ Beric Dondarrion
Jon Snow ++ Sandor “the Hound” Clegane
Jon Snow -- Theon and Yara Greyjoy
Jon Snow -- Sansa Stark
Jon Snow -- Arya Stark
Jon Snow -- Bran Stark
Jon Snow -- The Lords of the North and the Vale
Jon Snow -- Littlefinger
Jon Snow -- Cersei Lannister
Jon Snow -- Jaime Lannister
Jon Snow -- Euron Greyjoy
Tyrion Lannister ++ Varys
Tyrion Lannister ++ Jorah Mormont
Tyrion Lannister ++ Beric Dondarrion
Tyrion Lannister ++ Sandor “the Hound” Clegane
Tyrion Lannister ++ Theon and Yara Greyjoy
Tyrion Lannister -- Sansa Stark
Tyrion Lannister -- Arya Stark
Tyrion Lannister -- Bran Stark
Tyrion Lannister -- The Lords of the North and the Vale
Tyrion Lannister -- Littlefinger
Tyrion Lannister -- Cersei Lannister
Tyrion Lannister -- Jaime Lannister
Tyrion Lannister -- Euron Greyjoy
Varys ++ Jorah Mormont
Varys ++ Beric Dondarrion
Varys ++ Sandor “the Hound” Clegane
Varys ++ Theon and Yara Greyjoy
Varys -- Sansa Stark
Varys -- Arya Stark
Varys -- Bran Stark
Varys -- The Lords of the North and the Vale
Varys -- Littlefinger
Varys -- Cersei Lannister
Varys -- Jaime Lannister
Varys -- Euron Greyjoy
Jorah Mormont ++ Beric Dondarrion
Jorah Mormont ++ Sandor “the Hound” Clegane
Jorah Mormont ++ Theon and Yara Greyjoy
Jorah Mormont -- Sansa Stark
Jorah Mormont -- Arya Stark
Jorah Mormont -- Bran Stark
Jorah Mormont -- The Lords of the North and the Vale
Jorah Mormont -- Littlefinger
Jorah Mormont -- Cersei Lannister
Jorah Mormont -- Jaime Lannister
Jorah Mormont -- Euron Greyjoy
Beric Dondarrion ++ Sandor “the Hound” Clegane
Beric Dondarrion ++ Theon and Yara Greyjoy
Beric Dondarrion -- Sansa Stark
Beric Dondarrion -- Arya Stark
Beric Dondarrion -- Bran Stark
Beric Dondarrion -- The Lords of the North and the Vale
Beric Dondarrion -- Littlefinger
Beric Dondarrion -- Cersei Lannister
Beric Dondarrion -- Jaime Lannister
Beric Dondarrion -- Euron Greyjoy
Sandor “the Hound” Clegane ++ Theon and Yara Greyjoy
Sandor “the Hound” Clegane -- Sansa Stark
Sandor “the Hound” Clegane -- Arya Stark
Sandor “the Hound” Clegane -- Bran Stark
Sandor “the Hound” Clegane -- The Lords of the North and the Vale
Sandor “the Hound” Clegane -- Littlefinger
Sandor “the Hound” Clegane -- Cersei Lannister
Sandor “the Hound” Clegane -- Jaime Lannister
Sandor “the Hound” Clegane -- Euron Greyjoy
Theon and Yara Greyjoy -- Sansa Stark
Theon and Yara Greyjoy -- Arya Stark
Theon and Yara Greyjoy -- Bran Stark
Theon and Yara Greyjoy -- The Lords of the North and the Vale
Theon and Yara Greyjoy -- Littlefinger
Theon and Yara Greyjoy -- Cersei Lannister
Theon and Yara Greyjoy -- Jaime Lannister
Theon and Yara Greyjoy -- Euron Greyjoy
Sansa Stark ++ Arya Stark
Sansa Stark ++ Bran Stark
Sansa Stark ++ The Lords of the North and the Vale
Sansa Stark ++ Littlefinger
Sansa Stark -- Cersei Lannister
Sansa Stark -- Jaime Lannister
Sansa Stark -- Euron Greyjoy
Arya Stark ++ Bran Stark
Arya Stark ++ The Lords of the North and the Vale
Arya Stark ++ Littlefinger
Arya Stark -- Cersei Lannister
Arya Stark -- Jaime Lannister
Arya Stark -- Euron Greyjoy
Bran Stark ++ The Lords of the North and the Vale
Bran Stark -- Littlefinger
Bran Stark -- Cersei Lannister
Bran Stark -- Jaime Lannister
Bran Stark -- Euron Greyjoy
The Lords of the North and the Vale ++ Littlefinger
The Lords of the North and the Vale -- Cersei Lannister
The Lords of the North and the Vale -- Jaime Lannister
The Lords of the North and the Vale -- Euron Greyjoy
Littlefinger -- Cersei Lannister
Littlefinger -- Jaime Lannister
Littlefinger -- Euron Greyjoy
Cersei Lannister ++ Jaime Lannister
Cersei Lannister ++ Euron Greyjoy
Jaime Lannister ++ Euron Greyjoy
