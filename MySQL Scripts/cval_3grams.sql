SELECT id_trigram, colloc_freq, COUNT(_id), SUM(longer_freq) FROM (
SELECT 
    id_trigram, d{}_freq as colloc_freq, _id, longer_freq
FROM
    3grams_tokens AS 3gr
        JOIN
    (SELECT 
        id_4gram AS _id, d{}_freq AS longer_freq, trigram
    FROM
        4grams) AS 4gr ON trigram = id_trigram 
UNION SELECT 
    id_trigram, d{}_freq AS colloc_freq, _id, longer_freq
FROM
    3grams_tokens AS 3gr
        JOIN
    (SELECT 
        id_4gram AS _id, d{}_freq AS longer_freq, w1, w2, w3, w4
    FROM
        4grams_tokens) AS 4gr ON (3gr.w1 = 4gr.w2 AND 3gr.w2 = 4gr.w3
        AND 3gr.w3 = 4gr.w4) 
UNION SELECT 
    id_trigram, d{}_freq AS colloc_freq, _id, longer_freq
FROM
    3grams_tokens AS 3gr
        JOIN
    (SELECT 
        id_5gram AS _id, d{}_freq AS longer_freq, w1, w2, w3, w4, w5
    FROM
        5grams_tokens) AS 5gr ON (3gr.w1 = 5gr.w1 AND 3gr.w2 = 5gr.w2
        AND 3gr.w3 = 5gr.w3)
        OR (3gr.w1 = 5gr.w2 AND 3gr.w2 = 5gr.w3
        AND 3gr.w3 = 5gr.w4)
        OR (3gr.w1 = 5gr.w3 AND 3gr.w2 = 5gr.w4
        AND 3gr.w3 = 5gr.w5) 
UNION SELECT 
    id_trigram, d{}_freq AS colloc_freq, _id, longer_freq
FROM
    3grams_tokens AS 3gr
        JOIN
    (SELECT 
        id_6gram AS _id, d{}_freq AS longer_freq, w1, w2, w3, w4, w5, w6
    FROM
        6grams_tokens) AS 6gr ON (3gr.w1 = 6gr.w1 AND 3gr.w2 = 6gr.w2 AND 3gr.w3 = 6gr.w3)
        OR (3gr.w1 = 6gr.w2 AND 3gr.w2 = 6gr.w3 AND 3gr.w3 = 6gr.w4)
        OR (3gr.w1 = 6gr.w3 AND 3gr.w2 = 6gr.w4 AND 3gr.w3 = 6gr.w5)
        OR (3gr.w1 = 6gr.w4 AND 3gr.w2 = 6gr.w5 AND 3gr.w3 = 6gr.w6)
)  as nnnngr group by id_trigram