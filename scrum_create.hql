CREATE TABLE dim_customer
(
 ID_customer   integer ,
 customer_name string ,
 additional_info map<string, string>
)ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' collection items terminated by '$' map keys terminated by '#' STORED AS TEXTFILE;


CREATE TABLE dim_employee
(
 ID_employee integer ,
 full_name   string ,
 age         string ,
 experience  string ,
 position    string ,
 additional_info map<string, string> ,
 ID_team     integer
)ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' collection items terminated by '$' map keys terminated by '#' STORED AS TEXTFILE;


CREATE TABLE dim_sprint_retrospective
(
 ID_sprint_retrospective integer ,
 length_category         string ,
 progress                string ,
 attendance              string
)ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE;


CREATE TABLE dim_main_technology
(
 ID_main_technology integer ,
 name               string ,
 type               string ,
 difficulty         string ,
 cost               string
)ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE;


CREATE TABLE dim_time
(
 ID_time  integer ,
 year     smallint ,
 month    smallint ,
 day      smallint ,
 hour     smallint ,
 minute   smallint ,
 date_data     date ,
 datetime timestamp
)ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE;


CREATE TABLE dim_team
(
 ID_team    integer ,
 team_name  string ,
 team_size  string ,
 department string
)ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE;


CREATE TABLE fact_project
(
 ID_project             integer ,
 expected_no_of_sprints integer ,
 no_of_ppl_involved     integer ,
 price                  double ,
 customer_rating        integer ,
 duration_in_weeks      integer ,
 ID_project_start       integer ,
 ID_project_end         integer ,
 ID_product_owner       integer ,
 ID_scrum_master        integer ,
 ID_customer            integer ,
 ID_team                integer
)ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE;


CREATE external TABLE fact_sprint
(
 ID_sprint                    integer ,
 our_sprint_satisfaction      double ,
 client_sprint_satisfaction   double ,
 no_of_user_journeys_done     integer ,
 no_of_planned_user_stories   integer ,
 no_of_finished_user_stories  integer ,
 no_of_postponed_user_stories integer ,
 no_of_fixed_old_bugs         integer ,
 no_of_postponed_old_bugs     integer ,
 no_of_found_new_bugs         integer ,
 no_of_fixed_new_bugs         integer ,
 ID_project                   integer ,
 ID_sprint_start              integer ,
 ID_sprint_end                integer ,
 ID_sprint_retrospective      integer
)ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE;


CREATE external TABLE fact_task
(
 ID_task             integer ,
 completeness        double ,
 no_of_hours_planned double ,
 no_of_hours_spent   double ,
 ID_sprint           integer ,
 ID_task_start       integer ,
 ID_task_end         integer ,
 ID_employee         integer ,
 ID_technology	     integer
)ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE;
