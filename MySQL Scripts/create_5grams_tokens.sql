create table 5grams_tokens as
select
       w1         ,
       w2         ,
       w3         ,
       w4         ,
       token as w5,
       id_5gram   ,
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
                     w4,
                     id_4gram
              from
                     4grams_tokens
       )
       as 4gr
       join
              5grams
              on
                     4gram = id_4gram