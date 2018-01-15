drop database IF EXISTS bgt3;

create database bgt3;
create table bgt3.RECORDS ( 
JobID nvarchar(100) DEFAULT NULL,
State_ID nvarchar(100) Default Null,
State_Name varchar (45) Default Null,
MSA_ID bigint (20) default null,
MSA_Name varchar(255) default null,
County varchar(255) default null,
Occupation_Code bigint(20) default null,
Occupation_Name varchar(255) default null,
Occupation_Title VARCHAR(255) default null,
Degree_Level VARCHAR(75) default null,
Experience_Level VARCHAR (30) default null,
Edu_Major varchar(255) default Null,
Salary nvarchar(100)default null,
Posting_Duration int(11) default null,
Skill_ID bigint(20) default null,
Skill_Name VARCHAR (255) default null,
Skill_Type INT(11) Default null,
Cert_ID bigINT(20) Default null,
Cert_Name varchar (255) Default null
);
Truncate bgt3.RECORDS;


Load DATA LOCAL INFILE '/Users/rkelapure/Desktop/bgt.txt'
into table bgt3.RECORDS
fields terminated by '	'
lines terminated by '\r'
Ignore 1 lines;

select * from bgt3.RECORDS limit 10;
USE bgt3;

# Cleaning Records- Records rows -2293267  distinct rows 2153833- JOB


#Removing duplicate rows
CREATE table JOB
SELECT distinct * from bgt3.RECORDS; 

Select JOBID from bgt3.JOB
where JOBID is NULL;

#  Removing illegible data 
set SQL_SAFE_UPDATES = 0;

Update bgt3.JOB
set State_ID =  
 (Select replace (State_ID,"'\'","")as State_ID);

DELETE from bgt3.JOB
where Skill_ID = (0) ;

delete from bgt3.JOB
where Skill_ID = 1;

DELETE from bgt3.JOB
where STAte_ID is null;

Alter table bgt3.JOB
modify State_ID int (11);

Delete from bgt3.JOB 
where State_ID is null;

SELECT * from bgt3.JOB;

DELETE from bgt3.JOB
 where Occupation_Code = -999;
 
# creation of tables and Verification process

 Select distinct MSA_ID from bgt3.JOB;
 
 Select distinct MSA_name from bgt3.JOB;
 
 Select distinct State_ID from bgt3.JOB;
 Select Distinct State_name from bgt3.JOB;
 
 
 Select county from bgt3.JOB where county is null;
 Select county from bgt3.JOB;
 
 Select Occupation_code FROM bgt3.JOB;
  Select DISTINCT Occupation_code FROM bgt3.JOB ORDER BY OCCUPATION_CODE ASC;
  Select DISTINCT Occupation_code FROM bgt3.JOB where OCCUPATION_CODE is null;
  SELECT OCCUPATION_NAME FROM bgt3.JOB ORDER BY OCCUPATION_NAME ASC;
 
 SELECT OCCUPATION_TITLE FROM bgt3.JOB ORDER BY OCCUPATION_TITLE ASC;
 
 SELECT DEGREE_LEVEL FROM bgt3.JOB ORDER BY DEGREE_LEVEL ASC;
 SELECT EXPERIENCE_LEVEL FROM bgt3.JOB ORDER BY EXPERIENCE_LEVEL ASC;

select EDU_MAJOR FROM bgt3.JOB ORDER BY EDU_MAJOR ASC;

SELECT salary FROM bgt3.JOB ORDER BY SALARY ASC;
 
select skill_id from  bgt3.JOB ORDER BY skill_ID ASC;

select Skill_name from  bgt3.JOB ORDER BY skill_name ASC;

select Skill_type from  bgt3.JOB ORDER BY skill_type ASC;

select cert_ID from  bgt3.JOB ORDER BY cert_ID ASC;

select cert_name from  bgt3.JOB ORDER BY cert_name ASC;

select posting_duration from  bgt3.JOB ORDER BY posting_duration ASC;


# file clean rows - 1822107- Finaly data seemS to be cleanED !
select count(*) from bgt3.JOB;

# creation of tables


Alter table bgt3.JOB
add titleid int,
add countyid int,
add degreeid int,
add expid int,
add eduid int;

Drop table STATE; 

CReate table STATE
select distinct STATE_ID, STATE_NAME 
FROM bgt3.JOB 
where state_ID is not NULL;

alter table STATE
add primary key (STATE_ID);
 

CREATE TABLE MSA
SELECT DISTINCT MSA_ID, MSA_NAME 
FROM bgt3.JOB;

alter table MSA
add primary key (MSA_ID);

CREATE TABLE COUNTY 
SELECT DISTINCT COUNTY
FROM bgt3.JOB;

ALTER TABLE COUNTY
ADD COUNTYID INT NOT NULL auto_increment,
ADD PRIMARY KEY (COUNTYID);

CREATE TABLE OCCUP
SELECT DISTINCT OCCUPATION_CODE, OCCUPATION_NAME
FROM bgt3.JOB;


ALTER TABLE OCCUP
ADD PRIMARY KEY (OCCUPation_code);

create table title
select distinct occupation_title from bgt3.JOB;

ALTER TABLE title
ADD titleid INT NOT NULL auto_increment,
ADD PRIMARY KEY (titleid);

create table education
select distinct Edu_Major from bgt3.JOB;

ALTER TABLE education
ADD eduid INT NOT NULL auto_increment,
ADD PRIMARY KEY (eduid);

create table experience
select distinct experience_level from bgt3.JOB;

ALTER TABLE experience
ADD expid INT NOT NULL auto_increment,
ADD PRIMARY KEY (expid);

create table degree
select distinct degree_level from bgt3.JOB;

ALTER TABLE degree
ADD degreeid INT NOT NULL auto_increment,
ADD PRIMARY KEY (degreeid);


use bgt3;
select distinct degree_level FROM bgt3.JOB;


CREATE TABLE Skill
SELECT distinct Skill_ID, Skill_Name, Skill_Type
from bgt3.JOB; 

ALTER TABLE SKILL
ADD PRIMARY KEY (SKILL_ID);

Create table Cert
select distinct Cert_ID, Cert_Name
from bgt3.JOB;

ALTER TABLE CERT
ADD PRIMARY KEY (CERT_ID);

USE BGT3;

Select count(*) from BGT3.JOB;

Drop table JOB;

Create table job
select DISTINCT jobID, salary, posting_duration, state_id, MSA_id,
countyid, occupation_code, titleid, degreeid,
expid, eduid, skill_id, cert_id
from bgt3.JOB;


set sql_safe_updates = 0;  
  
update bgt3.JOb
inner join bgt3.degree on JOB.degree_level = degree.degree_level
inner join JOB on JOB.JOBID = JOB.JOBID
set job.degreeid = degree.degreeid
where JOB.degree_level = degree.degree_level and JOB.JOBID = JOB.JOBID;

select * from bgt3.experience;

update bgt3.JOB
inner join bgt3.education on JOB.edu_Major = education.edu_major
set JOB.eduid = education.eduid
where JOB.edu_Major = education.edu_major;

update bgt3.job 
inner join JOB on job.jobid = JOB.jobid
inner join degree on JOB.degree_level = degree.degree_level
set  job.degreeid = degree.degreeid;

update bgt3.JOB
inner join bgt3.experience on JOB.experience_level = experience.experience_level
set JOB.expid = experience.expid
where JOB.experience_level = experience.experience_level;

select expid from bgt3.JOB limit 100;

update bgt3.JOB
inner join bgt3.title on JOB.occupation_title = title.occupation_title
set JOB.titleid = title.titleid
where JOB.occupation_title = title.occupation_title;

update bgt3.JOB
inner join bgt3.county on JOB.county = county.county
set JOB.countyid = county.countyid
where JOB.county= county.county;


select eduid from bgt3.JOB limit 10;
RESET QUERY CACHE;
set sql_safe_updates = 0;  
set innodb_lock_wait_timeout = 2000 ;




ALTER TABLE JOB
Add ID int not null auto_increment,
ADD PRIMARY KEY (ID);


# SELECT * FROM bgt3.JOBS;

Alter table JOB 
ADD  FOREIGN KEY(STATE_ID) references bgt3.STATE(State_ID);

Alter table JOB 
ADD Foreign key (MSA_id) REFERENCES bgt3.MSA(MSA_id);

ALTER TABLE JOB
ADD Foreign key (SKILL_ID) REFERENCES bgt3.SKILL(SKILL_ID);

ALTER TABLE JOB
ADD Foreign key (CERT_id) REFERENCES bgt3.CERT(CERT_id);

ALTER TABLE JOB
ADD Foreign key (COUNTYID) REFERENCES bgt3.COUNTY(COUNTYID);

ALTER TABLE JOB
ADD  Foreign key (DEgreeid) REFERENCES bgt3.DEgree(DEgreeid);


ALTER TABLE JOB
ADD Foreign key (occupation_code) REFERENCES bgt3.OCCUP(occupation_code);

Alter table bgt3.JOB 
modify column countyid bigint (20);

Alter table bgt3.COUNTY
modify column countyid bigint (20);

ALTER TABLE JOB
ADD  Foreign key (titleID) REFERENCES bgt3.title(titleID);

ALTER TABLE JOB
ADD Foreign key (eduid) REFERENCES bgt3.education(eduid);

ALTER TABLE JOB
ADD Foreign key (expID) REFERENCES bgt3.experience(expID);

# questions 
# how many JOB opening are there per state/ county/ msa




# drop view JOBpersstate_name


Create view JOB.county as
select county, count (JOBID) FROM bgt3.JOB_1
ORDER BY COUNTY DESC;

use nycl;

select count(*) from NYCL.Records;

CREATE VIEW Important_Skills_By_State AS  
  SELECT states.State_Name, skills.skill_name AS
   top_skills, COUNT(*) count_of_skills  
  FROM states   RIGHT JOIN  
  JOBs ON states.state_id = JOBs.state_id          
  LEFT JOIN   JOBs_skills ON JOBs.JOBid = JOBs_skills.JOBID  LEFT JOIN   skills ON skills.skill_id = JOBs_skills.Skill_ID     WHERE skill_name IS NOT NULL     GROUP BY states.State_Name , top_skills     HAVING count_of_skills > 100  
  ORDER BY states.State_Name , count_of_skills DESC;
   select * from important_skills_by_state

set sql_safe_updates = 0;
select * from bgt3.JOB;



SHOW ENGINE INNODB STATUS;

show variables like 'innodb_lock_wait_timeout';

set innodb_lock_wait_timeout = 100 ;

# Queries- 

Alter table OCCUP
ADD SOC_CODE VARCHAR (255);
SELECT * FROM BG1.OCCUPATIONS LIMIT 10 ;

set SQL_SAFE_UPDATES = 0;

UPDATE  OCCUP
SET SOC_CODE = CASE WHEN SUBSTRING(OCCUPATION_CODE, 1, 2) = 11 THEN 'Management Occupations'
WHEN SUBSTRING(OCCUPATION_CODE, 1, 2) = 13  THEN'Business and Financial Operations Occupations'
WHEN SUBSTRING(OCCUPATION_CODE, 1, 2) = 15  THEN'Computer and Mathematical Occupations'
WHEN SUBSTRING(OCCUPATION_CODE, 1, 2) = 17  THEN 'Architecture and Engineering Occupations'
WHEN SUBSTRING(OCCUPATION_CODE, 1, 2) = 19  THEN 'Life, Physical, and Social Science Occupations'
WHEN SUBSTRING(OCCUPATION_CODE, 1, 2) = 21  THEN 'Community and Social Service Occupations'
WHEN SUBSTRING(OCCUPATION_CODE, 1, 2) = 23  THEN 'Legal Occupations'
WHEN SUBSTRING(OCCUPATION_CODE, 1, 2) = 25  THEN 'Education, Training, and Library Occupations'
WHEN SUBSTRING(OCCUPATION_CODE, 1, 2) = 27  THEN 'Arts, Design, Entertainment, Sports, and Media Occupations'
WHEN SUBSTRING(OCCUPATION_CODE, 1, 2) = 29  THEN 'Healthcare Practitioners and Technical Occupations'
WHEN SUBSTRING(OCCUPATION_CODE, 1, 2) = 31  THEN 'Healthcare Support Occupations'
WHEN SUBSTRING(OCCUPATION_CODE, 1, 2) = 33  THEN 'Protective Service Occupations'
WHEN SUBSTRING(OCCUPATION_CODE, 1, 2) = 35  THEN 'Food Preparation and Serving Related Occupations'
WHEN SUBSTRING(OCCUPATION_CODE, 1, 2) = 37  THEN 'Building and Grounds Cleaning and Maintenance Occupations'
WHEN SUBSTRING(OCCUPATION_CODE, 1, 2) = 39  THEN 'Personal Care and Service Occupations'
WHEN SUBSTRING(OCCUPATION_CODE, 1, 2) = 41  THEN 'Sales and Related Occupations'
WHEN SUBSTRING(OCCUPATION_CODE, 1, 2) = 43  THEN 'Office and Administrative Support Occupations'
WHEN SUBSTRING(OCCUPATION_CODE, 1, 2) = 45  THEN 'Farming, Fishing, and Forestry Occupations'
WHEN SUBSTRING(OCCUPATION_CODE, 1, 2) = 47  THEN 'Construction and Extraction Occupations'
WHEN SUBSTRING(OCCUPATION_CODE, 1, 2) = 49  THEN 'Installation, Maintenance, and Repair Occupations'
WHEN SUBSTRING(OCCUPATION_CODE, 1, 2) = 51  THEN 'Production Occupations'
WHEN SUBSTRING(OCCUPATION_CODE, 1, 2) = 53  THEN 'Transportation and Material Moving Occupations'
END ; 

# Which states are represented in the data? In what percentages? 

create view JOBperSta as
select state_name, 
count(JOBID) as JOBCOUNT,
(count(JOBID)/1932339)* 100 as Percent_JOB_POst, 
Avg(posting_Duration)AS Avg_POST_DUR, 
Avg (Salary) as AVG_SALARY
from BGT3.State, BGT3.JOB
where JOB.state_id = State.State_ID
group by state_name; 

create view JOBperMSA as
select MSA_name, 
count(JOBID) as JOBCOUNT,
(count(JOBID)/1932339)* 100 as Percent_JOB_POst, 
Avg(posting_Duration)AS Avg_POST_DUR, 
Avg (Salary) as AVG_SALARY
from BGT3.MSA, BGT3.JOB
where JOB.MSA_id = MSA.MSA_ID
group by MSA_name; 

create view JOBperCounty as
select County, 
count(JOBID) as JOBCOUNT,
(count(JOBID)/1932339)* 100 as Percent_JOB_POst, 
Avg(posting_Duration)AS Avg_POST_DUR, 
Avg (Salary) as AVG_SALARY
from BGT3.County, BGT3.JOB
where JOB.Countyid = COUNTY.CountyID
group by County; 

# What is the distribution of posting duration? 

# Is the posting duration distribution similar across states? 

Create view post_distri as
Select State_name, posting_duration
from bgt3.state , bgt3.JOB
where job.state_id = state.state_id;

Create view post_distri_occup as 
select OCCUPATION_NAME, posting_duration, STATE_NAME
from bgt3.occup,bgt3.JOB, bgt3.state 
where JOB.Occupation_code = Occup.Occupation_code
and job.state_id = state.state_id;

Create view post_distri_occup as 
select OCCUPATION_NAME, posting_duration, STATE_NAME
from bgt3.occup,bgt3.JOB, bgt3.state 
where JOB.Occupation_code = Occup.Occupation_code
and job.state_id = state.state_id;

# Is the posting duration distribution similar across occupations?

Create VIew JOB_OccupA_State AS
Select SOC_CODE, STATE_NAME  AS OCCUP_STATE,
count(JOBID) as JOBCOUNT,
(count(JOBID)/1932339)* 100 as Percent_JOB_POst, 
Avg(posting_Duration)AS Avg_POST_DUR, 
Avg (Salary) as AVG_SALARY
FROM BGT3.OCCUP, BGT3.JOB, BGT3.STATE
WHERE JOB.occupation_code = OCCUP.OCCUPATION_CODE
AND JOB.STATE_ID = STATE.STATE_ID
GROUP BY SOC_CODE, STATE_NAME;

CREATE VIEW JOB_STATE_OCCUP_POST_SALARY AS
Select SOC_CODE, STATE_NAME, JOBID, POSTING_DURATION,
SALARY AS OCCUP_STATE
FROM BGT3.OCCUP, BGT3.JOB, BGT3.STATE
WHERE JOB.occupation_code = OCCUP.OCCUPATION_CODE
AND JOB.STATE_ID = STATE.STATE_ID;

CREATE VIEW JOB_STATE_COUNTY_MSA_POST_SALARY AS
Select County, STATE_NAME,MSA_NAME, JOBID, POSTING_DURATION,
SALARY AS OCCUP_STATE
FROM BGT3.MSA, BGT3.JOB, BGT3.STATE, BGT3.COunty
WHERE JOB.MSA_id = MSA.MSA_ID
AND JOB.STATE_ID = STATE.STATE_ID
And Job.Countyid = COUNTY.COUNTYID; 

create view JOB_STATE_OCCP_TITLE_POST as
SELECT Occupation_title,STATE_NAME, JOBID, 
POSTING_DURATION,SOC_CODE,SALARY 
FROM BGT3.title, BGT3.JOB, BGT3.STATE, BGT3.OCCUP
WHERE JOB.titleid = Title.TitleID
AND JOB.STATE_ID = STATE.STATE_ID
and JOB.occupation_code= OCCUP.OCCUPATION_CODE; 

# Requirements for Registered Nurses, Sales Associates, HOME CARE REGISTERED NURSES
#Software  development Engineer Assistant Store Manager

CReate view TITLE_EDU_EXP_DEGREE_CERT_JOB_POST as
Select Occupation_title, EDU_MAJOR, Degree_level,Cert_name,
 JOBID,POsting_Duration, experience_level
 from 
BGT3.title, BGT3.JOB, BGT3.education, BGT3.degree,BGT3.cert,
BGT3.Experience
where JOB.titleid = Title.TitleID
AND JOB.eduid = education.eduID
and JOB.degreeid= degree.degreeid
and JOB.cert_id = CERT.Cert_ID
and JOB.expid = Experience.Expid; 


Create view JOB_SKILL_TITLE_state as
select JOBID, POsting_duration, 
Skill_name, Skill_type, Occupation_title, state_name
From BGT3.title, BGT3.JOB, BGT3.SKILL, BGT3.STATE
where JOB.titleid = Title.TitleID
and JOB.Skill_id = Skill.Skill_id
and JOB.STATE_ID = STATE.STATE_ID;
# Perform any other additional data exploration and document what you learn.


# What do you think may indicate a "skills gap" or "unfilled demand"? Number of listings? Posting duration? Something about skills data? A combination? Answer the following questions, and plan how you will visualize these results:
# What are the top listed occupation names as percent of total listings?
# Which occupation names have the longest durations?
# In which fields or industries is there the greatest unfilled demand (by your definition)?
# Within these fields, for which positions is there the greatest unfilled demand (by your definition)?
# What are the demographics of these positions—specifically:
# What level of education is required to perform these jobs?
# Which particular skills are required to perform these jobs?
# How many years of experience are required to perform these jobs?
# Are there any special certifications required?
# Optional: Consider these same questions in other regions, and draw comparisons.
# Optional: Anything else that you want to consider?




# IMportant Skills BY State

CREATE VIEW Important_Skills_By_State AS  
  SELECT states.State_Name, skills.skill_name AS
   top_skills, COUNT(*) count_of_skills  
  FROM states   RIGHT JOIN  
  jobs ON states.state_id = jobs.state_id          
  LEFT JOIN   jobs_skills ON jobs.jobid = jobs_skills.JobID  LEFT JOIN   skills ON skills.skill_id = jobs_skills.Skill_ID     WHERE skill_name IS NOT NULL     GROUP BY states.State_Name , top_skills     HAVING count_of_skills > 100  
  ORDER BY states.State_Name , count_of_skills DESC;
   select * from important_skills_by_state

