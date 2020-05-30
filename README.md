# CAT&kittens: the database and the collocation extraction code

The application to access the data and to proceed computations of association measures. The application is a part of the CAT&kittens project (Klimov et al., in press).


Requirements :

- Python 3.6+
- mysql-connector-python	8.0.17	8.0.20
- ufal.udpipe 1.2.0.2
- SynTagRus UDpipe model: russian-syntagrus-ud-2.4-190531.udpipe

Modules description:

1. Database:
* ud_parser.py - tool to annotate plain texts in Russian using UDPipe SynTagRus model
* colloc.py - tool to comuting association measures (t-score, logDice, PMI, c-value)
* cat_db.py - main database interface

The corpus cannot be published open-access. To request an access to the corpus, write to @Seraslain .
