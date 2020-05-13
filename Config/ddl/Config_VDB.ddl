CREATE VIEW menu_group_mapping(id string(50)
,menu_sercurity_name string(50)
,group_name string(50)
,CONSTRAINT menu_group_mapping_pkey PRIMARY KEY (id)) OPTIONS (UPDATABLE 'TRUE',DELETETABLE 'TRUE',menu_group_mapping.IMPLEMENTED 'TRUE') 
AS(select T0."id" as id
,T0."menu_sercurity_name" as menu_sercurity_name
,T0."group_name" as group_name
  from Config.menu_group_mapping T0);
  
  
  
CREATE VIEW well(id integer
,wellname string(50)
,oilgain integer,
CONSTRAINT PK_ASSET_HIERARCHY PRIMARY KEY (id)
) OPTIONS (UPDATABLE 'TRUE',well.IMPLEMENTED 'TRUE') 
AS(select T1."id" as id
,T1."wellname" as wellname
,T1."oilgain" as oilgain
  from Config.WELL T1);
  
CREATE VIRTUAL PROCEDURE SP_SAVE_WELL (id INTEGER,  wellname string(50), oilgain INTEGER) 
RETURNS (STATUS STRING) 
AS
BEGIN
	exec Config.p_save_well(id,wellname,oilgain);
	select 'success';
END;

CREATE VIRTUAL PROCEDURE SP_DELETE_GROUP_MENU (id_d STRING) 
RETURNS (STATUS STRING) 
AS
BEGIN
	
	DELETE FROM Config.menu_group_mapping  WHERE Config.menu_group_mapping."id" = id_d;
	select 'success';
END;
CREATE VIRTUAL PROCEDURE SP_APPEND_GROUP_MENU (menu_sercurity_name STRING,group_name STRING) 
RETURNS (STATUS STRING) 
AS
BEGIN
	
	INSERT INTO Config.menu_group_mapping(ID,menu_sercurity_name,group_name)
	SELECT uuid() as id,SP_APPEND_GROUP_MENU.menu_sercurity_name,SP_APPEND_GROUP_MENU.group_name;
	select 'success';
END;
CREATE VIRTUAL PROCEDURE SP_APPEND_GROUP_MENU_AUTH (changedby STRING, group_name STRING,authdata STRING(9999)) 
RETURNS (STATUS STRING) 
AS
BEGIN
   declare string data=replace(replace(replace(authdata,'^!','{'),'!^','}'),'111','&'); 
	 DELETE FROM Config.wf_leftmenu_auth WHERE usergroup =group_name;
	 INSERT INTO Config.wf_leftmenu_auth(USERGROUP,authmenus,rowchanged_by,rowchanged_date )
	 SELECT group_name,data,changedby,now();
	 select 'success';
END;
CREATE view GROUP_MENU_AUTH
(
	 usergroup string(50),
    authmenus string(500),
    rowchanged_by string(50),
    rowchanged_date timestamp,
	CONSTRAINT GROUP_MENU_AUTH_pkey PRIMARY KEY (usergroup)) OPTIONS (UPDATABLE 'TRUE',DELETETABLE 'TRUE',GROUP_MENU_AUTH.IMPLEMENTED 'TRUE') 
AS(
    select usergroup,authmenus,rowchanged_by,rowchanged_date from Config.wf_leftmenu_auth
);
  