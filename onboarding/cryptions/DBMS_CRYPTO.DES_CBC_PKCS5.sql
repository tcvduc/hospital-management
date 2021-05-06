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
dbms_output.put_line('> Input String : ' ||INPUT_STRING);
-- encrypt and decrypt functions in DBMS_CRYPTO package work on the RAW data
ENCRYPTED_RAW:=DBMS_CRYPTO.ENCRYPT(
    SRC => RAW_INPUT,
    TYP => DBMS_CRYPTO.DES_CBC_PKCS5,
    KEY => RAW_KEY
);
     DBMS_OUTPUT.PUT_LINE('> Input string encrypted ret: ' ||ENCRYPTED_RAW);

DBMS_OUTPUT.PUT_LINE('');
DECRYPTED_RAW :=DBMS_CRYPTO.DECRYPT(
    SRC =>ENCRYPTED_RAW,
    TYP => DBMS_CRYPTO.DES_CBC_PKCS5,
    KEY => RAW_KEY
);

DBMS_OUTPUT.PUT_LINE('Decrypted raw ret: '||DECRYPTED_RAW);

DECRYPTED_STRING := CONVERT(UTL_RAW.CAST_TO_VARCHAR2(DECRYPTED_RAW),'US7ASCII','AL32UTF8');

DBMS_OUTPUT.PUT_LINE('Decrypted string ret: '||DECRYPTED_STRING);

END;
/