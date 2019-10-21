--Name: Sulaiman Mohamed StuId: 102176657

/*Task 1

Tour(TourName, Description)
PK (TourName)
Client(ClientID, Surname, Givename, Gender)
PK (ClientID)
Event(EventYear, EventMonth, EventDay, Fee, TourName)
PK (EventYear, EventMonth, EventDay, TourName)
Booking(DateBooked, ClientID, Payment, EventYear, EventMonth, EventDay)
PK (EventYear, EventMonth, EventDay, TourName, ClientID)
FK (TourName) REFERENCES Tour
FK (ClientID) REFERENCES Client
FK (EventYear, EventMonth, EventDay) REFERENCES Event
*/


--Task 2
Drop table IF EXISTS Tour;
Create table Tour(
TourName NVARCHAR(100), 
Description NVARCHAR(500),
PRIMARY KEY(TourName)
);
Drop table IF EXISTS Client;
Create table Client(
ClientID INT,
Surname NVARCHAR(100) NOT NULL,
GivenName NVARCHAR(100) NOT NULL,
Gender  NVARCHAR(1) CHECK (Gender IN ('M','F','I')),
PRIMARY KEY(ClientID)
);
Drop table IF EXISTS Event;
Create table Event(
TourName NVARCHAR(100),
EventMonth NVARCHAR(3) CHECK (EventMonth IN ('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec')),
EventDay INT CHECK (EventDay > 1 AND EventDay < 31),
EventYear INT CHECK (DATALENGTH(EventYear)=4),
EventFee DECIMAL NOT NULL CHECK (EventFee > 0),
PRIMARY KEY(TourName,EventMonth,EventDay,EventYear),
Foreign KEY(TourName) References Tour
);
Drop table IF EXISTS Booking;
Create table Booking(
ClientID INT,
TourName NVARCHAR(100),
EventMonth  NVARCHAR(3) CHECK (EventMonth IN ('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec')),
EventDay INT CHECK (EventDay > 1 AND EventDay < 31),
EventYear INT CHECK (DATALENGTH(EventYear)=4),
Payment DECIMAL,
DateBooked DATE NOT NULL,
PRIMARY KEY(ClientID, TourName, EventMonth, EventDay, EventYear),
FOREIGN KEY(ClientID) REFERENCES Client,
FOREIGN KEY(TourName, EventMonth,EventDay,EventYear) REFERENCES Event
);

--Task 3 
INSERT INTO Tour(TourName, Description) VALUES ('North','Tour of wineries and outlets of the Bedigo and Castlemaine region');
INSERT INTO Tour(TourName, Description) VALUES ('South','Tour of wineries and outlets of Mornington Penisula');
INSERT INTO Tour(TourName, Description) VALUES ('West','Tour of wineries and outlets of the Geelong and Otways region');

INSERT INTO Client(ClientID,Surname,GivenName,Gender) VALUES (1,'Price','Taylor','M');
INSERT INTO Client(ClientID,Surname,GivenName,Gender) VALUES (2,'Gamble','Ellyse','F');
INSERT INTO Client(ClientID,Surname,GivenName,Gender) VALUES (3,'Tan','Tilly','F');
INSERT INTO Client(ClientID,Surname,GivenName,Gender) VALUES (4,'Sulaiman','Mohamed','M');

INSERT INTO Event(TourName,EventMonth,EventDay,EventYear,EventFee) VALUES ('North','Jan',9,2016,200);
INSERT INTO Event(TourName,EventMonth,EventDay,EventYear,EventFee) VALUES ('North','Feb',13,2016,225);
INSERT INTO Event(TourName,EventMonth,EventDay,EventYear,EventFee) VALUES ('South','Jan',9,2016,200);
INSERT INTO Event(TourName,EventMonth,EventDay,EventYear,EventFee) VALUES ('South','Jan',16,2016,200);
INSERT INTO Event(TourName,EventMonth,EventDay,EventYear,EventFee) VALUES ('West','Jan',29,2016,225);

INSERT INTO Booking(ClientID,TourName,EventMonth,EventDay,EventYear,Payment,DateBooked) VALUES (1,'North','Jan',9,2016,200,'12/10/2015');
INSERT INTO Booking(ClientID,TourName,EventMonth,EventDay,EventYear,Payment,DateBooked) VALUES (2,'North','Jan',9,2016,200,'12/16/2015');
INSERT INTO Booking(ClientID,TourName,EventMonth,EventDay,EventYear,Payment,DateBooked) VALUES (1,'North','Feb',13,2016,225,'1/8/2016');
INSERT INTO Booking(ClientID,TourName,EventMonth,EventDay,EventYear,Payment,DateBooked) VALUES (2,'North','Feb',13,2016,125,'1/14/2016');
INSERT INTO Booking(ClientID,TourName,EventMonth,EventDay,EventYear,Payment,DateBooked) VALUES (3,'North','Feb',13,2016,225,'2/3/2016');
INSERT INTO Booking(ClientID,TourName,EventMonth,EventDay,EventYear,Payment,DateBooked) VALUES (1,'South','Jan',9,2016,200,'12/10/2015');
INSERT INTO Booking(ClientID,TourName,EventMonth,EventDay,EventYear,Payment,DateBooked) VALUES (2,'South','Jan',16,2016,200,'12/18/2015');
INSERT INTO Booking(ClientID,TourName,EventMonth,EventDay,EventYear,Payment,DateBooked) VALUES (3,'South','Jan',16,2016,200,'1/9/2016');
INSERT INTO Booking(ClientID,TourName,EventMonth,EventDay,EventYear,Payment,DateBooked) VALUES (2,'West','Jan',29,2016,225,'12/17/2015');
INSERT INTO Booking(ClientID,TourName,EventMonth,EventDay,EventYear,Payment,DateBooked) VALUES (3,'West','Jan',29,2016,200,'12/18/2015');

--Task 3.1
Select * from Client; 
 


-- Task 4 
--Query 1
SELECT C.GivenName, C.Surname, T.TourName, T.Description, E.EventYear, E.EventMonth, E.EventDay, E.EventFee, B.DateBooked, B.Payment
From Booking B
INNER JOIN Client C ON B.ClientID=C.ClientID
LEFT OUTER JOIN Event E ON E.TourName=B.TourName
RIGHT OUTER JOIN Tour T ON T.TourName=B.TourName;

--Query 2 
SELECT EventMonth, TourName, COUNT(ClientID) as 'Num Bookings'
FROM Booking
GROUP BY EventMonth, TourName;

--Query 3 (Subquery)
SELECT * 
FROM Booking 
WHERE Payment>(SELECT AVG(Payment) From Booking);

--Task 5(Create a View)

Drop table IF EXISTS NewBooking;
CREATE VIEW NewBooking AS
SELECT C.GivenName, C.Surname, T.TourName, T.Description, E.EventYear, E.EventMonth, E.EventDay, E.EventFee, B.DateBooked, B.Payment
From Booking B
INNER JOIN Client C ON B.ClientID=C.ClientID
INNER JOIN Event E ON E.TourName=B.TourName
JOIN Tour T ON T.TourName=B.TourName;


SELECT * FROM NewBooking

CREATE TABLE BOOKINGB(
GivenName VARCHAR(100),
Surname VARCHAR(100),
TourName VARCHAR(100) UNIQUE,
Description VARCHAR(300),
EventYear INT CHECK (DATALENGTH(EventYear)=4),
EventMonth VARCHAR(3) CHECK (EventMonth IN ('Jan', 'Feb', 'Mar', 'Apr','May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec')),
EventDay INT CHECK(EventDay > 1 AND EventDay < 31),
EventFee DECIMAL CHECK (EventFee>0),
DateBooked DATE,
Payment DECIMAL,
);


Drop table IF EXISTS dbo.BOOKINGB;
SELECT * FROM BOOKINGB

--Task 6(Test queries)
SELECT EventMonth, TourName, COUNT(ClientID) as 'Num Bookings'
FROM Booking
GROUP BY EventMonth, TourName;
Checked against the generated table in task 4 query 2.


;


