-- 🔍 1. Retrieve Full Customer Information with Active Subscription Details
SELECT 
    c.CustomerID, c.Name, c.Email, c.PhoneNumber,
    s.SubscriptionID, s.PhoneNumber AS SubscriptionPhone, s.Status,
    p.PlanName, p.MonthlyPrice
FROM CUSTOMER AS c
JOIN SUBSCRIPTION s ON c.CustomerID = s.CustomerID
JOIN SERVICE_PLAN p ON s.PlanID = p.PlanID
WHERE s.Status = 'Active';

-- 📈 2. Analyze Monthly Data Usage per Customer (June 2023)

SELECT 
    c.Name,
    SUM(d.DataUsedMB) AS TotalDataMB,
    COUNT(d.DataID) AS Sessions,
    MONTH(d.StartTime) AS Month,
    YEAR(d.StartTime) AS Year
FROM CUSTOMER AS c
JOIN SUBSCRIPTION AS s ON c.CustomerID = s.CustomerID
JOIN DATA_USAGE AS d ON s.SubscriptionID = d.SubscriptionID
WHERE d.StartTime BETWEEN '2023-06-01' AND '2023-06-30'
GROUP BY c.Name, Month, Year
ORDER BY TotalDataMB DESC;

-- 💬 3. Total Outgoing SMS Per Customer
SELECT 
    c.Name, COUNT(*) AS OutgoingSMSCount
FROM CUSTOMER AS c
JOIN SUBSCRIPTION AS s ON c.CustomerID = s.CustomerID
JOIN SMS_RECORD AS sms ON s.SubscriptionID = sms.SubscriptionID
WHERE sms.Direction = 'Outgoing'
GROUP BY c.Name;

-- 🧾 4. Detailed Billing History for a Specific Customer (e.g., John Smith)
SELECT 
    c.Name, b.BillID, b.PeriodStart, b.PeriodEnd, b.DueDate, 
    b.PaidAmount, b.Status
FROM CUSTOMER AS c
JOIN SUBSCRIPTION AS s ON c.CustomerID = s.CustomerID
JOIN BILL AS b ON s.SubscriptionID = b.SubscriptionID
WHERE c.Name = 'John Smith'
ORDER BY b.DueDate DESC;

-- 🧠 5. Identify High-Value Customers (Spending > $100 in May 2023)
SELECT 
    c.CustomerID, c.Name, SUM(b.PaidAmount) AS TotalSpent
FROM CUSTOMER AS c
JOIN SUBSCRIPTION AS s ON c.CustomerID = s.CustomerID
JOIN BILL AS b ON s.SubscriptionID = b.SubscriptionID
WHERE b.PeriodStart = '2023-05-01'
GROUP BY c.CustomerID, c.Name
HAVING TotalSpent > 100;


-- 📞 6. Call Pattern Analysis: Average Call Duration Per Type
SELECT 
    CallType,
    AVG(TIMESTAMPDIFF(SECOND, StartTime, EndTime)) / 60 AS AvgDurationMins
FROM CALL_RECORD
GROUP BY CallType;


-- 🗼 7. Data Usage Load by Tower and Network Type
SELECT 
    d.TowerID, ne.Location, d.NetworkType, 
    SUM(d.DataUsedMB) AS TotalDataMB
FROM DATA_USAGE AS d
JOIN NETWORK_ELEMENT AS ne ON d.TowerID = ne.TowerID
GROUP BY d.TowerID, d.NetworkType, ne.Location
ORDER BY TotalDataMB DESC;

-- 🧾 8. Subscriptions with Overdue or Unpaid Bills
SELECT 
    c.Name, s.SubscriptionID, b.BillID, b.Status, b.DueDate
FROM BILL AS b
JOIN SUBSCRIPTION AS s ON b.SubscriptionID = s.SubscriptionID
JOIN CUSTOMER AS c ON s.CustomerID = c.CustomerID
WHERE b.Status IN ('Unpaid', 'Overdue');

-- 🚨 9. Customers with Open High Priority Tickets
SELECT 
    c.Name, t.TicketID, t.IssueType, t.Priority, t.Status
FROM SUPPORT_TICKET AS t
JOIN CUSTOMER AS c ON t.CustomerID = c.CustomerID
WHERE t.Status = 'Open' AND t.Priority = 'High';



