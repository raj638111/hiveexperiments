CREATE TABLE  maths (
   student  string,
   category string, --'alg', 'trig'
   mark     string,
   class    string
)                      
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';

load data local inpath './a13_example.txt' 
overwrite into table maths;


select 
   class, 
   category,
   case when category='alg' then sum(mark) else 'NA' end sum
from 
   maths 
group by 
   class, category;

10 alg   142.0
10 trig  NA
11 alg   90.0
   
-----------------------------------


select 
   class,
   sum(mark)
from 
   maths 
group by class;

10 303.0
11 90.0
-----------------------------------

select 
   class 
from 
   maths 
group by class;

10
11

-----------------------------------
select 
   class, 
   case when category='alg' then sum(mark) else 0 end 
from 
   maths 
group by 
   class;

