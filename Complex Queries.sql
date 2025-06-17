-- 📊 1. Calculate Detailed Monthly Bill (Including Overages on Data, Call, SMS)
SELECT 
    c.Name,
    sp.PlanName,
    sp.MonthlyPrice,
    IFNULL(us.TotalDataUsedMB, 0) AS TotalDataUsedMB,
    IFNULL(cr.TotalCallMinutes, 0) AS TotalCallMinutes,
    IFNULL(sm.TotalSMS, 0) AS TotalSMS,
    ROUND(
        sp.MonthlyPrice +
        GREATEST(IFNULL(us.TotalDataUsedMB, 0) - (sp.DataLimitGB * 1024), 0) * 0.01 +
        GREATEST(IFNULL(cr.TotalCallMinutes, 0) - sp.CallLimitMins, 0) * 0.05 +
        GREATEST(IFNULL(sm.TotalSMS, 0) - sp.SMSLimit, 0) * 0.10,
        2
    ) AS EstimatedBill
FROM CUSTOMER AS c
JOIN SUBSCRIPTION AS s ON c.CustomerID = s.CustomerID
JOIN SERVICE_PLAN AS sp ON s.PlanID = sp.PlanID
LEFT JOIN (
    SELECT SubscriptionID, SUM(DataUsedMB) AS TotalDataUsedMB
    FROM DATA_USAGE
    WHERE StartTime BETWEEN '2023-06-01' AND '2023-06-30'
    GROUP BY SubscriptionID
) us ON us.SubscriptionID = s.SubscriptionID
LEFT JOIN (
    SELECT SubscriptionID, 
           SUM(TIMESTAMPDIFF(MINUTE, StartTime, EndTime)) AS TotalCallMinutes
    FROM CALL_RECORD
    WHERE StartTime BETWEEN '2023-06-01' AND '2023-06-30'
    GROUP BY SubscriptionID
) cr ON cr.SubscriptionID = s.SubscriptionID
LEFT JOIN (
    SELECT SubscriptionID, COUNT(*) AS TotalSMS
    FROM SMS_RECORD
    WHERE Timestamp BETWEEN '2023-06-01' AND '2023-06-30'
    GROUP BY SubscriptionID
) sm ON sm.SubscriptionID = s.SubscriptionID
WHERE s.Status = 'Active';

-- 📞 2. Analyze Calling Patterns: Most Frequently Used Tower per Customer


SELECT 
    c.Name,
    s.PhoneNumber,
    cr.TowerID,
    COUNT(*) AS CallCount
FROM CUSTOMER AS c
JOIN SUBSCRIPTION AS s ON c.CustomerID = s.CustomerID
JOIN CALL_RECORD AS cr ON s.SubscriptionID = cr.SubscriptionID
GROUP BY c.Name, s.PhoneNumber, cr.TowerID
HAVING CallCount = (
    SELECT MAX(subcount)
    FROM (
        SELECT COUNT(*) AS subcount
        FROM CALL_RECORD AS cr2
        WHERE cr2.SubscriptionID = s.SubscriptionID
        GROUP BY cr2.TowerID
    ) AS subquery
)
ORDER BY c.Name;

-- 💎 3. Identify High-Value Customers by Total Data + Call Usage
SELECT 
    c.CustomerID,
    c.Name,
    ROUND(IFNULL(SUM(d.DataUsedMB), 0) / 1024, 2) AS TotalDataGB,
    SUM(TIMESTAMPDIFF(MINUTE, cr.StartTime, cr.EndTime)) AS TotalCallMinutes
FROM CUSTOMER AS c
LEFT JOIN SUBSCRIPTION AS s ON c.CustomerID = s.CustomerID
LEFT JOIN DATA_USAGE AS d ON s.SubscriptionID = d.SubscriptionID
LEFT JOIN CALL_RECORD AS cr ON s.SubscriptionID = cr.SubscriptionID
GROUP BY c.CustomerID, c.Name
ORDER BY (SUM(DataUsedMB) + SUM(TIMESTAMPDIFF(MINUTE, cr.StartTime, cr.EndTime))) DESC
LIMIT 5;


-- 🌐 4. Top 2 Towers by Total Data Transferred in June 2023
SELECT 
    ne.TowerID,
    ne.Location,
    ROUND(SUM(d.DataUsedMB) / 1024, 2) AS TotalDataGB
FROM DATA_USAGE AS d
JOIN NETWORK_ELEMENT AS ne ON d.TowerID = ne.TowerID
WHERE d.StartTime BETWEEN '2023-06-01' AND '2023-06-30'
GROUP BY ne.TowerID, ne.Location
ORDER BY TotalDataGB DESC
LIMIT 2;



