
----
-- 2. Procedure Create A User
------
CREATE OR REPLACE PROCEDURE createUser(
    pi_username IN NVARCHAR2,
    pi_password IN NVARCHAR2)
IS    
    user_name  NVARCHAR2(20):= pi_username;
    pwd NVARCHAR2(20):= pi_password;
    li_count INTEGER :=0;
    lv_stmt VARCHAR(1000);
    BEGIN
    SELECT COUNT (1)
    INTO li_count
    FROM all_users
    WHERE username =UPPER(user_name);
    
    
    IF li_count !=0
    THEN 
        lv_stmt:='DROP USER ' ||user_name ||' CASCADE';
        EXECUTE IMMEDIATE (lv_stmt);      
    END IF;
    
    lv_stmt:='ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE ';
    EXECUTE IMMEDIATE (lv_stmt);
    
   -- lv_stmt:='CREATE USER ' || user_name|| ' IDENTIFIED BY ' || pwd|| ' DEFAULT TABLESPACE SYSTEM ';
    lv_stmt:='CREATE USER ' || user_name|| ' IDENTIFIED BY ' || pwd;

  --  DBMS_OUTPUT.put_line(lv_stmt);
    
    EXECUTE IMMEDIATE (lv_stmt);
    
     -- ****** Object: Roles for user ******
     lv_stmt:='GRANT CREATE SESSION TO ' ||user_name;
         EXECUTE IMMEDIATE (lv_stmt);
      
          lv_stmt:='ALTER SESSION SET "_ORACLE_SCRIPT"=FALSE ';
    EXECUTE IMMEDIATE (lv_stmt);
       COMMIT;
    END createUser;
/

----------------
-- 3. Procedure Delete A User
------------------
CREATE OR REPLACE PROCEDURE deleteUser(
    ip_username IN NVARCHAR2)
IS
user_name NVARCHAR2(20):=ip_username;
exec_commander VARCHAR(1000);
    BEGIN
        exec_commander := 'ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE ';
        EXECUTE IMMEDIATE (exec_commander);
        
       exec_commander :='DROP USER ' || user_name|| ' CASCADE ';
           EXECUTE IMMEDIATE (exec_commander);
          exec_commander := 'ALTER SESSION SET "_ORACLE_SCRIPT"=FALSE ';
        EXECUTE IMMEDIATE (exec_commander);
        COMMIT;    
    END deleteUser;
/


----------------
-- 4. Procedure Create a role
------------------

CREATE OR REPLACE PROCEDURE proc_createRole(
    ip_rolename IN NVARCHAR2,
    ip_identify IN NVARCHAR2)
IS
role_name nvarchar2(20):= ip_rolename;
identify nvarchar2(20):= ip_identify;
exec_commander varchar(1000);
    BEGIN
        exec_commander:='ALTER SESSION SET "_ORACLE_SCRIPT"= TRUE';
        EXECUTE IMMEDIATE(exec_commander);
        
        exec_commander:='CREATE ROLE '||role_name ||' IDENTIFIED BY '||identify;
        EXECUTE IMMEDIATE(exec_commander);

     exec_commander:='GRANT CREATE SESSION TO '||role_name;
        EXECUTE IMMEDIATE(exec_commander);
        
          exec_commander:='ALTER SESSION SET "_ORACLE_SCRIPT"= FALSE';
        EXECUTE IMMEDIATE(exec_commander);
    COMMIT;
    END proc_createRole;
/


----------------
-- 5. Procedure Delete a role
------------------
CREATE OR REPLACE PROCEDURE proc_deleteRole(
ip_rolename IN NVARCHAR2)
IS 
role_name NVARCHAR2(20):=ip_rolename;
exec_commander varchar(1000);
BEGIN
    exec_commander:='ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE';
      EXECUTE IMMEDIATE(exec_commander);

    exec_commander:='DROP ROLE '|| role_name;
    EXECUTE IMMEDIATE (exec_commander);
    
      exec_commander:='ALTER SESSION SET "_ORACLE_SCRIPT"=FALSE';
      EXECUTE IMMEDIATE(exec_commander);
COMMIT;
END proc_deleteRole;
/

----------------
-- 6. Procedure Alter a user
------------------
CREATE OR REPLACE PROCEDURE proc_alterUser(
    ip_username nvarchar2,
    ip_identify nvarchar2)
IS
user_name nvarchar2(200):=ip_username;
user_identify nvarchar2(200):=ip_identify;
exec_commander varchar(1000);
BEGIN
 exec_commander:='ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE';
EXECUTE IMMEDIATE (exec_commander);

exec_commander:='ALTER USER '||user_name||' IDENTIFIED BY '||user_identify;
EXECUTE IMMEDIATE (exec_commander);

 exec_commander:='ALTER SESSION SET "_ORACLE_SCRIPT"=false';
 EXECUTE IMMEDIATE (exec_commander);


END proc_alterUser;
/




----------------
-- 7. Procedure Alter a ROLE
------------------
CREATE OR REPLACE PROCEDURE proc_AlterRole(
    ip_rolename nvarchar2,
    ip_identify nvarchar2)
IS
role_name nvarchar2(200):=ip_rolename;
role_identify nvarchar2(200):=ip_identify;
exec_commander varchar(1000);
BEGIN
 exec_commander:='ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE';
EXECUTE IMMEDIATE (exec_commander);

exec_commander:='ALTER ROLE '||role_name||' IDENTIFIED BY '||role_identify;
EXECUTE IMMEDIATE (exec_commander);

 exec_commander:='ALTER SESSION SET "_ORACLE_SCRIPT"=false';
 EXECUTE IMMEDIATE (exec_commander);


END proc_AlterRole;
/


----------------
-- 8. Procedure Create View That  Can Grant Select to User with Column Level 
------------------
CREATE OR REPLACE PROCEDURE proc_CreateViewUserSelectColumnLevel(
    ip_username nvarchar2,
    ip_column_name nvarchar2,
    ip_table_name nvarchar2,
    ip_granable nvarchar2
    )
IS
    user_name nvarchar2(200):=ip_username;
    column_name nvarchar2(200):=ip_column_name;
    table_name nvarchar2(200):=ip_table_name;
    exec_commander varchar(1000);
    priv nvarchar2(200);
    vw_name nvarchar2(200);
BEGIN 
    priv:='SELECT';
    exec_commander:='ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE ';
    EXECUTE IMMEDIATE (exec_commander);
    
    IF UPPER(ip_granable) = 'TRUE' THEN

     exec_commander:='CREATE VIEW VW_USER_SELECT_COLUMN_LEVEL_'||ip_username||'_'||ip_column_name||'_'||ip_table_name
    || ' AS '|| 'SELECT ' ||column_name|| ' FROM '|| table_name;
    EXECUTE IMMEDIATE (exec_commander);
    
    
        vw_name:='VW_USER_SELECT_COLUMN_LEVEL_'||ip_username||'_'||ip_column_name||'_'||ip_table_name;
    exec_commander:='GRANT SELECT ON '||vw_name || ' TO ' ||ip_username|| ' WITH GRANT OPTION ';
        EXECUTE IMMEDIATE (exec_commander);
           
    ELSE 
     exec_commander:='CREATE VIEW VW_USER_SELECT_COLUMN_LEVEL_'||ip_username||'_'||ip_column_name||'_'||ip_table_name
    || ' AS '|| 'SELECT ' ||column_name|| ' FROM '|| table_name;
    EXECUTE IMMEDIATE (exec_commander);
    
      vw_name:='VW_USER_SELECT_COLUMN_LEVEL_'||ip_username||'_'||ip_column_name||'_'||ip_table_name;
    exec_commander:='GRANT SELECT ON '||vw_name || ' TO ' ||ip_username;
        EXECUTE IMMEDIATE (exec_commander);
    
    END IF;

    
   exec_commander:='ALTER SESSION SET "_ORACLE_SCRIPT" = FALSE ';
    EXECUTE IMMEDIATE (exec_commander);
END proc_CreateViewUserSelectColumnLevel;
/


------------- TEST 8.
-- EXEC proc_UserSelectColumnLevel('user_temp_2','MANV','NHANVIEN');
-- SELECT * FROM VW_USER_SELECT_COLUMN_LEVEL_USER_TEMP_2_MANV_NHANVIEN;

--INSERT INTO VIEW_COLUMN_SELECT_USER(USERNAME,PRIV,COLUMN_NAME,TABLE_NAME,VIEW_NAME)
--VALUES ('USER_TEMP_02','SELECT','MANV','NHANVIEN','VW_SELECT_USER_TEMP_02_COLUMN');


----------------------------------------------------------------------------
-- 9. Procedure Insert into VIEW_COLUMN_SELECT_USER (TABLE SAVE INFO)
-------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE proc_insertViewUserSelectColumnLevel(
       p_USERNAME IN VIEW_COLUMN_SELECT_USER.USERNAME%TYPE,
       p_PRIV IN VIEW_COLUMN_SELECT_USER.PRIV%TYPE,
       p_COLUMN_NAME IN VIEW_COLUMN_SELECT_USER.COLUMN_NAME%TYPE,
       p_TABLE_NAME IN VIEW_COLUMN_SELECT_USER.TABLE_NAME%TYPE,
     p_GRANTABLE VIEW_COLUMN_SELECT_USER.GRANTABLE%TYPE,
       p_VIEW_NAME IN VIEW_COLUMN_SELECT_USER.VIEW_NAME%TYPE)
IS
exec_commander VARCHAR(1000);
BEGIN
    exec_commander:='ALTER SESSION SET "_ORACLE_SCRIPT" = FALSE ';
    EXECUTE IMMEDIATE (exec_commander);
    
  INSERT INTO VIEW_COLUMN_SELECT_USER ( USERNAME, PRIV ,COLUMN_NAME ,TABLE_NAME ,GRANTABLE,VIEW_NAME ) 
  VALUES (p_USERNAME, p_PRIV,p_COLUMN_NAME, p_TABLE_NAME,p_GRANTABLE,p_VIEW_NAME);
  

   exec_commander:='ALTER SESSION SET "_ORACLE_SCRIPT" = FALSE ';
    EXECUTE IMMEDIATE (exec_commander);
  COMMIT;

END;
/



----------------------------------------------------------------------------
-- 10. Procedure Insert into VIEW_COLUMN_SELECT_ROLE (TABLE SAVE INFO)
-------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE proc_insertViewUserSelectColumnLevel(
       P_ROLENAME IN VIEW_COLUMN_SELECT_ROLE.ROLENAME%TYPE,
       p_PRIV IN VIEW_COLUMN_SELECT_ROLE.PRIV%TYPE,
       p_COLUMN_NAME IN VIEW_COLUMN_SELECT_ROLE.COLUMN_NAME%TYPE,
       p_TABLE_NAME IN VIEW_COLUMN_SELECT_ROLE.TABLE_NAME%TYPE,
     p_GRANTABLE VIEW_COLUMN_SELECT_ROLE.GRANTABLE%TYPE,
       p_VIEW_NAME IN VIEW_COLUMN_SELECT_ROLE.VIEW_NAME%TYPE)
IS
exec_commander VARCHAR(1000);
BEGIN
    exec_commander:='ALTER SESSION SET "_ORACLE_SCRIPT" = FALSE ';
    EXECUTE IMMEDIATE (exec_commander);
    
  INSERT INTO VIEW_COLUMN_SELECT_ROLE ( ROLENAME, PRIV ,COLUMN_NAME ,TABLE_NAME ,GRANTABLE,VIEW_NAME ) 
  VALUES (P_ROLENAME, p_PRIV,p_COLUMN_NAME, p_TABLE_NAME,p_GRANTABLE,p_VIEW_NAME);
  

   exec_commander:='ALTER SESSION SET "_ORACLE_SCRIPT" = FALSE ';
    EXECUTE IMMEDIATE (exec_commander);
  COMMIT;

END;
/


--------------------------------------------------------------------------------
-- 11. Procedure Create View That Role Can Grant Select To  Column Level 
----------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE proc_CreateViewRoleSelectColumnLevel(
    ip_rolename nvarchar2,
    ip_column_name nvarchar2,
    ip_table_name nvarchar2,
    ip_granable nvarchar2
    )
IS
    role_name nvarchar2(200):=ip_rolename;
    column_name nvarchar2(200):=ip_column_name;
    table_name nvarchar2(200):=ip_table_name;
    exec_commander varchar(1000);
    priv nvarchar2(200);
    vw_name nvarchar2(200);
BEGIN 
    priv:='SELECT';
    exec_commander:='ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE ';
    EXECUTE IMMEDIATE (exec_commander);
    
    IF UPPER(ip_granable) = 'TRUE' THEN

     exec_commander:='CREATE VIEW VW_ROLE_SELECT_COLUMN_LEVEL_'||ip_rolename||'_'||ip_column_name||'_'||ip_table_name
    || ' AS '|| 'SELECT ' ||column_name|| ' FROM '|| table_name;
    EXECUTE IMMEDIATE (exec_commander);
    
    
        vw_name:='VW_ROLE_SELECT_COLUMN_LEVEL_'||ip_rolename||'_'||ip_column_name||'_'||ip_table_name;
    exec_commander:='GRANT SELECT ON '||vw_name || ' TO ' ||ip_rolename|| ' WITH GRANT OPTION ';
        EXECUTE IMMEDIATE (exec_commander);
           
    ELSE 
     exec_commander:='CREATE VIEW VW_ROLE_SELECT_COLUMN_LEVEL_'||ip_rolename||'_'||ip_column_name||'_'||ip_table_name
    || ' AS '|| 'SELECT ' ||column_name|| ' FROM '|| table_name;
    EXECUTE IMMEDIATE (exec_commander);
    
    
        vw_name:='VW_ROLE_SELECT_COLUMN_LEVEL_'||ip_rolename||'_'||ip_column_name||'_'||ip_table_name;
    exec_commander:='GRANT SELECT ON '||vw_name || ' TO ' ||ip_rolename;
        EXECUTE IMMEDIATE (exec_commander);
    END IF;

    
   exec_commander:='ALTER SESSION SET "_ORACLE_SCRIPT" = FALSE ';
    EXECUTE IMMEDIATE (exec_commander);
END proc_CreateViewRoleSelectColumnLevel;
/

--CREATE OR REPLACE VIEW RTEMP
--AS
--SELECT MANV FROM NHANVIEN;





