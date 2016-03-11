
create table markstbl(
   student        string,
   sciencemarks   array<int>,
   mathmarks      array<string>
)
row format delimited
fields terminated by ','
collection items terminated by '|'  --Delimiter for elements in ;
                                    --complex types like
                                    --ARRAY, MAP, STRUCT etc...

load data local inpath './a15_input.txt'
overwrite into table markstbl;

hive> select * from markstbl;
alice [33,34]  ["35","36"]
bob   [43,44]  ["45","46"]

hive> select totalmarks(student, sciencemarks) from markstbl;
FAILED: SemanticException [Error 10015]: Line 1:7 Arguments length mismatch 'sciencemarks': Expected no of arguments -> 1, Given no of arguments -> 2

hive> select totalmarks(student) from markstbl;
FAILED: SemanticException [Error 10016]: Line 1:18 Argument type mismatch 'student': First argument should be List, but has string

hive> select totalmarks(mathmarks) from markstbl;
FAILED: SemanticException [Error 10016]: Line 1:18 Argument type mismatch 'mathmarks': List should contain only Integer, but has string

hive> select totalmarks(sciencemarks) from markstbl;
67
87

hive> explain select totalmarks(sciencemarks) from markstbl;
OK
STAGE DEPENDENCIES:
  Stage-0 is a root stage

STAGE PLANS:
  Stage: Stage-0
    Fetch Operator
      limit: -1
      Processor Tree:
        TableScan
          alias: markstbl
          Statistics: Num rows: 1 Data size: 33 Basic stats: COMPLETE Column stats: NONE
          Select Operator
            expressions: totalmarks+(sciencemarks) (type: string)
            outputColumnNames: _col0
            Statistics: Num rows: 1 Data size: 33 Basic stats: COMPLETE Column stats: NONE
            ListSink


Reference
------------
https://hive.apache.org/javadocs/r0.10.0/api/org/apache/hadoop/hive/serde2/objectinspector/ObjectInspector.html


