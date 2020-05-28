SELECT id_bigram ,
       w1  ,
       pos1      ,
       w2  ,
       pos2      ,
       3w1       ,
       3w1_pos,
       3w2       ,
       3w2_pos,
       unigram as 3w3       ,
       pos as 3w3_pos,
       id_trigram       ,
       d2_freq   ,
       d2_pmi    ,
       d2_logdice,
       d2_tsc    ,
       d2_cval
       from
(SELECT id_bigram ,
       w1  ,
       pos1      ,
       w2  ,
       pos2      ,
       3w1       ,
       3w1_pos,
       unigram as 3w2       ,
       pos as 3w2_pos,
       3w3       ,
       id_trigram       ,
       d2_freq   ,
       d2_pmi    ,
       d2_logdice,
       d2_tsc    ,
       d2_cval
from
(SELECT id_bigram ,
       w1  ,
       pos1      ,
       w2  ,
       pos2      ,
       unigram as 3w1       ,
       pos as 3w1_pos,
       3w2       ,
       3w3       ,
       id_trigram       ,
       d2_freq   ,
       d2_pmi    ,
       d2_logdice,
       d2_tsc    ,
       d2_cval
       from
       (SELECT
       id_bigram ,
       u1 as w1  ,
       pos1      ,
       u2 as w2  ,
       pos2      ,
       3w1       ,
       3w2       ,
       3w3       ,
       id_trigram       ,
       d2_freq   ,
       d2_pmi    ,
       d2_logdice,
       d2_tsc    ,
       d2_cval
from
       (
              SELECT *
              from
                     (
                            SELECT
                                   id_bigram ,
                                   w1        ,
                                   w2        ,
                                   3w1       ,
       3w2       ,
       3w3       ,
       id_trigram       ,
                                   d2_freq   ,
                                   d2_pmi    ,
                                   d2_logdice,
                                   d2_tsc    ,
                                   d2_cval
                            FROM
                                   (
                                          SELECT
                                                 id_bigram       ,
                                                 wordform_1 AS w1,
                                                 wordform_2 AS w2,
                                                 d2_freq         ,
                                                 d2_pmi          ,
                                                 d2_logdice      ,
                                                 d2_tsc          ,
                                                 d2_cval
                                          FROM
                                                 2grams
                                          WHERE
                                                 d2_freq    >= 3
                                                 AND d2_tsc >= 2.55
                                   )
                                   AS 2gr
                                   JOIN
                                          (
                                                 SELECT
                                                        id_trigram AS _id,
                                                        bigram
                                                 FROM
                                                        3grams
                                          )
                                          AS 3gr
                                          ON
                                                 bigram = id_bigram
                                   JOIN
                                          (
                                                 SELECT
                                                        w1 as 3w1,
                                                        w2 as 3w2,
                                                        w3 as 3w3,
                                                        id_trigram
                                                 from
                                                        3grams_tokens
                                          )
                                          as 3tok
                                          on
                                                 _id = id_trigram
                     )
                     as firs
              UNION
              SELECT
                     id_bigram ,
                     w1        ,
                     w2        ,
                     3w1       ,
                     3w2       ,
                     3w3       ,
                     id_trigram,
                     d2_freq   ,
                     d2_pmi    ,
                     d2_logdice,
                     d2_tsc    ,
                     d2_cval
              FROM
                     (
                            SELECT
                                   id_bigram       ,
                                   wordform_1 AS w1,
                                   wordform_2 AS w2,
                                   d2_freq         ,
                                   d2_pmi          ,
                                   d2_logdice      ,
                                   d2_tsc          ,
                                   d2_cval
                            FROM
                                   2grams
                            WHERE
                                   d2_freq    >= 3
                                   AND d2_tsc >= 2.55
                     )
                     AS 2gr
                     join
                            (
                                   SELECT
                                          w1 as 3w1,
                                          w2 as 3w2,
                                          w3 as 3w3,
                                          id_trigram
                                   from
                                          3grams_tokens
                            )
                            as 3tok
                            on
                                   (
                                          w1     = 3w2
                                          AND w2 = 3w3
                                   )
       )
       as metrics
       join
              (
                     select
                            id_unigram   ,
                            unigram as u1,
                            pos     as pos1
                     from
                            unitags
              )
              as unigr1
              on
                     w1 = id_unigram
       join
              (
                     select
                            id_unigram as _id,
                            unigram    as u2 ,
                            pos        as pos2
                     from
                            unitags
              )
              as unigr2
              on
                     w2 = _id) as b
                     join unitags on 3w1 = id_unigram) as c
                     join unitags on 3w2 = id_unigram) as d
                     join unitags on 3w3 = id_unigram

    