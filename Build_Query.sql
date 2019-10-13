/* Name: Sulaiman Mohamed StuId: 102176657 */

/* Task 1

Tour(TourName, Description)
Client(ClientID, Surname, Givename, Gender)
Event(EventYear, EventMonth, EventDay, Fee, TourName)
Booking(DateBooked, Payment, ClientID, EventYear, EventMonth, EventDay)
FK (TourName) REFERENCES Tour
FK (ClientID) REFERENCES Client
FK (EventYear, EventMonth, EventDay) REFERENCES Event
*/

