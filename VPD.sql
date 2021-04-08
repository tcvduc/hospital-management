SET SERVEROUTPUT ON;
---------------------
-- Doctor Policy VPD
---------------------

-- 1. Only see patient information for their responsibility
-- 1.1 Temp function
CREATE OR REPLACE FUNCTION FUNC_TEMP_VPD_POLICY_DOCTOR_SEE_PATIENT_INFO(
    ip_doctor_name IN VARCHAR2
)
RETURN VARCHAR2 
AS
    predicate VARCHAR2(200);
    cur_user VARCHAR2(200):=UPPER(ip_doctor_name);
BEGIN
    IF(INSTR(cur_user,'BACSI')<>0) THEN
        predicate:= 'DOCTOR '|| cur_user;
            dbms_output.put_line(INSTR(cur_user,'BACSI')); 
    ELSE
        predicate:='';
    END IF;
    dbms_output.put_line(cur_user); 
    
   
    RETURN predicate;
END FUNC_TEMP_VPD_POLICY_DOCTOR_SEE_PATIENT_INFO;
/

-- Test 1.1 func TEMP
--SELECT FUNC_TEMP_VPD_POLICY_DOCTOR_SEE_PATIENT_INFO ('user_bacsi_01') FROM DUAL;
-- SELECT FUNC_TEMP_VPD_POLICY_DOCTOR_SEE_PATIENT_INFO ('alo') FROM DUAL;


-- 1. Only see patient information for their responsibility
-- 1.2 Real func
CREATE OR REPLACE FUNCTION FUNC_VPD_POLICY_DOCTOR_SEE_PATIENT_INFO(
    p_schema IN VARCHAR2,
    p_object IN VARCHAR2
)
RETURN VARCHAR2 
AS
    predicate VARCHAR2(200);
    cur_user VARCHAR2(200);
BEGIN
   cur_user:=SYS_CONTEXT('USERENV','SESSION_USER');
   cur_user:=UPPER(cur_user);
    IF(INSTR(cur_user,'BACSI')<>0) THEN
        predicate:= 'DOCTOR '|| cur_user;
            dbms_output.put_line(INSTR(cur_user,'BACSI')); 
    ELSE
        predicate:='';
    END IF;
    dbms_output.put_line(cur_user); 
    
   
    RETURN predicate;
END FUNC_VPD_POLICY_DOCTOR_SEE_PATIENT_INFO;
/
-- Test 1.2 real  func
-- SELECT FUNC_VPD_POLICY_DOCTOR_SEE_PATIENT_INFO('ALO') FROM DUAL;





-- Apply VPD
-- ALTER SYSTEM SET "_allow_insert_with_update_check"=TRUE scope=spfile;
BEGIN 
DBMS_RLS.DROP_POLICY('', 'HOSOBENHNHAN', 'VPD_POLICY_DOCTOR_SEE_PATIENT_INFO'); 
END;
/



BEGIN
    DBMS_RLS.add_policy(
  --  object_schema    => 'user_bacsi_01', if this is null - it will take the cur_session
    object_name      => 'HOSOBENHNHAN',
    policy_name      => 'VPD_POLICY_DOCTOR_SEE_PATIENT_INFO',
    policy_function  => 'FUNC_VPD_POLICY_DOCTOR_SEE_PATIENT_INFO'
    );
END;
/
