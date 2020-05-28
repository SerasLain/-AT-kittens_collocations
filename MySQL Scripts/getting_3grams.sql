SELECT
       w1,
       w2,
       w3
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
                                   id_unigram as w1
                            FROM
                                   words,
                                   metadata
                            where
                                   words.id_text          = metadata.id_text
                                   and metadata.id_domain = %s
                     )
                     AS word1
                     JOIN
                            (
                                   SELECT
                                          id_sent     as id_sent_    ,
                                          id_text     as id_text_    ,
                                          id_position as id_position_,
                                          id_unigram  as w2
                                   FROM
                                          words
                            )
                            AS word2
                            ON
                                   word1.id_text             = word2.id_text_
                                   AND word1.id_sent         = word2.id_sent_
                                   AND word1.id_position + 1 = word2.id_position_
       )
       as bigr
       join
              (
                     SELECT
                            id_sent     as id_sent_    ,
                            id_text     as id_text_    ,
                            id_position as id_position_,
                            id_unigram  as w3
                     from
                            words
              )
              as word3
              on
                     id_sent                  = id_sent_
                     and id_text              = id_text_
                     and bigr.id_position + 2 = id_position_