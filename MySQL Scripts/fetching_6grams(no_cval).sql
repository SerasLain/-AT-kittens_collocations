select
         id_6gram       ,
         unigram as w1  ,
         pos     as pos1,
         w2             ,
         pos2           ,
         w3             ,
         pos3           ,
         w4             ,
         pos4           ,
         w5             ,
         pos5           ,
         w6             ,
         pos6           ,
         logd
from
         (
                select
                       id_6gram       ,
                       wordform_1     ,
                       unigram as w2  ,
                       pos     as pos2,
                       w3             ,
                       pos3           ,
                       w4             ,
                       pos4           ,
                       w5             ,
                       pos5           ,
                       w6             ,
                       pos6           ,
                       logd
                from
                       (
                              SELECT
                                     id_6gram       ,
                                     bigram         ,
                                     unigram AS w3  ,
                                     pos     AS pos3,
                                     w4             ,
                                     pos4           ,
                                     w5             ,
                                     pos5           ,
                                     w6             ,
                                     pos6           ,
                                     logd
                              FROM
                                     (
                                            SELECT
                                                   id_6gram       ,
                                                   trigram        ,
                                                   unigram AS w4  ,
                                                   pos     AS pos4,
                                                   w5             ,
                                                   pos5           ,
                                                   w6             ,
                                                   pos6           ,
                                                   logd
                                            FROM
                                                   (
                                                          SELECT
                                                                 id_6gram       ,
                                                                 4gram          ,
                                                                 unigram AS w5  ,
                                                                 pos     AS pos5,
                                                                 w6             ,
                                                                 pos6           ,
                                                                 logd
                                                          FROM
                                                                 (
                                                                        SELECT
                                                                               id_6gram,
                                                                               4gram   ,
                                                                               token   ,
                                                                               w6      ,
                                                                               pos6    ,
                                                                               logd
                                                                        FROM
                                                                               (
                                                                                      SELECT
                                                                                             id_6gram       ,
                                                                                             5gram          ,
                                                                                             unigram AS w6  ,
                                                                                             pos     AS pos6,
                                                                                             logd
                                                                                      FROM
                                                                                             (
                                                                                                    SELECT
                                                                                                           id_6gram,
                                                                                                           5gram   ,
                                                                                                           token   ,
                                                                                                           d2_logdice AS logd
                                                                                                    FROM
                                                                                                           cat.6grams
                                                                                                    WHERE
                                                                                                           d2_tsc >= 2.55
                                                                                             )
                                                                                             AS 6gr
                                                                                             JOIN
                                                                                                    cat.unitags
                                                                                                    ON
                                                                                                           token = id_unigram
                                                                               )
                                                                               AS 65gr
                                                                               JOIN
                                                                                      5grams
                                                                                      ON
                                                                                             5gram = id_5gram
                                                                 )
                                                                 AS 5gr
                                                                 JOIN
                                                                        cat.unitags
                                                                        ON
                                                                               token = id_unigram
                                                   )
                                                   AS 4gr
                                                   JOIN
                                                          4grams
                                                          ON
                                                                 4gram = id_4gram
                                                   JOIN
                                                          unitags
                                                          ON
                                                                 token = id_unigram
                                     )
                                     AS 3gr
                                     join
                                            3grams
                                            on
                                                   trigram = id_trigram
                                     join
                                            unitags
                                            ON
                                                   token = id_unigram
                       )
                       as 2gr
                       join
                              2grams
                              on
                                     id_bigram = bigram
                       join
                              unitags
                              on
                                     wordform_2 = id_unigram
         )
         as 1gr
         join
                  unitags
                  on
                           wordform_1 = id_unigram
order by
         logd desc