INSERT INTO users(u_name, u_password, u_email, u_is_active, u_is_manager, 
  u_groom_name, u_groom_surname, u_groom_birthday, 
  u_bride_name, u_bride_surname, u_bride_birthday) 
  VALUES ('rand', 'at', 'dragon@reborn.net', 1, 1, 
    NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO users(u_name, u_password, u_email, u_is_active, u_is_manager, 
  u_groom_name, u_groom_surname, u_groom_birthday, 
  u_bride_name, u_bride_surname, u_bride_birthday) 
  VALUES ('garreth', 'garreth', 'garreth@tanfer.kar', 1, 0, 
    'unknown', 'garreth', '14-AUG-1988', 'tiny', 'teit', '20-APR-1990');
INSERT INTO users(u_name, u_password, u_email, u_is_active, u_is_manager, 
  u_groom_name, u_groom_surname, u_groom_birthday, 
  u_bride_name, u_bride_surname, u_bride_birthday) 
  VALUES ('Thelomen', 'Toblakai', 'teblor@uryd.lp', 1, 0, 
    'Karsa', 'Orlong', '23-SEP-1936', 'Samar', ' Dev', '11-JUN-1986');
    
INSERT INTO Messages(m_from_fk, m_to_fk, m_timestamp, m_content)
  VALUES ('rand', 'garreth', SYSTIMESTAMP, 'your name is a bit strange');
INSERT INTO Messages(m_from_fk, m_to_fk, m_timestamp, m_content)
  VALUES ('garreth', 'rand', SYSTIMESTAMP, 'i dont give a fuck');
INSERT INTO Messages(m_from_fk, m_to_fk, m_timestamp, m_content)
  VALUES ('rand', 'garreth', SYSTIMESTAMP, 'you better start doing it now');
INSERT INTO Messages(m_from_fk, m_to_fk, m_timestamp, m_content)
  VALUES ('Thelomen', 'rand', SYSTIMESTAMP, 
    'i will destroy you whatever you are');
  
INSERT INTO Ceremonies(c_number, u_name_fk, c_date, manager_fk)
  VALUES (0, 'garreth', '19-DEC-16', 'rand');
  
INSERT INTO Bills(b_number, c_number_fk, b_amount, b_timestamp, b_is_paid)
  VALUES (0, 0, 1488, SYSTIMESTAMP, 0);
INSERT INTO Bills(b_number, c_number_fk, b_amount, b_timestamp, b_is_paid)
  VALUES (1, 0, 1488, SYSTIMESTAMP, 1);

INSERT INTO Artists(a_contract, a_is_active, a_name, 
  a_email, a_genre, a_price_per_hour)
  VALUES (0, 1, 'Dandelion', 'not@a.spy', 'live music', 100);
INSERT INTO Artists(a_contract, a_is_active, a_name, 
  a_email, a_genre, a_price_per_hour)
  VALUES (1, 1, 'Thomdril Merrilin', 'jump_da@fuck.up', 'live music', 300);

INSERT INTO Performances(c_number_fk, a_contract_fk, p_hours, p_is_confirmed)
  VALUES (0, 0, 2, 0);
INSERT INTO Performances(c_number_fk, a_contract_fk, p_hours, p_is_confirmed)
  VALUES (0, 1, 2, 1);

INSERT INTO Restaurants(r_contract, r_is_active, r_name, 
  r_email, r_address, r_price_per_day)
  VALUES (0, 1, 'Pig and Whistle', 'pig@whist.le', 
    'Old Town, Stormwind City', 2000);
INSERT INTO Restaurants(r_contract, r_is_active, r_name, 
  r_email, r_address, r_price_per_day)
  VALUES (1, 1, 'Salty Sailor Tavern', 'salt@sail.or', 
    'Booty Bay, Stranglethorn Vale', 1488);

INSERT INTO Reservations(c_number_fk, r_contract_fk, r_is_confirmed)
  VALUES (0, 1, 0);
INSERT INTO Reservations(c_number_fk, r_contract_fk, r_is_confirmed)
  VALUES (0, 0, 1);

--procedures
CREATE OR REPLACE PROCEDURE REGISTERNEWUSER (
  USER_NAME IN VARCHAR2,
  USER_PASSWORD IN VARCHAR2,
  USER_EMAIL IN VARCHAR2, 
  REGISTRATION_STATUS OUT VARCHAR2 
) AS 
  sameLoginCount INTEGER;
  sameEmailCount INTEGER;
BEGIN
  SELECT COUNT(*) INTO sameLoginCount FROM Users WHERE u_name = USER_NAME;
  IF sameLoginCount = 0 THEN
    BEGIN
      SELECT COUNT(*) INTO sameEmailCount FROM Users WHERE u_email = USER_EMAIL;
      IF sameEmailCount = 0 THEN
        BEGIN
          INSERT INTO users(u_name, u_password, u_email, u_is_active, u_is_manager, 
            u_groom_name, u_groom_surname, u_groom_birthday, 
            u_bride_name, u_bride_surname, u_bride_birthday) 
          VALUES (USER_NAME, USER_PASSWORD, USER_EMAIL, 1, 0, 
            NULL, NULL, NULL, NULL, NULL, NULL);
          COMMIT;
          REGISTRATION_STATUS := 'OK';
        END;
      ELSE
        REGISTRATION_STATUS := 'Email already in use';
      END IF;
    END;
  ELSE
    REGISTRATION_STATUS := 'Login already in use';
  END IF;
END REGISTERNEWUSER;
/

CREATE OR REPLACE PROCEDURE AUTHORIZEUSER (
  USER_NAME IN VARCHAR2,
  USER_PASSWORD IN VARCHAR2,
  AUTH_STATUS OUT VARCHAR2,
  IS_MANAGER OUT NUMBER
) AS 
  userMatchCount INTEGER;
  managerMatchCount INTEGER;
BEGIN
  SELECT COUNT(*) INTO userMatchCount FROM Users WHERE u_name = USER_NAME AND u_password = USER_PASSWORD;
  IF userMatchCount > 0 THEN
    BEGIN
      AUTH_STATUS := 'OK';
      UPDATE Users SET u_is_active = 1 WHERE u_name = USER_NAME;
      SELECT COUNT(*) INTO managerMatchCount FROM Users WHERE u_name = USER_NAME AND u_password = USER_PASSWORD AND u_is_manager <> 0;
      IF managerMatchCount > 0 THEN
        IS_MANAGER := 1;
      ELSE
        IS_MANAGER := 0;
      END IF;
      COMMIT;
    END;
  ELSE
    AUTH_STATUS := 'Wrong login/password combination';
    IS_MANAGER := 0;
  END IF;
END AUTHORIZEUSER;
/

CREATE OR REPLACE PROCEDURE RESTOREPASSWORD (
  USER_NAME IN VARCHAR2,
  USER_EMAIL IN VARCHAR2,
  STATUS OUT VARCHAR2,
  USER_PASSWORD OUT VARCHAR2  
) AS
loginEmailPairCount INTEGER;
BEGIN
  SELECT COUNT (*) INTO loginEmailPairCount FROM Users WHERE u_name = USER_NAME AND u_email = USER_EMAIL;
  IF loginEmailPairCount > 0 THEN
    BEGIN
      STATUS := 'OK';
      SELECT u_password INTO USER_PASSWORD FROM Users WHERE u_name = USER_NAME AND u_email = USER_EMAIL;
    END;
  ELSE
    STATUS := 'Failed to restore password. Wrong login/email combination';
    USER_PASSWORD := '';
  END IF;
END RESTOREPASSWORD;
/

create or replace 
PROCEDURE UPDATEPERSONALPAGE (
  USER_NAME IN VARCHAR2,
  USER_PASSWORD IN VARCHAR2,
  GROOM_NAME IN VARCHAR2,
  GROOM_SURNAME IN VARCHAR2,
  GROOM_BIRTHDAY IN VARCHAR2,
  BRIDE_NAME IN VARCHAR2,
  BRIDE_SURNAME IN VARCHAR2,
  BRIDE_BIRTHDAY IN VARCHAR2, 
  NEW_EMAIL IN VARCHAR2,
  NEW_PASSWORD IN VARCHAR2,
  STATUS OUT VARCHAR2  
) AS 
correctUserCount INTEGER;
sameEmailCount INTEGER;
BEGIN
  SELECT COUNT(*) INTO correctUserCount FROM Users WHERE u_name = USER_NAME AND u_password = USER_PASSWORD;
  IF correctUserCount <> 0 THEN
    BEGIN
      IF GROOM_NAME IS NOT NULL THEN
        UPDATE Users SET u_groom_name = GROOM_NAME WHERE u_name = USER_NAME;
      END IF;
      IF GROOM_SURNAME IS NOT NULL THEN
        UPDATE Users SET u_groom_surname = GROOM_SURNAME WHERE u_name = USER_NAME;
      END IF;
      IF GROOM_BIRTHDAY IS NOT NULL THEN
        UPDATE Users SET u_groom_birthday = GROOM_BIRTHDAY WHERE u_name = USER_NAME;
      END IF;
      
      IF BRIDE_NAME IS NOT NULL THEN
        UPDATE Users SET u_bride_name = BRIDE_NAME WHERE u_name = USER_NAME;
      END IF;
      IF BRIDE_SURNAME IS NOT NULL THEN
        UPDATE Users SET u_bride_surname = BRIDE_SURNAME WHERE u_name = USER_NAME;
      END IF;
      IF BRIDE_BIRTHDAY IS NOT NULL THEN
        UPDATE Users SET u_bride_birthday = BRIDE_BIRTHDAY WHERE u_name = USER_NAME;
      END IF;
      
      IF NEW_PASSWORD IS NOT NULL THEN
        UPDATE Users SET u_password = NEW_PASSWORD WHERE u_name = USER_NAME;
      END IF;
      
      STATUS := 'OK';
    
      IF NEW_EMAIL IS NOT NULL THEN
        BEGIN
          SELECT COUNT(*) INTO sameEmailCount FROM Users WHERE u_email = NEW_EMAIL;
          IF sameEmailCount = 0 THEN
            UPDATE Users SET u_email = NEW_EMAIL WHERE u_name = USER_NAME;
          END IF;
          STATUS := 'OK. Failed to update email. Specified address is already occupied';
        END;
      END IF;
      COMMIT;
    END;
  ELSE
    STATUS := 'Failed to apply changes. Incorrect current password';
  END IF;
END UPDATEPERSONALPAGE;
/
