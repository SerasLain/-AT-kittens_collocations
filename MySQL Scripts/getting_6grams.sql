SELECT
       w1,
       w2,
       w3,
       w4,
       w5,
       w6
FROM
       (
              SELECT
                     w1         ,
                     w2         ,
                     w3         ,
                     w4         ,
                     w5         ,
                     id_position,
                     id_sent    ,
                     id_text
              FROM
                     (
                            SELECT
                                   w1         ,
                                   w2         ,
                                   w3         ,
                                   w4         ,
                                   id_position,
                                   id_sent    ,
                                   id_text
                            FROM
                                   (
                                          SELECT
                                                 w1         ,
                                                 w2         ,
                                                 w3         ,
                                                 id_position,
                                                 id_sent    ,
                                                 id_text
                                          FROM
                                                 (
                                                        SELECT
                                                               id_sent    ,
                                                               id_position,
                                                               id_text    ,
                                                               w1         ,
                                                               w2
                                                        FROM
                                                               (
                                                                      SELECT
                                                                             id_sent      ,
                                                                             words.id_text,
                                                                             id_position  ,
                                                                             id_unigram AS w1
                                                                      FROM
                                                                             words,
                                                                             metadata
                                                                      WHERE
                                                                             words.id_text          = metadata.id_text
                                                                             AND metadata.id_domain = %s
                                                               )
                                                               AS word1
                                                               JOIN
                                                                      (
                                                                             SELECT
                                                                                    id_sent     AS id_sent_    ,
                                                                                    id_text     AS id_text_    ,
                                                                                    id_position AS id_position_,
                                                                                    id_unigram  AS w2
                                                                             FROM
                                                                                    words
                                                                      )
                                                                      AS word2
                                                                      ON
                                                                             word1.id_text             = word2.id_text_
                                                                             AND word1.id_sent         = word2.id_sent_
                                                                             AND word1.id_position + 1 = word2.id_position_
                                                 )
                                                 AS bigr
                                                 JOIN
                                                        (
                                                               SELECT
                                                                      id_sent     AS id_sent_    ,
                                                                      id_text     AS id_text_    ,
                                                                      id_position AS id_position_,
                                                                      id_unigram  AS w3
                                                               FROM
                                                                      words
                                                        )
                                                        AS word3
                                                        ON
                                                               id_sent                  = id_sent_
                                                               AND id_text              = id_text_
                                                               AND bigr.id_position + 2 = id_position_
                                   )
                                   AS trigr
                                   JOIN
                                          (
                                                 SELECT
                                                        id_sent     AS id_sent_    ,
                                                        id_text     AS id_text_    ,
                                                        id_position AS id_position_,
                                                        id_unigram  AS w4
                                                 FROM
                                                        words
                                          )
                                          AS word4
                                          ON
                                                 id_sent                   = id_sent_
                                                 AND id_text               = id_text_
                                                 AND trigr.id_position + 3 = id_position_
                     )
                     AS 4gr
                     JOIN
                            (
                                   SELECT
                                          id_sent     AS id_sent_    ,
                                          id_text     AS id_text_    ,
                                          id_position AS id_position_,
                                          id_unigram  AS w5
                                   FROM
                                          words
                            )
                            AS word5
                            ON
                                   id_sent                 = id_sent_
                                   AND id_text             = id_text_
                                   AND 4gr.id_position + 4 = id_position_
       )
       AS 5gr
       JOIN
              (
                     SELECT
                            id_sent     AS id_sent_    ,
                            id_text     AS id_text_    ,
                            id_position AS id_position_,
                            id_unigram  AS w6
                     FROM
                            words
              )
              AS word6
              ON
                     id_sent                 = id_sent_
                     AND id_text             = id_text_
                     AND 5gr.id_position + 5 = id_position_