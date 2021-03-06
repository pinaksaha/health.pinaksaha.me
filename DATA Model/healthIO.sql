CREATE TABLE USERS
(
			id INTEGER PRIMARY KEY,
			username VARCHAR(255) NOT NULL,
			pin INTEGER NOT NULL
);
CREATE TABLE USERS_BloodPressures
		(
			id INTEGER PRIMARY KEY,
			users_id INTEGER NOT NULL,
			high INTEGER NOT NULL,
			low INTEGER NOT NULL,
			created_at TIMESTAMP NOT NULL,
			FOREIGN KEY (users_id) REFERENCES USERS(id)
		);

CREATE TABLE USERS_BloodSugars
		(
			id INTEGER PRIMARY KEY,
			users_id INTEGER NOT NULL,
			levels  INTEGER NOT NULL,
			created_at TIMESTAMP NOT NULL,
			
			FOREIGN KEY (users_id) REFERENCES USERS(id)
			
		);
CREATE TABLE USERS_Weights
		(
			id INTEGER PRIMARY KEY ,
			users_id INTEGER NOT NULL,
			levels  INTEGER NOT NULL,
			created_at TIMESTAMP NOT NULL,
			FOREIGN KEY (users_id) REFERENCES USERS(id)
			
		);
CREATE TABLE USERS_HeartRate
		(
			id INTEGER PRIMARY KEY,
			users_id INTEGER NOT NULL,
			bpm  INTEGER NOT NULL,
			created_at TIMESTAMP NOT NULL,
			FOREIGN KEY (users_id) REFERENCES USERS(id)
			
		);
CREATE TABLE USERS_Journal
		(
			id INTEGER PRIMARY KEY,
			users_id INTEGER NOT NULL,
			post  VARCHAR(2048) NOT NULL,
			created_at TIMESTAMP NOT NULL,
			FOREIGN KEY (users_id) REFERENCES USERS(id)
			
		);