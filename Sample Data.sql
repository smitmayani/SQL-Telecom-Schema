-- Sample Data Population
-- Insert sample data into CUSTOMER
INSERT INTO CUSTOMER (Name, PhoneNumber, Email, JoinDate, CustomerType, CreditRating) VALUES
('John Smith', '5551234567', 'john.smith@email.com', '2022-01-15', 'Individual', 720),
('Acme Corp', '5552345678', 'contact@acme.com', '2021-11-03', 'Business', 780),
('Sarah Johnson', '5553456789', 'sarah.j@email.com', '2023-02-20', 'Individual', 650),
('XYZ Enterprises', '5554567890', 'info@xyz.com', '2020-05-10', 'Business', 820);
-- Insert sample data into SERVICE_PLAN
INSERT INTO SERVICE_PLAN (PlanName, MonthlyPrice, DataLimitGB, CallLimitMins, SMSLimit, RoamingPolicy, ThrottleSpeed) VALUES
('Basic', 29.99, 5, 300, 100, 'Domestic only', '512Kbps after limit'),
('Premium', 59.99, 20, 1000, 500, 'North America included', '1Mbps after limit'),
('Unlimited', 89.99, 50, -1, -1, 'Global roaming', '2Mbps after limit'),
('Business Pro', 149.99, 100, -1, -1, 'Global roaming', 'No throttle');
-- Insert sample data into SUBSCRIPTION
INSERT INTO SUBSCRIPTION (CustomerID, PlanID, PhoneNumber, IMEI, SIMNumber, StartDate, EndDate, Status) VALUES
(1, 2, '5551112222', '123456789012345', 'SIM12345', '2023-01-01', NULL, 'Active'),
(2, 4, '5552223333', '234567890123456', 'SIM23456', '2022-06-01', NULL, 'Active'),
(3, 1, '5553334444', '345678901234567', 'SIM34567', '2023-03-15', NULL, 'Active'),
(4, 3, '5554445555', '456789012345678', 'SIM45678', '2021-08-01', '2023-08-01', 'Terminated');
-- Insert sample data into NETWORK_ELEMENT
INSERT INTO NETWORK_ELEMENT (TowerID, Type, Location, CallCapacity, DataCapacity, Technology) VALUES
('TOWER001', 'Cell Tower', '40.7128,-74.0060', 1000, 1000.00, '5G'),
('TOWER002', 'Cell Tower', '34.0522,-118.2437', 800, 800.00, 'LTE'),
('SWITCH001', 'Switch', 'Main Data Center', NULL, 10000.00, 'Fiber'),
('ROUTER001', 'Router', 'Central Office', NULL, 5000.00, 'MPLS');
-- Insert sample data into DATA_USAGE
INSERT INTO DATA_USAGE (SubscriptionID, StartTime, EndTime, DataUsedMB, NetworkType, TowerID) VALUES
(1, '2023-06-01 08:15:30', '2023-06-01 09:30:45', 256.75, '5G', 'TOWER001'),
(1, '2023-06-01 12:30:00', '2023-06-01 13:45:00', 512.30, 'LTE', 'TOWER002'),
(2, '2023-06-01 09:00:00', '2023-06-01 17:00:00', 2048.90, '5G', 'TOWER001'),
(3, '2023-06-01 18:30:00', '2023-06-01 20:15:00', 128.45, 'LTE', 'TOWER002');
-- Insert sample data into CALL_RECORD
INSERT INTO CALL_RECORD (SubscriptionID, StartTime, EndTime, CallType, Direction, TowerID) VALUES
(1, '2023-06-01 10:15:00', '2023-06-01 10:30:45', 'Voice', 'Outgoing', 'TOWER001'),
(1, '2023-06-01 14:20:00', '2023-06-01 14:35:30', 'Video', 'Incoming', 'TOWER002'),
(2, '2023-06-01 11:00:00', '2023-06-01 11:45:00', 'Voice', 'Outgoing', 'TOWER001'),
(3, '2023-06-01 19:00:00', '2023-06-01 19:15:30', 'Voice', 'Incoming', 'TOWER002');
-- Insert sample data into SMS_RECORD
INSERT INTO SMS_RECORD (SubscriptionID, Timestamp, Recipient, Status, Direction, TowerID) VALUES
(1, '2023-06-01 09:00:00', '5559998888', 'Delivered', 'Outgoing', 'TOWER001'),
(1, '2023-06-01 13:30:00', '5551112222', 'Delivered', 'Incoming', 'TOWER002'),
(2, '2023-06-01 10:30:00', '5557776666', 'Delivered', 'Outgoing', 'TOWER001'),
(3, '2023-06-01 20:00:00', '5553334444', 'Delivered', 'Incoming', 'TOWER002');
-- Insert sample data into BILL
INSERT INTO BILL (SubscriptionID, PeriodStart, PeriodEnd, DueDate, PaidAmount, Status) VALUES
(1, '2023-05-01', '2023-05-31', '2023-06-15', 59.99, 'Paid'),
(1, '2023-06-01', '2023-06-30', '2023-07-15', 0.00, 'Unpaid'),
(2, '2023-05-01', '2023-05-31', '2023-06-15', 149.99, 'Paid'),
(3, '2023-05-01', '2023-05-31', '2023-06-15', 29.99, 'Overdue');
-- Insert sample data into SUPPORT_TICKET
INSERT INTO SUPPORT_TICKET (CustomerID, IssueType, OpenDate, Priority, Status) VALUES
(1, 'Billing Question', '2023-06-01 09:15:00', 'Medium', 'Resolved'),
(2, 'Network Outage', '2023-06-02 14:30:00', 'High', 'In Progress'),
(3, 'Plan Upgrade', '2023-06-03 10:45:00', 'Low', 'Open'),
(1, 'Data Speed Issue', '2023-06-05 16:20:00', 'Medium', 'Open');