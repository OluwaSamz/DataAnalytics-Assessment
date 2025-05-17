USE adashi_staging;

SELECT DISTINCT plan_id, owner_id, type, last_transaction_date, inactivity_days
FROM (
    -- First part: Subquery to Get last transaction date and inactivity days for savings accounts
    SELECT 
        s.savings_id AS plan_id,  -- Use savings ID as plan ID
        s.owner_id AS owner_id,   -- Owner of the savings plan
        'savings' AS type,        -- Label this record as a savings type
        MAX(s.transaction_date) AS last_transaction_date,  -- Most recent transaction
        DATEDIFF(CURDATE(), MAX(s.transaction_date)) AS inactivity_days  -- Days since last transaction
    FROM savings_savingsaccount s
    GROUP BY s.savings_id, s.owner_id  -- Group by each savings account

    UNION

    -- Use plan start_date as a proxy for last activity on investment plans
    SELECT 
        p.id AS plan_id,         -- plan_id
        p.owner_id,              -- customer_id
        'investment' AS type,    -- Label this record as an investment type
        MAX(p.start_date) AS last_transaction_date,  -- Use plan start date as last activity
        DATEDIFF(CURDATE(), MAX(p.start_date)) AS inactivity_days  -- Days since plan started
    FROM plans_plan p
    GROUP BY p.id, p.owner_id
) AS t
-- Filter for inactive accounts with No transaction activity in the last 365 days
WHERE inactivity_days >= 365
-- Order by how long the account has been inactive
ORDER BY inactivity_days;

