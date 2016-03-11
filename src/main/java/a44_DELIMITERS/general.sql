

Default delimiters
--#################################################################


Primitive & Complex field
--------------------------

create table marks as
select 
   'bob'                                           as name, 
   named_struct('engtot', '104', 'mathtot', '135') as total, 
   array(
      array(
         named_struct(
            'eng', 
            '33',
            'math',
            '44'
         ),
         named_struct(
            'eng',          
            '35',
            'math',
            '45'
         )
      ),
      array(
         named_struct(
            'eng', 
            '36',
            'math',
            '46'
         )
      )      
   )                                               as testmarks,
   map('engavg', '34.6', 'mathavg', '45')          as average;

hive> select * from marks;
OK
bob   {"engtot":"104","mathtot":"135"} [[{"eng":"33","math":"44"},{"eng":"35","math":"45"}],[{"eng":"36","math":"46"}]] {"engavg":"34.6","mathavg":"45"}


hive> desc marks;
OK
name                 string
total                struct<engtot:string,mathtot:string>
testmarks            array<array<struct<eng:string,math:string>>>
average              map<string,string>   

hdfs dfs -getmerge /user/hive/warehouse/marks result.txt
vi result.txt
bob^A104^B135^A33^D44^C35^D45^B36^D46^Aengavg^C34.6^Bmathavg^C45






Primitive field
------------------

create table table1 as 
select
   'f1',
   'f2',
   'f3'

hive> desc table1;
OK
_c0                  string
_c1                  string
_c2                  string

hive> select * from table1;
OK
f1 f2 f3


hdfs dfs -getmerge /user/hive/warehouse/table1 result.txt
vi result.txt
f1^Af2^Af3

