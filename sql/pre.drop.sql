ALTER SESSION SET "_ORACLE_SCRIPT"= TRUE;
DROP USER LBACSYS;
drop table testing;

DROP USER USER_TAIVU_01;
DROP USER U1;
DROP USER U2;
DROP USER USER_TAINGUYEN_NHANSU_01;
DROP USER USER_TAINGUYEN_NHANSU_02;
DROP USER SCOTT;


DROP ROLE NHANVIEN_TAIVU;
DROP ROLE R1;
DROP ROLE R2;
DROP ROLE ROLE_DEP_QL_TG_NS;


DROP USER USER_NHANVIEN_QUANLY_TV01 ;
DROP USER USER_NHANVIEN_QUANLY_TV02 ;
DROP USER USER_NHANVIEN_QUANLY_TV03 ;

DROP USER USER_NHANVIEN_THUTHU_TV01_01;
DROP USER USER_NHANVIEN_THUTHU_TV01_02;
DROP USER USER_NHANVIEN_THUTHU_TV02_01;
DROP USER USER_NHANVIEN_THUTHU_TV02_02 ;
DROP USER USER_NHANVIEN_THUTHU_TV03_01 ;
DROP USER USER_NHANVIEN_THUTHU_TV03_02 ;

DROP USER DUCCAO_01 ;
DROP USER DUCCAO_02 ;
DROP USER DUCCAO_03 ;


DROP USER JOHN ;
DROP USER JOE ;
DROP USER FRED ;
DROP USER LYNN ;
DROP USER AMY ;
DROP USER BETH ;

DROP TABLE JOHN.JOIN_TBL;
DROP TABLESPACE TBS_HW32USERS;
DROP TABLE  ATTENDANCE;


DROP ROLE DATAENTRY;
DROP ROLE SUPERVISOR;
DROP ROLE MANAGEMENT;

DROP USER NameManager;

-- PROJECT
DROP ROLE role_dep_letan;

DROP USER USER_TIEPTAN_01;
DROP USER USER_TIEPTAN_02;

DROP ROLE ROLE_DOCTOR;

DROP USER USER_BACSI_01;
DROP USER USER_BACSI_02;

DROP ROLE ROLE_DEP_KETOAN;

DROP USER USER_KETOAN_01;
DROP USER USER_KETOAN_02;


DROP USER USER_QUANLY_TAIVU_01;
DROP USER USER_QUANLY_TAIVU_02;
DROP USER USER_QUANLY_TAIVU_03;

DROP USER USER_QUANLY_TAIVU_01;
DROP USER USER_QUANLY_TAIVU_02;
DROP USER USER_QUANLY_TAIVU_03;
DROP ROLE ROLE_DEP_QL_TAIVU;

DROP USER USER_QUANLY_CHUYENMON_01;
DROP USER USER_QUANLY_CHUYENMON_02;
DROP USER USER_QUANLY_CHUYENMON_03;
DROP ROLE ROLE_DEP_QL_CHUYENMON;

BEGIN 
 DBMS_RLS.DROP_GROUPED_POLICY('DUCCAO_ADMIN', 'HOSOBENHNHAN', 'SYS_DEFAULT','POLICY_VPD_DOCTOR_HOSOBENHNHAN'); 
 DBMS_RLS.DROP_GROUPED_POLICY('DUCCAO_ADMIN', 'VIEW_VPD_DOCTOR_CTDONTHUOC','SYS_DEFAULT', 'POLICY_VPD_DOCTOR_CTDONTHUOC'); 
 DBMS_RLS.DROP_GROUPED_POLICY('DUCCAO_ADMIN', 'VW_DOCTOR_SEE_THEIR_INFO', 'SYS_DEFAULT','POLICY_VPD_DOCTOR_SEE_THEIR_INFO_ONLY'); 

END;
/







