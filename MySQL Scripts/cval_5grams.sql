SELECT
       id_5gram    ,
       colloc_freq ,
       longer_count,
       longer_freq
from
       (
                SELECT
                         COUNT(*)  AS longer_count,
                         SUM(freq) AS longer_freq ,
                         id_5gram
                FROM
                         (
                                SELECT
                                       w1              ,
                                       w2              ,
                                       w3              ,
                                       w4              ,
                                       w5              ,
                                       w6              ,
                                       id_6gram        ,
                                       d{}_freq as freq,
                                       5gram
                                FROM
                                       6grams_tokens
                                       JOIN
                                              (
                                                     SELECT
                                                            5gram          ,
                                                            id_6gram as id6,
                                                            d{}_freq as freq
                                                     FROM
                                                            6grams
                                              )
                                              AS 6gr
                                              ON
                                                     6grams_tokens.id_6gram = 6gr.id6
                         )
                         AS 6grf
                         JOIN
                                  5grams_tokens
                                  ON
                                           id_5gram = `6grf`.`5gram`
                                           OR
                                           (
                                                    6grf.w2     = 5grams_tokens.w1
                                                    AND 6grf.w3 = 5grams_tokens.w2
                                                    AND 6grf.w4 = 5grams_tokens.w3
                                                    AND 6grf.w5 = 5grams_tokens.w4
                                                    AND 6grf.w6 = 5grams_tokens.w5
                                           )
                group by
                         id_5gram
       )
       as l
       join
              (
                     select
                            d{}_freq as colloc_freq,
                            id_5gram as i
                     from
                            5grams
              )
              as 5gr
              on
                     id_5gram = i