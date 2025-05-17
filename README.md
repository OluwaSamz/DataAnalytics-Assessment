# DataAnalytics-Assessment
Question 1:Write a query to find customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits.



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
