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
