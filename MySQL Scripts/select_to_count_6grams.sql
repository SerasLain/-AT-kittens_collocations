select
       id_5gram,
       d{}_freq
from
       (
              SELECT
                     id_4gram
              FROM
                     (
                            SELECT
                                   id_trigram
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
                     )
                     AS trigr
                     JOIN
                            4grams
                            ON
                                   trigram   = id_trigram
                                   AND token = %s
       )
       as 4gr
       JOIN
              5grams
              ON
                     4gram     = id_4gram
                     AND token = %s