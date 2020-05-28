SELECT
       id_4gram                         ,
       freq as colloc_freq,
       COUNT(*) as longer_count,
       SUM(longer_freq)  as longer_freq
FROM
       (
              SELECT
                     id_4gram                ,
                     _id,
                     longer_freq, d{}_freq as freq
              FROM
                     (
                              SELECT
                                       id_4gram,
                                       4grams_tokens.d{}_freq,
                                       _id     ,
                                       longer_freq
                              FROM
                                       4grams_tokens
                                       JOIN
                                                (
                                                       SELECT        w1, w2, w3, w4, w5, d{}_freq AS longer_freq, id_5gram
                                                       FROM
                                                              5grams_tokens
                                                              JOIN
                                                                     (
                                                                            SELECT
                                                                                   4gram,
                                                                                   id_5gram AS _id
                                                                            FROM
                                                                                   5grams
                                                                     )
                                                                     AS 4gr
                                                                     ON
                                                                            id_5gram = _id
                                                )
                                                AS 5gr
                                                ON
                                                         4gram = id_4gram
                                                         OR
                                                         (
                                                                  4grams_tokens.w1     = 5gr.w2
                                                                  AND 4grams_tokens.w2 = 5gr.w3
                                                                  AND 4grams_tokens.w3 = 5gr.w4
                                                                  AND 4grams_tokens.w4 = 5gr.w5
                                                         )
                              group by
                                       id_4gram
                     )
                     AS 5grl
              UNION ALL
              (SELECT
                       id_4gram       ,
                       4gr.d{}_freq as freq,
                       id_6gram AS _id,
						6gr.d{}_freq as longer_freq
              FROM
                       4grams_tokens as 4gr
                       JOIN
                               
                                              6grams_tokens as 6gr
                                ON
                                         (
                                                  4gr.w1     = 6gr.w1
                                                  AND 4gr.w2 = 6gr.w2
                                                  AND 4gr.w3 = 6gr.w3
                                                  AND 4gr.w4 = 6gr.w4
                                         )
                                         OR
                                         (
                                                  4gr.w1     = 6gr.w2
                                                  AND 4gr.w2 = 6gr.w3
                                                  AND 4gr.w3 = 6gr.w4
                                                  AND 4gr.w4 = 6gr.w5
                                         )
                                         OR
                                         (
                                                  4gr.w1     = 6gr.w3
                                                  AND 4gr.w2 = 6gr.w4
                                                  AND 4gr.w3 = 6gr.w5
                                                  AND 4gr.w4 = 6gr.w6
                                         )
              )
					   
       ) as 4ggr
       group by id_4gram