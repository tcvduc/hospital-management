SET SERVEROUTPUT ON SIZE 30000;

DECLARE
    INPUT_STRING VARCHAR2(200):='DUCCAO-LEARNING-EN/DECRIPT';
    RAW_INPUT RAW(128):= 
    UTL_RAW.CAST_TO_RAW(CONVERT(INPUT_STRING,'AL32UTF8','US7ASCII'));
    
    KEY_STRING VARCHAR2(200) := 'KEY-USING-TO-Encrypt-&-Decrypt';
    RAW_KEY RAW(128):=
    UTL_RAW.CAST_TO_RAW(CONVERT(KEY_STRING,'AL32UTF8','US7ASCII'));
    
    ENCRYPTED_RAW RAW(2048);
    ENCRYPTED_STRING VARCHAR2(2048);
    
    DECRYPTED_RAW RAW(2048);
    DECRYPTED_STRING VARCHAR2(2048);
    
BEGIN
-- using MAC - MD5
DBMS_OUTPUT.PUT_LINE('> Input string: '||INPUT_STRING);
DBMS_OUTPUT.PUT_LINE('> MAC-MD5 Hashing .....');

ENCRYPTED_RAW:=dbms_crypto.MAC(
    src => RAW_INPUT,
    typ =>DBMS_CRYPTO.HMAC_MD5,
    key => raw_key
);

DBMS_OUTPUT.PUT_LINE('> MAC-MD5 Hashed ret: '||ENCRYPTED_RAW);
DBMS_OUTPUT.PUT_LINE('> MAC-MD5 Hashed hex ret: '
||rawtohex(UTL_RAW.CAST_TO_RAW(ENCRYPTED_RAW)));

END;
/