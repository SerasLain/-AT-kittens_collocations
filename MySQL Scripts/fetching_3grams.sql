SELECT id_trigram, unigram as w1, w2, w3, d{}_logdice from (SELECT id_trigram, wordform_1, unigram as w2, w3, d{}_logdice FROM
((SELECT 
    id_trigram, wordform_1, wordform_2, unigram as w3, d{}_logdice
FROM
    ((SELECT 
        id_trigram, bigram, token, d{}_logdice
    FROM
        3grams AS t1
    WHERE
        d{}_freq >= 3 and d{}_tsc > 2.576 order by d{}_logdice desc limit 5000) as t2
        JOIN
    (select unigram, id_unigram from unigrams) as t3 ON token = id_unigram)
    join (select id_bigram, wordform_1, wordform_2 from 2grams) as 2g on bigram = id_bigram) as t4
    join (select unigram, id_unigram from unigrams) as n on wordform_2 = id_unigram)) as t5
    join (select unigram, id_unigram from unigrams) as n2 on wordform_1 = id_unigram
