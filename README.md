# DataAnalytics-Assessment
Question 1:Write a query to find customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits.


## Approach
1. First step is to identify the columns needed.
   - User ID (`owner_id`)
   - Full name (concatenation of first and last names)
   - Count of distinct savings transactions (`savings_count`)
   - Count of distinct investment plans (`investment_count`)
   - Total deposits converted from kobo to Naira (divided by 100)

2. Next to see how the table relates to one another

  - the `users_customuser` table left joins with `plans_plan` table, the result is then left joined with `savings_savingsaccount`

3. Next is to aggregate the results by user ID and name

4.  We then filter to see which user has At least 1 savings transaction (`savings_count >= 1`) AND At least 1 investment plan (`investment_count >= 1`)

5. Sort in descending order of total deposits

___________________________________________
 Question 2:Calculate the average number of transactions per customer per month and
 categorize them:

● "High Frequency" (≥10 transactions/month)

● "Medium Frequency" (3-9 transactions/month)

● "Low Frequency" (≤2 transactions/month)

## Approach
The query has two main parts:
1. An inner subquery that calculates transaction frequencies per customer
2. An outer query that aggregates these into frequency categories

INNER QUERY:
1. Joins users with their savings transactions
2. For each customer (grouped by name):
   - Calculates average transactions per month (total transactions divided by distinct months)
   - Categorizes them into:
     - High Frequency: ≥10 transactions/month
     - Medium Frequency: 3-9 transactions/month
     - Low Frequency: <3 transactions/month

OUTER QUERY:
1. Takes the results from the inner query (aliased as 't')
2. Group by the frequency categories
3. For each category calculates:
   - Number of customers
   - Average transactions per month (rounded to 2 decimal places)
  

_________________________________________

Question 3: Find all active accounts (savings or investments) with no transactions in the last 1 year (365 days).

## Approach

Two subqueries are needed (savings and investments) the  union to combine them and then filters for inactive accounts.

subquery 1:
 - Identify each savings account (`savings_id`) and its owner
- Label records as 'savings' type
- Find the most recent transaction date for each account
- Calculate days of inactivity (current date minus last transaction date)

subquery 2:
- Identify each investment plan (`id`) and its owner
- Label records as 'investment' type
- Use the plan start date as a proxy for last activity (since investment plans may not have regular transactions)

main query:
- Combine savings and investment results with UNION
- Filter for accounts with ≥365 days of inactivity
- Order results by inactivity duration (longest inactive first)
- Return distinct records to avoid duplicates
_______________________________________
 Question 4:For each customer, assuming the profit_per_transaction is 0.1% of the transaction value, calculate:

● Account tenure (months since signup)

● Total transactions

● Estimated CLV (Assume: CLV = (total_transactions / tenure) * 12 *

avg_profit_per_transaction)

● Order by estimated CLV from highest to lowest

## Approach
- Combine first and last names for easy identification.
- Measures how many months the customer has been active.
- Count all transactions.
- Calculate average profit per transaction (assuming 0.1% profit margin).
- Converts from kobo to Naira by dividing by 100.
- divide total transactions by avg profit per transaction
