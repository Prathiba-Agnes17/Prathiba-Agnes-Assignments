CREATE TABLE Crimes(
CrimeID int primary key identity(1,1),
IncidentType varchar(255) not null,
IncidentDate date not null,
Location VARCHAR(200) not null,
Description VARCHAR(MAX),
Status VARCHAR(20) CHECK (Status IN('Open','Under Investigation','Closed')))

CREATE TABLE Victims (
VictimID int primary key identity(1,1),
CrimeID int NOT NULL,
Name VARCHAR(100) not null,
ContactInfo VARCHAR(50),
Injuries VARCHAR(200),
Age int,
FOREIGN KEY (CrimeID) REFERENCES Crimes(CrimeID))

CREATE TABLE Suspects (
SuspectID INT IDENTITY(1,1) PRIMARY KEY,
CrimeID INT NOT NULL,
Name VARCHAR(100) NOT NULL,
Description VARCHAR(MAX),
CriminalHistory VARCHAR(MAX),
Age INT,
FOREIGN KEY (CrimeID) REFERENCES Crimes(CrimeID))


INSERT INTO Crimes values
('Robbery','2023-02-10','MG Road, Bengaluru','Masked men looted a jewelry store.','Open'),
('Homicide','2023-03-05','Anna Nagar, Chennai','Murder case under investigation.','Under Investigation'),
('Theft','2023-01-28','Connaught Place, Delhi','Pickpocketing incident in a crowded metro station.','Closed'),
('Fraud','2023-03-15','Gachibowli, Hyderabad','Financial scam involving a fake investment scheme.','Open'),
('Assault','2023-02-20','Marine Drive, Mumbai','Physical assault reported in a public park.','Closed'),
('Cyber Crime','2023-03-01','Electronic City, Bengaluru','Online banking fraud of ₹10 lakhs.','Under Investigation'),
('Hit and Run','2023-02-25','Sector 62, Noida','Car accident where the driver fled.','Closed'),
('Kidnapping','2023-03-10','South Extension, Delhi','Child abducted from a residential area.','Open'),
('Vandalism','2023-02-18','Shivaji Park, Mumbai','Public property damaged by miscreants.','Closed'),
('Extortion','2023-03-12','Salt Lake, Kolkata','Businessman threatened for ransom.','Under Investigation'),
('Burglary','2023-09-05','Koramangala, Bengaluru','House break-in at midnight.','Under Investigation'),
('Robbery','2023-02-18','Brigade Road, Bengaluru','A gang looted a mobile shop.','Open'),
('Arson','2023-03-10','Sector 15, Noida','An abandoned warehouse was set on fire.','Under Investigation')
 
select * from Suspects

INSERT INTO Victims (CrimeID, Name, ContactInfo, Injuries, Age)values
(1,'Rajesh Kumar','rajesh.kumar@email.com','Head injury and minor bruises',42),
(2,'Priya Sharma','priya.sharma@email.com','Deceased',30),
(3,'Anil Verma','anil.verma@email.com','Wallet stolen, no physical injuries',28),
(4,'Sneha Iyer','sneha.iyer@email.com','Financial loss of ₹5 lakhs, no physical injury',40),
(5,'Vikram Reddy','vikram.reddy@email.com','Fractured arm and bruises',35),
(6,'Pooja Desai','pooja.desai@email.com','Bank account hacked, ₹10 lakhs stolen',29),
(7,'Ramesh Yadav','ramesh.yadav@email.com','Leg fracture due to hit-and-run incident',50),
(8,'Meena Agarwal','meena.agarwal@email.com','Abducted for 3 days, no major injuries',31),
(9,'Sanjay Patel','sanjay.patel@email.com','Broken car windows and damaged property',45),
(10, 'Arvind Gupta','arvind.gupta@email.com','Threatened at gunpoint, emotional distress',38),
(11, 'John Doe','john.doe@email.com','Minor bruises',35);


INSERT INTO Suspects (CrimeID, Name, Description, CriminalHistory, Age)values
(1,'Arun Prasad','Wore a black hoodie and carried a knife.','Previously arrested for burglary.',39),
(2,'Unknown','Investigation ongoing.',NULL,NULL),
(3,'Rahul Mehta','Caught on CCTV near the crime scene.','Previous pickpocketing cases.',34),
(4,'Suresh Nair','Ran a fake investment company.','Charged with fraud in 2022.',45),
(5,'Deepak Singh','Attacked victim with a blunt object.','History of violent offenses.',29),
(6,'Amit Trivedi','Hacked into multiple bank accounts.','Cybercrime record in 2021.',41),
(7,'Mahesh Rao','Fled the accident scene in a white sedan.','Traffic violations in past.',36),
(8,'Ajay Bansal','Suspected of kidnapping a child.','Previously charged with child trafficking.',32),
(9,'Vivek Sharma','Caught vandalizing public property.','No previous criminal record.',27),
(10,'Karthik Iyer','Sent extortion threats via anonymous emails.','Under surveillance for past threats.',48);


-- 1. Select all open incidents
select * from Crimes WHERE Status ='Open'

-- 2. Find the total number of incidents
SELECT COUNT(*) AS TotalIncidents from Crimes

-- 3. List all unique incident types
SELECT DISTINCT IncidentType from Crimes

-- 4. Retrieve incidents between '2023-09-01' and '2023-09-10'
select * from Crimes WHERE IncidentDate between'2023-09-01'and'2023-09-10'

-- 5. List persons involved in incidents in descending order of age
Select Name, Age FROM(SELECT Name, Age FROM Victims
UNION ALL
Select Name, Age FROM Suspects) 
AS People order by Age DESC

-- 6. Find the average age of persons involved in incidents
Select AVG(Age) as AverageAge 
from (select Age from Victims
UNION ALL
select Age from Suspects) AS People

--7. List incident types and their counts, only for open cases. 
select IncidentType, COUNT(*) AS CaseCount 
from Crimes 
where Status='Open' 
group by IncidentType

--8. Find persons with names containing 'Doe'
select * from Victims Where Name LIKE '%Doe%'
union
select * from Suspects Where Name LIKE '%Doe%'

--9. Retrieve the names of persons involved in open cases and closed cases.
select v.Name AS victimname, s.Name AS suspectname, c.Status
from Crimes c
Left Join Victims v 
ON c.CrimeID=v.CrimeID
LEFT JOIN Suspects s 
ON c.CrimeID=s.CrimeID
Where c.Status IN('Open','Closed')

--10. List incident types where there are persons aged 30 or 35 involved
select DISTINCT c.IncidentType 
from Crimes c
JOIN Victims v ON c.CrimeID=v.CrimeID
WHERE v.Age IN(30,35)
Union
Select DISTINCT c.IncidentType 
from Crimes c
JOIN Suspects s ON c.CrimeID=s.CrimeID
WherE s.Age IN(30,35)

--11. Find persons involved in incidents of the same type as 'Robbery'.
Select v.Name from Victims v 
JOIN Crimes c 
ON v.CrimeID = c.CrimeID 
where c.IncidentType='Robbery'
UNION
select s.Name FROM Suspects s 
JOIN Crimes c 
ON s.CrimeID=c.CrimeID 
Where c.IncidentType='Robbery'

--12. List incident types with more than one open case
select IncidentType FROM Crimes 
where Status='Open' 
group by IncidentType 
HAVING COUNT(*)>1

--13. List all incidents with suspects whose names also appear as victims in other incidents. 
select DISTINCT c.IncidentType,s.Name AS SuspectName
From Suspects s
JOIN Victims v On s.Name=v.Name
JOIN Crimes c oN s.CrimeID=c.CrimeID

--14.  Retrieve all incidents along with victim and suspect details. 
SELECt c.CrimeID,c.IncidentType,v.Name AS Victim,s.Name AS Suspect
from Crimes c
left join Victims v ON c.CrimeID=v.CrimeID
left join Suspects s on c.CrimeID=s.CrimeID

--15. Find incidents where the suspect is older than any victim
select distinct c.CrimeID,c.IncidentType,c.IncidentDate,c.Location
from Crimes c
JOIN Victims v on c.CrimeID=v.CrimeID
JOIN Suspects s On c.CrimeID=s.CrimeID
where s.Age>v.Age

--16. Find suspects involved in multiple incidents
Select Name From Suspects 
Group by Name 
HAVING Count(CrimeID)>1

--17. List incidents with no suspects involved. 
select c.* FROM Crimes c
LEFT JOIN Suspects s ON c.CrimeID=s.CrimeID
Where s.CrimeID IS NULL

--18. List all cases where at least one incident is of type 'Homicide' and all other incidents are of type 'Robbery'. 
select * from Crimes 
where IncidentType ='Homicide' 
AND NOT EXISTS (SELECT 1 FROM Crimes WHERE IncidentType !='Homicide' AND IncidentType !='Robbery')

--19. Retrieve a list of all incidents and the associated suspects, showing suspects for each incident, or 'No Suspect' if there are none.
select c.IncidentType, isnull(s.Name,'No Suspect') AS Suspect
FROM Crimes c
LEFT JOIN Suspects s ON c.CrimeID = s.CrimeID

--20. List all suspects who have been involved in incidents with incident types 'Robbery' or 'Assault'
select Name from Suspects 
where CrimeID IN (SELECT CrimeID FROM Crimes WHERE IncidentType IN('Robbery','Assault'))


