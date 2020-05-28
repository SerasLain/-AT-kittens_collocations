SELECT 
        tokens.id_4gram AS id_4gram,
        w1,
        pos1,
        w2,
        pos2,
        w3,
        pos3,
        w4,
        pos4,
        d{}_freq,
        d{}_pmi,
        d{}_logdice,
        d{}_tsc,
        d{}_cval
    FROM
        (SELECT 
            wp1.id_4gram AS id_4gram, w1, pos1, w2, pos2, w3, pos3, w4, pos4
        FROM
            ((SELECT 
            id_4gram, unigram AS w1, pos AS pos1
        FROM
            (SELECT 
            id_4gram, w1
        FROM
            4grams_tokens) AS t1
        JOIN unitags ON id_unigram = w1) AS wp1
        JOIN (SELECT 
            id_4gram, unigram AS w2, pos AS pos2
        FROM
            (SELECT 
            id_4gram, w2
        FROM
            4grams_tokens) AS t2
        JOIN unitags ON id_unigram = w2) AS wp2 ON wp1.id_4gram = wp2.id_4gram
        JOIN (SELECT 
            id_4gram, unigram AS w3, pos AS pos3
        FROM
            (SELECT 
            id_4gram, w3
        FROM
            4grams_tokens) AS t3
        JOIN unitags ON id_unigram = w3) AS wp3 ON wp2.id_4gram = wp3.id_4gram)
        
        JOIN (SELECT 
            id_4gram, unigram AS w4, pos AS pos4
        FROM
            (SELECT 
            id_4gram, w4
        FROM
            4grams_tokens) AS t4
        JOIN unitags ON id_unigram = w4) AS wp4 ON wp3.id_4gram = wp4.id_4gram) AS tokens
            JOIN
        (SELECT 
            id_4gram, d{}_freq, d{}_pmi, d{}_logdice, d{}_tsc, d{}_cval
        FROM
            4grams WHERE d{}_tsc >= 2.576) AS metrics ON tokens.id_4gram = metrics.id_4gram