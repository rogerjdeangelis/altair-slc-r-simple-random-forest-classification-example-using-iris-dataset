# altair-slc-r-simple-random-forest-classification-example-using-iris-dataset
Altair slc r simple random forest classification example using iris dataset
    %let pgm=utl-altair-slc-r-simple-random-forest-classification-example-using-iris-dataset;

    Altair slc r simple random forest classification example using iris dataset

    %stop_submission;

    Too long to post here see github
    https://github.com/rogerjdeangelis/altair-slc-r-simple-random-forest-classification-example-using-iris-dataset

    PROBLEM

      Identify the species of iris floweres given Sepal_Length, Sepal_Width, Petal_Length, and Petal_Width.

      This is just a template, the iris dataset is too small with 4 fact variables to yeild an improvement
      over a single tree CART software.

      Be skeptical of this post. Github is a software development site where
      issues are welcome.

    CONTENTS

       i  OVERVIEW SIMPLE PROGRAM

           1 Inputs
             a training
               d:/wpswrkx/iris20260101_train.sas7bdat
             b holdout (validation)
               d:/wpswrkx/iris20260101_holdout.sas7bdat

           2 confusion datasets and predictions
             a Training
               d:/wpswrkx/train_cm.sas7bdat
             b Holdout
               d:/wpswrkx/holdout_cm.sas7bdat
             c Training and Holdout
               d:/wpswrkx/combined_cm.sas7bdat
             d combined model predictions
               d:/wpswrkx/combined_pred.sas7bdat

           3 combinrd model saved to r file
             d:/rds/iris_rf_model.rds

           4 Apply classifier to next weeks data
             a next week inputs
               d:/wpswrkx/iris20260105.sas7bdat
               d:/rds/iris_rf_model.rds
             b next week pedictions
               d:/wpswrkx/iris20260105_pred.sas7bdat
             c species frequency of next week data

      ii  SIMPLIFIED PROCESS FOR OVERVIEW

           1 inputs
           2  model build verfify and save
           3  build output

     iii  THEORY AND DIAGMOSTICS

           1  comments

           2  inputs

           3  gridplot of histogrames and scatterplots
              d:/pdf/gridplot.pdf

           4  multi-dimensional scaling plot
              d:/pdf/mds.pdf
               vey useful for undestanding the trees

           5  randomforest process
              d:/txt/rf_gini.txt
              d:/txt/training.txt
              d:/txt/rf_classifier_train.txt
              d:/txt/gettree.txt
              d:/txt/rcasewhen.txt
              d:/txt/rcasewhen.txt
              d:/pdf/rocr_holdout.pdf
              d:/pdf/gini_training.pdf
              d:/pdf/errorbytree_training.pdf

           6  apply saved model
              input: d;/wpswrk/iris20260105.sas7bdat
              output: d;/wpswrk/iris20260105_pred.sas7bdat
                      d;/wpswrk/iris20260105_species_freq

           7  freq next week

           8  calc confusion by hand

           9  roc auc analysis
              d:/pdf/rocr_holdout.pdf

          10  out of bag error
              d:/pdf/errorbytree_training.pdf

          11  gini
              d:/pdf/gini_training.pdf

          12  1st tree case/when
              d:/txt/rcasewhen.sas

          13  execute case/when
              d;/wpswrk/iris_from_tree.sas7bdat

          14  1st tree confusion

          15   randomforest objects

          16  sample tree

    You can find any missing macros in
    https://github.com/rogerjdeangelis/utl-macros-used-in-many-of-rogerjdeangelis-repositories


    Be skeptical of this post. Github is a software development site where
    issues are welcome.

    REVEALING VALUABLE ADDITIONAL INSIGHTS
    --------------------------------------

       1  Repository files and readme
       2  Necessity to create miss-classifications
       3  Multidimensional Scaling.
       4  First tree has the lowest error and how many trees are needed


    1  The text of this message provides general documentation on randomforest.
       All of the r and slc code in the message have be run and produce the files in the repository

    2  Because Random forest is so powerfull, with this small sample, I had to
       create miss-classifications in the holdout(validation) data,
       otherwise the validation dataset had 100 matches,
       The first tree does a remakable job in classification.

       You can force a miss-classifications in the holdout by duplicating
       Sepal_Length, Sepal_Width, Petal_Length, and Petal_Width
       and assigning two different Species

              Sepal_    Sepal_    Petal_    Petal_
       Obs    Length     Width    Length     Width    Species

         1      5.0       3.3       1.4       0.2     virginica   one of these will be a miss-classification
         2      5.0       3.3       1.4       0.2     versicolor

    3  Using Multidimensional Scaling to reveal underlying structures i the data.

                            Dimension 1
            -5.0     -2.5      0.0      2.5      5.0
          2 +-+--------+--------+--------+--------+--+ 2
            |                                        |
            |          +    + Setosa        X        |
       D    |         +     . Versicolor     X       |   D
       I  1 +          +    X Virginica              + 1 I
       M    |         +++                  X         |   M
       E    |          +             .   X XX        |   E
       N    |         +++          ..  XXXXX X       |   N
       S    |       + ++           ....XXX    X      |   S
       I  0 +         +++        .... XXXX           + 0 I
       O    |         ++       . ....XXXX            |   O
       N    |        ++        ..... XX              |   N
            |       + +        .....XXX              |
       2    |                .  ..   X               |   2
         -1 +         +      .                       + 1
            |                 .   X                  |
            |                                        |
            +-+--------+--------+--------+--------+--+
            -5.0     -2.5      0.0      2.5      5.0
                           Dimension 1

            This indicates than Setosa will be easier to classify
            (however my corruption of the data weakend setosa classification)

    With small sample size like iris (150 with 100 training) is is not
    unusual for early trees to have the least error, as is one case run here,

    4  how many trees do i need. (out of bag alysis)
        Note the plateauing at around 37 trees.
        Also note that the first tree has the minnimum error


                                          TREE
                12345678911111111112222222222333333333344  777777778888  9999991
                         01234567890123456789012345678901  234567890123  4567890
                                                                               0
             ---+++++++++++++++++++++++++++++++++++++++++// +++++++++++//+++++++-
         OOB |  | OUT OF BAD ERRORS BY TREES (LEVELS OUT AT TREE 37)            |  OOB
        0.12 +  |                                     TREE       OOB            + 0.12
             |  |<-- fist tree has least error                                  |
             |  |                                       1     0.025641          |
             |  | *                                     2     0.046875          |
        0.10 +  |                                      ..                       + 0.10
             |  |                                      99     0.038835          |
             |  |   *                                 100     0.038835          |
             |  |*                          ********                            |
        0.08 +  |                                                               + 0.08
             |  |  * **    ****   * **** ***        *****//************//*******|
             |  |                                                               |
             |  |        *     *** *    *                                       |
        0.06 +  |                                                               + 0.06
             |  |      ** *                                                     |
             |  *                                                               |
             |  |                                                               |
        0.04 +  |<-- fist tree has least error                                  + 0.04
             |  |                                                               |
             ---+++++++++++++++++++++++++++++++++++++++++//++++++++++++//+++++++-
                12345678911111111112222222222333333333344  777777778888  9999991
                         01234567890123456789012345678901  234567890123  4567890
                                           TREE                                0

    Another isse



    INPUTS

    iris20260101_train.sas7bdat      training
    iris20260101_holdout.sas7bdat    holdout 9VALIDATION)

    iris20260105.sas7bdat            next weeks data load

    OUTPUTS


    d:/txt/rf_gini.txt                                training confusion matrix
    d:/txt/training.txt                               training confusion matrix
    d:/txt/rf_classifier_train.txt                    structure of list of all rf_classifier 19 objets
    d:/txt/gettree.txt                                first tree as a dataframe
    d:/txt/sqlcode_train.txt                          sql 'CASE when' code for all 100 trees (if then else also aviAlable)
                                                      you don't need these trees, use the binary rds file below

    d:/rds/iris_rf_model.rds                          save model function in a binary rds for latter execution

    d:/pdf/rocr_holdout.pdf                           roc auc curves
    d:/pdf/gini_training.pdf                          comprate decrease in accuracy by species
    d:/pdf/errorbytree_training.pdf

    d:/wpswrkx/irs20260101_holdout_pred.sas7bdat      holdout predictions
    d:/wpswrkx/irs20260101_holdout_roc_auc.sas7bdat   holdout roc aucs
    d:/wpswrkx/irs20260101_train_err.sas7bdat         errors by tree for training data (levels off)
    d:/wpswrkx/irs20260101_train_gini.sas7bdat        gini

     _                             _
    (_)   _____   _____ _ ____   _(_) _____      __
    | |  / _ \ \ / / _ \ `__\ \ / / |/ _ \ \ /\ / /
    | | | (_) \ V /  __/ |   \ V /| |  __/\ V  V /
    |_|  \___/ \_/ \___|_|    \_/ |_|\___| \_/\_/


        1 INPUTS OVERVIEW  70/30 PERCENT SPLIT (HOLDOUT IS THE VALIDATION DATASET)

           NOTE: The data set WORKX.IRIS20260101_TRAIN has 105 observations and 5 variables.  ~.7*150
           NOTE: The data set WORKX.IRIS20260101_HOLDOUT has 46 observations and 5 variables. ~.3*150

           NEW DATA
           NOTE: The data set WORKX.IRIS20260105 has 150 observations and 4 variables


          a THIS TRAINING AND HOLDOUT 70/30 PERCENT SPLIT

            WORKX.IRIS20260101_TRAIN TOTAL OBS=103

                   Sepal_    Sepal_    Petal_    Petal_
            Obs    Length     Width    Length     Width    Species

              1      5.0       3.3       1.4       0.2     setosa
              2      6.5       2.8       4.6       1.5     versicolor
              3      6.4       2.8       5.6       2.2     virginica
            ...
            101      5.3       3.7       1.5       0.2     setosa
            102      6.7       3.0       5.0       1.7     versicolor
            103      6.3       3.3       6.0       2.5     virginica


          b WORKX.IRIS20260101_HOLD  TOTAL OBS=46

                   Sepal_    Sepal_    Petal_    Petal_
            Obs    Length     Width    Length     Width    Species

              1      5.0       3.3       1.4       0.2     setosa
              2      6.5       2.8       4.6       1.5     versicolor
              3      6.4       2.8       5.6       2.2     virginica
            ...
             44      5.3       3.7       1.5       0.2     setosa
             45      6.7       3.0       5.0       1.7     versicolor
             46      6.3       3.3       6.0       2.5     virginica


        2 OUTPUT CONFUSION MATRICES
          --------------------------

          A TRAINING CONFUSION DATASET
            --------------------------

           Training - The model is built with 70% of the iris data ~.7*150 = 103

           Error rate: 5.83%  (6/103)

           SLC DATASET WORKX.TRAIN20260101_CM

           Species    setosa   versicolor  virginica sum         class_error

           setosa         30           0          0   30   0/20  0.00000000
           versicolor      0          36          2   38   2/38  0.05263158  * 2 miss-classification
           virginica       0           4         31   35   4/35  0.11428571  * 4 miss-classification

           sum            30          40         22  103  6/103  0.05825243  * 6 miss-classification

          B HOLDOUT CONFUSION DATASET
           --------------------------

           HOLDOUT - Results using training model on holdout sample  30% of the iris data ~.3*150 = 47

           Error rate: 4.26% (2/47)

           SLC DATASET WORKX.HOLDOUT20260101_CM

           Species    setosa    versicolor virginica sum         class_error

           setosa         20           0          0   20   0/20  0.00000000
           versicolor      0          11          1   12   1/12  0.08333333
           virginica       0           1         14   15   1/14  0.07142857

           sum            20          12         15   47   2/47  0.04255320

          C COMBINED HOLDOUT PLUS TRAINING CONFUSION DATASET
            ------------------------------------------------

            HOLDOUT- Results using training + holdout model on holdout sample 100% of the iris data 150 obs

            Error rate: 4.67% (7/150)

            SLC DATASET WORKX.COMBINED20260101_CM

            Species    setosa  versicolor virginica class_error

            setosa         50           0         0        0.00
            versicolor      0          47         3        0.06
            virginica       0           4        46        0.08

            sum            50          51        49

        3 SAVED COMBINED HOLDOUT PLUS TRAINING MODEL TO R DATA
          ----------------------------------------------------

          SAVED MODEL: d:/rds/iris_rf_model.rds (unzipped)

          *--- CREATE HEX LISTING ---;
          %*utlrulr
            (
             uinflt =d:/rds/iris_rf_model,
             uprnlen =100,
             ulrecl  =100,
             urecfm   =f,
             uobs = 3,
             uchrtyp =ascii,
             uotflt =d:\txt\delete.hex
            );


          ASCII Flatfile Ruler & Hex
          utlrulr
          d:/rds/iris_rf_model.rds
          d:\txt\delete.hex


           --- Record Number ---  1   ---  Record Length ---- 100

          X.................CP1252........................randomForest................formula................~
          1...5....10...15...20...25...30...35...40...45...50...55...60...65...70...75...80...85...90...95...1
          5000000000000000004533330001000100000000000000007666664676770000000000000000667676600000000000000007
          8A000304520350000630125200330003000600010409000C21E4FD6F253400420001040900076F2D5C10006000104090001E


           --- Record Number ---  2   ---  Record Length ---- 100

          ................Species.....................................data............combined_data...........
          1...5....10...15...20...25...30...35...40...45...50...55...60...65...70...75...80...85...90...95...1
          0000000000000000576666700000000000000002000F00000000000000006676000000000000666666665667600100000000
          000200010409000730539530002000104090001E000E0042000104090004414100010409000D3FD29E54F414100420001040


           --- Record Number ---  3   ---  Record Length ---- 100

          .....importance............................ntree........@.@.........................classification..
          1...5....10...15...20...25...30...35...40...45...50...55...60...65...70...75...80...85...90...95...1
          0000066767766660000000000000010000000000000677660000000047400000000F00010000000000006667766666766600
          9000A9D0F241E35000A000100010042000104090005E4255000E00010F000000000E000000010409000E3C1339693149FE00


        4 APPLY CLASSIFIER TO NEXT WEEKS DATA
          ------------------------------------

          A INPUT (NO SPECIES COLUMN)
          ---------------------------

            WORKX.IRIS20260105 total obs=150

                   Sepal_    Sepal_    Petal_    Petal_
            Obs    Length     Width    Length     Width

              1      5.1       3.4       1.4       0.2
              2      6.6       2.9       4.7       1.6
              3      6.4       2.8       5.7       2.3
            ...
            148      5.4       3.7       1.6       0.2
            149      6.7       3.0       5.0       1.7
            150      6.3       3.3       6.0       2.6

         B JUST TWO R STATEMENTS
           ---------------------

            loaded_model <- readRDS("d:/rds/iris_rf_model.rds")
            iris20260105_pred <- predict(loaded_model, iris20260105)


         C OUTPUT
           ------

            WORKX.ADD_ORIGINAL_DATA total obs=150

                   Sepal_    Petal_    Petal_    Sepal_    IRIS20260105_
            Obs     Width    Length     Width    Length        PRED

              1      3.3       1.4       0.2       5.0      setosa
              2      2.8       4.6       1.5       6.5      versicolor
              3      2.8       5.6       2.2       6.4      virginica
            ...
            148      3.7       1.5       0.2       5.3      setosa
            149      3.0       5.0       1.7       6.7      versicolor
            150      3.3       6.0       2.5       6.3      virginica


            IRIS20260105_                             Cumulative    Cumulative
            PRED             Frequency     Percent     Frequency      Percent
            ------------------------------------------------------------------
            setosa                 49       32.67            49        32.67
            versicolor             53       35.33           102        68.00
            virginica              48       32.00           150       100.00

         _                   _
    / | (_)_ __  _ __  _   _| |_ ___
    | | | | `_ \| `_ \| | | | __/ __|
    | | | | | | | |_) | |_| | |_\__ \
    |_| |_|_| |_| .__/ \__,_|\__|___/
                |_|

      WORKX.IRIS20260101_TRAIN TOTAL OBS=103
      --------------------------------------

             Sepal_    Sepal_    Petal_    Petal_
      Obs    Length     Width    Length     Width    Species

        1      5.0       3.3       1.4       0.2     setosa
        2      6.5       2.8       4.6       1.5     versicolor
        3      6.4       2.8       5.6       2.2     virginica
      ...
      101      5.3       3.7       1.5       0.2     setosa
      102      6.7       3.0       5.0       1.7     versicolor
      103      6.3       3.3       6.0       2.5     virginica


      WORKX.IRIS20260101_HOLD  TOTAL OBS=46
      -------------------------------------

             Sepal_    Sepal_    Petal_    Petal_
      Obs    Length     Width    Length     Width    Species

        1      5.0       3.3       1.4       0.2     setosa
        2      6.5       2.8       4.6       1.5     versicolor
        3      6.4       2.8       5.6       2.2     virginica
      ...
       44      5.3       3.7       1.5       0.2     setosa
       45      6.7       3.0       5.0       1.7     versicolor
       46      6.3       3.3       6.0       2.5     virginica


      NEXT WEEKS DATA (idetify species)
      WORKX.IRIS20260105 total obs=150
      --------------------------------

             Sepal_    Sepal_    Petal_    Petal_
      Obs    Length     Width    Length     Width

        1      5.1       3.4       1.4       0.2
        2      6.6       2.9       4.7       1.6
        3      6.4       2.8       5.7       2.3
      ...
      148      5.4       3.7       1.6       0.2
      149      6.7       3.0       5.0       1.7
      150      6.3       3.3       6.0       2.6
    */

    /*   _             _
     ___| |_ __ _ _ __| |_
    / __| __/ _` | `__| __|
    \__ \ || (_| | |  | |_
    |___/\__\__,_|_|   \__|

    */

    proc datasets lib=workx kill nolist nodetails;
    run;quit;

    /*--- iris data 20260101 will be split in R to 70/30 training/holdout ---*/

    options validvarname=v7;
    data
      workx.iris20260101_train
      workx.iris20260101_holdout;

      retain beenthere 0 Sepal_Length Sepal_Width Petal_Length Petal_Width Species;
      informat Species $10.;

      input Species Sepal_Length Sepal_Width Petal_Length Petal_Width @@;

       holdout=(uniform(54321)<.3);

       array ns[*] Sepal_Length Sepal_Width Petal_Length Petal_Width;
       do i=1 to dim(ns);
         ns[i]=ns[i]/10;
       end;

       if holdout and beenthere=0 and species='setosa' then do;
          species='virginica' ; output workx.iris20260101_holdout;
          species='versicolor'; output workx.iris20260101_holdout;
          beenthere=1;
       end;
       else if holdout then output workx.iris20260101_holdout;
       else output workx.iris20260101_train;

       drop i holdout beenthere;
    cards4;
    setosa 50 33 14 2  versicolor 65 28 46 15  virginica 64 28 56 22  setosa 57 44 15 4  versicolor 57 30 42 12  virginica 64 28 56 21
    setosa 46 34 14 3  versicolor 62 22 45 15  virginica 67 31 56 24  setosa 50 36 14 2  versicolor 66 29 46 13  virginica 62 28 48 18
    setosa 46 36 10 2  versicolor 59 32 48 18  virginica 63 28 51 15  setosa 54 34 15 4  versicolor 52 27 39 14  virginica 77 30 61 23
    setosa 51 33 17 5  versicolor 61 30 46 14  virginica 69 31 51 23  setosa 52 41 15 1  versicolor 60 34 45 16  virginica 63 34 56 24
    setosa 55 35 13 2  versicolor 60 27 51 16  virginica 65 30 52 20  setosa 55 42 14 2  versicolor 50 20 35 10  virginica 58 27 51 19
    setosa 48 31 16 2  versicolor 56 25 39 11  virginica 65 30 55 18  setosa 49 31 15 2  versicolor 55 24 37 10  virginica 72 30 58 16
    setosa 52 34 14 2  versicolor 57 28 45 13  virginica 58 27 51 19  setosa 54 39 17 4  versicolor 58 27 39 12  virginica 71 30 59 21
    setosa 49 36 14 1  versicolor 63 33 47 16  virginica 68 32 59 23  setosa 50 34 15 2  versicolor 62 29 43 13  virginica 64 31 55 18
    setosa 44 32 13 2  versicolor 70 32 47 14  virginica 62 34 54 23  setosa 44 29 14 2  versicolor 59 30 42 15  virginica 60 30 48 18
    setosa 50 35 16 6  versicolor 64 32 45 15  virginica 77 38 67 22  setosa 47 32 13 2  versicolor 60 22 40 10  virginica 63 29 56 18
    setosa 44 30 13 2  versicolor 61 28 40 13  virginica 67 33 57 25  setosa 46 31 15 2  versicolor 67 31 47 15  virginica 77 26 69 23
    setosa 47 32 16 2  versicolor 55 24 38 11  virginica 76 30 66 21  setosa 51 34 15 2  versicolor 63 23 44 13  virginica 60 22 50 15
    setosa 48 30 14 3  versicolor 54 30 45 15  virginica 49 25 45 17  setosa 50 35 13 3  versicolor 56 30 41 13  virginica 69 32 57 23
    setosa 51 38 16 2  versicolor 58 26 40 12  virginica 67 30 52 23  setosa 49 31 15 1  versicolor 63 25 49 15  virginica 74 28 61 19
    setosa 48 34 19 2  versicolor 55 26 44 12  virginica 59 30 51 18  setosa 54 37 15 2  versicolor 61 28 47 12  virginica 56 28 49 20
    setosa 50 30 16 2  versicolor 50 23 33 10  virginica 63 25 50 19  setosa 54 39 13 4  versicolor 64 29 43 13  virginica 73 29 63 18
    setosa 50 32 12 2  versicolor 67 31 44 14  virginica 64 32 53 23  setosa 51 35 14 3  versicolor 51 25 30 11  virginica 67 25 58 18
    setosa 43 30 11 1  versicolor 56 30 45 15  virginica 79 38 64 20  setosa 48 34 16 2  versicolor 57 28 41 13  virginica 65 30 58 22
    setosa 58 40 12 2  versicolor 58 27 41 10  virginica 67 33 57 21  setosa 48 30 14 1  versicolor 61 29 47 14  virginica 69 31 54 21
    setosa 51 38 19 4  versicolor 60 29 45 15  virginica 77 28 67 20  setosa 45 23 13 3  versicolor 56 29 36 13  virginica 72 36 61 25
    setosa 49 30 14 2  versicolor 57 26 35 10  virginica 63 27 49 18  setosa 57 38 17 3  versicolor 69 31 49 15  virginica 65 32 51 20
    setosa 51 35 14 2  versicolor 57 29 42 13  virginica 72 32 60 18  setosa 51 38 15 3  versicolor 55 25 40 13  virginica 64 27 53 19
    setosa 50 34 16 4  versicolor 49 24 33 10  virginica 61 30 49 18  setosa 54 34 17 2  versicolor 55 23 40 13  virginica 68 30 55 21
    setosa 46 32 14 2  versicolor 56 27 42 13  virginica 61 26 56 14  setosa 51 37 15 4  versicolor 66 30 44 14  virginica 57 25 50 20
    setosa 57 44 15 4  versicolor 57 30 42 12  virginica 64 28 56 21  setosa 52 35 15 2  versicolor 68 28 48 14  virginica 58 28 51 24
    setosa 50 36 14 2  versicolor 66 29 46 13  virginica 62 28 48 18  setosa 53 37 15 2  versicolor 67 30 50 17  virginica 63 33 60 25
    ;;;;
    run;quit;

    /*               _                       _              _       _
     _ __   _____  _| |_  __      _____  ___| | _____    __| | __ _| |_ __ _
    | `_ \ / _ \ \/ / __| \ \ /\ / / _ \/ _ \ |/ / __|  / _` |/ _` | __/ _` |
    | | | |  __/>  <| |_   \ V  V /  __/  __/   <\__ \ | (_| | (_| | || (_| |
    |_| |_|\___/_/\_\\__|   \_/\_/ \___|\___|_|\_\___/  \__,_|\__,_|\__\__,_|

    Need to classify into species
    */

    options validvarname=v7;

    data
      workx.iris20260105(label="next weeks data");

      retain  Sepal_Width Petal_Length Petal_Width ;

      input Sepal_Length Sepal_Width Petal_Length Petal_Width @@;

      array ns[*] Sepal_Length Sepal_Width Petal_Length Petal_Width;
      do i=1 to dim(ns);
        ns[i]=ns[i]/10;
      end;

      drop i;

    cards4;
    50 33 14 2  65 28 46 15  64 28 56 22  50 36 14 2  57 30 42 12  57 30 42 12
    46 34 14 3  62 22 45 15  67 31 56 24  54 34 15 4  52 27 39 14  57 30 42 12
    46 36 10 2  59 32 48 18  63 28 51 15  52 41 15 1  60 34 45 16  63 34 56 24
    51 33 17 5  61 30 46 14  69 31 51 23  55 42 14 2  50 20 35 10  58 27 51 19
    55 35 13 2  60 27 51 16  65 30 52 20  49 31 15 2  55 24 37 10  72 30 58 16
    48 31 16 2  56 25 39 11  65 30 55 18  54 39 17 4  58 27 39 12  71 30 59 21
    52 34 14 2  57 28 45 13  58 27 51 19  50 34 15 2  62 29 43 13  64 31 55 18
    49 36 14 1  63 33 47 16  68 32 59 23  44 29 14 2  59 30 42 15  60 30 48 18
    44 32 13 2  70 32 47 14  62 34 54 23  47 32 13 2  60 22 40 10  63 29 56 18
    50 35 16 6  64 32 45 15  77 38 67 22  46 31 15 2  67 31 47 15  77 26 69 23
    44 30 13 2  61 28 40 13  67 33 57 25  51 34 15 2  63 23 44 13  60 22 50 15
    47 32 16 2  55 24 38 11  76 30 66 21  50 35 13 3  56 30 41 13  69 32 57 23
    48 30 14 3  54 30 45 15  49 25 45 17  49 31 15 1  63 25 49 15  74 28 61 19
    51 38 16 2  58 26 40 12  67 30 52 23  54 37 15 2  61 28 47 12  56 28 49 20
    48 34 19 2  58 26 40 12  67 30 52 23  54 39 13 4  64 29 43 13  73 29 63 18
    50 30 16 2  50 23 33 10  63 25 50 19  51 35 14 3  51 25 30 11  67 25 58 18
    50 32 12 2  67 31 44 14  64 32 53 23  48 34 16 2  57 28 41 13  65 30 58 22
    43 30 11 1  56 30 45 15  79 38 64 20  48 30 14 1  61 29 47 14  69 31 54 21
    58 40 12 2  58 27 41 10  67 33 57 21  45 23 13 3  56 29 36 13  72 36 61 25
    51 38 19 4  60 29 45 15  77 28 67 20  57 38 17 3  69 31 49 15  65 32 51 20
    49 30 14 2  57 26 35 10  63 27 49 18  51 38 15 3  55 25 40 13  64 27 53 19
    51 35 14 2  57 29 42 13  72 32 60 18  54 34 17 2  55 23 40 13  68 30 55 21
    50 34 16 4  49 24 33 10  61 30 49 18  51 37 15 4  66 30 44 14  57 25 50 20
    46 32 14 2  56 27 42 13  61 26 56 14  52 35 15 2  68 28 48 14  58 28 51 24
    57 44 15 4  57 30 42 12  64 28 56 21  53 37 15 2  67 30 50 17  63 33 60 25
    ;;;;
    run;quit;

    /*___   _           _ _     _                 _  __                                                 _      _
    |___ \ | |__  _   _(_) | __| |__   _____ _ __(_)/ _|_   _  ___  __ ___   _____  _ __ ___   ___   __| | ___| |
      __) || `_ \| | | | | |/ _` |\ \ / / _ \ `__| | |_| | | |/ __|/ _` \ \ / / _ \| `_ ` _ \ / _ \ / _` |/ _ \ |
     / __/ | |_) | |_| | | | (_| | \ V /  __/ |  | |  _| |_| |\__ \ (_| |\ V /  __/| | | | | | (_) | (_| |  __/ |
    |_____||_.__/ \__,_|_|_|\__,_|  \_/ \___|_|  |_|_|  \__, ||___/\__,_| \_/ \___||_| |_| |_|\___/ \__,_|\___|_|
                                                        |___/
    */

    /*---
      Train, Verify and save model
    ---*/

    %utlfkil(d:/rds/iris_rf_classifier.rds);

    proc delete data=
      workx.train20260101_cm
      workx.holdout20260101_cm
      workx.combined20260101_pred;
    run;quit;

    options set=RHOME "C:\Progra~1\R\R-4.5.2\bin\r";

    proc r;
    export data=workx.iris20260101_train   r=train_data;
    export data=workx.iris20260101_holdout r=holdout_data;
    submit;
    # Load required library
    library(randomForest)

    # covert confusion matrices to dataframes function & msking rownames a charater column
    conf2df <- function(df) {
      df <- as.data.frame.matrix(df)
      result <- data.frame(Species = rownames(df), df,row.names = NULL)
      return(result)
     }

    # get training and holdout and make Species a factor
    train_data$Species<-as.factor(train_data$Species)
    holdout_data$Species<-as.factor(holdout_data$Species)

    # 1. Train Random Forest model
    rf_classifier = randomForest(Species ~ ., data=train_data, ntree=100, mtry=2, importance=TRUE)

    # Predictions and confusion matrices
    # 2. Training set predictions
    train_cm <- conf2df(rf_classifier$confusion[, 1:3])
    cat("Training Confusion Matrix:\n")
    print(train_cm)

    # 3. Holdout set predictions
    holdout_pred <- predict(rf_classifier, holdout_data)
    holdout_cm <- conf2df(table(Actual = holdout_data$Species, Predicted = holdout_pred))
    cat("\nHoldout Confusion Matrix:\n")
    print(holdout_cm)

    # 4. Combined set (training + holdout) predictions
    combined_data <- rbind(train_data, holdout_data)
    rf_classifier = randomForest(Species ~ ., data=combined_data, ntree=100, mtry=2, importance=TRUE)
    combined_cm <- conf2df(rf_classifier$confusion[, 1:3])
    cat("\nCombined Data Confusion Matrix:\n")
    print(combined_cm)

    # 5 Save model to RDS file
    saveRDS(rf_classifier, "d:/rds/iris_rf_classifier.rds")
    cat("\nModel saved as 'd:/rds/iris_rf_classifier.rds'\n")

    predict <- predict(rf_classifier,combined_data)
    combined_pred<-as.data.frame(cbind(combined_data,predict))
    head(combined_pred)

    endsubmit;

    import data=workx.train20260101_cm      r=train_cm     ;
    import data=workx.holdout20260101_cm    r=holdout_cm    ;
    import data=workx.combined20260101_cm   r=combined_cm   ;
    import data=workx.combined20260101_pred r=combined_pred ;

    run;quit;

    /*--- BACK TO PARENT SLC PROCESS ---*/

    data allthree;
      retain from;
      set
        workx.train20260101_cm(in=t)
        workx.holdout20260101_cm(in=h)
        workx.combined20260101_cm(in=c);
     array ts[3] setosa versicolor virginica;
     select;
       when (t) FROM='train   ';
       when (h) FROM='holdout ';
       when (c) FROM='combined';
     end;  /*--- lave off otherwise to force error ---*/
     select;
       when (mod(_n_,3) = 1) class_err=(ts[2]+ts[3])/sum(of ts[*]);
       when (mod(_n_,3) = 2) class_err=(ts[1]+ts[3])/sum(of ts[*]);
       when (mod(_n_,3) = 0) class_err=(ts[1]+ts[2])/sum(of ts[*]);
     end;
    run;quit;

    proc report data=allthree headskip;
    define from /group order=data;
    break after from /skip;
    run;quit;

    /*                 _                             _      _
      __ _ _ __  _ __ | |_   _   _ __ ___   ___   __| | ___| |
     / _` | `_ \| `_ \| | | | | | `_ ` _ \ / _ \ / _` |/ _ \ |
    | (_| | |_) | |_) | | |_| | | | | | | | (_) | (_| |  __/ |
     \__,_| .__/| .__/|_|\__, | |_| |_| |_|\___/ \__,_|\___|_|
          |_|   |_|      |___/
    */

    proc delete data=workx.iris20260105_pred;
    run;quit;

    options set=RHOME "C:\Progra~1\R\R-4.5.2\bin\r";
    proc r;
    export data=workx.iris20260105 r=iris20260105;
    submit;

    # Load required library
    library(randomForest)

    # Example: How to use saved model on new data
    # Load model and predict on new data (using holdout as example new data)
    loaded_model <- readRDS("d:/rds/iris_rf_classifier.rds")

    # predict from saved model
    iris20260105_pred <- predict(loaded_model, iris20260105)

    endsubmit;
    import data=iris20260105_pred  r=iris20260105_pred  ;
    run;quit;

    data workx.iris20260105_pred;
      merge workx.iris20260105 iris20260105_pred;
    run;quit;

    proc freq data=workx.iris20260105_pred ;
      tables iris20260105_pred /out=species_freq;
    run;

    proc print data=species_freq;
    run;quit;

    /*____   _           _ _     _               _               _
    |___ /  | |__  _   _(_) | __| |   ___  _   _| |_ _ __  _   _| |_
      |_ \  | `_ \| | | | | |/ _` |  / _ \| | | | __| `_ \| | | | __|
     ___) | | |_) | |_| | | | (_| | | (_) | |_| | |_| |_) | |_| | |_
    |____/  |_.__/ \__,_|_|_|\__,_|  \___/ \__,_|\__| .__/ \__,_|\__|

    CONTENTS of workx (d:/wpswrkx)
    ------------------------------

    iris20260101_holdout.sas7bdat   5,120 Inputs
    iris20260101_train.sas7bdat     9,216
           .
    train20260101_cm.sas7bdat       5,120 confusion matrix
    holdout20260101_cm.sas7bdat     5,120 confusion matrix
    combined20260101_cm.sas7bdat    5,120 confusion matrix

    combined20260101_pred.sas7bdat 17,408 combined data input to saved model for later use

    iris20260105.sas7bdat           9,216 next weeks data


    SLC SAS DATASETS
    ----------------

    WORKX.TRAIN20260101_CM total obs=3 08JAN2026:10:59:29

     Species       setosa    versicolor    virginica

     setosa          38           0             0
     versicolor       0          32             3
     virginica        0           4            32


    WORKX.HOLDOUT20260101_CM total obs=3 08JAN2026:11:00:06

    Species       setosa    versicolor    virginica

    setosa          13           0             0
    versicolor       1          17             0
    virginica        1           0            16


    4WORKX.COMBINED20260101_CM total obs=3 08JAN2026:11:12:01

     Species       setosa    versicolor    virginica

     setosa          51           0             0
     versicolor       0          49             4
     virginica        0           5            48


    TEXT OUTPUT
    -----------

    Training Confusion Matrix:
                Predicted
    Actual       setosa versicolor virginica
      setosa         34          0         0
      versicolor      0         37         0
      virginica       0          0        34


    Holdout Confusion Matrix:
                Predicted
    Actual       setosa versicolor virginica
      setosa         16          0         0
      versicolor      0         12         1
      virginica       0          2        14


    Combined Data Confusion Matrix:
                Predicted
    Actual       setosa versicolor virginica
      setosa         50          0         0
      versicolor      0         49         1
      virginica       0          2        48


    Altair SLC

      FROM      SPECIES        SETOSA VERSICOLOR  VIRGINICA  CLASS_ERR

      train     setosa             34          0          0          0
                versicolor          0         37          0          0
                virginica           0          0         34          0

      holdout   setosa             16          0          0          0
                versicolor          0         12          1  0.0769231
                virginica           0          2         14      0.125

      combined  setosa             50          0          0          0
                versicolor          0         49          1       0.02
                virginica           0          2         48       0.04


    WHAT THE SAVED MODEL LOOKS LIKE IN THE RDS FILE (RANDOM FOREST FORMULA FILE)
    ----------------------------------------------------------------------------

    SAVED MODEL: d:/rds/iris_rf_model.rds (unzipped)

    %utlrulr
      (
       uinflt =d:/rds/iris_rf_model,
       uprnlen =100,  /* Linesize for Dump */
       ulrecl  =100,  /* maximum record length */
       urecfm   =f,
       uobs = 3,        /* number of obs to dump */
       uchrtyp =ascii,  /* ascii or ebcdic */
       uotflt =d:\txt\delete.hex
      );


    ASCII Flatfile Ruler & Hex
    utlrulr
    d:/rds/iris_rf_model.rds
    d:\txt\delete.hex


     --- Record Number ---  1   ---  Record Length ---- 100

    X.................CP1252........................randomForest................formula................~
    1...5....10...15...20...25...30...35...40...45...50...55...60...65...70...75...80...85...90...95...1
    5000000000000000004533330001000100000000000000007666664676770000000000000000667676600000000000000007
    8A000304520350000630125200330003000600010409000C21E4FD6F253400420001040900076F2D5C10006000104090001E


     --- Record Number ---  2   ---  Record Length ---- 100

    ................Species.....................................data............combined_data...........
    1...5....10...15...20...25...30...35...40...45...50...55...60...65...70...75...80...85...90...95...1
    0000000000000000576666700000000000000002000F00000000000000006676000000000000666666665667600100000000
    000200010409000730539530002000104090001E000E0042000104090004414100010409000D3FD29E54F414100420001040


     --- Record Number ---  3   ---  Record Length ---- 100

    .....importance............................ntree........@.@.........................classification..
    1...5....10...15...20...25...30...35...40...45...50...55...60...65...70...75...80...85...90...95...1
    0000066767766660000000000000010000000000000677660000000047400000000F00010000000000006667766666766600
    9000A9D0F241E35000A000100010042000104090005E4255000E00010F000000000E000000010409000E3C1339693149FE00


    FROM THE RN ON NEXT WEEKS DATA
    ------------------------------

     WORKX.IRIS20260105_PRED total obs=150 08JAN2026:11:28:14

                                                    PREDICTED
            Sepal_    Petal_    Petal_    Sepal_    IRIS20260105_
     Obs     Width    Length     Width    Length        PRED

       1      3.3       1.4       0.2       5.0      setosa
       2      2.8       4.6       1.5       6.5      versicolor
       3      2.8       5.6       2.2       6.4      virginica
     ...
     148      3.7       1.5       0.2       5.3      setosa
     149      3.0       5.0       1.7       6.7      versicolor
     150      3.3       6.0       2.5       6.3      virginica


     IRIS20260105_                             Cumulative    Cumulative
     PRED             Frequency     Percent     Frequency      Percent
     ------------------------------------------------------------------
     setosa                 49       32.67            49        32.67
     versicolor             53       35.33           102        68.00
     virginica              48       32.00           150       100.00

    /*  _     _
    | || |   | | ___   __ _
    | || |_  | |/ _ \ / _` |
    |__   _| | | (_) | (_| |
       |_|   |_|\___/ \__, |
                      |___/
    */

    %macro logoff();
    1                                          Altair SLC      14:05 Saturday, January 10, 2026

    NOTE: Copyright 2002-2025 World Programming, an Altair Company
    NOTE: Altair SLC 2026 (05.26.01.00.000758)
          Licensed to Roger DeAngelis
    NOTE: This session is executing on the X64_WIN11PRO platform and is running in 64 bit mode

    NOTE: AUTOEXEC processing beginning; file is C:\wpsoto\autoexec.sas
    NOTE: AUTOEXEC source line
    1       +  ï»¿ods _all_ close;
               ^
    ERROR: Expected a statement keyword : found "?"
    NOTE: Library workx assigned as follows:
          Engine:        SAS7BDAT
          Physical Name: d:\wpswrkx

    NOTE: Library slchelp assigned as follows:
          Engine:        WPD
          Physical Name: C:\Progra~1\Altair\SLC\2026\sashelp


    LOG  JUST AFTER AUTOEXEC---- TIME=14:05 -----
    NOTE: 1 record was written to file PRINT

    NOTE: The data step took :
          real time : 0.015
          cpu time  : 0.031


    NOTE: AUTOEXEC processing completed

    1
    2         %utlfkil(d:/rds/iris_rf_classifier.rds);
    The file d:/rds/iris_rf_classifier.rds does not exist
    3
    4         proc delete data=
    5           workx.train20260101_cm
    6           workx.holdout20260101_cm
    7           workx.combined20260101_pred;
    8         run;quit;
    NOTE: WORKX.TRAIN20260101_CM (memtype="DATA") was not found, and has not been deleted
    NOTE: WORKX.HOLDOUT20260101_CM (memtype="DATA") was not found, and has not been deleted
    NOTE: WORKX.COMBINED20260101_PRED (memtype="DATA") was not found, and has not been deleted
    NOTE: Procedure delete step took :
          real time : 0.000
          cpu time  : 0.000


    9
    10        options set=RHOME "C:\Progra~1\R\R-4.5.2\bin\r";
    11
    12        proc r;
    NOTE: Using R version 4.5.2 (2025-10-31 ucrt) from C:\Program Files\R\R-4.5.2
    13        export data=workx.iris20260101_train   r=train_data;
    NOTE: Creating R data frame 'train_data' from data set 'WORKX.iris20260101_train'

    14        export data=workx.iris20260101_holdout r=holdout_data;
    NOTE: Creating R data frame 'holdout_data' from data set 'WORKX.iris20260101_holdout'

    15        submit;
    16        # Load required library
    17        library(randomForest)
    18
    19        # covert confusion matrices to dataframes function & msking rownames a charater column
    20        conf2df <- function(df) {

    2                                                                                                                         Altair SLC

    21          df <- as.data.frame.matrix(df)
    22          result <- data.frame(Species = rownames(df), df,row.names = NULL)
    23          return(result)
    24         }
    25
    26        # get training and holdout and make Species a factor
    27        train_data$Species<-as.factor(train_data$Species)
    28        holdout_data$Species<-as.factor(holdout_data$Species)
    29
    30        # 1. Train Random Forest model
    31        rf_classifier = randomForest(Species ~ ., data=train_data, ntree=100, mtry=2, importance=TRUE)
    32
    33        # Predictions and confusion matrices
    34        # 2. Training set predictions
    35        train_cm <- conf2df(rf_classifier$confusion[, 1:3])
    36        cat("Training Confusion Matrix:\n")
    37        print(train_cm)
    38
    39        # 3. Holdout set predictions
    40        holdout_pred <- predict(rf_classifier, holdout_data)
    41        holdout_cm <- conf2df(table(Actual = holdout_data$Species, Predicted = holdout_pred))
    42        cat("\nHoldout Confusion Matrix:\n")
    43        print(holdout_cm)
    44
    45        # 4. Combined set (training + holdout) predictions
    46        combined_data <- rbind(train_data, holdout_data)
    47        rf_classifier = randomForest(Species ~ ., data=combined_data, ntree=100, mtry=2, importance=TRUE)
    48        combined_cm <- conf2df(rf_classifier$confusion[, 1:3])
    49        cat("\nCombined Data Confusion Matrix:\n")
    50        print(combined_cm)
    51
    52        # 5 Save model to RDS file
    53        saveRDS(rf_classifier, "d:/rds/iris_rf_classifier.rds")
    54        cat("\nModel saved as 'd:/rds/iris_rf_classifier.rds'\n")
    55
    56        predict <- predict(rf_classifier,combined_data)
    57        combined_pred<-as.data.frame(cbind(combined_data,predict))
    58        head(combined_pred)
    59
    60        endsubmit;

    NOTE: Submitting statements to R:

    > # Load required library
    > library(randomForest)
    randomForest 4.7-1.2
    Type rfNews() to see new features/changes/bug fixes.
    >
    > # covert confusion matrices to dataframes function & msking rownames a charater column
    > conf2df <- function(df) {
    +   df <- as.data.frame.matrix(df)
    +   result <- data.frame(Species = rownames(df), df,row.names = NULL)
    +   return(result)
    +  }
    >
    > # get training and holdout and make Species a factor
    > train_data$Species<-as.factor(train_data$Species)
    > holdout_data$Species<-as.factor(holdout_data$Species)
    >
    > # 1. Train Random Forest model
    > rf_classifier = randomForest(Species ~ ., data=train_data, ntree=100, mtry=2, importance=TRUE)
    >
    > # Predictions and confusion matrices

    3                                                                                                                         Altair SLC

    > # 2. Training set predictions
    > train_cm <- conf2df(rf_classifier$confusion[, 1:3])
    > cat("Training Confusion Matrix:\n")
    > print(train_cm)
    >
    > # 3. Holdout set predictions
    > holdout_pred <- predict(rf_classifier, holdout_data)
    > holdout_cm <- conf2df(table(Actual = holdout_data$Species, Predicted = holdout_pred))
    > cat("\nHoldout Confusion Matrix:\n")
    > print(holdout_cm)
    >
    > # 4. Combined set (training + holdout) predictions
    > combined_data <- rbind(train_data, holdout_data)
    > rf_classifier = randomForest(Species ~ ., data=combined_data, ntree=100, mtry=2, importance=TRUE)
    > combined_cm <- conf2df(rf_classifier$confusion[, 1:3])
    > cat("\nCombined Data Confusion Matrix:\n")
    > print(combined_cm)
    >
    > # 5 Save model to RDS file
    > saveRDS(rf_classifier, "d:/rds/iris_rf_classifier.rds")
    > cat("\nModel saved as 'd:/rds/iris_rf_classifier.rds'\n")
    >
    > predict <- predict(rf_classifier,combined_data)
    > combined_pred<-as.data.frame(cbind(combined_data,predict))
    > head(combined_pred)
    >

    NOTE: Processing of R statements complete

    61
    62        import data=workx.train20260101_cm      r=train_cm     ;
    NOTE: Creating data set 'WORKX.train20260101_cm' from R data frame 'train_cm'
    NOTE: Column names modified during import of 'train_cm'
    NOTE: Data set "WORKX.train20260101_cm" has 3 observation(s) and 4 variable(s)

    63        import data=workx.holdout20260101_cm    r=holdout_cm    ;
    NOTE: Creating data set 'WORKX.holdout20260101_cm' from R data frame 'holdout_cm'
    NOTE: Column names modified during import of 'holdout_cm'
    NOTE: Data set "WORKX.holdout20260101_cm" has 3 observation(s) and 4 variable(s)

    64        import data=workx.combined20260101_cm   r=combined_cm   ;
    NOTE: Creating data set 'WORKX.combined20260101_cm' from R data frame 'combined_cm'
    NOTE: Column names modified during import of 'combined_cm'
    NOTE: Data set "WORKX.combined20260101_cm" has 3 observation(s) and 4 variable(s)

    65        import data=workx.combined20260101_pred r=combined_pred ;
    NOTE: Creating data set 'WORKX.combined20260101_pred' from R data frame 'combined_pred'
    NOTE: Column names modified during import of 'combined_pred'
    NOTE: Data set "WORKX.combined20260101_pred" has 157 observation(s) and 6 variable(s)

    66
    67        run;quit;
    NOTE: Procedure r step took :
          real time : 0.555
          cpu time  : 0.046


    68
    69        /*--- BACK TO PARENT SLC PROCESS ---*/
    70
    71        data allthree;
    72          retain from;
    73          set

    4                                                                                                                         Altair SLC

    74            workx.train20260101_cm(in=t)
    75            workx.holdout20260101_cm(in=h)
    76            workx.combined20260101_cm(in=c);
    77         array ts[3] setosa versicolor virginica;
    78         select;
    79           when (t) FROM='train   ';
    80           when (h) FROM='holdout ';
    81           when (c) FROM='combined';
    82         end;  /*--- lave off otherwise to force error ---*/
    83         select;
    84           when (mod(_n_,3) = 1) class_err=(ts[2]+ts[3])/sum(of ts[*]);
    85           when (mod(_n_,3) = 2) class_err=(ts[1]+ts[3])/sum(of ts[*]);
    86           when (mod(_n_,3) = 0) class_err=(ts[1]+ts[2])/sum(of ts[*]);
    87         end;
    88        run;

    NOTE: 3 observations were read from "WORKX.train20260101_cm"
    NOTE: 3 observations were read from "WORKX.holdout20260101_cm"
    NOTE: 3 observations were read from "WORKX.combined20260101_cm"
    NOTE: Data set "WORK.allthree" has 9 observation(s) and 6 variable(s)
    NOTE: The data step took :
          real time : 0.090
          cpu time  : 0.000


    88      !     quit;
    89
    90        proc report data=allthree headskip;
    91        define from /group order=data;
    92        break after from /skip;
    93        run;quit;
    NOTE: 9 observations were read from "WORK.allthree"
    NOTE: Procedure report step took :
          real time : 0.023
          cpu time  : 0.000


    94
    95        /*                 _                             _      _
    96          __ _ _ __  _ __ | |_   _   _ __ ___   ___   __| | ___| |
    97         / _` | `_ \| `_ \| | | | | | `_ ` _ \ / _ \ / _` |/ _ \ |
    98        | (_| | |_) | |_) | | |_| | | | | | | | (_) | (_| |  __/ |
    99         \__,_| .__/| .__/|_|\__, | |_| |_| |_|\___/ \__,_|\___|_|
    100             |_|   |_|      |___/
    101       */
    102
    103       proc delete data=workx.iris20260105_pred;
    104       run;quit;
    NOTE: WORKX.IRIS20260105_PRED (memtype="DATA") was not found, and has not been deleted
    NOTE: Procedure delete step took :
          real time : 0.000
          cpu time  : 0.000


    105
    106       options set=RHOME "C:\Progra~1\R\R-4.5.2\bin\r";
    107       proc r;
    NOTE: Using R version 4.5.2 (2025-10-31 ucrt) from C:\Program Files\R\R-4.5.2
    108       export data=workx.iris20260105 r=iris20260105;
    NOTE: Creating R data frame 'iris20260105' from data set 'WORKX.iris20260105'

    109       submit;
    110

    5                                                                                                                         Altair SLC

    111       # Load required library
    112       library(randomForest)
    113
    114       # Example: How to use saved model on new data
    115       # Load model and predict on new data (using holdout as example new data)
    116       loaded_model <- readRDS("d:/rds/iris_rf_classifier.rds")
    117
    118       # predict from saved model
    119       iris20260105_pred <- predict(loaded_model, iris20260105)
    120
    121       endsubmit;

    NOTE: Submitting statements to R:

    >
    > # Load required library
    > library(randomForest)
    randomForest 4.7-1.2
    Type rfNews() to see new features/changes/bug fixes.
    >
    > # Example: How to use saved model on new data
    > # Load model and predict on new data (using holdout as example new data)
    > loaded_model <- readRDS("d:/rds/iris_rf_classifier.rds")
    >
    > # predict from saved model
    > iris20260105_pred <- predict(loaded_model, iris20260105)
    >

    NOTE: Processing of R statements complete

    122       import data=iris20260105_pred  r=iris20260105_pred  ;
    NOTE: Creating data set 'WORK.iris20260105_pred' from R data frame 'iris20260105_pred'
    NOTE: Column names modified during import of 'iris20260105_pred'
    NOTE: Data set "WORK.iris20260105_pred" has 150 observation(s) and 1 variable(s)

    123       run;quit;
    NOTE: Procedure r step took :
          real time : 0.311
          cpu time  : 0.015


    124
    125       data workx.iris20260105_pred;
    126         merge workx.iris20260105 iris20260105_pred;
    127       run;

    NOTE: 150 observations were read from "WORKX.iris20260105"
    NOTE: 150 observations were read from "WORK.iris20260105_pred"
    NOTE: Data set "WORKX.iris20260105_pred" has 150 observation(s) and 5 variable(s)
    NOTE: The data step took :
          real time : 0.011
          cpu time  : 0.015


    127     !     quit;
    128
    129       proc freq data=workx.iris20260105_pred ;
    130         tables iris20260105_pred /out=species_freq;
    131       run;
    NOTE: 150 observations were read from "WORKX.iris20260105_pred"
    NOTE: Data set "WORK.species_freq" has 3 observation(s) and 3 variable(s)
    NOTE: Procedure freq step took :
          real time : 0.031

    6                                                                                                                         Altair SLC

          cpu time  : 0.031


    132
    133       proc print data=species_freq;
    134       run;quit;
    NOTE: 3 observations were read from "WORK.species_freq"
    NOTE: Procedure print step took :
          real time : 0.031
          cpu time  : 0.000


    ERROR: Error printed on page 1

    NOTE: Submitted statements took :
          real time : 1.499
          cpu time  : 0.234


    %mend logoff;
    /*       _   _
    __   __ | |_| |__   ___  ___  _ __ _   _
    \ \ / / | __| `_ \ / _ \/ _ \| `__| | | |
     \ V /  | |_| | | |  __/ (_) | |  | |_| |
      \_/    \__|_| |_|\___|\___/|_|   \__, |
     _                                 |___/      _
    / |   ___ ___  _ __ ___  _ __ ___   ___ _ __ | |_ ___
    | |  / __/ _ \| `_ ` _ \| `_ ` _ \ / _ \ `_ \| __/ __|
    | | | (_| (_) | | | | | | | | | | |  __/ | | | |_\__ \
    |_|  \___\___/|_| |_| |_|_| |_| |_|\___|_| |_|\__|___/

    */

        R simple random forest classification example using iris datase

        Unlike CART or Logistic Regression, randomforest does not provide insight into
        your data. It is primarily a black box with bootstrapping and randomly selected and averaged
        variables and subsets of the data. It often 'averages' 1,000 pf decision rees.

        What you need to know about a randomforest of trees before you start.
        ====================================================================

        "Trees in RF and single trees are built using the same algorithm (usually CART).
        The only minor difference is that a single tree tries all predictors at each split,
        whereas trees in RF only try a random subset of the predictors at each split
        (this creates independent trees). Also, each tree in a RF is built on a bootstrap
        sample of the training data, rather than on the full training
        data set. This makes each tree in the forest an expert on
        some domains of the data space, and bad elsewhere.

        So, for these reasons, it makes no sense to extract a single tree
        from a Random Forest in order to use it as a classifier. Depending on its domains of expertise,
        it could give you better results than a traditional tree built with CART on the full dataset,
        or much worse. The thing that allows a RF to be much better than a single tree is that
        it grows many decorrelated trees and averages their output. Only when the committee
        of ensemble of trees has enough members (usually between 200 and 2000) is variance reduced.
        But individually, each tree of a RF would be weaker than a single tree built via traditional CART."

        https://tinyurl.com/y9uznf5s
        https://stats.stackexchange.com/users/71672/antoine

        Even though Python has popular statistical packages, I prefer R. Primarily becaose of
        very skilled statisticians and programmers behind R.

           Frank Harrel     ASA Fellow Professor of Biostatistics Vanderbuilt Founding Chair
           Brian Ripley     Phd Guy Medal Royal Statistical Society Applied Stat U of Oxford(past)
           Duncan Murdoch   Professor Ameritus Carleton University,
           Brian Ripley     Professor of Statistics at the University of Auckland

           and many others

           Method (R)

             1. Split the iris data into a training and hold out sample,
                70% training and 30% holdout .
                We will build the random forest model using the training data and
                then apply the model to the hold out sample(verification data).

             2. 100 decision trees will be generated. We will pick with binary splits.
                Select randomly 2 of the four IRIS variable.
                see https://towardsdatascience.com/what-is-out-of-bag-oob-score-in-random-forest-a7fa23d710

             3. Do over trees
                Generate a bootstrap sample from the training data
                create a classification tree usin the bootstrapped data
                for each split selecte 2 variables at random
                pick the best variable of the two and split then node
                use defualt stopping criteria
                repeat

             4. Validate by applying the model developed using the training data to
                the hold out sample

             5. The randomForest function in R
                rf_model <- randomForest(target ~ ., data = your_data, mtry = 2, ntree = 500)
                Here, each split considers only 2 random predictors from the full set.


    /*___    _                   _
    |___ \  (_)_ __  _ __  _   _| |_
      __) | | | `_ \| `_ \| | | | __|
     / __/  | | | | | |_) | |_| | |_
    |_____| |_|_| |_| .__/ \__,_|\__|
                    |_|
    see d:/wpswrkx/IRIS20260105.sas7bdat and iris20260101.sas7bdat

    INPUTS FROM ABOVE ALL WE NEED
    -----------------------------

    d:/wpswrkx

    iris20260101_holdout.sas7bdat   5,120 Inputs
    iris20260101_train.sas7bdat     9,216

    iris20260105.sas7bdat           9,216 next weeks data

    */

    proc datasets lib=workx nodetails nolist;
      save
        iris20260101_holdout
        iris20260101_train
        iris20260105
        ;
    quit;

    /*
     _____              _     _         _       _
    |___ /    __ _ _ __(_) __| |  _ __ | | ___ | |_
      |_ \   / _` | `__| |/ _` | | `_ \| |/ _ \| __|
     ___) | | (_| | |  | | (_| | | |_) | | (_) | |_
    |____/   \__, |_|  |_|\__,_| | .__/|_|\___/ \__|
             |___/               |_|
    */

    %utlfkil(d:/pdf/gridplot.pdf);

    options orientation=landscape;
    ods graphics on / reset width=10in height=8in;
    ODS pdf file="d:/pdf/gridplot.pdf";

    title1 "Sepal and Petal Sizes in Iris Species Training Dataset";
    proc sgscatter data=workx.iris20260101_train;
    matrix sepal_width sepal_length petal_width
    petal_length / group=species
    diagonal=(histogram kernel);
    run;
    ods pdf close;
    ods graphics off;

    /*---
       SPECIES

       + Setosa
       . Versicolor
       X Virginica

                  Sepal Width                Sepal Length                Petal Width
      S   ------------------------------------------------------- ---------------------------
      e  |             ##            ||                          ||                          |
      p  |             ##            ||                          ||                          |
      a  |             ##            ||           + +            ||           + +            |
      l  |          ## ##            ||        + +   +           ||        + +   +           |
         |          ## ##            ||  +  +++++++ +         x  ||  +  +++++++ +         x  |  ...
      W  |          ## ## ##         ||+ +++ +++ +    .. xxx. x  ||+ +++ +++ +    .. xxx. x  |
      i  |          ## ## ##         ||+ + +++   . .. x..xxx xxx ||+ + +++   . .. x..xxx xxx |
      d  |       ## ## ## ## ##      ||     x ..  .x.x .xx.     x||     x ..  .x.x .xx.     x|
      t  |       ## ## ## ## ##      || +   ..    .    .         || +   ..    .    .         |
      h  |    ## ## ## ## ## ## ##   ||      .                   ||      .                   |
         ------------------------------------------------------------------------------------
      S  |                           ||                          ||
      e  |                           ||                          ||
      p  |                           ||        ##                ||
      a  |  +   +                    ||        ## ## ##          ||
      l  |+ +   +                    ||        ## ## ##          ||                            ...
         |+ + + +                   x||        ## ## ## ##       ||
      L  |  + + + +         . . .   .||        ## ## ## ##       ||
      e  |+ + +      . . . . x . x  x||        #### ## ## ##     ||
      n  |     . . . . x x . x x x xx||        ## ## ## ## ##    ||
      g  |  +  . .   .   .           ||     ## ## ## ## ## ## ## ||
      t   ---------------------------------------------------------
      h


     _
    | | ___   __ _
    | |/ _ \ / _` |
    | | (_) | (_| |
    |_|\___/ \__, |
             |___/

    *.

    %macro logoff();

    1                                          Altair SLC      12:45 Thursday, January  8, 2026

    NOTE: Copyright 2002-2025 World Programming, an Altair Company
    NOTE: Altair SLC 2026 (05.26.01.00.000758)
          Licensed to Roger DeAngelis
    NOTE: This session is executing on the X64_WIN11PRO platform and is running in 64 bit mode

    NOTE: AUTOEXEC processing beginning; file is C:\wpsoto\autoexec.sas
    NOTE: AUTOEXEC source line
    1       +  ï»¿ods _all_ close;
               ^
    ERROR: Expected a statement keyword : found "?"
    NOTE: Library workx assigned as follows:
          Engine:        SAS7BDAT
          Physical Name: d:\wpswrkx

    NOTE: Library slchelp assigned as follows:
          Engine:        WPD
          Physical Name: C:\Progra~1\Altair\SLC\2026\sashelp


    NOTE: 1 record was written to file PRINT

    NOTE: The data step took :
          real time : 0.031
          cpu time  : 0.015


    NOTE: AUTOEXEC processing completed

    1          %utlfkil(d:/pdf/mds.pdf);
    The file d:/pdf/mds.pdf does not exist
    2         %utlfkil(d:/pdf/oob.pdf);
    The file d:/pdf/oob.pdf does not exist
    3         %utlfkil(d:/pdf/rocr.pdf);
    The file d:/pdf/rocr.pdf does not exist
    4         %utlfkil(d:/pdf/errorbytree.pdf);
    The file d:/pdf/errorbytree.pdf does not exist
    5         %utlfkil(d:/pdf/gini.pdf);
    The file d:/pdf/gini.pdf does not exist
    6         %utlfkil(d:/pdf/gridplot.pdf);
    7
    8         options orientation=landscape;
    9         ods graphics on / reset width=10in height=8in;
    10        ODS pdf file="d:/pdf/gridplot.pdf";
    11
    12        title1 "Sepal and Petal Sizes in Iris Species Training Dataset";
    13        proc sgscatter data=workx.iris20260101_train;
    14        matrix sepal_width sepal_length petal_width
    15        petal_length / group=species
    16        diagonal=(histogram kernel);
    17        run;
    NOTE: Writing file d:\pdf\gridplot.pdf
    NOTE: Successfully written image .\SGSCATTER.png
    NOTE: Procedure sgscatter step took :
          real time : 0.589
          cpu time  : 0.968


    18        ods pdf close;
    19        ods graphics off;
    ERROR: Error printed on page 1

    NOTE: Submitted statements took :
          real time : 1.194
          cpu time  : 1.265

    %mend logoff;

     _  _                    _   _     _ _                          _                   _        _       _
    | || |   _ __ ___  _   _| |_(_) __| (_)_ __ ___   ___ _ __  ___(_) ___  _ __   __ _| | _ __ | | ___ | |_
    | || |_ | `_ ` _ \| | | | __| |/ _` | | `_ ` _ \ / _ \ `_ \/ __| |/ _ \| `_ \ / _` | || `_ \| |/ _ \| __|
    |__   _|| | | | | | |_| | |_| | (_| | | | | | | |  __/ | | \__ \ | (_) | | | | (_| | || |_) | | (_) | |_
       |_|  |_| |_| |_|\__,_|\__|_|\__,_|_|_| |_| |_|\___|_| |_|___/_|\___/|_| |_|\__,_|_|| .__/|_|\___/ \__|
                                                                                          |_|
            see d:/pdf/mds.pdf
    ---*/

    %utlfkil(d:/pdf/mds.pdf);

    proc delete data=workx.want;
    run;quit;

    options set=RHOME "C:\Progra~1\R\R-4.5.2\bin\r";
    proc r;
    export data=workx.iris20260101+train r=iris;
    submit;
    library(data.table)

    # Prepare data
    iris$Species <- as.factor(iris$Species)
    irisDist <- dist(iris[,1:4])
    irisMds <- cmdscale(irisDist, k=2)

    # Create PDF
    pdf(file="d:/pdf/mds.pdf")

    # Plot
    plot(irisMds,
         pch = 16,
         col = c("red", "green", "blue")[iris$Species],
         xlab = "MDS Dimension 1",
         ylab = "MDS Dimension 2")

    # Add labels
    text(irisMds[,1], irisMds[,2] + 0.05,
         1:nrow(irisMds),
         cex = 0.4)

    # Add legend - SIMPLEST VERSION
    legend("bottomright",
           levels(iris$Species),
           col = c("red", "green", "blue"),
           pch = 16)

    dev.off()

    # Create data.table
    want <- as.data.table(irisMds)
    endsubmit;
    import data=workx.want r=want;
    run;quit;

    /*---
    WORKX.WANT total obs=150 07JAN2026:11:54:55

    Obs       V1          V2

      1     2.70336     0.10771
      2    -1.08810     0.07459
      3    -2.15944    -0.21728
    ...
    148     2.54309     0.57941
    149    -1.55780     0.26750
    150    -2.53119    -0.00985
    ---*/


    /*
    data want_mds;
      retain species;
      merge workx.want workx.iris20260101(keep=species);
      select (species);
         when ("setosa"    ) sym=  "+";
         when ("versicolor") sym=  ".";
         when ("virginica" ) sym=  "X";
      end;
      v1=-v1;
      v2=-v2;
    run;quit;

    options ls=64 ps=32;
    proc plot data=want_mds(rename=v2=v12345678901234567890);
     plot v12345678901234567890*v1=" " $ sym /box;
    run;quit;


    Dimension reduction using Multi-dimensional Scalinig
    IS related to distances between poitns in 4 dimenional space,

    Give us an ideaif the Random forest will be sucessful?


           -5.0     -2.5      0.0      2.5      5.0
         2 +-+--------+--------+--------+--------+--+ 2
           |                                        |
           |          +    + Setosa        X        |
      D    |         +     . Versicolor     X       |
      I  1 +          +    X Virginica              + 1
      M    |         +++                  X         |
      _    |          +             .   X XX        |
      2    |         +++          ..  XXXXX X       |
           |       + ++           ....XXX    X      |
         0 +         +++        .... XXXX           + 0
           |         ++       . ....XXXX            |
           |        ++        ..... XX              |
           |       + +        .....XXX              |
           |                .  ..   X               |
        -1 +         +      .                       + 1
           |                 .   X                  |
           |                                        |
           +-+--------+--------+--------+--------+--+
           -5.0     -2.5      0.0      2.5      5.0

                            Dim_1
    */

    /*
    | | ___   __ _
    | |/ _ \ / _` |
    | | (_) | (_| |
    |_|\___/ \__, |
             |___/
    */

    %macro logoff();

    Ignore ERROR: Expected a statement keyword : found "?"

    1                                          Altair SLC       15:01 Tuesday, January  6, 2026

    NOTE: Copyright 2002-2025 World Programming, an Altair Company
    NOTE: Altair SLC 2026 (05.26.01.00.000758)
          Licensed to Roger DeAngelis
    NOTE: This session is executing on the X64_WIN11PRO platform and is running in 64 bit mode

    NOTE: AUTOEXEC processing beginning; file is C:\wpsoto\autoexec.sas
    NOTE: AUTOEXEC source line
    1       +  ï»¿ods _all_ close;
               ^
    ERROR: Expected a statement keyword : found "?"
    NOTE: Library workx assigned as follows:
          Engine:        SAS7BDAT
          Physical Name: d:\wpswrkx

    NOTE: Library slchelp assigned as follows:
          Engine:        WPD
          Physical Name: C:\Progra~1\Altair\SLC\2026\sashelp


    NOTE: 1 record was written to file PRINT

    NOTE: The data step took :
          real time : 0.027
          cpu time  : 0.015


    NOTE: AUTOEXEC processing completed

    1         proc delete data=workx.want;
    2         run;quit;
    NOTE: Deleting "WORKX.WANT" (memtype="DATA")
    NOTE: Procedure delete step took :
          real time : 0.001
          cpu time  : 0.000


    3
    4         options set=RHOME "C:\Progra~1\R\R-4.5.2\bin\r";
    5         proc r;
    NOTE: Using R version 4.5.2 (2025-10-31 ucrt) from C:\Program Files\R\R-4.5.2
    6         export data=workx.iris20260101 r=iris;
    NOTE: Creating R data frame 'iris' from data set 'WORKX.iris20260101'

    7         submit;
    8         library(data.table);
    9         iris$Species<-as.factor(iris$Species);
    10        irisDist <- dist(iris[,1:4]);
    11        irisMds = cmdscale(irisDist, k=2);
    12        str(irisMds);
    13        pdf(file="d:/pdf/mds.pdf");
    14        plot(irisMds);
    15        text(irisMds[,1], (irisMds[,2]+max(irisMds[,2])*0.05), labels=1:nrow(irisMds), cex = 0.4, xpd = TRUE);
    16        points(irisMds, col=c("red", "green", "blue")[as.numeric(iris$Species)]);
    17        pdf();
    18        want<-as.data.table(irisMds);
    19        endsubmit;

    NOTE: Submitting statements to R:

    > library(data.table);
    > iris$Species<-as.factor(iris$Species);
    > irisDist <- dist(iris[,1:4]);
    > irisMds = cmdscale(irisDist, k=2);

    2

    > str(irisMds);
    > pdf(file="d:/pdf/mds.pdf");
    > plot(irisMds);
    > text(irisMds[,1], (irisMds[,2]+max(irisMds[,2])*0.05), labels=1:nrow(irisMds), cex = 0.4, xpd = TRUE);
    > points(irisMds, col=c("red", "green", "blue")[as.numeric(iris$Species)]);
    > pdf();
    > want<-as.data.table(irisMds);

    NOTE: Processing of R statements complete

    20        import data=workx.want r=want;
    NOTE: Creating data set 'WORKX.want' from R data frame 'want'
    NOTE: Data set "WORKX.want" has 150 observation(s) and 2 variable(s)

    21        run;quit;
    NOTE: Procedure r step took :
          real time : 0.571
          cpu time  : 0.046


    ERROR: Error printed on page 1

    NOTE: Submitted statements took :
          real time : 0.656
          cpu time  : 0.109

    %mend logoff;

    /*___                        _                  __                     _
    | ___|   _ __ __ _ _ __   __| | ___  _ __ ___  / _| ___  _ __ ___  ___| |_  _ __  _ __ ___   ___ ___  ___ ___
    |___ \  | `__/ _` | `_ \ / _` |/ _ \| `_ ` _ \| |_ / _ \| `__/ _ \/ __| __|| `_ \| `__/ _ \ / __/ _ \/ __/ __|
     ___) | | | | (_| | | | | (_| | (_) | | | | | |  _| (_) | | |  __/\__ \ |_ | |_) | | | (_) | (_|  __/\__ \__ \
    |____/  |_|  \__,_|_| |_|\__,_|\___/|_| |_| |_|_|  \___/|_|  \___||___/\__|| .__/|_|  \___/ \___\___||___/___/
                                                                               |_|
    */

    %utlfkil(d:/txt/training.txt            );
    %utlfkil(d:/txt/rf_classifier_train.txt );
    %utlfkil(d:/txt/gettree.txt             );
    %utlfkil(d:/txt/sqlcasewhen_train.txt   );
    %utlfkil(d:/txt/rcasewhen_train.txt     );
    %utlfkil(d:/rds/iris_rf_model.rds       );

    %utlfkil(d:/rds/iris_rf_classify.rds    );

    %utlfkil(d:/pdf/rocr_holdout.pdf        );
    %utlfkil(d:/pdf/gini_training.pdf       );
    %utlfkil(d:/pdf/errorbytree_training.pdf);

    proc delete data=
       workx.irs20260101_holdout_pred
       workx.irs20260101_holdout_roc_auc
       workx.irs20260101_train_gini
       workx.irs20260101_train_err
       workx.irs20260101_combined_pred
       ;
    run;quit;

    /*---
    NOTE: The data set WORKX.TRAINING has 101 observations and 6 variables.
    NOTE: The data set WORKX.VALIDATION has 49 observations and 6 variables.
    ---*/

    options set=RHOME "C:\Progra~1\R\R-4.5.2\bin\r";

    proc r;

    export data=workx.iris20260101_train   r=training;
    export data=workx.iris20260101_holdout r=validation1;

    submit;
    library(tidypredict)
    library(randomForest)
    library(ROCR)
    library(data.table)

    # COVERT CONFUSION MATRICES TO DATAFRAMES FUNCTION & MSKING ROWNAMES A CHARATER COLUMN
    conf2df <- function(df) {
      df <- as.data.frame.matrix(df)
      result <- data.frame(Species = rownames(df), df,row.names = NULL)
      return(result)
     }

    set.seed(17)

    # GET TRAINING AND VALIDATION
    training$Species<-as.factor(training$Species)
    validation1$Species<-as.factor(validation1$Species)

    # RANDOMFOREST CLASSIFIER
    rf_classifier = randomForest(Species ~ ., data=training, ntree=100, mtry=2, importance=TRUE)

    # summary report
    sink("d:/txt/training.txt")
    rf_classifier
    sink()

    # GINI DATA FOR PLOTS * CONDITION FOR SAS DATASET
    imp  <-rf_classifier$importanceSD[,-1]
    impx <- as.data.table(importance(rf_classifier))
    imp  <-cbind(rownames(imp),impx)
    impx$vars<-t(rownames(imp))

    # DETAIL META DATA ON ALL POSSIBLE OUTPUT SAS DATASETS - LIKE PROC CONTENTS
    sink(file="d:/txt/rf_gini_train.txt")
    print(imp)
    sink()

    # DETAIL META DATA ON ALL POSSIBLE OUTPUT SAS DATASETS - LIKE PROC CONTENTS
    sink(file="d:/txt/rf_classifier_train.txt")
    str(rf_classifier)
    sink()

    # EXTRACT THE FIRST TREE WITH DATA THAT IS USE FOR PLOTTING A DECISION TREE
    sink(file="d:/txt/gettree_train.txt")
    getTree(rf_classifier, 1, labelVar=TRUE)
    sink()

    # CREATE GENI PDF
    pdf(file="d:/pdf/gini_training.pdf")
    varImpPlot(rf_classifier)
    dev.off()

    # Validation set assessment #1: looking at confusion matrix
    prediction_for_table <- predict(rf_classifier,validation1[,-5])

    # ROC curves and AUC
    prediction_for_roc_curve <- predict(rf_classifier,validation1[,-5],type="prob")

    # USE PRETTY COLOURS:
    pretty_colours <- c("#F8766D","#00BA38","#619CFF")

    # SPECIFY THE DIFFERENT CLASSES
    classes <- levels(validation1$Species)

    # PLOT DECISION TREE - NEEDS A LITTLE MORE WORK BUT IS NOT CRITICAL
    pdf(file="d:/pdf/rocr_holdout.pdf")

    puc<-c(1,1,1)
    for (i in 1:3) {
       true_values <- ifelse(validation1[,5]==classes[i],1,0)
       pred <- prediction(prediction_for_roc_curve[,i],true_values)
       perf <- performance(pred, "tpr", "fpr")
          if (i==1)
          {plot(perf,main="ROC Curve",col=pretty_colours[i])}
          else {plot(perf,main="ROC Curve",col=pretty_colours[i],add=TRUE)}
       # Calculate the AUC and print it to screen
       auc.perf <- performance(pred, measure = "auc")
       puc[i]<-auc.perf@y.values[[1]]
    }
    dev.off()

    # AREA UNDER ROC CURVES
    puc<-as.data.table(t(puc))
    colnames(puc)<-classes

    # COMBINE PREDICTED AND OBSERVED VALUES FOR SPECIES
    wantpred<-as.data.table(cbind(validation1[,1:5],prediction_for_table))

    pdf(file="d:/pdf/errorbytree_training.pdf", family="sans")
    plot(rf_classifier)
    dev.off()

    # CREATE SAS ERROR DATASET
    errors<-as.data.table(rf_classifier$err.rate)

    # COMBINED SET (TRAINING + HOLDOUT) PREDICTIONS
    combined_data <- rbind(training, validation1)
    rf_classifier = randomForest(Species ~ ., data=combined_data, ntree=100, mtry=2, importance=TRUE)
    combined_cm <- conf2df(rf_classifier$confusion[, 1:3])
    cat("\nCombined Data Confusion Matrix:\n")
    print(combined_cm)

    # SAVE MODEL TO RDS FILE
    saveRDS(rf_classifier, "d:/rds/iris_rf_classify.rds")
    cat("\nModel saved as 'd:/rds/iris_rf_classify.rds'\n")

    # PREDICT FROM COMBIMED DATA
    predict <- predict(rf_classifier,combined_data)
    combined_pred<-as.data.frame(cbind(combined_data,predict))
    head(combined_pred)

    # CREATE R CASEWHEN FILE CODE (SINGLE TREE)
    sink(file="d:/txt/rcasewhen.txt");
    tidypredict_fit(rf_classifier)[2];
    sink();

    # CREATE SQL CODE (MORE USEFULL WITH CART ANF SINGLE TREE)
    sink(file="d:/txt/sqlcasewhen.txt");
    tidypredict_sql(rf_classifier,dbplyr::simulate_mssql());
    sink();

    endsubmit;

    import r=combined_pred   data=workx.irs20260101_combined_pred;
    import r=wantpred        data=workx.irs20260101_holdout_pred;
    import r=puc             data=workx.irs20260101_holdout_roc_auc;
    import r=imp             data=workx.irs20260101_train_gini;
    import r=errors          data=workx.irs20260101_train_err;

    run;quit;


    %macro logoff();

    1                                          Altair SLC      14:18 Saturday, January 10, 2026

    NOTE: Copyright 2002-2025 World Programming, an Altair Company
    NOTE: Altair SLC 2026 (05.26.01.00.000758)
          Licensed to Roger DeAngelis
    NOTE: This session is executing on the X64_WIN11PRO platform and is running in 64 bit mode

    NOTE: AUTOEXEC processing beginning; file is C:\wpsoto\autoexec.sas
    NOTE: AUTOEXEC source line
    1       +  ï»¿ods _all_ close;
               ^
    ERROR: Expected a statement keyword : found "?"
    NOTE: Library workx assigned as follows:
          Engine:        SAS7BDAT
          Physical Name: d:\wpswrkx

    NOTE: Library slchelp assigned as follows:
          Engine:        WPD
          Physical Name: C:\Progra~1\Altair\SLC\2026\sashelp


    LOG  JUST AFTER AUTOEXEC---- TIME=14:18 -----
    NOTE: 1 record was written to file PRINT

    NOTE: The data step took :
          real time : 0.020
          cpu time  : 0.000


    NOTE: AUTOEXEC processing completed

    1
    2         %utlfkil(d:/txt/training.txt            );
    The file d:/txt/training.txt does not exist
    3         %utlfkil(d:/txt/rf_classifier_train.txt );
    The file d:/txt/rf_classifier_train.txt does not exist
    4         %utlfkil(d:/txt/gettree.txt             );
    The file d:/txt/gettree.txt does not exist
    5         %utlfkil(d:/txt/sqlcasewhen_train.txt   );
    The file d:/txt/sqlcasewhen_train.txt does not exist
    6         %utlfkil(d:/txt/rcasewhen_train.txt     );
    The file d:/txt/rcasewhen_train.txt does not exist
    7         %utlfkil(d:/rds/iris_rf_model.rds       );
    The file d:/rds/iris_rf_model.rds does not exist
    8
    9         %utlfkil(d:/rds/iris_rf_classify.rds    );
    The file d:/rds/iris_rf_classify.rds does not exist
    10
    11        %utlfkil(d:/pdf/rocr_holdout.pdf        );
    The file d:/pdf/rocr_holdout.pdf does not exist
    12        %utlfkil(d:/pdf/gini_training.pdf       );
    The file d:/pdf/gini_training.pdf does not exist
    13        %utlfkil(d:/pdf/errorbytree_training.pdf);
    The file d:/pdf/errorbytree_training.pdf does not exist
    14
    15        proc delete data=
    16           workx.irs20260101_holdout_pred
    17           workx.irs20260101_holdout_roc_auc
    18           workx.irs20260101_train_gini
    19           workx.irs20260101_train_err
    20           workx.irs20260101_combined_pred
    21           ;
    22        run;quit;
    NOTE: WORKX.IRS20260101_HOLDOUT_PRED (memtype="DATA") was not found, and has not been deleted
    NOTE: WORKX.IRS20260101_HOLDOUT_ROC_AUC (memtype="DATA") was not found, and has not been deleted

    2                                                                                                                         Altair SLC

    NOTE: WORKX.IRS20260101_TRAIN_GINI (memtype="DATA") was not found, and has not been deleted
    NOTE: WORKX.IRS20260101_TRAIN_ERR (memtype="DATA") was not found, and has not been deleted
    NOTE: WORKX.IRS20260101_COMBINED_PRED (memtype="DATA") was not found, and has not been deleted
    NOTE: Procedure delete step took :
          real time : 0.000
          cpu time  : 0.000


    23
    24        /*---
    25        NOTE: The data set WORKX.TRAINING has 101 observations and 6 variables.
    26        NOTE: The data set WORKX.VALIDATION has 49 observations and 6 variables.
    27        ---*/
    28
    29        options set=RHOME "C:\Progra~1\R\R-4.5.2\bin\r";
    30
    31        proc r;
    NOTE: Using R version 4.5.2 (2025-10-31 ucrt) from C:\Program Files\R\R-4.5.2
    32
    33        export data=workx.iris20260101_train   r=training;
    NOTE: Creating R data frame 'training' from data set 'WORKX.iris20260101_train'

    34        export data=workx.iris20260101_holdout r=validation1;
    NOTE: Creating R data frame 'validation1' from data set 'WORKX.iris20260101_holdout'

    35
    36        submit;
    37        library(tidypredict)
    38        library(randomForest)
    39        library(ROCR)
    40        library(data.table)
    41
    42        # COVERT CONFUSION MATRICES TO DATAFRAMES FUNCTION & MSKING ROWNAMES A CHARATER COLUMN
    43        conf2df <- function(df) {
    44          df <- as.data.frame.matrix(df)
    45          result <- data.frame(Species = rownames(df), df,row.names = NULL)
    46          return(result)
    47         }
    48
    49        set.seed(17)
    50
    51        # GET TRAINING AND VALIDATION
    52        training$Species<-as.factor(training$Species)
    53        validation1$Species<-as.factor(validation1$Species)
    54
    55        # RANDOMFOREST CLASSIFIER
    56        rf_classifier = randomForest(Species ~ ., data=training, ntree=100, mtry=2, importance=TRUE)
    57
    58        # summary report
    59        sink("d:/txt/training.txt")
    60        rf_classifier
    61        sink()
    62
    63        # GINI DATA FOR PLOTS * CONDITION FOR SAS DATASET
    64        imp  <-rf_classifier$importanceSD[,-1]
    65        impx <- as.data.table(importance(rf_classifier))
    66        imp  <-cbind(rownames(imp),impx)
    67        impx$vars<-t(rownames(imp))
    68
    69        # DETAIL META DATA ON ALL POSSIBLE OUTPUT SAS DATASETS - LIKE PROC CONTENTS
    70        sink(file="d:/txt/rf_gini_train.txt")
    71        print(imp)
    72        sink()

    3                                                                                                                         Altair SLC

    73
    74        # DETAIL META DATA ON ALL POSSIBLE OUTPUT SAS DATASETS - LIKE PROC CONTENTS
    75        sink(file="d:/txt/rf_classifier_train.txt")
    76        str(rf_classifier)
    77        sink()
    78
    79        # EXTRACT THE FIRST TREE WITH DATA THAT IS USE FOR PLOTTING A DECISION TREE
    80        sink(file="d:/txt/gettree_train.txt")
    81        getTree(rf_classifier, 1, labelVar=TRUE)
    82        sink()
    83
    84        # CREATE GENI PDF
    85        pdf(file="d:/pdf/gini_training.pdf")
    86        varImpPlot(rf_classifier)
    87        dev.off()
    88
    89        # Validation set assessment #1: looking at confusion matrix
    90        prediction_for_table <- predict(rf_classifier,validation1[,-5])
    91
    92        # ROC curves and AUC
    93        prediction_for_roc_curve <- predict(rf_classifier,validation1[,-5],type="prob")
    94
    95        # USE PRETTY COLOURS:
    96        pretty_colours <- c("#F8766D","#00BA38","#619CFF")
    97
    98        # SPECIFY THE DIFFERENT CLASSES
    99        classes <- levels(validation1$Species)
    100
    101       # PLOT DECISION TREE - NEEDS A LITTLE MORE WORK BUT IS NOT CRITICAL
    102       pdf(file="d:/pdf/rocr_holdout.pdf")
    103
    104       puc<-c(1,1,1)
    105       for (i in 1:3) {
    106          true_values <- ifelse(validation1[,5]==classes[i],1,0)
    107          pred <- prediction(prediction_for_roc_curve[,i],true_values)
    108          perf <- performance(pred, "tpr", "fpr")
    109             if (i==1)
    110             {plot(perf,main="ROC Curve",col=pretty_colours[i])}
    111             else {plot(perf,main="ROC Curve",col=pretty_colours[i],add=TRUE)}
    112          # Calculate the AUC and print it to screen
    113          auc.perf <- performance(pred, measure = "auc")
    114          puc[i]<-auc.perf@y.values[[1]]
    115       }
    116       dev.off()
    117
    118       # AREA UNDER ROC CURVES
    119       puc<-as.data.table(t(puc))
    120       colnames(puc)<-classes
    121
    122       # COMBINE PREDICTED AND OBSERVED VALUES FOR SPECIES
    123       wantpred<-as.data.table(cbind(validation1[,1:5],prediction_for_table))
    124
    125       pdf(file="d:/pdf/errorbytree_training.pdf", family="sans")
    126       plot(rf_classifier)
    127       dev.off()
    128
    129       # CREATE SAS ERROR DATASET
    130       errors<-as.data.table(rf_classifier$err.rate)
    131
    132       # COMBINED SET (TRAINING + HOLDOUT) PREDICTIONS
    133       combined_data <- rbind(training, validation1)
    134       rf_classifier = randomForest(Species ~ ., data=combined_data, ntree=100, mtry=2, importance=TRUE)
    135       combined_cm <- conf2df(rf_classifier$confusion[, 1:3])

    4                                                                                                                         Altair SLC

    136       cat("\nCombined Data Confusion Matrix:\n")
    137       print(combined_cm)
    138
    139       # SAVE MODEL TO RDS FILE
    140       saveRDS(rf_classifier, "d:/rds/iris_rf_classify.rds")
    141       cat("\nModel saved as 'd:/rds/iris_rf_classify.rds'\n")
    142
    143       # PREDICT FROM COMBIMED DATA
    144       predict <- predict(rf_classifier,combined_data)
    145       combined_pred<-as.data.frame(cbind(combined_data,predict))
    146       head(combined_pred)
    147
    148       # CREATE R CASEWHEN FILE CODE (SINGLE TREE)
    149       sink(file="d:/txt/rcasewhen.txt");
    150       tidypredict_fit(rf_classifier)[2];
    151       sink();
    152
    153       # CREATE SQL CODE (MORE USEFULL WITH CART ANF SINGLE TREE)
    154       sink(file="d:/txt/sqlcasewhen.txt");
    155       tidypredict_sql(rf_classifier,dbplyr::simulate_mssql());
    156       sink();
    157
    158       endsubmit;

    NOTE: Submitting statements to R:

    > library(tidypredict)
    > library(randomForest)
    randomForest 4.7-1.2
    Type rfNews() to see new features/changes/bug fixes.
    > library(ROCR)
    > library(data.table)
    >
    > # COVERT CONFUSION MATRICES TO DATAFRAMES FUNCTION & MSKING ROWNAMES A CHARATER COLUMN
    > conf2df <- function(df) {
    +   df <- as.data.frame.matrix(df)
    +   result <- data.frame(Species = rownames(df), df,row.names = NULL)
    +   return(result)
    +  }
    >
    > set.seed(17)
    >
    > # GET TRAINING AND VALIDATION
    > training$Species<-as.factor(training$Species)
    > validation1$Species<-as.factor(validation1$Species)
    >
    > # RANDOMFOREST CLASSIFIER
    > rf_classifier = randomForest(Species ~ ., data=training, ntree=100, mtry=2, importance=TRUE)
    >
    > # summary report
    > sink("d:/txt/training.txt")
    > rf_classifier
    > sink()
    >
    > # GINI DATA FOR PLOTS * CONDITION FOR SAS DATASET
    > imp  <-rf_classifier$importanceSD[,-1]
    > impx <- as.data.table(importance(rf_classifier))
    > imp  <-cbind(rownames(imp),impx)
    > impx$vars<-t(rownames(imp))
    Warning message:
    In set(x, j = name, value = value) :
      4 column matrix RHS of := will be treated as one vector
    >

    5                                                                                                                         Altair SLC

    > # DETAIL META DATA ON ALL POSSIBLE OUTPUT SAS DATASETS - LIKE PROC CONTENTS
    > sink(file="d:/txt/rf_gini_train.txt")
    > print(imp)
    > sink()
    >
    > # DETAIL META DATA ON ALL POSSIBLE OUTPUT SAS DATASETS - LIKE PROC CONTENTS
    > sink(file="d:/txt/rf_classifier_train.txt")
    > str(rf_classifier)
    > sink()
    >
    > # EXTRACT THE FIRST TREE WITH DATA THAT IS USE FOR PLOTTING A DECISION TREE
    > sink(file="d:/txt/gettree_train.txt")
    > getTree(rf_classifier, 1, labelVar=TRUE)
    > sink()
    >
    > # CREATE GENI PDF
    > pdf(file="d:/pdf/gini_training.pdf")
    > varImpPlot(rf_classifier)
    > dev.off()
    >
    > # Validation set assessment #1: looking at confusion matrix
    > prediction_for_table <- predict(rf_classifier,validation1[,-5])
    >
    > # ROC curves and AUC
    > prediction_for_roc_curve <- predict(rf_classifier,validation1[,-5],type="prob")
    >
    > # USE PRETTY COLOURS:
    > pretty_colours <- c("#F8766D","#00BA38","#619CFF")
    >
    > # SPECIFY THE DIFFERENT CLASSES
    > classes <- levels(validation1$Species)
    >
    > # PLOT DECISION TREE - NEEDS A LITTLE MORE WORK BUT IS NOT CRITICAL
    > pdf(file="d:/pdf/rocr_holdout.pdf")
    >
    > puc<-c(1,1,1)
    > for (i in 1:3) {
    +    true_values <- ifelse(validation1[,5]==classes[i],1,0)
    +    pred <- prediction(prediction_for_roc_curve[,i],true_values)
    +    perf <- performance(pred, "tpr", "fpr")
    +       if (i==1)
    +       {plot(perf,main="ROC Curve",col=pretty_colours[i])}
    +       else {plot(perf,main="ROC Curve",col=pretty_colours[i],add=TRUE)}
    +    # Calculate the AUC and print it to screen
    +    auc.perf <- performance(pred, measure = "auc")
    +    puc[i]<-auc.perf@y.values[[1]]
    + }
    > dev.off()
    >
    > # AREA UNDER ROC CURVES
    > puc<-as.data.table(t(puc))
    > colnames(puc)<-classes
    >
    > # COMBINE PREDICTED AND OBSERVED VALUES FOR SPECIES
    > wantpred<-as.data.table(cbind(validation1[,1:5],prediction_for_table))
    >
    > pdf(file="d:/pdf/errorbytree_training.pdf", family="sans")
    > plot(rf_classifier)
    > dev.off()
    >
    > # CREATE SAS ERROR DATASET
    > errors<-as.data.table(rf_classifier$err.rate)
    >

    6                                                                                                                         Altair SLC

    > # COMBINED SET (TRAINING + HOLDOUT) PREDICTIONS
    > combined_data <- rbind(training, validation1)
    > rf_classifier = randomForest(Species ~ ., data=combined_data, ntree=100, mtry=2, importance=TRUE)
    > combined_cm <- conf2df(rf_classifier$confusion[, 1:3])
    > cat("\nCombined Data Confusion Matrix:\n")
    > print(combined_cm)
    >
    > # SAVE MODEL TO RDS FILE
    > saveRDS(rf_classifier, "d:/rds/iris_rf_classify.rds")
    > cat("\nModel saved as 'd:/rds/iris_rf_classify.rds'\n")
    >
    > # PREDICT FROM COMBIMED DATA
    > predict <- predict(rf_classifier,combined_data)
    > combined_pred<-as.data.frame(cbind(combined_data,predict))
    > head(combined_pred)
    >
    > # CREATE R CASEWHEN FILE CODE (SINGLE TREE)
    > sink(file="d:/txt/rcasewhen.txt");
    > tidypredict_fit(rf_classifier)[2];
    > sink();
    >
    > # CREATE SQL CODE (MORE USEFULL WITH CART ANF SINGLE TREE)
    > sink(file="d:/txt/sqlcasewhen.txt");
    > tidypredict_sql(rf_classifier,dbplyr::simulate_mssql());
    > sink();
    >

    NOTE: Processing of R statements complete

    159
    160       import r=combined_pred   data=workx.irs20260101_combined_pred;
    NOTE: Creating data set 'WORKX.irs20260101_combined_pred' from R data frame 'combined_pred'
    NOTE: Column names modified during import of 'combined_pred'
    NOTE: Data set "WORKX.irs20260101_combined_pred" has 157 observation(s) and 6 variable(s)

    161       import r=wantpred        data=workx.irs20260101_holdout_pred;
    NOTE: Creating data set 'WORKX.irs20260101_holdout_pred' from R data frame 'wantpred'
    NOTE: Column names modified during import of 'wantpred'
    NOTE: Data set "WORKX.irs20260101_holdout_pred" has 48 observation(s) and 6 variable(s)

    162       import r=puc             data=workx.irs20260101_holdout_roc_auc;
    NOTE: Creating data set 'WORKX.irs20260101_holdout_roc_auc' from R data frame 'puc'
    NOTE: Column names modified during import of 'puc'
    NOTE: Data set "WORKX.irs20260101_holdout_roc_auc" has 1 observation(s) and 3 variable(s)

    163       import r=imp             data=workx.irs20260101_train_gini;
    NOTE: Creating data set 'WORKX.irs20260101_train_gini' from R data frame 'imp'
    NOTE: Column names modified during import of 'imp'
    NOTE: Data set "WORKX.irs20260101_train_gini" has 4 observation(s) and 6 variable(s)

    164       import r=errors          data=workx.irs20260101_train_err;
    NOTE: Creating data set 'WORKX.irs20260101_train_err' from R data frame 'errors'
    NOTE: Column names modified during import of 'errors'
    NOTE: Data set "WORKX.irs20260101_train_err" has 100 observation(s) and 4 variable(s)

    165
    166       run;quit;
    NOTE: Procedure r step took :
          real time : 12.552
          cpu time  : 0.046


    167

    7                                                                                                                         Altair SLC

    ERROR: Error printed on page 1

    NOTE: Submitted statements took :
          real time : 12.663
          cpu time  : 0.109


    %mend logoff;

    /*__                      _                             _      _                  _                      _
     / /_    __ _ _ __  _ __ | |_   _   _ __ ___   ___   __| | ___| | _ __   _____  _| |_ __      _____  ___| | __
    | `_ \  / _` | `_ \| `_ \| | | | | | `_ ` _ \ / _ \ / _` |/ _ \ || `_ \ / _ \ \/ / __|\ \ /\ / / _ \/ _ \ |/ /
    | (_) || (_| | |_) | |_) | | |_| | | | | | | | (_) | (_| |  __/ || | | |  __/>  <| |_  \ V  V /  __/  __/   <
     \___/  \__,_| .__/| .__/|_|\__, | |_| |_| |_|\___/ \__,_|\___|_||_| |_|\___/_/\_\\__|  \_/\_/ \___|\___|_|\_\
                 |_|   |_|      |___/
    */

    proc delete data=workx.iris20260105_pred;
    run;quit;

    options set=RHOME "C:\Progra~1\R\R-4.5.2\bin\r";
    proc r;
    export data=workx.iris20260105 r=iris20260105;
    submit;

    library(randomForest)

    # EXAMPLE: HOW TO USE SAVED MODEL ON NEW DATA
    # LOAD MODEL AND PREDICT ON NEW DATA (USING HOLDOUT AS EXAMPLE NEW DATA)
    loaded_model <- readRDS("d:/rds/iris_rf_classify.rds")

    # PREDICT FROM SAVED MODEL
    iris20260105_pred <- predict(loaded_model, iris20260105)

    endsubmit;
    import data=workx.iris20260105_fulpred  r=iris20260105_pred  ;
    run;quit;

    /*---
    1                                          Altair SLC      14:28 Saturday, January 10, 2026

    NOTE: Copyright 2002-2025 World Programming, an Altair Company
    NOTE: Altair SLC 2026 (05.26.01.00.000758)
          Licensed to Roger DeAngelis
    NOTE: This session is executing on the X64_WIN11PRO platform and is running in 64 bit mode

    NOTE: AUTOEXEC processing beginning; file is C:\wpsoto\autoexec.sas
    NOTE: AUTOEXEC source line
    1       +  ï»¿ods _all_ close;
               ^
    ERROR: Expected a statement keyword : found "?"
    NOTE: Library workx assigned as follows:
          Engine:        SAS7BDAT
          Physical Name: d:\wpswrkx

    NOTE: Library slchelp assigned as follows:
          Engine:        WPD
          Physical Name: C:\Progra~1\Altair\SLC\2026\sashelp


    LOG  JUST AFTER AUTOEXEC---- TIME=14:28 -----
    NOTE: 1 record was written to file PRINT

    NOTE: The data step took :
          real time : 0.029
          cpu time  : 0.000


    NOTE: AUTOEXEC processing completed

    1
    2         proc delete data=workx.iris20260105_pred;
    3         run;quit;
    NOTE: WORKX.IRIS20260105_PRED (memtype="DATA") was not found, and has not been deleted
    NOTE: Procedure delete step took :
          real time : 0.000
          cpu time  : 0.000


    4
    5         options set=RHOME "C:\Progra~1\R\R-4.5.2\bin\r";
    6         proc r;
    NOTE: Using R version 4.5.2 (2025-10-31 ucrt) from C:\Program Files\R\R-4.5.2
    7         export data=workx.iris20260105 r=iris20260105;
    NOTE: Creating R data frame 'iris20260105' from data set 'WORKX.iris20260105'

    8         submit;
    9
    10        library(randomForest)
    11
    12        # EXAMPLE: HOW TO USE SAVED MODEL ON NEW DATA
    13        # LOAD MODEL AND PREDICT ON NEW DATA (USING HOLDOUT AS EXAMPLE NEW DATA)
    14        loaded_model <- readRDS("d:/rds/iris_rf_classify.rds")
    15
    16        # PREDICT FROM SAVED MODEL
    17        iris20260105_pred <- predict(loaded_model, iris20260105)
    18
    19        endsubmit;

    NOTE: Submitting statements to R:

    >
    > library(randomForest)
    randomForest 4.7-1.2

    2                                                                                                                         Altair SLC

    Type rfNews() to see new features/changes/bug fixes.
    >
    > # EXAMPLE: HOW TO USE SAVED MODEL ON NEW DATA
    > # LOAD MODEL AND PREDICT ON NEW DATA (USING HOLDOUT AS EXAMPLE NEW DATA)
    > loaded_model <- readRDS("d:/rds/iris_rf_classify.rds")
    >
    > # PREDICT FROM SAVED MODEL
    > iris20260105_pred <- predict(loaded_model, iris20260105)
    >

    NOTE: Processing of R statements complete

    20        import data=workx.iris20260105_fulpred  r=iris20260105_pred  ;
    NOTE: Creating data set 'WORKX.iris20260105_fulpred' from R data frame 'iris20260105_pred'
    NOTE: Column names modified during import of 'iris20260105_pred'
    NOTE: Data set "WORKX.iris20260105_fulpred" has 150 observation(s) and 1 variable(s)

    21        run;quit;
    NOTE: Procedure r step took :
          real time : 0.331
          cpu time  : 0.000


    22
    ERROR: Error printed on page 1

    NOTE: Submitted statements took :
          real time : 0.427
          cpu time  : 0.046

    ---*/

    /*____    __                                  _                       _
    |___  |  / _|_ __ ___  __ _   _ __   _____  _| |_  __      _____  ___| | __
       / /  | |_| `__/ _ \/ _` | | `_ \ / _ \ \/ / __| \ \ /\ / / _ \/ _ \ |/ /
      / /   |  _| | |  __/ (_| | | | | |  __/>  <| |_   \ V  V /  __/  __/   <
     /_/    |_| |_|  \___|\__, | |_| |_|\___/_/\_\\__|   \_/\_/ \___|\___|_|\_\
                             |_|
    */

    /*--- ADD SEPAL AND PETAL VALUES ---*/
    data workx.iris20260105_pred;
      merge workx.iris20260105 workx.iris20260105_fulpred;
    run;quit;

    proc freq data=workx.iris20260105_pred ;
      tables iris20260105_pred /out=workx.iris20260105_species_freq;
    run;

    proc print data==workx.iris20260105_species_freq;
    run;quit;

    /*---

    IRIS20260105_                             Cumulative    Cumulative
    PRED             Frequency     Percent     Frequency      Percent
    ------------------------------------------------------------------
    setosa                 49       32.67            49        32.67
    versicolor             53       35.33           102        68.00
    virginica              48       32.00           150       100.00

    ---*/


    /*___              _                         __           _              _             _                     _
     ( _ )    ___ __ _| | ___    ___ ___  _ __  / _|_   _ ___(_) ___  _ __  | |__  _   _  | |__   __ _ _ __   __| |
     / _ \   / __/ _` | |/ __|  / __/ _ \| `_ \| |_| | | / __| |/ _ \| `_ \ | `_ \| | | | | `_ \ / _` | `_ \ / _` |
    | (_) | | (_| (_| | | (__  | (_| (_) | | | |  _| |_| \__ \ | (_) | | | || |_) | |_| | | | | | (_| | | | | (_| |
     \___/   \___\__,_|_|\___|  \___\___/|_| |_|_|  \__,_|___/_|\___/|_| |_||_.__/ \__, | |_| |_|\__,_|_| |_|\__,_|
                                                                                   |___/
    */
    options ls=255;

    ods exclude all;
    ods output observed=wantXpo(rename=label=LEVELS
     label="Classification matrix classified and miss-classified counts");
    proc corresp data=workx.irs20260101_holdout_pred dim=1 observed;
    tables species,prediction_for_table;
    run;quit;
    ods select all;

    data class_err(drop=pre_toterr toterr);
      retain toterr 0;
      set wantXpo end=dne;
      array ts[3] setosa versicolor virginica;
      select;
        when (mod(_n_,3) = 1) do; err=ts[2]+ts[3]; class_err=err/sum; toterr=toterr+err; end;
        when (mod(_n_,3) = 2) do; err=ts[1]+ts[3]; class_err=err/sum; toterr=toterr+err; end;
        when (mod(_n_,3) = 0) do; err=ts[1]+ts[2]; class_err=err/sum; toterr=toterr+err; end;
      end;
      pre_toterr=lag(toterr);
      if levels='Sum' then do;
          class_err=pre_toterr/sum;
          toterr=pre_toterr;
          err=pre_toterr;
      end;
     ;
    run;quit;

    /*---
    p to 40 obs from last table WORK.CLASS_ERR total obs=4 09JAN2026:11:50:47

                                                                            class_
    bs    LEVELS        setosa    versicolor    virginica    Sum    err      err

    1     setosa          13           0             0        13     0     0.00000 Note agrees with 'proc mds'
    2     versicolor       1          17             0        18     1     0.05556
    3     virginica        1           1            15        17     2     0.11765
    4     Sum             15          18            15        48     3     0.06250

    /*___
     / _ \   _ __ ___   ___    __ _ _   _  ___
    | (_) | | `__/ _ \ / __|  / _` | | | |/ __|
     \__, | | | | (_) | (__  | (_| | |_| | (__
       /_/  |_|  \___/ \___|  \__,_|\__,_|\___|
    */

    data rocauc(label="area under the ROC curves by Species");
      set workx.irs20260101_holdout_roc_auc;
    run;quit;

    /*---
    WORK.ROCAUC total obs=1 06JAN2026:12:24:43 WOW

      SETOSA    VERSICOLOR    VIRGINICA

     0.96264      0.96019      0.95731


                               ROC CURVES


                0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0
               --+---+---+---+---+---+---+---+---+---+---+--
               | |   |<|-1/15 Virginica (AUC=0.99342)      |
       t   1.0 + |___| |                                   + 1.0
       r       | |_____|<-1/14 Versicolor (AUC=0.99294)    |
       u   0.9 + |                                         + 0.9
       e       | |                                         |
       -   0.8 + |<-Setosa no false positives              + 0.8
       p       | |  Perfect classification                 |
       o   0.7 + |  All true positives                     + 0.7
       s       | |  AUC=1                                  |
       i   0.6 + |                                         + 0.6
       t       | |                                         |
       i   0.5 + |                                         + 0.5
       v       | |                                         |
       e   0.4 + |<-  perfect matching setosa              | 0.4
       -       | |                                         |
       r   0.3 + |                                         + 0.3
       a       | |                                         |
       t   0.2 + |                                         + 0.2
       e       | |                                         |
           0.1 + |                                         + 0.1
               | |                                         |
           0.0 + |                                         + 0.0
               | |                                         |
               ---+---+---+---+---+---+---+---+---+---+---+--
               0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0

                           false_positive_rate

        ___               _            __   _
    / |/ _ \   ___  _   _| |_    ___  / _| | |__   __ _  __ _    ___ _ __ _ __
    | | | | | / _ \| | | | __|  / _ \| |_  | `_ \ / _` |/ _` |  / _ \ `__| `__|
    | | |_| || (_) | |_| | |_  | (_) |  _| | |_) | (_| | (_| | |  __/ |  | |
    |_|\___/  \___/ \__,_|\__|  \___/|_|   |_.__/ \__,_|\__, |  \___|_|  |_|
                                                        |___/
         see d:/pdf/oob.pdf
    */

    data oob_errors(label="Out of Bag errors by each of the 100 trees");
    retain tree;
      set workx.irs20260101_train_err;
      tree=_n_;
    run;quit;

    options ls=120 ps=32;
    proc plot data=oob_errors;
     plot oob*tree='*' / box haxis =1 to 100 href=1;
    run;quit;

    /*---   options ls=255 ps=100;

    OOB_ERRORS total obs=100

    Obs    tree       OOB      SETOSA    VERSICOLOR    VIRGINICA

      1      1     0.025641       0        0.08333      0.00000
      2      2     0.046875       0        0.10000      0.05263
      3      3     0.049383       0        0.07692      0.08000
    ...
     98     98     0.038835       0       0.058824      0.064516
     99     99     0.038835       0       0.058824      0.064516
    100    100     0.038835       0       0.058824      0.064516


                                       TREE
             12345678911111111112222222222333333333344  777777778888  9999991
                      01234567890123456789012345678901  234567890123  4567890
                                                                            0
          ---+++++++++++++++++++++++++++++++++++++++++// +++++++++++//+++++++-
      OOB |  | OUT OF BAD ERRORS BY TREES                                    |
     0.12 +  |                                     TREE       OOB            +  OOB
          |  |<-- fist tree has least error                                  | 0.12
          |  |                                       1     0.025641          |
          |  | *                                     2     0.046875          |
     0.10 +  |                                      ..                       +
          |  |                                      99     0.038835          | 0.10
          |  |   *                                 100     0.038835          |
          |  |*                          ********                            |
     0.08 +  |                                                               +
          |  |  * **    ****   * **** ***        *****//************//*******| 0.08
          |  |                                                               |
          |  |        *     *** *    *                                       |
     0.06 +  |                                                               +
          |  |      ** *                                                     | 0.06
          |  *                                                               |
          |  |                                                               |
     0.04 +  |<-- fist tree has least error                                  +
          |  |                                                               | 0.04
          ---+++++++++++++++++++++++++++++++++++++++++//++++++++++++//+++++++-
             12345678911111111112222222222333333333344  777777778888  9999991
                      01234567890123456789012345678901  234567890123  4567890
                                        TREE                                0                          0

    ---*/

    data oob_errors(label="Out of Bag errors by each of the 100 trees");
    retain tree;
      set workx.irs20260101_train_err;
      tree=_n_;
    run;quit;

    proc transpose data=oob_errors out=oobXpo;
    by tree;
    var oob setosa versicolor virginica;
    run;quit;

    proc sort data=oobXpo out=oobSrt;
    by _name_ tree;
    run;quit;

    %utlfkil(d:/pdf/oob.pdf);

    options orientation=landscape;
    ods graphics on / reset width=10in height=8in;
    ods pdf file="d:/pdf/oob.pdf";

    proc sgpanel data=oobSrt;
    panelby _name_;
    label col1="Error";
    label tree="Tree";
    series x=tree y=col1 ;
    run;quit;

    ods pdf close;
    ods graphics off;

    /* _        _       _
    / / |  __ _(_)_ __ (_)
    | | | / _` | | `_ \| |
    | | || (_| | | | | | |
    |_|_| \__, |_|_| |_|_|
          |___/
    */

    options ls=255;
    data gini(label="GINI equality indexes by flower petals and sepals");
      set workx.irs20260101_train_gini(where=(v1 ne 'less7'));
      symAcc=put(MEANDECREASEACCURACY,2.);
      symGin=put(MEANDECREASEGINI,2.);
    run;quit;

    /*----

         V1          SETOSA    VERSICOLOR    VIRGINICA    MEANDECREASEACCURACY    MEANDECREASEGINI

    Sepal_Length     3.2045       2.6733       4.3581             4.9151                7.2902
    Sepal_Width      1.0050       1.0560       2.5237             1.8345                1.7149
    Petal_Length    10.7143      12.0515      13.4704            14.3986               33.1019
    Petal_Width      8.6102      11.9965      14.7549            13.9657               29.8795


    ---*/

    options ls=64 ps=32;
    proc plot data=gini;
    plot v1*MeanDecreaseAccuracy="*" $ symacc /box;
    plot v1*MEANDECREASEGINI="*" $ symgin /box;
    run;quit;

    /*---

       GINI is a measure of the equality of values.
       The lower the Gini the more equal the values are.

       This ranking implies a random forest prioritizes petalwidth and petallength
       for accuracy, potentially achieving high performance (e.g., 95%+ on Iris).
       Dropping low-importance features like sepalwidth risks little performance loss.


         Plot of V1*MeanDecreaseAccuracy$symAcc.  Symbol used is '*'.


                     5.0      7.5     10.0     12.5     15.0     17.5
                    --+--------+--------+--------+--------+--------+---
                 V1 |                                                 |
       Sepal_Width  +                                     * 15        + Sepal_Width
                    |                                                 |
                    |                                                 |
       Sepal_Length +         *  7                                    + Sepal_Length
                    |                                                 |
                    |                                                 |
       Petal_Width  +                   * 10                          + Petal_Width
                    |                                                 |
                    |                                                 |
       Petal_Length +                                         * 16    + Petal_Length
                    --+--------+--------+--------+--------+--------+---
                     5.0      7.5     10.0     12.5     15.0     17.5

                                   MeanDecreaseAccuracy



           Plot of V1*MeanDecreaseGini$symGin.  Symbol used is '*'.


                    10          15          20          25          30
                    -+-----------+-----------+-----------+-----------+-
                 V1 |                                                 |
       Sepal_Width  + * 10                                            + Sepal_Width
                    |                                                 |
                    |                                                 |
       Sepal_Length +  * 11                                           + Sepal_Length
                    |                                                 |
                    |                                                 |
       Petal_Width  +                  * 18                           + Petal_Width
                    |                                                 |
                    |                                                 |
       Petal_Length +                                         * 27    + Petal_Length
                    -+-----------+-----------+-----------+-----------+-
                    10          15          20          25          30

                                     MeanDecreaseGini

    ---*/

    options ls=64 ps=32;
    proc plot data=oob_errors(obs=50 );
      plot oob*tree='*'/box href=24  haxis=0 to 50 by 2;
    run;quit;

    /*---               1 1 1 1 1 2 2 2 2 2 3 3 3 3 3 4 4 4 4 4 5
              0 2 4 6 8 0 2 4 6 8 0 2 4 6 8 0 2 4 6 8 0 2 4 6 8 0
           ---+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+---
       OOB |                          |                            |    OOB ERROR
    0.1386 +   *                      | TREE 24 HAS LEAST ERRROR   + 0.1386
           |                          |                            |
    0.1287 +              * *         |                            + 0.1287
           |        * *               |                            |
    0.1188 +               *          |                            + 0.1188
           |         *                |                            |
    0.1089 +           ***            |                            + 0.1089
           |    *  *                  |                            |
    0.0990 +      *          *    *   |         *     *            + 0.0990
           |                          |                            |
    0.0891 +     *            *    *  |       **  **   *  **  *    + 0.0891
           |                          |                            |
    0.0792 +                     *    | *   **   *  **  *   ** **  + 0.0792
           |                          |                            |
    0.0693 +                   **     |  ***             *         + 0.0693
           |                          |                            |
    0.0594 +                        **|*                           + 0.0594
           |                          |                            |
    0.0495 +                          *                            + 0.0495
           ---+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+---
              0 2 4 6 8 1 1 1 1 1 2 2 2 2 2 3 3 3 3 3 4 4 4 4 4 5
                        0 2 4 6 8 0 2 4 6 8 0 2 4 6 8 0 2 4 6 8 0
                                   TREE

    /* ____    _     _     _                                               __         _
    / |___ \  / |___| |_  | |_ _ __ ___  ___    ___   ___ __ _ ___  ___   / /_      _| |__   ___ _ __
    | | __) | | / __| __| | __| `__/ _ \/ _ \  / _ \ / __/ _` / __|/ _ \ / /\ \ /\ / / `_ \ / _ \ `_ \
    | |/ __/  | \__ \ |_  | |_| | |  __/  __/ |  __/| (_| (_| \__ \  __// /  \ V  V /| | | |  __/ | | |
    |_|_____| |_|___/\__|  \__|_|  \___|\___|  \___| \___\__,_|___/\___/_/    \_/\_/ |_| |_|\___|_| |_|

    */

    options ls=255;
    data _null_;

      infile "d:/txt/rcasewhen.txt" ;
      file   "d:/txt/rcasewhen.sas" ;

      input;

      if _n_=1 then do;
         putlog
             'options set=RHOME "C:\Progra~1\R\R-4.5.2\bin\r";' /
             'proc r;' /
             'export data=workx.iris20260101_train r=iris20260101_train;' /
             'submit;' /
             'library(dplyr)' /
             'iris20260101_train$species2 <- with(iris20260101_train,';

         /*--- output to d:/txt/rcasewhen.sas ---*/
         put
             'options set=RHOME "C:\Progra~1\R\R-4.5.2\bin\r";' /
             'proc r;' /
             'export data=workx.iris20260101_train r=iris20260101_train;' /
             'submit;' /
             'library(dplyr)' /
             'iris20260101_train$species2 <- with(iris20260101_train,' ;
      end;

      select;
        when (_n_=1)  _infile_ = substr(_infile_,2);
        when (index(_infile_,'default')) _infile_ = cats(scan(_infile_,1,'+'),')');
        otherwise ;
      end;

      putlog _infile_;
      put _infile_;

      if index(_infile_,'default')  then do;
         putlog 'head(iris20260101_train)';
         putlog 'endsubmit;';
         putlog 'import data=workx.iris_from_tree r=iris20260101_train;';
         putlog 'run;quit;'
    ;
         put  'head(iris20260101_train)';
         put 'endsubmit;';
         put 'import data=workx.iris_from_tree r=iris20260101_train;';
         put 'run;quit;';

         stop;
      end;
    run;quit;

    /*---
    proc r;
    export data=workx.iris20260101_train r=iris20260101_train;
    submit;
    library(dplyr)
    iris20260101_train$species2 <- with(iris20260101_train,
    case_when(Sepal_Length >= 4.65 & Petal_Width < 0.8 ~ "setosa",
        Petal_Length < 4.75 & Petal_Width >= 0.8 ~ "versicolor",
        Sepal_Length < 4.55 & Sepal_Length < 4.65 & Petal_Width <
            0.8 ~ "setosa", Petal_Length < 1.2 & Sepal_Length >=
            4.55 & Sepal_Length < 4.65 & Petal_Width < 0.8 ~ "setosa",
        Sepal_Length < 5.95 & Petal_Length < 4.85 & Petal_Length >=
            4.75 & Petal_Width >= 0.8 ~ "versicolor", Petal_Width >=
            1.75 & Petal_Length >= 4.85 & Petal_Length >= 4.75 &
            Petal_Width >= 0.8 ~ "virginica", Sepal_Width < 3.3 &
            Petal_Length >= 1.2 & Sepal_Length >= 4.55 & Sepal_Length <
            4.65 & Petal_Width < 0.8 ~ "setosa", Sepal_Width >= 3.3 &
            Petal_Length >= 1.2 & Sepal_Length >= 4.55 & Sepal_Length <
            4.65 & Petal_Width < 0.8 ~ "versicolor", Sepal_Length <
            6.5 & Sepal_Length >= 5.95 & Petal_Length < 4.85 & Petal_Length >=
            4.75 & Petal_Width >= 0.8 ~ "virginica", Sepal_Length >=
            6.5 & Sepal_Length >= 5.95 & Petal_Length < 4.85 & Petal_Length >=
            4.75 & Petal_Width >= 0.8 ~ "versicolor", Petal_Width <
            1.55 & Petal_Width < 1.75 & Petal_Length >= 4.85 & Petal_Length >=
            4.75 & Petal_Width >= 0.8 ~ "virginica", Petal_Length <
            5.45 & Petal_Width >= 1.55 & Petal_Width < 1.75 & Petal_Length >=
            4.85 & Petal_Length >= 4.75 & Petal_Width >= 0.8 ~ "versicolor",
    .default = "virginica"))
    head(iris20260101_train)
    endsubmit;
    import data=workx.iris_from_tree r=iris20260101_train;
    run;quit;
    ---*/

    /* _____                            _                              __         _
    / |___ /    _____  _____  ___ _   _| |_ ___   ___ __ _ ___  ___   / /_      _| |__   ___ _ __
    | | |_ \   / _ \ \/ / _ \/ __| | | | __/ _ \ / __/ _` / __|/ _ \ / /\ \ /\ / / `_ \ / _ \ `_ \
    | |___) | |  __/>  <  __/ (__| |_| | ||  __/| (_| (_| \__ \  __// /  \ V  V /| | | |  __/ | | |
    |_|____/   \___/_/\_\___|\___|\__,_|\__\___| \___\__,_|___/\___/_/    \_/\_/ |_| |_|\___|_| |_|

    */

    %inc "d:/txt/rcasewhen.sas";

    /* _  _     _     _     _                                   __           _
    / | || |   / |___| |_  | |_ _ __ ___  ___   ___ ___  _ __  / _|_   _ ___(_) ___  _ __
    | | || |_  | / __| __| | __| `__/ _ \/ _ \ / __/ _ \| `_ \| |_| | | / __| |/ _ \| `_ \
    | |__   _| | \__ \ |_  | |_| | |  __/  __/| (_| (_) | | | |  _| |_| \__ \ | (_) | | | |
    |_|  |_|   |_|___/\__|  \__|_|  \___|\___| \___\___/|_| |_|_|  \__,_|___/_|\___/|_| |_|
    */

    options ls=255;

    ods exclude all;
    ods output observed=wantXpo(rename=label=LEVELS
     label="Classification matrix classified and miss-classified counts");
    proc corresp data=workx.iris_from_tree dim=1 observed;
    tables species,species2;
    run;quit;
    ods select all;

    /*----
    Obs    LEVELS        setosa    versicolor    virginica    Sum

     1     setosa          38           0             0        38
     2     versicolor       0          33             2        35
     3     virginica        0           1            35        36
     4     Sum             38          34            37       109
    ---*/


    data class_err(drop=pre_toterr toterr);
      retain toterr 0;
      set wantXpo end=dne;
      array ts[3] setosa versicolor virginica;
      select;
        when (mod(_n_,3) = 1) do; err=ts[2]+ts[3]; class_err=err/sum; toterr=toterr+err; end;
        when (mod(_n_,3) = 2) do; err=ts[1]+ts[3]; class_err=err/sum; toterr=toterr+err; end;
        when (mod(_n_,3) = 0) do; err=ts[1]+ts[2]; class_err=err/sum; toterr=toterr+err; end;
      end;
      pre_toterr=lag(toterr);
      if levels='Sum' then do;
          class_err=pre_toterr/sum;
          toterr=pre_toterr;
          err=pre_toterr;
      end;
     ;
    run;quit;

    proc print data=class_err;
    run;quit;

    proc print data=workx.iris_from_tree(where=(species ne species2));
    run;quit;

    /*---
    CLASS_ERR total obs=4 10JAN2026:13:00:19
                                                                             class_
    Obs    LEVELS        setosa    versicolor    virginica    Sum    err       err

     1     setosa          38           0             0        38     0     0.000000
     2     versicolor       0          33             2        35     2     0.057143
     3     virginica        0           1            35        36     1     0.027778
     4     Sum             38          34            37       109     3     0.027523

    MISS-CLASSIFICATIONS

    WORKX.IRIS_FROM_TREE total obs=109 10JAN2026:14:49:25

           SEPAL_    SEPAL_    PETAL_    PETAL_
    Obs    LENGTH     WIDTH    LENGTH     WIDTH     SPECIES       SPECIES2

     54      4.9       2.5       4.5       1.7     virginica     versicolor
     61      6.3       2.5       4.9       1.5     versicolor    virginica
     89      6.9       3.1       4.9       1.5     versicolor    virginica

    ---*/

    /* ____                        _                  __                     _          _     _           _
    / | ___|   _ __ __ _ _ __   __| | ___  _ __ ___  / _| ___  _ __ ___  ___| |_   ___ | |__ (_) ___  ___| |_ ___
    | |___ \  | `__/ _` | `_ \ / _` |/ _ \| `_ ` _ \| |_ / _ \| `__/ _ \/ __| __| / _ \| `_ \| |/ _ \/ __| __/ __|
    | |___) | | | | (_| | | | | (_| | (_) | | | | | |  _| (_) | | |  __/\__ \ |_ | (_) | |_) | |  __/ (__| |_\__ \
    |_|____/  |_|  \__,_|_| |_|\__,_|\___/|_| |_| |_|_|  \___/|_|  \___||___/\__| \___/|_.__// |\___|\___|\__|___/
                                                                                           |__/
    */

    List of 19

     $ call           : language randomForest(formula = Species ~ ., data = training, ntree = 100, mtry = 2,      importance = TRUE)
     $ type           : chr "classification"

    PREDICTION IN TRAINING SAMPLE (103 OBSERVATION - TRAINING SET

     $ predicted      : Factor w/ 3 levels "Setosa","Versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...
      ..- attr(*, "names")= chr [1:103] "1" "2" "3" "4" ...

    ERROR ASSOCIATED WITH EACH OF THE HUNDRED TRESS


     $ err.rate       : num [1:100, 1:4] 0.0513 0.0656 0.0658 0.0595 0.0761 ...
      ..- attr(*, "dimnames")=List of 2
      .. ..$ : NULL
      .. ..$ : chr [1:4] "OOB" "Setosa" "Versicolor" "Virginica"

    MISS-CLASSIFICATION MATRIX IN THE SMALLER HOLD OUT SAMPLE - 47 OBSERVATIONS
    ============================================================================

     $ confusion      : num [1:3, 1:4] 30 0 0 0 36 4 0 2 31 0 ...
      ..- attr(*, "dimnames")=List of 2
      .. ..$ : chr [1:3] "Setosa" "Versicolor" "Virginica"
      .. ..$ : chr [1:4] "Setosa" "Versicolor" "Virginica" "class.error"
     $ votes          : 'matrix' num [1:103, 1:3] 1 1 0.921 1 1 ...

      ..- attr(*, "dimnames")=List of 2
      .. ..$ : chr [1:103] "1" "2" "3" "4" ...
      .. ..$ : chr [1:3] "Setosa" "Versicolor" "Virginica"
     $ oob.times      : num [1:103] 38 37 38 37 29 37 44 42 31 30 ...
     $ classes        : chr [1:3] "Setosa" "Versicolor" "Virginica"

    Mean Decrease Accuracy and GINI
    ==============================

     $ importance     : num [1:4, 1:5] 0.0281 0.0143 0.3746 0.3098 0.0143 ...
      ..- attr(*, "dimnames")=List of 2
      .. ..$ : chr [1:4] "sepallength" "sepalwidth" "petallength" "petalwidth"
      .. ..$ : chr [1:5] "Setosa" "Versicolor" "Virginica" "MeanDecreaseAccuracy" ...
     $ importanceSD   : num [1:4, 1:4] 0.0113 0.00637 0.03421 0.03418 0.00724 ...
      ..- attr(*, "dimnames")=List of 2
      .. ..$ : chr [1:4] "sepallength" "sepalwidth" "petallength" "petalwidth"
      .. ..$ : chr [1:4] "Setosa" "Versicolor" "Virginica" "MeanDecreaseAccuracy"
     $ localImportance: NULL
     $ proximity      : NULL
     $ ntree          : num 100
     $ mtry           : num 2
     $ forest         :List of 14
      ..$ ndbigtree : int [1:100] 17 9 15 11 15 21 13 17 17 7 ...
      ..$ nodestatus: int [1:31, 1:100] 1 1 1 1 1 -1 1 -1 1 1 ...
      ..$ bestvar   : int [1:31, 1:100] 2 4 3 3 1 0 1 0 3 2 ...
      ..$ treemap   : int [1:31, 1:2, 1:100] 2 4 6 8 10 0 12 0 14 16 ...
      ..$ nodepred  : int [1:31, 1:100] 0 0 0 0 0 1 0 1 0 0 ...

    SPLIT POINTS
    ============
      ..$ xbestsplit: num [1:31, 1:100] 3.25 1.65 3.1 2.3 5.95 0 6.1 0 5.45 3 ...
      ..$ pid       : num [1:3] 1 1 1
      ..$ cutoff    : num [1:3] 0.333 0.333 0.333
      ..$ ncat      : Named int [1:4] 1 1 1 1
      .. ..- attr(*, "names")= chr [1:4] "sepallength" "sepalwidth" "petallength" "petalwidth"
      ..$ maxcat    : int 1
      ..$ nrnodes   : int 31
      ..$ ntree     : num 100
      ..$ nclass    : int 3
      ..$ xlevels   :List of 4
      .. ..$ sepallength: num 0
      .. ..$ sepalwidth : num 0
      .. ..$ petallength: num 0
      .. ..$ petalwidth : num 0
     $ y              : Factor w/ 3 levels "Setosa","Versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...
      ..- attr(*, "names")= chr [1:103] "1" "2" "3" "4" ...
     $ test           : NULL
     $ inbag          : NULL
     $ terms          :Classes 'terms', 'formula'  language Species ~ sepallength + sepalwidth + petallength + petalwidth
      .. ..- attr(*, "variables")= language list(Species, sepallength, sepalwidth, petallength, petalwidth)
      .. ..- attr(*, "factors")= int [1:5, 1:4] 0 1 0 0 0 0 0 1 0 0 ...
      .. .. ..- attr(*, "dimnames")=List of 2
      .. .. .. ..$ : chr [1:5] "Species" "sepallength" "sepalwidth" "petallength" ...
      .. .. .. ..$ : chr [1:4] "sepallength" "sepalwidth" "petallength" "petalwidth"
      .. ..- attr(*, "term.labels")= chr [1:4] "sepallength" "sepalwidth" "petallength" "petalwidth"
      .. ..- attr(*, "order")= int [1:4] 1 1 1 1
      .. ..- attr(*, "intercept")= num 0
      .. ..- attr(*, "response")= int 1
      .. ..- attr(*, ".Environment")=<environment: R_GlobalEnv>
      .. ..- attr(*, "predvars")= language list(Species, sepallength, sepalwidth, petallength, petalwidth)
      .. ..- attr(*, "dataClasses")= Named chr [1:5] "factor" "numeric" "numeric" "numeric" ...
      .. .. ..- attr(*, "names")= chr [1:5] "Species" "sepallength" "sepalwidth" "petallength" ...
     - attr(*, "class")= chr [1:2] "randomForest.formula" "randomForest"

    /*  __                               _        _
    / |/ /_    ___  __ _ _ __ ___  _ __ | | ___  | |_ _ __ ___  ___
    | | `_ \  / __|/ _` | `_ ` _ \| `_ \| |/ _ \ | __| `__/ _ \/ _ \
    | | (_) | \__ \ (_| | | | | | | |_) | |  __/ | |_| | |  __/  __/
    |_|\___/  |___/\__,_|_| |_| |_| .__/|_|\___|  \__|_|  \___|\___|
                                  |_|
    */

      This is not useful, it is just one of 100 trees.
      Just shown for academic reasons to present one of the ensemble of trees.
      Random Forest `averages` the uncorrelated treees.
      Tndom selection and bootstrap ensures uncorreated trees.

                                  sepalwidth

                                 <=3.25/\ > 3.21
                                      /  \
                                     /    \
                                    /      \
                                   /        \
                                  /          \
                                 /            \ petallength
                                /        <=3.1 * > 3.1
                               /              / \
                              /              /   \
                  petallength/              /     \
                      <=1.65* >1.65     Setosa     \ sepallength
                           / \                 <=6.2\  >6.2
                          /   \                     /*
                         /     \                   /  \
                        /       \                 /    \
                       /         \               /      \
                      /           \       VERICOLOR   VIRGINICA
                     /             \
                sepalength          \
              <=2.3*\ >2.3           \
                  /  \                \
            SERTOSA   \                \
                       \                \
                    petalwidth           \

                  <=5.45 *>5.45        petalwidth
                        /\           <=5.95* >5.95
                       /  \               / \
                      /    \             /   \
                     /      \     sepallength \
             VERSICOLOR  VIRGINICA   <=3*>3    \
                                      / \    VIRGINICA
                                     /   \
                                    /     \
                              VIRGINICA  VERSICOLOR

    /*              _
      ___ _ __   __| |
     / _ \ `_ \ / _` |
    |  __/ | | | (_| |
     \___|_| |_|\__,_|

    */
























































github SQL Code
https://tinyurl.com/ychfd3nd
https://github.com/rogerjdeangelis/utl-r-simple-random-forest-classification-example-using-iris-dataset/blob/master/sqlcode.txt

OR IN SQL

[[1]]
<SQL> CASE
WHEN (`petallength` < 3.1 AND `sepalwidth` >= 3.25) THEN ("Setosa")
WHEN (`petallength` < 2.3 AND `petalwidth` < 1.65 AND `sepalwidth` < 3.25) THEN ("Setosa")
WHEN (`sepallength` >= 5.95 AND `petalwidth` >= 1.65 AND `sepalwidth` < 3.25) THEN ("Virginica")
WHEN (`sepallength` < 6.1 AND `petallength` >= 3.1 AND `sepalwidth` >= 3.25) THEN ("Versicolor")
WHEN (`sepallength` >= 6.1 AND `petallength` >= 3.1 AND `sepalwidth` >= 3.25) THEN ("Virginica")
WHEN (`petallength` < 5.45 AND `petallength` >= 2.3 AND `petalwidth` < 1.65 AND `sepalwidth` < 3.25) THEN ("Versicolor")
WHEN (`petallength` >= 5.45 AND `petallength` >= 2.3 AND `petalwidth` < 1.65 AND `sepalwidth` < 3.25) THEN ("Virginica")
WHEN (`sepalwidth` < 3.0 AND `sepallength` < 5.95 AND `petalwidth` >= 1.65 AND `sepalwidth` < 3.25) THEN ("Virginica")
WHEN (`sepalwidth` >= 3.0 AND `sepallength` < 5.95 AND `petalwidth` >= 1.65 AND `sepalwidth` < 3.25) THEN ("Versicolor")
END

[[2]]
<SQL> CASE
WHEN (`petallength` < 2.35) THEN ("Setosa")
WHEN (`petallength` < 4.75 AND `petallength` >= 2.35) THEN ("Versicolor")
WHEN (`petallength` >= 4.95 AND `petallength` >= 4.75 AND `petallength` >= 2.35) THEN ("Virginica")
WHEN (`petalwidth` < 1.65 AND `petallength` < 4.95 AND `petallength` >= 4.75 AND `petallength` >= 2.35) THEN ("Versicolor")
WHEN (`petalwidth` >= 1.65 AND `petallength` < 4.95 AND `petallength` >= 4.75 AND `petallength` >= 2.35) THEN ("Virginica")
END
...
...
[[100]]
<SQL> CASE
WHEN (`petallength` < 2.45) THEN ("Setosa")
WHEN (`petalwidth` < 1.7 AND `sepallength` >= 6.25 AND `petallength` >= 2.45) THEN ("Versicolor")
WHEN (`petalwidth` >= 1.7 AND `sepallength` >= 6.25 AND `petallength` >= 2.45) THEN ("Virginica")
WHEN (`petallength` >= 5.35 AND `petalwidth` < 1.65 AND `sepallength` < 6.25 AND `petallength` >= 2.45) THEN ("Virginica")
WHEN (`sepallength` < 5.85 AND `petalwidth` >= 1.65 AND `sepallength` < 6.25 AND `petallength` >= 2.45) THEN ("Virginica")
WHEN (`petallength` < 4.75 AND `petallength` < 5.35 AND `petalwidth` < 1.65 AND `sepallength` < 6.25 AND `petallength` >= 2.45) THEN ("Versicolor")
WHEN (`sepallength` < 6.0 AND `sepallength` >= 5.85 AND `petalwidth` >= 1.65 AND `sepallength` < 6.25 AND `petallength` >= 2.45) THEN ("Versicolor")
WHEN (`sepallength` >= 6.0 AND `sepallength` >= 5.85 AND `petalwidth` >= 1.65 AND `sepallength` < 6.25 AND `petallength` >= 2.45) THEN ("Virginica")
WHEN (`sepalwidth` < 2.45 AND `petallength` >= 4.75 AND `petallength` < 5.35 AND `petalwidth` < 1.65 AND `sepallength` < 6.25 AND `petallength` >= 2.45) THEN ("Virginica")
WHEN (`sepalwidth` >= 2.45 AND `petallength` >= 4.75 AND `petallength` < 5.35 AND `petalwidth` < 1.65 AND `sepallength` < 6.25 AND `petallength` >= 2.45) THEN ("Versicolor")
END

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/






































                   ;;;;%end;%mend;/*'*/ *);*};*];*/;/*"*/;run;quit;%end;end;run;endcomp;%utlfix;



                          ;;;;%end;%mend;/*'*/ *);*};*];*/;/*"*/;run;quit;%end;end;run;endcomp;%utlfix;

      put 'if ';
      _infile_=scan(_infile_,2,'(');
  end;

  _infile_=prxchange('s/\,/; else if /',-1,_infile_);
  _infile_=prxchange('s/\&/and/',-1,_infile_);
  _infile_=prxchange('s/\~/then pspecies=/',-1,_infile_);
  _infile_=prxchange('s/\)/;/',-1,_infile_);

  put _infile_;
  putlog _infile_;

  if _n_ = 100 then stop;

run;quit;








































proc report data=allthree headskip;
define from /group order=data;
break after from /skip;
run;quit;


proc freq data=predicted;
 tables species*prediction;
run;quit;

data _null_;

  infile "d:/txt/rcasewhen.txt" firstobs=2 ;
  file "d:/txt/rcasewhen.sas" ;

  input;

  if _n_=1 then do;
      put 'if ';
      _infile_=scan(_infile_,2,'(');
  end;

  _infile_=prxchange('s/\,/; else if /',-1,_infile_);
  _infile_=prxchange('s/\&/and/',-1,_infile_);
  _infile_=prxchange('s/\~/then pspecies=/',-1,_infile_);
  _infile_=prxchange('s/\)/;/',-1,_infile_);

  put _infile_;
  putlog _infile_;

  if _n_ = 100 then stop;

run;quit;


data sascode(label="Deriving the sas code for tree number one and executing it");
  retain species prediction pspecies;
  length pspecies $16;
  set predicted;
  %inc "d:/txt/slcifthen.sas";
run;quit;

`/`(case_when(Sepal_Length >= 4.65 & Petal_Width < 0.8 ~ "setosa",

data chk;
 length pspecies $16;
 set workx.iris20260105 ;
   if
    Sepal_Length < 4.55 and Sepal_Length < 4.65 and Petal_Width <
        0.8 then pspecies= "setosa"; else if  Petal_Length < 1.2 and Sepal_Length >=
        4.55 and Sepal_Length < 4.65 and Petal_Width < 0.8 then pspecies= "setosa"; else if
    Sepal_Length < 5.95 and Petal_Length < 4.85 and Petal_Length >=
        4.75 and Petal_Width >= 0.8 then pspecies= "versicolor"; else if  Petal_Width >=
        1.75 and Petal_Length >= 4.85 and Petal_Length >= 4.75 and
        Petal_Width >= 0.8 then pspecies= "virginica"; else if  Sepal_Width < 3.3 and
        Petal_Length >= 1.2 and Sepal_Length >= 4.55 and Sepal_Length <
        4.65 and Petal_Width < 0.8 then pspecies= "setosa"; else if  Sepal_Width >= 3.3 and
        Petal_Length >= 1.2 and Sepal_Length >= 4.55 and Sepal_Length <
        4.65 and Petal_Width < 0.8 then pspecies= "versicolor"; else if  Sepal_Length <
        6.5 and Sepal_Length >= 5.95 and Petal_Length < 4.85 and Petal_Length >=
        4.75 and Petal_Width >= 0.8 then pspecies= "virginica"; else if  Sepal_Length >=
        6.5 and Sepal_Length >= 5.95 and Petal_Length < 4.85 and Petal_Length >=
        4.75 and Petal_Width >= 0.8 then pspecies= "versicolor"; else if  Petal_Width <
        1.55 and Petal_Width < 1.75 and Petal_Length >= 4.85 and Petal_Length >=
        4.75 and Petal_Width >= 0.8 then pspecies= "virginica"; else if  Petal_Length <
        5.45 and Petal_Width >= 1.55 and Petal_Width < 1.75 and Petal_Length >=
        4.85 and Petal_Length >= 4.75 and Petal_Width >= 0.8 then pspecies= "versicolor"; else
    pspecies = "virginica";
run;quit;


options set=RHOME "C:\Progra~1\R\R-4.5.2\bin\r";
proc r;
export data=workx.iris20260105 r=iris20260105;
submit;
library(dplyr)
result<-with(iris20260105,
case_when(Sepal_Length >= 4.65 & Petal_Width < 0.8 ~ "setosa",
    Petal_Length < 4.75 & Petal_Width >= 0.8 ~ "versicolor",
    Sepal_Length < 4.55 & Sepal_Length < 4.65 & Petal_Width <
        0.8 ~ "setosa", Petal_Length < 1.2 & Sepal_Length >=
        4.55 & Sepal_Length < 4.65 & Petal_Width < 0.8 ~ "setosa",
    Sepal_Length < 5.95 & Petal_Length < 4.85 & Petal_Length >=
        4.75 & Petal_Width >= 0.8 ~ "versicolor", Petal_Width >=
        1.75 & Petal_Length >= 4.85 & Petal_Length >= 4.75 &
        Petal_Width >= 0.8 ~ "virginica", Sepal_Width < 3.3 &
        Petal_Length >= 1.2 & Sepal_Length >= 4.55 & Sepal_Length <
        4.65 & Petal_Width < 0.8 ~ "setosa", Sepal_Width >= 3.3 &
        Petal_Length >= 1.2 & Sepal_Length >= 4.55 & Sepal_Length <
        4.65 & Petal_Width < 0.8 ~ "versicolor", Sepal_Length <
        6.5 & Sepal_Length >= 5.95 & Petal_Length < 4.85 & Petal_Length >=
        4.75 & Petal_Width >= 0.8 ~ "virginica", Sepal_Length >=
        6.5 & Sepal_Length >= 5.95 & Petal_Length < 4.85 & Petal_Length >=
        4.75 & Petal_Width >= 0.8 ~ "versicolor", Petal_Width <
        1.55 & Petal_Width < 1.75 & Petal_Length >= 4.85 & Petal_Length >=
        4.75 & Petal_Width >= 0.8 ~ "virginica", Petal_Length <
        5.45 & Petal_Width >= 1.55 & Petal_Width < 1.75 & Petal_Length >=
        4.85 & Petal_Length >= 4.75 & Petal_Width >= 0.8 ~ "versicolor",
    .default = "virginica"
   ))
result
endsubmit;
run;quit;































;

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/




# Train in R
rf <- randomForest(target ~ ., data = train_df)

# Convert to SQL scoring code (using a helper function/script you source)
sql.export.rf(
  rf,
  file        = "rf_model.sql",
  input.table = "schema.source_table",
  key         = "id"
)


















Up to 40 obs from WANTXPO total obs=4

Obs    LEVELS        Setosa    Versicolor    Virginica    Sum

 1     Setosa          20           0             0        20
 2     Versicolor       0          11             1        12
 3     Virginica        0           1            14        15
 4     Sum             20          12            15        47
*/

data allthree;
  retain from;
  set
    workx.train20260101_cm(in=t)
    workx.holdout20260101_cm(in=h)
    workx.combined20260101_cm(in=c);
 array ts[3] setosa versicolor virginica;
 select;
   when (t) FROM='train   ';
   when (h) FROM='holdout ';
   when (c) FROM='combined';
 end;  /*--- lave off otherwise to force error ---*/
 select;
   when (mod(_n_,3) = 1) class_err=(ts[2]+ts[3])/sum(of ts[*]);
   when (mod(_n_,3) = 2) class_err=(ts[1]+ts[3])/sum(of ts[*]);
   when (mod(_n_,3) = 0) class_err=(ts[1]+ts[2])/sum(of ts[*]);
 end;
run;quit;

proc report data=allthree headskip;
define from /group order=data;
break after from /skip;
run;quit;


proc freq data=predicted;
 tables species*prediction;
run;quit;

data _null_;

  infile "d:/txt/rcasewhen.txt" firstobs=2 ;
  file "d:/txt/sascode.sas" ;

  input;

  if _n_=1 then do;
      put 'if ';
      _infile_=scan(_infile_,2,'(');
  end;

  _infile_=prxchange('s/\,/; else if /',-1,_infile_);
  _infile_=prxchange('s/\&/and/',-1,_infile_);
  _infile_=prxchange('s/\~/then pspecies=/',-1,_infile_);
  _infile_=prxchange('s/\)/;/',-1,_infile_);

  put _infile_;
  putlog _infile_;

run;quit;

data sascode(label="Deriving the sas code for tree number one and executing it");
  retain species prediction pspecies;
  length pspecies $16;
  set predicted;
  %inc "d:/txt/sascode.sas";
run;quit;
;

                     _                  __                     _
 _ __ __ _ _ __   __| | ___  _ __ ___  / _| ___  _ __ ___  ___| |_
| `__/ _` | `_ \ / _` |/ _ \| `_ ` _ \| |_ / _ \| `__/ _ \/ __| __|
| | | (_| | | | | (_| | (_) | | | | | |  _| (_) | | |  __/\__ \ |_
|_|  \__,_|_| |_|\__,_|\___/|_| |_| |_|_|  \___/|_|  \___||___/\__|



THIS LIST CONTAINS THE META DATA ON ALL OF THE RANDOMFOREST OUTPUT
===================================================================

List of 19

 $ call           : language randomForest(formula = Species ~ ., data = training, ntree = 100, mtry = 2,      importance = TRUE)
 $ type           : chr "classification"

PREDICTION IN TRAINING SAMPLE (103 OBSERVATION - TRAINING SET

 $ predicted      : Factor w/ 3 levels "Setosa","Versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...
  ..- attr(*, "names")= chr [1:103] "1" "2" "3" "4" ...

ERROR ASSOCIATED WITH EACH OF THE HUNDRED TRESS


 $ err.rate       : num [1:100, 1:4] 0.0513 0.0656 0.0658 0.0595 0.0761 ...
  ..- attr(*, "dimnames")=List of 2
  .. ..$ : NULL
  .. ..$ : chr [1:4] "OOB" "Setosa" "Versicolor" "Virginica"

MISS-CLASSIFICATION MATRIX IN THE SMALLER HOLD OUT SAMPLE - 47 OBSERVATIONS
============================================================================

 $ confusion      : num [1:3, 1:4] 30 0 0 0 36 4 0 2 31 0 ...
  ..- attr(*, "dimnames")=List of 2
  .. ..$ : chr [1:3] "Setosa" "Versicolor" "Virginica"
  .. ..$ : chr [1:4] "Setosa" "Versicolor" "Virginica" "class.error"
 $ votes          : 'matrix' num [1:103, 1:3] 1 1 0.921 1 1 ...

  ..- attr(*, "dimnames")=List of 2
  .. ..$ : chr [1:103] "1" "2" "3" "4" ...
  .. ..$ : chr [1:3] "Setosa" "Versicolor" "Virginica"
 $ oob.times      : num [1:103] 38 37 38 37 29 37 44 42 31 30 ...
 $ classes        : chr [1:3] "Setosa" "Versicolor" "Virginica"

Mean Decrease Accuracy and GINI
==============================

 $ importance     : num [1:4, 1:5] 0.0281 0.0143 0.3746 0.3098 0.0143 ...
  ..- attr(*, "dimnames")=List of 2
  .. ..$ : chr [1:4] "sepallength" "sepalwidth" "petallength" "petalwidth"
  .. ..$ : chr [1:5] "Setosa" "Versicolor" "Virginica" "MeanDecreaseAccuracy" ...
 $ importanceSD   : num [1:4, 1:4] 0.0113 0.00637 0.03421 0.03418 0.00724 ...
  ..- attr(*, "dimnames")=List of 2
  .. ..$ : chr [1:4] "sepallength" "sepalwidth" "petallength" "petalwidth"
  .. ..$ : chr [1:4] "Setosa" "Versicolor" "Virginica" "MeanDecreaseAccuracy"
 $ localImportance: NULL
 $ proximity      : NULL
 $ ntree          : num 100
 $ mtry           : num 2
 $ forest         :List of 14
  ..$ ndbigtree : int [1:100] 17 9 15 11 15 21 13 17 17 7 ...
  ..$ nodestatus: int [1:31, 1:100] 1 1 1 1 1 -1 1 -1 1 1 ...
  ..$ bestvar   : int [1:31, 1:100] 2 4 3 3 1 0 1 0 3 2 ...
  ..$ treemap   : int [1:31, 1:2, 1:100] 2 4 6 8 10 0 12 0 14 16 ...
  ..$ nodepred  : int [1:31, 1:100] 0 0 0 0 0 1 0 1 0 0 ...

SPLIT POINTS
============
  ..$ xbestsplit: num [1:31, 1:100] 3.25 1.65 3.1 2.3 5.95 0 6.1 0 5.45 3 ...
  ..$ pid       : num [1:3] 1 1 1
  ..$ cutoff    : num [1:3] 0.333 0.333 0.333
  ..$ ncat      : Named int [1:4] 1 1 1 1
  .. ..- attr(*, "names")= chr [1:4] "sepallength" "sepalwidth" "petallength" "petalwidth"
  ..$ maxcat    : int 1
  ..$ nrnodes   : int 31
  ..$ ntree     : num 100
  ..$ nclass    : int 3
  ..$ xlevels   :List of 4
  .. ..$ sepallength: num 0
  .. ..$ sepalwidth : num 0
  .. ..$ petallength: num 0
  .. ..$ petalwidth : num 0
 $ y              : Factor w/ 3 levels "Setosa","Versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...
  ..- attr(*, "names")= chr [1:103] "1" "2" "3" "4" ...
 $ test           : NULL
 $ inbag          : NULL
 $ terms          :Classes 'terms', 'formula'  language Species ~ sepallength + sepalwidth + petallength + petalwidth
  .. ..- attr(*, "variables")= language list(Species, sepallength, sepalwidth, petallength, petalwidth)
  .. ..- attr(*, "factors")= int [1:5, 1:4] 0 1 0 0 0 0 0 1 0 0 ...
  .. .. ..- attr(*, "dimnames")=List of 2
  .. .. .. ..$ : chr [1:5] "Species" "sepallength" "sepalwidth" "petallength" ...
  .. .. .. ..$ : chr [1:4] "sepallength" "sepalwidth" "petallength" "petalwidth"
  .. ..- attr(*, "term.labels")= chr [1:4] "sepallength" "sepalwidth" "petallength" "petalwidth"
  .. ..- attr(*, "order")= int [1:4] 1 1 1 1
  .. ..- attr(*, "intercept")= num 0
  .. ..- attr(*, "response")= int 1
  .. ..- attr(*, ".Environment")=<environment: R_GlobalEnv>
  .. ..- attr(*, "predvars")= language list(Species, sepallength, sepalwidth, petallength, petalwidth)
  .. ..- attr(*, "dataClasses")= Named chr [1:5] "factor" "numeric" "numeric" "numeric" ...
  .. .. ..- attr(*, "names")= chr [1:5] "Species" "sepallength" "sepalwidth" "petallength" ...
 - attr(*, "class")= chr [1:2] "randomForest.formula" "randomForest"

       _       _     _
 _ __ | | ___ | |_  | |_ _ __ ___  ___
| `_ \| |/ _ \| __| | __| `__/ _ \/ _ \
| |_) | | (_) | |_  | |_| | |  __/  __/
| .__/|_|\___/ \__|  \__|_|  \___|\___|
|_|


  This is not useful, it is just one of 100 trees.
  Just shown for academic reasons to present one of the ensemble of trees.
  Random Forest `averages` the uncorrelated treees.
  Tndom selection and bootstrap ensures uncorreated trees.

                              sepalwidth

                             <=3.25/\ > 3.21
                                  /  \
                                 /    \
                                /      \
                               /        \
                              /          \
                             /            \ petallength
                            /        <=3.1 * > 3.1
                           /              / \
                          /              /   \
              petallength/              /     \
                  <=1.65* >1.65     Setosa     \ sepallength
                       / \                 <=6.2\  >6.2
                      /   \                     /*
                     /     \                   /  \
                    /       \                 /    \
                   /         \               /      \
                  /           \       VERICOLOR   VIRGINICA
                 /             \
            sepalength          \
          <=2.3*\ >2.3           \
              /  \                \
        SERTOSA   \                \
                   \                \
                petalwidth           \
              <=5.45 *>5.45        petalwidth
                    /\           <=5.95* >5.95
                   /  \               / \
                  /    \             /   \
                 /      \     sepallength \
         VERSICOLOR  VIRGINICA   <=3*>3    \
                                  / \    VIRGINICA
                                 /   \
                                /     \
                          VIRGINICA  VERSICOLOR

                               _
 ___  __ _ ___    ___ ___   __| | ___
/ __|/ _` / __|  / __/ _ \ / _` |/ _ \
\__ \ (_| \__ \ | (_| (_) | (_| |  __/
|___/\__,_|___/  \___\___/ \__,_|\___|


SAS CODE
========

github SAS CODE
https://tinyurl.com/y8cet7k6
https://github.com/rogerjdeangelis/utl-r-simple-random-forest-classification-example-using-iris-dataset/blob/master/sascode.sas

 You can also get the code benind each of the 100 trees.
 Tidypredict provides ways to get the code behand other models.
 Very useful if you want to

 [1] (tree number 1 of 100)

   if petallength < 3.1 and sepalwidth >= 3.25  then pspecies= "Setosa" ;
   else if petallength < 2.3 and petalwidth < 1.65 and sepalwidth < 3.25  then pspecies="Setosa" ;
       else if   sepallength >= 5.95 and petalwidth >= 1.65 and
            sepalwidth < 3.25  then pspecies= "Virginica" ;
          else if   sepallength < 6.1 and
              petallength >= 3.1 and sepalwidth >= 3.25  then pspecies= "Versicolor" ;
            else if sepallength >= 6.1 and petallength >= 3.1 and sepalwidth >= 3.25  then pspecies="Virginica" ;
              else if   petallength < 5.45 and petallength >= 2.3 and
                   petalwidth < 1.65 and sepalwidth < 3.25  then pspecies= "Versicolor" ;
                else if petallength >= 5.45 and petallength >= 2.3 and petalwidth < 1.65 and
                     sepalwidth < 3.25  then pspecies= "Virginica" ;
                   else if   sepalwidth < 3 and sepallength <
                        5.95 and petalwidth >= 1.65 and sepalwidth < 3.25  then pspecies= "Virginica" ;
                      else if sepalwidth >= 3 and sepallength < 5.95 and petalwidth >= 1.65 and
                      sepalwidth < 3.25  then pspecies= "Versicolor";
           _                 _
 ___  __ _| |   ___ ___   __| | ___
/ __|/ _` | |  / __/ _ \ / _` |/ _ \
\__ \ (_| | | | (_| (_) | (_| |  __/
|___/\__, |_|  \___\___/ \__,_|\___|
        |_|

github SQL Code
https://tinyurl.com/ychfd3nd
https://github.com/rogerjdeangelis/utl-r-simple-random-forest-classification-example-using-iris-dataset/blob/master/sqlcode.txt

OR IN SQL

[[1]]
<SQL> CASE
WHEN (`petallength` < 3.1 AND `sepalwidth` >= 3.25) THEN ("Setosa")
WHEN (`petallength` < 2.3 AND `petalwidth` < 1.65 AND `sepalwidth` < 3.25) THEN ("Setosa")
WHEN (`sepallength` >= 5.95 AND `petalwidth` >= 1.65 AND `sepalwidth` < 3.25) THEN ("Virginica")
WHEN (`sepallength` < 6.1 AND `petallength` >= 3.1 AND `sepalwidth` >= 3.25) THEN ("Versicolor")
WHEN (`sepallength` >= 6.1 AND `petallength` >= 3.1 AND `sepalwidth` >= 3.25) THEN ("Virginica")
WHEN (`petallength` < 5.45 AND `petallength` >= 2.3 AND `petalwidth` < 1.65 AND `sepalwidth` < 3.25) THEN ("Versicolor")
WHEN (`petallength` >= 5.45 AND `petallength` >= 2.3 AND `petalwidth` < 1.65 AND `sepalwidth` < 3.25) THEN ("Virginica")
WHEN (`sepalwidth` < 3.0 AND `sepallength` < 5.95 AND `petalwidth` >= 1.65 AND `sepalwidth` < 3.25) THEN ("Virginica")
WHEN (`sepalwidth` >= 3.0 AND `sepallength` < 5.95 AND `petalwidth` >= 1.65 AND `sepalwidth` < 3.25) THEN ("Versicolor")
END

[[2]]
<SQL> CASE
WHEN (`petallength` < 2.35) THEN ("Setosa")
WHEN (`petallength` < 4.75 AND `petallength` >= 2.35) THEN ("Versicolor")
WHEN (`petallength` >= 4.95 AND `petallength` >= 4.75 AND `petallength` >= 2.35) THEN ("Virginica")
WHEN (`petalwidth` < 1.65 AND `petallength` < 4.95 AND `petallength` >= 4.75 AND `petallength` >= 2.35) THEN ("Versicolor")
WHEN (`petalwidth` >= 1.65 AND `petallength` < 4.95 AND `petallength` >= 4.75 AND `petallength` >= 2.35) THEN ("Virginica")
END
...
...
[[100]]
<SQL> CASE
WHEN (`petallength` < 2.45) THEN ("Setosa")
WHEN (`petalwidth` < 1.7 AND `sepallength` >= 6.25 AND `petallength` >= 2.45) THEN ("Versicolor")
WHEN (`petalwidth` >= 1.7 AND `sepallength` >= 6.25 AND `petallength` >= 2.45) THEN ("Virginica")
WHEN (`petallength` >= 5.35 AND `petalwidth` < 1.65 AND `sepallength` < 6.25 AND `petallength` >= 2.45) THEN ("Virginica")
WHEN (`sepallength` < 5.85 AND `petalwidth` >= 1.65 AND `sepallength` < 6.25 AND `petallength` >= 2.45) THEN ("Virginica")
WHEN (`petallength` < 4.75 AND `petallength` < 5.35 AND `petalwidth` < 1.65 AND `sepallength` < 6.25 AND `petallength` >= 2.45) THEN ("Versicolor")
WHEN (`sepallength` < 6.0 AND `sepallength` >= 5.85 AND `petalwidth` >= 1.65 AND `sepallength` < 6.25 AND `petallength` >= 2.45) THEN ("Versicolor")
WHEN (`sepallength` >= 6.0 AND `sepallength` >= 5.85 AND `petalwidth` >= 1.65 AND `sepallength` < 6.25 AND `petallength` >= 2.45) THEN ("Virginica")
WHEN (`sepalwidth` < 2.45 AND `petallength` >= 4.75 AND `petallength` < 5.35 AND `petalwidth` < 1.65 AND `sepallength` < 6.25 AND `petallength` >= 2.45) THEN ("Virginica")
WHEN (`sepalwidth` >= 2.45 AND `petallength` >= 4.75 AND `petallength` < 5.35 AND `petalwidth` < 1.65 AND `sepallength` < 6.25 AND `petallength` >= 2.45) THEN ("Versicolor")
END

           _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| `_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

*/



%utlfkil(d:/txt/training.txt);
%utlfkil(d:/txt/rf_classifier.txt);
%utlfkil(d:/pdf/rocr.pdf);
%utlfkil(d:/pdf/gini.pdf);
%utlfkil(d:/pdf/errorbytree.pdf);
%utlfkil(d:/txt/gettree.txt);
%utlfkil(d:/txt/codesas.txt);
%utlfkil(d:/txt/sascode.txt);
%utlfkil(d:/txt/sqlcode.txt);
%utlfkil(d:/pdf/decisiontree.pdf);

proc datasets lib=work kill nolist;
run;quit;

options validvarname=v7; * important;

* input;
libname sd1 "d:/sd1";

data sd1.have(rename=species=Species);
   /* structure the SAS iris data to look like the R iris data */
   retain sepallength sepalwidth petallength petalwidth Species;
   set sashelp.iris;
   array ns[*] _numeric_;
   do i=1 to dim(ns);
     ns[i]=ns[i]/10;
   end;
   drop i;
run;quit;

%utl_submit_r64(resolve('
library(dbplyr);
library(dplyr);
library(tidypredict);
library(randomForest);
library(ROCR);
library(haven);
library(SASxport);
library(data.table);
library(ggraph);
library(igraph);
/* plot function for decision tree */
plot_rf_tree <- function(final_model, tree_num, shorten_label = TRUE) {
  tree <- getTree(rf_classifier,  k = tree_num, labelVar = TRUE) %>%
    tibble::rownames_to_column() %>%
    mutate(`split point` = ifelse(is.na(prediction), `split point`, NA));
  graph_frame <- data.frame(from = rep(tree$rowname, 2), to = c(tree$`left daughter`, tree$`right daughter`));
  graph <- graph_from_data_frame(graph_frame) %>% delete_vertices("0");
  V(graph)$node_label <- gsub("_", " ", as.character(tree$`split var`));
  if (shorten_label) { V(graph)$leaf_label <- substr(as.character(tree$prediction), 1, 5) };
  print(tree$prediction);
  V(graph)$split <- as.character(round(tree$`split point`, digits = 2));
  print(round(tree$`split point`, digits = 2));
  plot <- ggraph(graph, "tree") +
      theme_graph() +
      geom_edge_link() +
      geom_node_point() +
      geom_node_text(aes(label = split), nudge_x = -.3) +
      geom_node_label(aes(label = leaf_label, fill = leaf_label), na.rm = TRUE,
                    repel = FALSE, colour = "white", show.legend = FALSE);
  print(plot);
};
set.seed(17);
iris<-read_sas("d:/sd1/have.sas7bdat");
iris$Species<-as.factor(iris$Species);
/* Calculate the size of each of the traning and holdout samples: */
ind <- sample(2, nrow(iris), replace=TRUE, prob=c(0.7, 0.3));
training    <- iris[ind==1,];
validation1 <- iris[ind==2,];
/* develop model using the 103 observation training sample */
rf_classifier = randomForest(Species ~ ., data=training, ntree=100, mtry=2, importance=TRUE);
/* summary report */
sink("d:/txt/training.txt");
rf_classifier;
sink();
/* gini data for plots * condition for sas dataset */
imp  <-rf_classifier$importanceSD[,-1];
impx <- as.data.table(importance(rf_classifier));
imp  <-cbind(rownames(imp),impx);
impx$vars<-t(rownames(imp));
/* detail meta data on all possible output SAS datasets - like proc contents */
sink(file="d:/txt/rf_classifier.txt");
str(rf_classifier);
sink();
/* extract the first tree with data that is use for plotting a decision tree */
sink(file="d:/txt/gettree.txt");
getTree(rf_classifier, 1, labelVar=TRUE);
sink();
/* create a text file with sas code tha can be used to run the model in sas */
sink(file="d:/txt/codesas.txt");
tidypredict_fit(rf_classifier)[1];
sink();
/* create a text file with sas code tha can be used to run the model in sas */
sink(file="d:/txt/sqlcode.txt");
tidypredict_sql(rf_classifier,dbplyr::simulate_mssql());
sink();
/* create highres geni plots */
pdf(file="d:/pdf/gini.pdf");
varImpPlot(rf_classifier);
pdf();
/* Validation set assessment #1: looking at confusion matrix */
prediction_for_table <- predict(rf_classifier,validation1[,-5]);
/* ROC curves and AUC */
prediction_for_roc_curve <- predict(rf_classifier,validation1[,-5],type="prob");
/* Use pretty colours: */
pretty_colours <- c("#F8766D","#00BA38","#619CFF");
/* Specify the different classes */
classes <- levels(validation1$Species);
pdf(file="d:/pdf/rocr.pdf");
pdf();
/* plot decision tree - needs a little more work but is not critical */
puc<-c(1,1,1);
for (i in 1:3) {
   true_values <- ifelse(validation1[,5]==classes[i],1,0);
   pred <- prediction(prediction_for_roc_curve[,i],true_values);
   perf <- performance(pred, "tpr", "fpr");
      if (i==1)
      {plot(perf,main="ROC Curve",col=pretty_colours[i])}
      else {plot(perf,main="ROC Curve",col=pretty_colours[i],add=TRUE)};
   /* Calculate the AUC and print it to screen */
   auc.perf <- performance(pred, measure = "auc");
   puc[i]<-auc.perf@y.values[[1]];
};
/* area under roc curves */
puc<-as.data.table(t(puc));
colnames(puc)<-classes;
wantpred<-as.data.table(cbind(validation1[,1:5],prediction_for_table));
/* change factor columns to character for sas export */
wantpred[] <- lapply(wantpred, function(x) if(is.factor(x)) as.character(x) else x);
/* store long column names in the label of the v5 exort file */
for (i in seq_along(wantpred)) {label(wantpred[[i]])<- colnames(wantpred)[[i]]};
pdf(file="d:/pdf/errorbytree.pdf");
plot(rf_classifier);
pdf();
/* decision tree */
pdf(file="d:/pdf/decisiontree.pdf");
plot_rf_tree(rf_classifier,1);
pdf();
/* create sas error dataset */
errors<-as.data.table(rf_classifier$err.rate);
for (i in seq_along(imp)) {label(imp[[i]])<- colnames(imp)[[i]]};
write.xport(wantpred, puc, imp, errors,file="d:/xpt/want.xpt");
'));


options ls=171 ps=65;

libname xpt xport "d:/xpt/want.xpt";

proc contents data=xpt._all_;
run;quit;

proc datasets lib=work kill;
run;quit;

data predicted(label="Predictions using the holdout sample 47 obs")
     miss_classified(label="Miss-classified observations using the holdout sample 47 obs") ;
 retain species prediction;
 %utl_rens(xpt.wantpred);
 set wantpred(rename=prediction_for_table=prediction);
 output predicted;
 if species ne prediction then output miss_classified ;
run;quit;

data rocauc(label="area under the ROC curves by Species");
  set xpt.puc;
run;quit;

data oob_errors(label="Out of Bag errors by each of the 100 trees");
retain tree;
  set xpt.errors;
  tree=_n_;
run;quit;

data gini(label="GINI equality indexes by flower petals and sepals");
  %utl_rens(xpt.imp);
  set imp;
run;quit;

proc datasets lib=work mt=view nolist;
  delete imp wantpred;
run;quit;

libname xpt clear;

options ls=64 ps=28;
proc plot data=oob_errors(obs=25 rename=oob=oob12345678901234567890);
  plot oob12345678901234567890*tree='*'/box href=14 haxis=0 to 25 by 2;
run;quit;

ods exclude all;
ods output observed=wantXpo(rename=label=LEVELS label="Classification matrix classified and miss-classified counts");
proc corresp data=predicted dim=1 observed;
tables species,prediction;
run;quit;
ods select all;

/*
Up to 40 obs from WANTXPO total obs=4

Obs    LEVELS        Setosa    Versicolor    Virginica    Sum

 1     Setosa          20           0             0        20
 2     Versicolor       0          11             1        12
 3     Virginica        0           1            14        15
 4     Sum             20          12            15        47
*/

proc freq data=predicted;
 tables species*prediction;
run;quit;

data _null_;

  infile "d:/txt/codesas.txt" firstobs=2 ;
  file "d:/txt/sascode.sas" ;

  input;

  if _n_=1 then do;
      put 'if ';
      _infile_=scan(_infile_,2,'(');
  end;

  _infile_=prxchange('s/\,/; else if /',-1,_infile_);
  _infile_=prxchange('s/\&/and/',-1,_infile_);
  _infile_=prxchange('s/\~/then pspecies=/',-1,_infile_);
  _infile_=prxchange('s/\)/;/',-1,_infile_);

  put _infile_;
  putlog _infile_;

run;quit;

data sascode(label="Deriving the sas code for tree number one and executing it");
  retain species prediction pspecies;
  length pspecies $16;
  set predicted;
  %inc "d:/txt/sascode.sas";
run;quit;
;

           _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| `_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

*/



%utlfkil(d:/txt/training.txt);
%utlfkil(d:/txt/rf_classifier.txt);
%utlfkil(d:/pdf/rocr.pdf);
%utlfkil(d:/pdf/gini.pdf);
%utlfkil(d:/pdf/errorbytree.pdf);
%utlfkil(d:/txt/gettree.txt);
%utlfkil(d:/txt/codesas.txt);
%utlfkil(d:/txt/sascode.txt);
%utlfkil(d:/txt/sqlcode.txt);
%utlfkil(d:/pdf/decisiontree.pdf);

proc datasets lib=workx kill nolist;
run;quit;

options validvarname=v7;
data workx.have;
  retain sepallength sepalwidth petallength petalwidth Species;
  informat
   Species $10.;
  input Species sepallength sepalwidth petallength petalwidth @@;
   array ns[*] _numeric_;
   do i=1 to dim(ns);
     ns[i]=ns[i]/10;
   end;
   drop i;
cards4;
Setosa 50 33 14 2  Versicolor 65 28 46 15  Virginica 64 28 56 22
Setosa 46 34 14 3  Versicolor 62 22 45 15  Virginica 67 31 56 24
Setosa 46 36 10 2  Versicolor 59 32 48 18  Virginica 63 28 51 15
Setosa 51 33 17 5  Versicolor 61 30 46 14  Virginica 69 31 51 23
Setosa 55 35 13 2  Versicolor 60 27 51 16  Virginica 65 30 52 20
Setosa 48 31 16 2  Versicolor 56 25 39 11  Virginica 65 30 55 18
Setosa 52 34 14 2  Versicolor 57 28 45 13  Virginica 58 27 51 19
Setosa 49 36 14 1  Versicolor 63 33 47 16  Virginica 68 32 59 23
Setosa 44 32 13 2  Versicolor 70 32 47 14  Virginica 62 34 54 23
Setosa 50 35 16 6  Versicolor 64 32 45 15  Virginica 77 38 67 22
Setosa 44 30 13 2  Versicolor 61 28 40 13  Virginica 67 33 57 25
Setosa 47 32 16 2  Versicolor 55 24 38 11  Virginica 76 30 66 21
Setosa 48 30 14 3  Versicolor 54 30 45 15  Virginica 49 25 45 17
Setosa 51 38 16 2  Versicolor 58 26 40 12  Virginica 67 30 52 23
Setosa 48 34 19 2  Versicolor 55 26 44 12  Virginica 59 30 51 18
Setosa 50 30 16 2  Versicolor 50 23 33 10  Virginica 63 25 50 19
Setosa 50 32 12 2  Versicolor 67 31 44 14  Virginica 64 32 53 23
Setosa 43 30 11 1  Versicolor 56 30 45 15  Virginica 79 38 64 20
Setosa 58 40 12 2  Versicolor 58 27 41 10  Virginica 67 33 57 21
Setosa 51 38 19 4  Versicolor 60 29 45 15  Virginica 77 28 67 20
Setosa 49 30 14 2  Versicolor 57 26 35 10  Virginica 63 27 49 18
Setosa 51 35 14 2  Versicolor 57 29 42 13  Virginica 72 32 60 18
Setosa 50 34 16 4  Versicolor 49 24 33 10  Virginica 61 30 49 18
Setosa 46 32 14 2  Versicolor 56 27 42 13  Virginica 61 26 56 14
Setosa 57 44 15 4  Versicolor 57 30 42 12  Virginica 64 28 56 21
Setosa 50 36 14 2  Versicolor 66 29 46 13  Virginica 62 28 48 18
Setosa 54 34 15 4  Versicolor 52 27 39 14  Virginica 77 30 61 23
Setosa 52 41 15 1  Versicolor 60 34 45 16  Virginica 63 34 56 24
Setosa 55 42 14 2  Versicolor 50 20 35 10  Virginica 58 27 51 19
Setosa 49 31 15 2  Versicolor 55 24 37 10  Virginica 72 30 58 16
Setosa 54 39 17 4  Versicolor 58 27 39 12  Virginica 71 30 59 21
Setosa 50 34 15 2  Versicolor 62 29 43 13  Virginica 64 31 55 18
Setosa 44 29 14 2  Versicolor 59 30 42 15  Virginica 60 30 48 18
Setosa 47 32 13 2  Versicolor 60 22 40 10  Virginica 63 29 56 18
Setosa 46 31 15 2  Versicolor 67 31 47 15  Virginica 77 26 69 23
Setosa 51 34 15 2  Versicolor 63 23 44 13  Virginica 60 22 50 15
Setosa 50 35 13 3  Versicolor 56 30 41 13  Virginica 69 32 57 23
Setosa 49 31 15 1  Versicolor 63 25 49 15  Virginica 74 28 61 19
Setosa 54 37 15 2  Versicolor 61 28 47 12  Virginica 56 28 49 20
Setosa 54 39 13 4  Versicolor 64 29 43 13  Virginica 73 29 63 18
Setosa 51 35 14 3  Versicolor 51 25 30 11  Virginica 67 25 58 18
Setosa 48 34 16 2  Versicolor 57 28 41 13  Virginica 65 30 58 22
Setosa 48 30 14 1  Versicolor 61 29 47 14  Virginica 69 31 54 21
Setosa 45 23 13 3  Versicolor 56 29 36 13  Virginica 72 36 61 25
Setosa 57 38 17 3  Versicolor 69 31 49 15  Virginica 65 32 51 20
Setosa 51 38 15 3  Versicolor 55 25 40 13  Virginica 64 27 53 19
Setosa 54 34 17 2  Versicolor 55 23 40 13  Virginica 68 30 55 21
Setosa 51 37 15 4  Versicolor 66 30 44 14  Virginica 57 25 50 20
Setosa 52 35 15 2  Versicolor 68 28 48 14  Virginica 58 28 51 24
Setosa 53 37 15 2  Versicolor 67 30 50 17  Virginica 63 33 60 25
;;;;
run;quit;



%utlfkil(d:/txt/training.txt);
%utlfkil(d:/txt/rf_classifier.txt);
%utlfkil(d:/pdf/rocr.pdf);
%utlfkil(d:/pdf/gini.pdf);
%utlfkil(d:/pdf/errorbytree.pdf);
%utlfkil(d:/txt/gettree.txt);
%utlfkil(d:/txt/codesas.txt);
%utlfkil(d:/txt/sascode.txt);
%utlfkil(d:/txt/sqlcode.txt);
%utlfkil(d:/pdf/decisiontree.pdf);

options set=RHOME "C:\Progra~1\R\R-4.5.2\bin\r";
proc r;
export data=workx.have r=have;
submit;
library(dbplyr)
library(dplyr)
library(tidypredict)
library(randomForest)
library(ROCR)
library(data.table)
library(ggraph)
library(igraph)
# plot function for decision tree
plot_rf_tree <- function(final_model, tree_num, shorten_label = TRUE) {
  tree <- getTree(rf_classifier,  k = tree_num, labelVar = TRUE) %>%
    tibble::rownames_to_column() %>%
    mutate(`split point` = ifelse(is.na(prediction), `split point`, NA))
  graph_frame <- data.frame(from = rep(tree$rowname, 2), to = c(tree$`left daughter`, tree$`right daughter`))
  graph <- graph_from_data_frame(graph_frame) %>% delete_vertices("0")
  V(graph)$node_label <- gsub("_", " ", as.character(tree$`split var`))
  if (shorten_label) { V(graph)$leaf_label <- substr(as.character(tree$prediction), 1, 5) }
  print(tree$prediction)
  V(graph)$split <- as.character(round(tree$`split point`, digits = 2))
  print(round(tree$`split point`, digits = 2))
  plot <- ggraph(graph, "tree") +
      theme_graph() +
      geom_edge_link() +
      geom_node_point() +
      geom_node_text(aes(label = split), nudge_x = -.3) +
      geom_node_label(aes(label = leaf_label, fill = leaf_label), na.rm = TRUE,
                    repel = FALSE, colour = "white", show.legend = FALSE)
  print(plot)
}
set.seed(17)
iris<-have
iris
iris$Species<-as.factor(iris$Species)

# Calculate the size of each of the traning and holdout samples:
ind <- sample(2, nrow(iris), replace=TRUE, prob=c(0.7, 0.3))
training    <- iris[ind==1,]
validation1 <- iris[ind==2,]
# develop model using the 103 observation training sample
rf_classifier = randomForest(Species ~ ., data=training, ntree=100, mtry=2, importance=TRUE)

# summary report
sink("d:/txt/training.txt")
rf_classifier
sink()

# gini data for plots * condition for sas dataset
imp  <-rf_classifier$importanceSD[,-1]
impx <- as.data.table(importance(rf_classifier))
imp  <-cbind(rownames(imp),impx)
impx$vars<-t(rownames(imp))

# detail meta data on all possible output SAS datasets - like proc contents
sink(file="d:/txt/rf_classifier.txt")
str(rf_classifier)
sink()

# extract the first tree with data that is use for plotting a decision tree
sink(file="d:/txt/gettree.txt")
getTree(rf_classifier, 1, labelVar=TRUE)
sink()

# create a text file with sas code tha can be used to run the model in sas
sink(file="d:/txt/codesas.txt")
tidypredict_fit(rf_classifier)[1]
sink()

# create a text file with sas code tha can be used to run the model in sas
sink(file="d:/txt/sqlcode.txt")
tidypredict_sql(rf_classifier,dbplyr::simulate_mssql())
sink()

# create highres geni plots
pdf(file="d:/pdf/gini.pdf", family="sans")
varImpPlot(rf_classifier)
dev.off()

# Validation set assessment #1: looking at confusion matrix
prediction_for_table <- predict(rf_classifier,validation1[,-5])

# ROC curves and AUC
prediction_for_roc_curve <- predict(rf_classifier,validation1[,-5],type="prob")

# Use pretty colours:
pretty_colours <- c("#F8766D","#00BA38","#619CFF")

# Specify the different classes
classes <- levels(validation1$Species)
pdf(file="d:/pdf/rocr.pdf", family="sans")
dev.off()

# plot decision tree - needs a little more work but is not critical
puc<-c(1,1,1)
for (i in 1:3) {
   true_values <- ifelse(validation1[,5]==classes[i],1,0)
   pred <- prediction(prediction_for_roc_curve[,i],true_values)
   perf <- performance(pred, "tpr", "fpr")
      if (i==1)
      {plot(perf,main="ROC Curve",col=pretty_colours[i])}
      else {plot(perf,main="ROC Curve",col=pretty_colours[i],add=TRUE)}
   # Calculate the AUC and print it to screen
   auc.perf <- performance(pred, measure = "auc")
   puc[i]<-auc.perf@y.values[[1]]
}

# area under roc curves
puc<-as.data.table(t(puc))
colnames(puc)<-classes
wantpred<-as.data.table(cbind(validation1[,1:5],prediction_for_table))

pdf(file="d:/pdf/errorbytree.pdf", family="sans")
plot(rf_classifier)
dev.off()

endsubmit;
import r=wantpred   data=workx.wantpred;
import r=puc        data=workx.puc     ;
import r=imp        data=workx.imp     ;
import r=errors     data=workx.errors  ;
run;quit;







options ls=171 ps=65;

libname xpt xport "d:/xpt/want.xpt";

proc contents data=xpt._all_;
run;quit;

proc datasets lib=work kill;
run;quit;

data predicted(label="Predictions using the holdout sample 47 obs")
     miss_classified(label="Miss-classified observations using the holdout sample 47 obs") ;
 retain species prediction;
 %utl_rens(xpt.wantpred);
 set wantpred(rename=prediction_for_table=prediction);
 output predicted;
 if species ne prediction then output miss_classified ;
run;quit;

data rocauc(label="area under the ROC curves by Species");
  set xpt.puc;
run;quit;

data oob_errors(label="Out of Bag errors by each of the 100 trees");
retain tree;
  set xpt.errors;
  tree=_n_;
run;quit;

data gini(label="GINI equality indexes by flower petals and sepals");
  %utl_rens(xpt.imp);
  set imp;
run;quit;

proc datasets lib=work mt=view nolist;
  delete imp wantpred;
run;quit;

libname xpt clear;

options ls=64 ps=28;
proc plot data=oob_errors(obs=25 rename=oob=oob12345678901234567890);
  plot oob12345678901234567890*tree='*'/box href=14 haxis=0 to 25 by 2;
run;quit;

ods exclude all;
ods output observed=wantXpo(rename=label=LEVELS label="Classification matrix classified and miss-classified counts");
proc corresp data=predicted dim=1 observed;
tables species,prediction;
run;quit;
ods select all;

/*
Up to 40 obs from WANTXPO total obs=4

Obs    LEVELS        Setosa    Versicolor    Virginica    Sum

 1     Setosa          20           0             0        20
 2     Versicolor       0          11             1        12
 3     Virginica        0           1            14        15
 4     Sum             20          12            15        47
*/

proc freq data=predicted;
 tables species*prediction;
run;quit;

data _null_;

  infile "d:/txt/codesas.txt" firstobs=2 ;
  file "d:/txt/sascode.sas" ;

  input;

  if _n_=1 then do;
      put 'if ';
      _infile_=scan(_infile_,2,'(');
  end;

  _infile_=prxchange('s/\,/; else if /',-1,_infile_);
  _infile_=prxchange('s/\&/and/',-1,_infile_);
  _infile_=prxchange('s/\~/then pspecies=/',-1,_infile_);
  _infile_=prxchange('s/\)/;/',-1,_infile_);

  put _infile_;
  putlog _infile_;

run;quit;

data sascode(label="Deriving the sas code for tree number one and executing it");
  retain species prediction pspecies;
  length pspecies $16;
  set predicted;
  %inc "d:/txt/sascode.sas";
run;quit;
;


proc datasets lib=work kill nolist;
run;quit;

options validvarname=v7; * important;

* input;
libname sd1 "d:/sd1";

data sd1.have(rename=species=Species);
   /* structure the SAS iris data to look like the R iris data */
   retain sepallength sepalwidth petallength petalwidth Species;
   set sashelp.iris;
   array ns[*] _numeric_;
   do i=1 to dim(ns);
     ns[i]=ns[i]/10;
   end;
   drop i;
run;quit;

%utl_submit_r64(resolve('
library(dbplyr);
library(dplyr);
library(tidypredict);
library(randomForest);
library(ROCR);
library(haven);
library(SASxport);
library(data.table);
library(ggraph);
library(igraph);
/* plot function for decision tree */
plot_rf_tree <- function(final_model, tree_num, shorten_label = TRUE) {
  tree <- getTree(rf_classifier,  k = tree_num, labelVar = TRUE) %>%
    tibble::rownames_to_column() %>%
    mutate(`split point` = ifelse(is.na(prediction), `split point`, NA));
  graph_frame <- data.frame(from = rep(tree$rowname, 2), to = c(tree$`left daughter`, tree$`right daughter`));
  graph <- graph_from_data_frame(graph_frame) %>% delete_vertices("0");
  V(graph)$node_label <- gsub("_", " ", as.character(tree$`split var`));
  if (shorten_label) { V(graph)$leaf_label <- substr(as.character(tree$prediction), 1, 5) };
  print(tree$prediction);
  V(graph)$split <- as.character(round(tree$`split point`, digits = 2));
  print(round(tree$`split point`, digits = 2));
  plot <- ggraph(graph, "tree") +
      theme_graph() +
      geom_edge_link() +
      geom_node_point() +
      geom_node_text(aes(label = split), nudge_x = -.3) +
      geom_node_label(aes(label = leaf_label, fill = leaf_label), na.rm = TRUE,
                    repel = FALSE, colour = "white", show.legend = FALSE);
  print(plot);
};
set.seed(17);
iris<-read_sas("d:/sd1/have.sas7bdat");
iris$Species<-as.factor(iris$Species);
/* Calculate the size of each of the traning and holdout samples: */
ind <- sample(2, nrow(iris), replace=TRUE, prob=c(0.7, 0.3));
training    <- iris[ind==1,];
validation1 <- iris[ind==2,];
/* develop model using the 103 observation training sample */
rf_classifier = randomForest(Species ~ ., data=training, ntree=100, mtry=2, importance=TRUE);
/* summary report */
sink("d:/txt/training.txt");
rf_classifier;
sink();
/* gini data for plots * condition for sas dataset */
imp  <-rf_classifier$importanceSD[,-1];
impx <- as.data.table(importance(rf_classifier));
imp  <-cbind(rownames(imp),impx);
impx$vars<-t(rownames(imp));
/* detail meta data on all possible output SAS datasets - like proc contents */
sink(file="d:/txt/rf_classifier.txt");
str(rf_classifier);
sink();
/* extract the first tree with data that is use for plotting a decision tree */
sink(file="d:/txt/gettree.txt");
getTree(rf_classifier, 1, labelVar=TRUE);
sink();
/* create a text file with sas code tha can be used to run the model in sas */
sink(file="d:/txt/codesas.txt");
tidypredict_fit(rf_classifier)[1];
sink();
/* create a text file with sas code tha can be used to run the model in sas */
sink(file="d:/txt/sqlcode.txt");
tidypredict_sql(rf_classifier,dbplyr::simulate_mssql());
sink();
/* create highres geni plots */
pdf(file="d:/pdf/gini.pdf");
varImpPlot(rf_classifier);
pdf();
/* Validation set assessment #1: looking at confusion matrix */
prediction_for_table <- predict(rf_classifier,validation1[,-5]);
/* ROC curves and AUC */
prediction_for_roc_curve <- predict(rf_classifier,validation1[,-5],type="prob");
/* Use pretty colours: */
pretty_colours <- c("#F8766D","#00BA38","#619CFF");
/* Specify the different classes */
classes <- levels(validation1$Species);
pdf(file="d:/pdf/rocr.pdf");
pdf();
/* plot decision tree - needs a little more work but is not critical */
puc<-c(1,1,1);
for (i in 1:3) {
   true_values <- ifelse(validation1[,5]==classes[i],1,0);
   pred <- prediction(prediction_for_roc_curve[,i],true_values);
   perf <- performance(pred, "tpr", "fpr");
      if (i==1)
      {plot(perf,main="ROC Curve",col=pretty_colours[i])}
      else {plot(perf,main="ROC Curve",col=pretty_colours[i],add=TRUE)};
   /* Calculate the AUC and print it to screen */
   auc.perf <- performance(pred, measure = "auc");
   puc[i]<-auc.perf@y.values[[1]];
};
/* area under roc curves */
puc<-as.data.table(t(puc));
colnames(puc)<-classes;
wantpred<-as.data.table(cbind(validation1[,1:5],prediction_for_table));
/* change factor columns to character for sas export */
wantpred[] <- lapply(wantpred, function(x) if(is.factor(x)) as.character(x) else x);
/* store long column names in the label of the v5 exort file */
for (i in seq_along(wantpred)) {label(wantpred[[i]])<- colnames(wantpred)[[i]]};
pdf(file="d:/pdf/errorbytree.pdf");
plot(rf_classifier);
pdf();
/* decision tree */
pdf(file="d:/pdf/decisiontree.pdf");
plot_rf_tree(rf_classifier,1);
pdf();
/* create sas error dataset */
errors<-as.data.table(rf_classifier$err.rate);
for (i in seq_along(imp)) {label(imp[[i]])<- colnames(imp)[[i]]};
write.xport(wantpred, puc, imp, errors,file="d:/xpt/want.xpt");
'));


/*___                        _                  __                     _
| ___|   _ __ __ _ _ __   __| | ___  _ __ ___  / _| ___  _ __ ___  ___| |_  _ __  _ __ ___   ___ ___  ___ ___
|___ \  | `__/ _` | `_ \ / _` |/ _ \| `_ ` _ \| |_ / _ \| `__/ _ \/ __| __|| `_ \| `__/ _ \ / __/ _ \/ __/ __|
 ___) | | | | (_| | | | | (_| | (_) | | | | | |  _| (_) | | |  __/\__ \ |_ | |_) | | | (_) | (_|  __/\__ \__ \
|____/  |_|  \__,_|_| |_|\__,_|\___/|_| |_| |_|_|  \___/|_|  \___||___/\__|| .__/|_|  \___/ \___\___||___/___/
                                                                           |_|
*/

%utlfkil(d:/txt/training.txt);
%utlfkil(d:/txt/rf_classifier.txt);
%utlfkil(d:/pdf/rocr.pdf);
%utlfkil(d:/pdf/gini.pdf);
%utlfkil(d:/pdf/errorbytree.pdf);
%utlfkil(d:/txt/gettree.txt);
%utlfkil(d:/txt/codesas.txt);
%utlfkil(d:/txt/sascode.txt);
%utlfkil(d:/txt/sqlcode.txt);
%utlfkil(d:/pdf/decisiontree.pdf);

options set=RHOME "C:\Progra~1\R\R-4.5.2\bin\r";
proc r;
export data=workx.iris20260101 r=iris;
submit;
library(dbplyr)
library(dplyr)
library(tidypredict)
library(randomForest)
library(ROCR)
library(data.table)
library(ggraph)
library(igraph)
# plot function for decision tree
plot_rf_tree <- function(final_model, tree_num, shorten_label = TRUE) {
  tree <- getTree(rf_classifier,  k = tree_num, labelVar = TRUE) %>%
    tibble::rownames_to_column() %>%
    mutate(`split point` = ifelse(is.na(prediction), `split point`, NA))
  graph_frame <- data.frame(from = rep(tree$rowname, 2), to = c(tree$`left daughter`, tree$`right daughter`))
  graph <- graph_from_data_frame(graph_frame) %>% delete_vertices("0")
  V(graph)$node_label <- gsub("_", " ", as.character(tree$`split var`))
  if (shorten_label) { V(graph)$leaf_label <- substr(as.character(tree$prediction), 1, 5) }
  print(tree$prediction)
  V(graph)$split <- as.character(round(tree$`split point`, digits = 2))
  print(round(tree$`split point`, digits = 2))
  plot <- ggraph(graph, "tree") +
      theme_graph() +
      geom_edge_link() +
      geom_node_point() +
      geom_node_text(aes(label = split), nudge_x = -.3) +
      geom_node_label(aes(label = leaf_label, fill = leaf_label), na.rm = TRUE,
                    repel = FALSE, colour = "white", show.legend = FALSE)
  print(plot)
}
set.seed(17)
iris$Species<-as.factor(iris$Species)

# Calculate the size of each of the traning and holdout samples:
training    <- iris

# develop model using the 103 observation training sample
rf_classifier = randomForest(Species ~ ., data=training, ntree=100, mtry=2, importance=TRUE)

# summary report
sink("d:/txt/training.txt")
rf_classifier
sink()

# gini data for plots * condition for sas dataset
imp  <-rf_classifier$importanceSD[,-1]
impx <- as.data.table(importance(rf_classifier))
imp  <-cbind(rownames(imp),impx)
impx$vars<-t(rownames(imp))

# detail meta data on all possible output SAS datasets - like proc contents
sink(file="d:/txt/rf_classifier.txt")
str(rf_classifier)
sink()

# extract the first tree with data that is use for plotting a decision tree
sink(file="d:/txt/gettree.txt")
getTree(rf_classifier, 1, labelVar=TRUE)
sink()

# create a text file with sas code tha can be used to run the model in sas
sink(file="d:/txt/codesas.txt")
tidypredict_fit(rf_classifier)[1]
sink()

# create a text file with sas code tha can be used to run the model in sas
sink(file="d:/txt/sqlcode.txt")
tidypredict_sql(rf_classifier,dbplyr::simulate_mssql())
sink()

# create highres geni plots
pdf(file="d:/pdf/gini.pdf", family="sans")
varImpPlot(rf_classifier)
dev.off()

# Validation set assessment #1: looking at confusion matrix
prediction_for_table <- predict(rf_classifier,validation1[,-5])

# ROC curves and AUC
prediction_for_roc_curve <- predict(rf_classifier,validation1[,-5],type="prob")

# Use pretty colours:
pretty_colours <- c("#F8766D","#00BA38","#619CFF")

# Specify the different classes
classes <- levels(validation1$Species)
pdf(file="d:/pdf/rocr.pdf", family="sans")
dev.off()

# plot decision tree - needs a little more work but is not critical
puc<-c(1,1,1)
for (i in 1:3) {
   true_values <- ifelse(validation1[,5]==classes[i],1,0)
   pred <- prediction(prediction_for_roc_curve[,i],true_values)
   perf <- performance(pred, "tpr", "fpr")
      if (i==1)
      {plot(perf,main="ROC Curve",col=pretty_colours[i])}
      else {plot(perf,main="ROC Curve",col=pretty_colours[i],add=TRUE)}
   # Calculate the AUC and print it to screen
   auc.perf <- performance(pred, measure = "auc")
   puc[i]<-auc.perf@y.values[[1]]
}

# area under roc curves
puc<-as.data.table(t(puc))
colnames(puc)<-classes
wantpred<-as.data.table(cbind(validation1[,1:5],prediction_for_table))

pdf(file="d:/pdf/errorbytree.pdf", family="sans")
plot(rf_classifier)
dev.off()

errors<-as.data.table(rf_classifier$err.rate);

endsubmit;
import r=wantpred   data=workx.wantpred;
import r=puc        data=workx.puc     ;
import r=imp        data=workx.imp     ;
import r=errors     data=workx.errors  ;
run;quit;
