#Shuffle
###Evan Senter

_Altschul, S. F., & Erickson, B. W. (1985). Significance of nucleotide sequence alignments: a method for random sequence permutation that preserves dinucleotide and codon usage. Molecular biology and evolution, 2(6), 526–38. Retrieved from http://www.ncbi.nlm.nih.gov/pubmed/3870875_

    shuffler = Shuffle.new("AGACATAAAGTTCCGTACTGCCGGGAT")
    puts (dishuffled_sequence = shuffler.dishuffle)
    #=> AGAAGTACAATCGGTACGATTGGCCCT
    shuffler.valid?(dishuffled_sequence, 2)
    #=> true (Shuffler preserved the di-token frequency)
    shuffler.valid?(dishuffled_sequence, 3)
    #=> false-ish (Shuffler does not guarantee to preserve the tri-token frequency)
    puts (trishuffled_sequence = shuffler.shuffle(3))
    #=> AGTACTGCCGTTCCGGGATAAAGACAT
    shuffler.valid?(trishuffled_sequence, 3)
    #=> true

[motivation.](http://www.youtube.com/watch?v=xFZYJIwfUbo)