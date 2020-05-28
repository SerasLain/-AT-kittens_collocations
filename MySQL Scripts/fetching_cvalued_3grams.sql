SELECT 
        tokens.id_trigram AS id_trigram,
        w1,
        pos1,
        w2,
        pos2,
        w3,
        pos3,
        d{}_freq,
        d{}_pmi,
        d{}_logdice,
        d{}_tsc,
        d{}_cval
    FROM
        (SELECT 
            wp1.id_trigram AS id_trigram, w1, pos1, w2, pos2, w3, pos3
        FROM
            ((SELECT 
            id_trigram, unigram AS w1, pos AS pos1
        FROM
            (SELECT 
            id_trigram, w1
        FROM
            3grams_tokens) AS t1
        JOIN unitags ON id_unigram = w1) AS wp1
        JOIN (SELECT 
            id_trigram, unigram AS w2, pos AS pos2
        FROM
            (SELECT 
            id_trigram, w2
        FROM
            3grams_tokens) AS t2
        JOIN unitags ON id_unigram = w2) AS wp2 ON wp1.id_trigram = wp2.id_trigram
        JOIN (SELECT 
            id_trigram, unigram AS w3, pos AS pos3
        FROM
            (SELECT 
            id_trigram, w3
        FROM
            3grams_tokens) AS t3
        JOIN unitags ON id_unigram = w3) AS wp3 ON wp2.id_trigram = wp3.id_trigram)) AS tokens
            JOIN
        (SELECT 
            id_trigram, d{}_freq, d{}_pmi, d{}_logdice, d{}_tsc, d{}_cval
        FROM
            3grams WHERE d{}_tsc >= 2.576) AS metrics ON tokens.id_trigram = metrics.id_trigram