SELECT
        tokens.id_6gram AS id_6gram,
        w1,
        pos1,
        w2,
        pos2,
        w3,
        pos3,
        w4,
        pos4,
        w5,
        pos5,
        w6,
        pos6,
        d{}_freq,
        d{}_pmi,
        d{}_logdice,
        d{}_tsc
    FROM
        (SELECT
            wp1.id_6gram AS id_6gram, w1, pos1, w2, pos2, w3, pos3, w4, pos4, w5, pos5, w6, pos6
        FROM
            ((SELECT
            id_6gram, unigram AS w1, pos AS pos1
        FROM
            (SELECT
            id_6gram, w1
        FROM
            6grams_tokens) AS t1
        JOIN unitags ON id_unigram = w1) AS wp1
        JOIN (SELECT
            id_6gram, unigram AS w2, pos AS pos2
        FROM
            (SELECT
            id_6gram, w2
        FROM
            6grams_tokens) AS t2
        JOIN unitags ON id_unigram = w2) AS wp2 ON wp1.id_6gram = wp2.id_6gram
        JOIN (SELECT
            id_6gram, unigram AS w3, pos AS pos3
        FROM
            (SELECT
            id_6gram, w3
        FROM
            6grams_tokens) AS t3
        JOIN unitags ON id_unigram = w3) AS wp3 ON wp2.id_6gram = wp3.id_6gram

        JOIN (SELECT
            id_6gram, unigram AS w4, pos AS pos4
        FROM
            (SELECT
            id_6gram, w4
        FROM
            6grams_tokens) AS t4
        JOIN unitags ON id_unigram = w4) AS wp4 ON wp3.id_6gram = wp4.id_6gram

        JOIN (SELECT
            id_6gram, unigram AS w5, pos AS pos5
        FROM
            (SELECT
            id_6gram, w5
        FROM
            6grams_tokens) AS t5
        JOIN unitags ON id_unigram = w5) AS wp5 ON wp4.id_6gram = wp5.id_6gram
        )

        JOIN (SELECT
            id_6gram, unigram AS w6, pos AS pos6
        FROM
            (SELECT
            id_6gram, w6
        FROM
            6grams_tokens) AS t6
        JOIN unitags ON id_unigram = w6) AS wp6 ON wp5.id_6gram = wp6.id_6gram) AS tokens

            JOIN

        (SELECT
            id_6gram, d{}_freq, d{}_pmi, d{}_logdice, d{}_tsc
        FROM
            6grams WHERE d{}_tsc >= 2.576) AS metrics ON tokens.id_6gram = metrics.id_6gram