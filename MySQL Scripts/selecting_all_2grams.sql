SELECT
       id_bigram     AS id     ,
       raw_frequency AS freq   ,
       w1.freq_all   AS w1_freq,
       w2.freq_all   AS w2_freq
FROM
       2grams        ,
       unigrams AS w1,
       unigrams AS w2
WHERE
       2grams.wordform_1     = w1.id_unigram
       AND 2grams.wordform_2 = w2.id_unigram