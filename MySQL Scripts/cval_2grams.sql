SELECT id_bigram, colloc_freq, COUNT(_id), SUM(longer_freq) FROM (
SELECT 
    id_bigram, colloc_freq, _id, longer_freq
FROM
    (SELECT id_bigram, d{}_freq as colloc_freq FROM 2grams WHERE d{}_freq >=3) AS 2gr
        JOIN
    (SELECT 
        id_trigram AS _id, d{}_freq AS longer_freq, bigram
    FROM
        3grams) AS 3gr ON bigram = id_bigram 
UNION SELECT 
    id_bigram, colloc_freq, _id, longer_freq
FROM
    (SELECT id_bigram, wordform_1 as w1, wordform_2 as w2, d{}_freq as colloc_freq FROM 2grams WHERE d{}_freq >=3) AS 2gr
        JOIN
    (SELECT 
        id_trigram AS _id, d{}_freq AS longer_freq, w1, w2, w3
    FROM
        3grams_tokens) AS 3gr ON (2gr.w1 = 3gr.w2 AND 2gr.w2 = 3gr.w3)
UNION SELECT 
    id_bigram, colloc_freq, _id, longer_freq
FROM
    (SELECT id_bigram, wordform_1 as w1, wordform_2 as w2, d{}_freq as colloc_freq FROM 2grams WHERE d{}_freq >=3) AS 2gr
        JOIN
    (SELECT 
        id_4gram AS _id, d{}_freq AS longer_freq, w1, w2, w3, w4
    FROM
        4grams_tokens) AS 4gr ON (2gr.w1 = 4gr.w1 AND 2gr.w2 = 4gr.w2)
        OR (2gr.w1 = 4gr.w2 AND 2gr.w2 = 4gr.w3)
        OR (2gr.w1 = 4gr.w3 AND 2gr.w2 = 4gr.w4)
UNION SELECT 
    id_bigram, colloc_freq, _id, longer_freq
FROM
     (SELECT id_bigram, wordform_1 as w1, wordform_2 as w2, d{}_freq as colloc_freq FROM 2grams WHERE d{}_freq >=3) AS 2gr
        JOIN
    (SELECT 
        id_5gram AS _id, d{}_freq AS longer_freq, w1, w2, w3, w4, w5
    FROM
        5grams_tokens) AS 5gr ON (2gr.w1 = 5gr.w1 AND 2gr.w2 = 5gr.w2)
        OR (2gr.w1 = 5gr.w2 AND 2gr.w2 = 5gr.w3)
        OR (2gr.w1 = 5gr.w3 AND 2gr.w2 = 5gr.w4)
        OR (2gr.w1 = 5gr.w4 AND 2gr.w2 = 5gr.w5)
UNION SELECT 
    id_bigram, colloc_freq, _id, longer_freq
FROM
     (SELECT id_bigram, wordform_1 as w1, wordform_2 as w2, d{}_freq as colloc_freq FROM 2grams WHERE d{}_freq >=3) AS 2gr
        JOIN
    (SELECT 
        id_6gram AS _id, d{}_freq AS longer_freq, w1, w2, w3, w4, w5, w6
    FROM
        6grams_tokens) AS 6gr ON (2gr.w1 = 6gr.w1 AND 2gr.w2 = 6gr.w2)
        OR (2gr.w1 = 6gr.w2 AND 2gr.w2 = 6gr.w3)
        OR (2gr.w1 = 6gr.w3 AND 2gr.w2 = 6gr.w4)
        OR (2gr.w1 = 6gr.w4 AND 2gr.w2 = 6gr.w5)
        OR (2gr.w1 = 6gr.w5 AND 2gr.w2 = 6gr.w6)
)  as nnnngr group by id_bigram