create table 4grams_tokens as
select
       w1         ,
       w2         ,
       w3         ,
       token as w4,
       id_4gram   ,
       d1_freq    ,
       d2_freq    ,
       d3_freq    ,
       d4_freq    ,
       d5_freq    ,
       d6_freq
from
       (
              select
                     w1,
                     w2,
                     w3,
                     id_trigram
              from
                     3grams_tokens
       )
       as 3gr
       join
              4grams
              on
                     id_trigram = trigram