-- 1. Total number of tickets raised
SELECT COUNT(*) AS Total_Tickets FROM Tickets;

-- 2. Monthly ticket trend
SELECT 
    DATE_FORMAT(TicketCreationDate, '%Y-%m') AS Month,
    COUNT(*) AS Total_Tickets
FROM Tickets
GROUP BY Month
ORDER BY Month;

-- 3. Average resolution time by team
SELECT 
    TeamName,
    ROUND(AVG(TIMESTAMPDIFF(MINUTE, TicketCreationDate, ResolutionDate)), 2) AS Avg_Resolution_Time_Minutes
FROM Tickets t
JOIN Teams tm ON t.TeamID = tm.TeamID
GROUP BY TeamName
ORDER BY Avg_Resolution_Time_Minutes;

-- 4. Ticket inflow by priority
SELECT 
    Priority,
    COUNT(*) AS Ticket_Count
FROM Tickets
GROUP BY Priority
ORDER BY Ticket_Count DESC;

-- 5. Percentage of SLA breaches
SELECT 
    ROUND(SUM(CASE WHEN SLA_Breached = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS SLA_Breach_Percentage
FROM Tickets;

-- 6. Team with the highest backlog (Unresolved tickets)
SELECT 
    tm.TeamName,
    COUNT(*) AS Open_Tickets
FROM Tickets t
JOIN Teams tm ON t.TeamID = tm.TeamID
WHERE t.ResolutionDate IS NULL
GROUP BY tm.TeamName
ORDER BY Open_Tickets DESC
LIMIT 1;

-- 7. Using CTE and Date Functions: Weekly ticket inflow and resolution rate
WITH WeeklyStats AS (
    SELECT 
        YEARWEEK(TicketCreationDate, 1) AS Week,
        COUNT(*) AS Tickets_Created,
        SUM(CASE WHEN ResolutionDate IS NOT NULL THEN 1 ELSE 0 END) AS Tickets_Resolved
    FROM Tickets
    GROUP BY Week
)
SELECT 
    Week,
    Tickets_Created,
    Tickets_Resolved,
    ROUND((Tickets_Resolved / Tickets_Created) * 100, 2) AS Resolution_Rate_Percent
FROM WeeklyStats;

-- 8. Agent with highest average satisfaction score
SELECT 
    a.AgentID,
    a.AgentName,
    ROUND(AVG(r.CustomerSatisfactionScore), 2) AS Avg_Satisfaction
FROM Agents a
JOIN Tickets t ON a.AgentID = t.AgentID
JOIN ResolutionFeedback r ON t.TicketID = r.TicketID
GROUP BY a.AgentID, a.AgentName
ORDER BY Avg_Satisfaction DESC
LIMIT 1;

-- 9. Daily average tickets by category (Using GROUP BY and date functions)
SELECT 
    DATE(TicketCreationDate) AS Date,
    Category,
    COUNT(*) AS Ticket_Count
FROM Tickets
GROUP BY Date, Category
ORDER BY Date, Category;

-- 10. Resolution time trend over time (Using DATE_FORMAT)
SELECT 
    DATE_FORMAT(ResolutionDate, '%Y-%m') AS Month,
    ROUND(AVG(TIMESTAMPDIFF(MINUTE, TicketCreationDate, ResolutionDate)), 2) AS Avg_Resolution_Time_Minutes
FROM Tickets
WHERE ResolutionDate IS NOT NULL
GROUP BY Month
ORDER BY Month;

-- 11. Churned vs Retained agents based on average feedback
SELECT 
    a.AgentID,
    a.AgentName,
    ROUND(AVG(r.CustomerSatisfactionScore), 2) AS Avg_Feedback,
    CASE 
        WHEN ROUND(AVG(r.CustomerSatisfactionScore), 2) < 3 THEN 'Needs Improvement'
        ELSE 'Retained'
    END AS Status
FROM Agents a
JOIN Tickets t ON a.AgentID = t.AgentID
JOIN ResolutionFeedback r ON t.TicketID = r.TicketID
GROUP BY a.AgentID, a.AgentName
ORDER BY Avg_Feedback;


