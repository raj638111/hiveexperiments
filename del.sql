

{
   "acctsummary":{
      "am":[
         {
            "field1":"AM1","field2":"f1"
         },
         {
            "field1":"AM2","field2":"f1"
         }
      ]
   }
}

create external table test (
   escid       string,
   acctId      string,
   cardacct    struct <
                  acctSummary:struct <
                     AM:array<
                        struct<
                           field1:string,
                           field2:string
                        >
                     >
                  >
               >
)
location '/Users/raj/del/test';



create external table test (
   escid       string,
   acctId      string,
   cardacct    struct <
                  acctSummary:struct <
                     AM00:array<
                        struct<
                           field1:string,
                           field2:string
                        >
                     >,
                     CR00:array<
                        struct<
                           field1:string,
                           field2:string
                        >
                     >
                  >
)
location '/Users/raj/del/test';


create external table test (
   escid       string,
   acctId      string,
   cardacct    struct <
                  acctSummary:struct <
                     am00:array<
                        struct<
                           field1:string,
                           field2:string,
                           sDate:string,
                           eDate:string
                        >
                     >,
                     am01:array<
                        struct<
                           field1:string,
                           field2:string,
                           sDate:string,
                           eDate:string
                        >
                     >
                  >
               >
)
location '/Users/raj/del/test';




create external table test (
   escid       string,
   acctId      string,
   cardacct    struct <
                  acctSummary:struct <
                     am00:array<
                        struct<
                           field1:string,
                           field2:string,
                           sDate:string,
                           eDate:string
                        >
                     >,
                     am01:array<
                        struct<
                           field1:string,
                           field2:string,
                           sDate:string,
                           eDate:string
                        >
                     >
                  >,
                  rewardSummary:struct <
                     seg01:array<
                        struct<
                           field1:string,
                           field2:string,
                           sDate:string,
                           eDate:string
                        >
                     >,
                     seg02:array<
                        struct<
                           field1:string,
                           field2:string,
                           sDate:string,
                           eDate:string
                        >
                     >
                  >
               >     
)
location '/Users/raj/del/test';



create external table test (
   escid       string,
   acctId      string
)
location '/Users/raj/del/test';




insert overwrite table integratort1
select
   ecr.escid,
   ecr.acctId,
   concat_ws('\002',
      concat_ws('\003', 
         tbl0.rec))
   as cardacct
from
   ecrmaster ecr
   left outer join
   curtbl0intgtr tbl0
   on ecr.acctId = tbl0.acctId;


create external table integratort (
   escid       string,
   acctId      string,
   cardacct    struct <
                  acctSummary:struct <
                     tbl0data:array<
                        struct<
                           field1:string,
                           field2:string,
                           startDate:string,
                           endDate:string
                        >
                     >
                  >
               >     
)
location '/Users/raj/del/test';
