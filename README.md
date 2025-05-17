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
### Question 2:Calculate the average number of transactions per customer per month and
## categorize them:

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
2. Groups by the frequency categories
3. For each category calculates:
   - Number of customers
   - Average transactions per month (rounded to 2 decimal places)
