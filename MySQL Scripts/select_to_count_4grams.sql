SELECT
       id_trigram,
       d{}_freq
FROM
       (
              SELECT
                     id_bigram
              FROM
                     2grams
              WHERE
                     wordform_1     = %s
                     AND wordform_2 = %s
       )
       AS bigr
       JOIN
              3grams
              ON
                     bigram    = id_bigram
                     AND token = %s