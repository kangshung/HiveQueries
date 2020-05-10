-- 1. What is the average customer satisfaction grade for projects that took more than 20 weeks?

select avg(customer_rating) average_rating_for_long_projects
from fact_project where duration_in_weeks > 20;

-- 2. What is the average price for projects done by different-sized teams in 2015 or 2016?

select avg(price) average_price, team_size from fact_project a
join dim_team b on a.ID_team = b.ID_team
join dim_time c on a.ID_project_start = c.ID_time
join dim_time d on a.ID_project_end = d.ID_time
where c.year = 2016 or d.year = 2016 or c.year = 2015 or d.year = 2015
group by team_size;

-- 3. What is the number of sprints for customers from different industries?

select count(*) sprints, additional_info["industry"] industry
from fact_sprint a
join fact_project b on a.ID_project = b.ID_project
join dim_customer c on b.ID_customer = c.ID_customer
group by additional_info["industry"];

-- 4. What is the average number of user journeys, user stories, fixed bugs and fixed new defects in sprints of the project in which a scrum master is mid-experienced?

select avg(no_of_user_journeys_done) average_user_journeys_done,
avg(no_of_finished_user_stories) average_user_stories_done,
avg(no_of_fixed_old_bugs) average_fixed_bugs,
avg(no_of_fixed_new_bugs) average_fixed_new_defects
from fact_sprint a
join fact_project b on a.ID_project = b.ID_project
join dim_employee c on b.ID_scrum_master = c.ID_employee
where experience = "mid";

-- 5. What is the minimum, average and maximum number of user stories postponed for the next sprint in projects that have customer rating bigger than 3 or in which there are at least 20 people involved and the product owner is young?

select min(no_of_postponed_user_stories) minimum_postponed,
avg(no_of_postponed_user_stories) average_postponed,
max(no_of_postponed_user_stories) maximum_postponed
from fact_sprint a
join fact_project b on a.id_project = b.id_project
join dim_employee c on b.id_product_owner = c.id_employee
where (customer_rating > 3 or no_of_ppl_involved >= 20) and age = "young";

-- 6. What is the average ratio of defects rate in sprints in projects for different size of customers?

select avg(no_of_fixed_new_bugs / no_of_found_new_bugs) defects_rate,
additional_info["Company_size"] size
from fact_sprint a
join fact_project b on a.id_project = b.id_project
join dim_customer c on b.id_customer = c.id_customer
group by additional_info["Company_size"];

-- 7. What is the number of tasks for different types of technologies for sprints with client and company’s sprint satisfaction above 5?

select count(*) no_of_tasks, type from fact_task a
join fact_sprint b on a.id_sprint = b.id_sprint
join dim_main_technology c on a.id_technology = c.id_main_technology
where client_sprint_satisfaction >= 5 and our_sprint_satisfaction >= 5
group by type;

-- 8. What was the average completeness of tasks from Hadoop-ecosystem type technology for different employee positions in 2005? (tricky question)

select avg(completeness) average_completenes from fact_task a
join dim_main_technology b on a.id_technology = b.id_main_technology
join dim_employee c on a.id_employee = c.id_employee
join dim_time d on a.id_task_start = d.id_time
join dim_time e on a.id_task_end = e.id_time
where type = "Hadoop" and (d.year = 2005 or e.year = 2005);
#Hadoop did not exist in 2005

-- 9. What was the number of tasks done with expensive technology for sprints whose retrospectives attendance was not some in each year?

select count(*) no_of_tasks, year from fact_task a
join fact_sprint b on a.id_sprint = b.id_sprint
join dim_main_technology c on a.id_technology = c.id_main_technology
join dim_sprint_retrospective d on
b.id_sprint_retrospective = d.id_sprint_retrospective
join dim_time e on a.id_task_start = e.id_time
where cost = "expensive" and attendance <> "some"
group by year;

-- 10.What is the ratio of number of sprints and the average expected number of sprints in projects where the product owner is called Maksymilian Operlejn?

select count(*) / avg(expected_no_of_sprints) ratio_of_sprint_duration
from fact_sprint a
join fact_project b on a.id_project = b.id_project
join dim_employee c on b.id_product_owner = c.id_employee
where full_name = "Maksymilian Operlejn";
