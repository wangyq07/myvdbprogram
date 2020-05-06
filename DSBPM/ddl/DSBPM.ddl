CREATE VIEW TASK_COMMENT(
	id long NOT NULL
,addedat timestamp
,text string(1000)
,addedby string(255)
,taskdata_comments_id long
,CONSTRAINT TASK_COMMENT_mapping_pkey PRIMARY KEY (id)) OPTIONS (UPDATABLE 'FALSE',DELETETABLE 'TRUE',TASK_COMMENT.IMPLEMENTED 'TRUE') 
AS(select id,addedat,text,addedby_id,taskdata_comments_id
  from DSBPM.vw_task_comment);
  
  
  CREATE VIEW TASKS_OLD(
 id long NOT NULL
,allowedtodelegate string(255)
,priority integer
,activationtime timestamp
,createdon timestamp
,expirationtime timestamp
,previousstatus integer
,processid string(255)
,processinstanceid long
,processsessionid long
,skipable boolean
,status string(255)
,workitemid long
,optlock integer
,taskinitiator_id string(255)
,actualowner_id string(255)
,createdby_id string(255)
,formname string(255)
,deploymentid string(255)
,tasktype string(255)
,description string(255)
,name string(255)
,subject string(255)
,CONSTRAINT TASKS_OLD_mapping_pkey PRIMARY KEY (id)) OPTIONS (UPDATABLE 'FALSE',DELETETABLE 'TRUE',TASKS_OLD.IMPLEMENTED 'TRUE') 
AS(select 
id
,allowedtodelegate 
,priority 
,activationtime 
,createdon 
,expirationtime 
,previousstatus 
,processid 
,processinstanceid 
,processsessionid 
,skipable 
,status 
,workitemid 
,optlock 
,taskinitiator_id 
,actualowner_id 
,createdby_id 
,formname 
,deploymentid 
,tasktype 
,description 
,name 
,subject 
  from DSBPM.vw_tasks);
  
   CREATE VIEW TASKS(
 id long NOT NULL
,activationtime date
,actualowner string(50)
,createdby string(50)
,createdon date
,deploymentid string(50)
,description string(255)
,duedate date
,name string(255)
,parentid long
,priority integer
,processid string(50)
,processinstanceid long
,processsessionid integer
,status string(50)
,taskid long
,workitemid long
,GroupId string(100)
,submit_content string(100)
,approve_content string(100)
,flag string(100)
,ticket_field string(100)
,ticket_well string(100)
,CONSTRAINT TASKS_mapping_pkey PRIMARY KEY (id)) OPTIONS (UPDATABLE 'FALSE',DELETETABLE 'TRUE',TASKS.IMPLEMENTED 'TRUE') 
AS(select 
id
,activationtime
,actualowner
,createdby 
,createdon 
,deploymentid
,description
,duedate
,"name"
,parentid
,priority
,processid
,processinstanceid
,processsessionid
,status
,t4.taskid
,workitemid
,t5.GroupId
,t5.submit_content
,t5.approve_content
,t5.flag
,t5.ticket_field
,t5.ticket_well
  from DSBPM.audittaskimpl t4
  left join (
  select 
    taskid,
    Ltrim(rtrim(case when locate('|#%',GroupId)>0 then substring(GroupId,1,locate('|#%',GroupId)-1) else GroupId end)) GroupId,
    ltrim(rtrim(case when locate('|#%',submit_content)>0 then substring(submit_content,1,locate('|#%',submit_content)-1) else submit_content end)) submit_content,
    ltrim(rtrim(case when locate('|#%',approve_content)>0 then substring(approve_content,1,locate('|#%',approve_content)-1) else approve_content end)) approve_content,
    ltrim(rtrim(case when locate('|#%',flag)>0 then substring(flag,1,locate('|#%',flag)-1) else flag end)) flag,
    ltrim(rtrim(case when locate('|#%',ticket_field)>0 then substring(ticket_field,1,locate('|#%',ticket_field)-1) else ticket_field end)) ticket_field,
    ltrim(rtrim(case when locate('|#%',ticket_well)>0 then substring(ticket_well,1,locate('|#%',ticket_well)-1) else ticket_well end)) ticket_well
  from
  (
    select 
 taskid
,  convert(string_agg(	GroupId	,'|#%'  order by GroupId desc),string)  GroupId
, convert(string_agg(	submit_content	,'|#%'  order by submit_content desc),string)  submit_content
, convert(string_agg(	approve_content	,'|#%'  order by approve_content desc),string)  approve_content
, convert(string_agg(	flag	,'|#%'  order by flag desc),string) flag
, convert(string_agg(	ticket_field	,'|#%'  order by ticket_field desc),string)  ticket_field
, convert(string_agg(	ticket_well	,'|#%'  order by ticket_well desc),string) ticket_well
from
(
select
taskid
,case when name ='GroupId' then "value" else '' end GroupId
,case when name ='submit_content' then "value" else '' end submit_content
,case when name ='approve_content' then "value" else '' end approve_content
,case when name ='flag' then "value" else '' end flag
,case when name ='ticket_field' then "value" else '' end ticket_field
,case when name ='ticket_well' then "value" else '' end ticket_well
from DSBPM.taskvariableimpl t1
where name in('GroupId','submit_content','approve_content','flag')
	) t3
  group by t3.taskid
  ) t6
  )t5
  on t5.taskid=t4.taskid
  );
  
  CREATE VIEW TICKET_OLD(
id long NOT NULL
,end_date timestamp
,outcome string(255)
,processinstanceid long
,processid string(255)
,start_date timestamp
,status integer
,status_name string(255)
,duration long
,externalid string(255)
,created_by string(255)
,processname string(255)
,processversion string(255)
,processinstancedescription string(255)
,CONSTRAINT TICKET_OLD_pkey PRIMARY KEY (id)) OPTIONS (UPDATABLE 'FALSE',DELETETABLE 'TRUE',TICKET_OLD.IMPLEMENTED 'TRUE') 
AS(select 
id 
,end_date 
,outcome 
,processinstanceid 
,processid 
,start_date 
,status 
,status_name 
,duration 
,externalid 
,user_identity 
,processname 
,processversion 
,processinstancedescription 
  from DSBPM.vw_tickets);
  
  CREATE VIEW TICKET(
id long NOT NULL
,end_date timestamp
,outcome string(255)
,processinstanceid long
,processid string(255)
,start_date timestamp
,status integer
,status_name string(255)
,duration long
,externalid string(255)
,created_by string(255)
,processname string(255)
,processversion string(255)
,processinstancedescription string(255)
,ticket_type string(100)
,aborted_by string(100)
,ticket_des string(100)
,CONSTRAINT TICKET_mapping_pkey PRIMARY KEY (id)) OPTIONS (UPDATABLE 'FALSE',DELETETABLE 'TRUE',TICKET.IMPLEMENTED 'TRUE') 
AS(select 
id 
,end_date 
,outcome 
,t4.processinstanceid 
,t4.processid 
,start_date 
,status 
,status_name 
,duration 
,externalid 
,user_identity 
,processname 
,processversion 
,processinstancedescription 
,ticket_type
,aborted_by
,ticket_des
  from DSBPM.vw_tickets T4
  left join
  (
    select 
 processinstanceid
,ltrim(convert(string_agg(	ticket_type	,' '  order by ticket_type asc),string)) ticket_type
,ltrim(convert(string_agg(	aborted_by	,' '  order by aborted_by asc),string)) aborted_by
,ltrim(convert(string_agg(	ticket_des	,' '  order by ticket_des asc),string)) ticket_des
from
(
select
processinstanceid
,case when variableid ='ticket_type' then "value" else '' end ticket_type
,case when variableid ='aborted_by' then "value" else '' end aborted_by
,case when variableid ='ticket_des' then "value" else '' end ticket_des
from DSBPM.variableinstancelog t1
where  variableid in('ticket_type','aborted_by','ticket_des')
	) t3
  group by t3.processinstanceid
  ) t5
  on t5.processinstanceid=t4.processinstanceid
  );

  CREATE VIEW TASK_EVENT_OLD(
	id long NOT NULL
,logtime timestamp
,message string(255)
,processinstanceid long
,taskid long
,type string(255)
,userid string(255)
, optlock integer
,workitemid long
,CONSTRAINT TASK_EVENT_OLD_mapping_pkey PRIMARY KEY (id)) OPTIONS (UPDATABLE 'FALSE',DELETETABLE 'TRUE',TASK_EVENT_OLD.IMPLEMENTED 'TRUE') 
AS(select 
id 
,logtime 
,message 
,processinstanceid 
,taskid 
,type 
,userid 
, optlock 
,workitemid 
  from DSBPM.vw_task_event);

  CREATE VIEW TASK_EVENT(
	id long NOT NULL
  ,name string(50)
,logtime timestamp
,message string(255)
,processinstanceid long
,taskid long
,type string(255)
,userid string(255)
, optlock integer
,workitemid long
,CONSTRAINT TASK_EVENT_mapping_pkey PRIMARY KEY (id)) OPTIONS (UPDATABLE 'FALSE',DELETETABLE 'TRUE',TASK_EVENT.IMPLEMENTED 'TRUE') 
AS(select 
id 
,GroupId
,logtime 
,message 
,processinstanceid 
,t4.taskid 
,type 
,userid 
, optlock 
,workitemid 
  from DSBPM.vw_task_event t4
  left join  (
    select taskid,"name" GroupId from DSBPM.audittaskimpl t2 where  exists(
 select 1 
	from
	(select taskid,max(activationtime) activationtime from DSBPM.audittaskimpl group by taskid) t1
	where t1.activationtime=t2.activationtime and t1.taskid=t2.taskid
)
  )t3
  on t3.taskid=t4.taskid
  );
  
  
  
