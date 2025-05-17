USE adashi_staging ;

--  a query to find customers with at least one funded savings plan 
-- AND one funded investment plan, sorted by total deposits

SELECT 
    u.id AS owner_id,
    CONCAT(u.first_name, " ", u.last_name) AS name,  -- Combine first and last names into a full name
    COUNT(DISTINCT s.id) AS savings_count,           -- Count of unique savings transactions
    COUNT(DISTINCT p.id) AS investment_count,        -- Count of unique investment plans
    (SUM(s.amount)/100) AS total_deposits_in_naira   -- Sum of savings amounts converted from kobo to Naira
FROM users_customuser u
-- Join investment plans to users
LEFT JOIN plans_plan p ON u.id = p.owner_id
-- Join savings transactions to the investment plans
LEFT JOIN savings_savingsaccount s ON p.id = s.plan_id
GROUP BY u.id, name
-- Only include users who have both savings and investment records
HAVING savings_count >= 1 AND investment_count >= 1
-- Order users by total deposits in descending order
ORDER BY total_deposits_in_naira DESC;





