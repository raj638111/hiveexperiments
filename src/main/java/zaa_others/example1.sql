SET hive.exec.dynamic.partition.mode=non-strict;

set updatedate=2017-11-12;
set updatedate;

insert overwrite table 
   hivetable
partition(inquiry_date)
select
   res.inquiry_id, res.update_date, res.inquiry_date
from(
   select 
      a3.inquiry_id, a3.inquiry_date, a3.update_date
   from
      (select
         a3_1.inquiry_id, a3_1.inquiry_date, a3_1.update_date
      from
         (select 
            inquiry_id, inquiry_date, update_date
         from
            hivetable) a3_1
         join
         (select distinct 
            inquiry_date 
         from 
            sqltable 
         where update_date="${hiveconf:updatedate}") a3_2
         on
            a3_1.inquiry_date == a3_2.inquiry_date) a3
   UNION ALL
   select 
      inquiry_id, inquiry_date, update_date 
   from 
      sqltable 
   where 
      update_date="${hiveconf:updatedate}"
)res;
