SELECT
       unigrams.id_unigram
FROM
       unigrams,
       words   ,
       metadata
WHERE
       unigrams.id_unigram    = words.id_unigram
       AND words.id_text      = metadata.id_text
       AND metadata.id_domain = 3
INTO
       third_domain_unigrams