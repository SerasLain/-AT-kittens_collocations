select
       id_bigram  ,
       w1         ,
       pos1       ,
       w2         ,
       pos2       ,
       d{}_freq   ,
       d{}_pmi    ,
       d{}_logdice,
       d{}_tsc    ,
       d{}_cval
from
       (
              select
                     id_bigram as _id ,
                     unigram   as w2  ,
                     pos       as pos2,
                     d{}_freq         ,
                     d{}_pmi          ,
                     d{}_logdice      ,
                     d{}_tsc          ,
                     d{}_cval
              from
                     (
                            select
                                   id_bigram  ,
                                   wordform_2 ,
                                   d{}_freq   ,
                                   d{}_pmi    ,
                                   d{}_logdice,
                                   d{}_tsc    ,
                                   d{}_cval
                            from
                                   2grams
                            where
                                   d{}_tsc      >= 2.576
                                   and d{}_freq >= 3
                     )
                     as w2
                     join
                            unitags
                            on
                                   wordform_2 = id_unigram
       )
       as metrics
       join
              (
                     select
                            id_bigram    ,
                            unigram as w1,
                            pos     as pos1
                     from
                            (
                            (
                                   select
                                          id_bigram,
                                          wordform_1
                                   from
                                          2grams
                            )
                            as w1
                            join
                                   unitags
                                   on
                                          wordform_1 = id_unigram)
              )
              as token
              on
                     id_bigram =_id