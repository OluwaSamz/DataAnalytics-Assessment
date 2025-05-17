USE `adashi_staging`;

SELECT 
    frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_trnscn_per_month), 2) AS avg_transactions_per_month
FROM
-- subquery
(
SELECT
	CASE 
        WHEN COUNT(s.id) / COUNT(DISTINCT DATE_FORMAT(s.transaction_date, '%Y-%m')) >= 10 THEN 'High Frequency'
        WHEN COUNT(s.id) / COUNT(DISTINCT DATE_FORMAT(s.transaction_date, '%Y-%m')) BETWEEN 3 AND 9 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS frequency_category,
    concat(u.first_name," ",u.last_name) as customer_name,
    COUNT(s.id) / COUNT(DISTINCT DATE_FORMAT(s.transaction_date, '%Y-%m')) AS avg_trnscn_per_month 
FROM users_customuser u
LEFT JOIN savings_savingsaccount s ON s.owner_id = u.id
GROUP BY customer_name
-- ORDER BY 3 DESC
) AS t
group by frequency_category;


SELECT 
    frequency_category,
    COUNT(*) AS customer_count,  -- Total number of customers in each frequency category
    ROUND(AVG(avg_trnscn_per_month), 2) AS avg_transactions_per_month  -- Average monthly transactions per category
FROM
(
    SELECT
        -- Categorize users based on their average monthly transaction count
        CASE 
            WHEN COUNT(s.id) / COUNT(DISTINCT DATE_FORMAT(s.transaction_date, '%Y-%m')) >= 10 THEN 'High Frequency'
            WHEN COUNT(s.id) / COUNT(DISTINCT DATE_FORMAT(s.transaction_date, '%Y-%m')) BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category,
        
        CONCAT(u.first_name, " ", u.last_name) AS customer_name,  -- Create full name for grouping
        
        -- Calculate average number of transactions per month
        COUNT(s.id) / COUNT(DISTINCT DATE_FORMAT(s.transaction_date, '%Y-%m')) AS avg_trnscn_per_month
    FROM users_customuser u
    LEFT JOIN savings_savingsaccount s ON s.owner_id = u.id  -- Link transactions to their owners
    GROUP BY customer_name  -- Group by individual customer
    -- ORDER BY 3 DESC  -- Optional: Uncomment to sort by avg_trnscn_per_month
) AS t
GROUP BY frequency_category;  -- Final grouping by frequency category






