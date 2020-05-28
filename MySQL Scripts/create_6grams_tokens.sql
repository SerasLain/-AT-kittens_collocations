create table 6grams_tokens as
select
       w1         ,
       w2         ,
       w3         ,
       w4         ,
       w5         ,
       token as w6,
       id_6gram   ,
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
                     w5,
                     id_5gram
              from
                     5grams_tokens
       )
       as 5gr
       join
              6grams
              on
                     5gram = id_5gram"]