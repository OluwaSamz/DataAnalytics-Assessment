USE adashi_staging;

SELECT 
    u.id AS customer_id,
    CONCAT(u.first_name, " ", u.last_name) AS name,  -- Combine first and last names for full customer name

    -- Calculate how many months the customer has been active (tenure)
    TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) AS tenure_months,

    COUNT(s.id) AS total_transactions,  -- Total number of savings transactions

    -- Calculate average profit per transaction (0.1% of amount), then convert kobo to Naira by dividing by 100
    (AVG(0.001 * s.amount) / 100) AS avg_profit_per_transaction_in_naira,

    -- Estimate CLV using: (monthly transactions) * 12 * avg profit
    ROUND(
        (
            COUNT(s.id) / NULLIF(TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()), 0)  -- Avoid division by zero
        ) * 12 * AVG(0.001 * s.amount),  -- Use 0.1% of transaction value as profit
        2
    ) AS estimated_clv  -- Final customer lifetime value estimate, rounded to 2 decimal places

FROM users_customuser u
JOIN savings_savingsaccount s ON u.id = s.owner_id  -- Join savings data to user accounts

GROUP BY u.id, tenure_months  -- Group by customer and tenure for aggregation

ORDER BY estimated_clv DESC;  -- Rank customers by highest CLV
