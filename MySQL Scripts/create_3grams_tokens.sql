create table 3grams_tokens as
select
       w1         ,
       w2         ,
       token as w3,
       id_trigram ,
       d1_freq    ,
       d2_freq    ,
       d3_freq    ,
       d4_freq    ,
       d5_freq    ,
       d6_freq
from
       (
              select
                     id_bigram       ,
                     wordform_1 as w1,
                     wordform_2 as w2
              from
                     2grams
              where
                     tscore             > 2.576
                     and raw_frequency >= 10
       )
       as 2gr
       join
              3grams
              on
                     bigram = id_bigram