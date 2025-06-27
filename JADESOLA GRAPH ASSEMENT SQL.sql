CREATE DATABASE customer_rentention;
# SELECT ALL DATABASE
select * from churn;
select * from transactions;
select * from user_acquisition;
select * from user_activity;

#Customer Acquisition Trends
SELECT
  month,
  acquisition_channel,
  SUM(acquisition_cost) / NULLIF(SUM(new_users), 0) AS cac
FROM user_acquisition
GROUP BY month, acquisition_channel
ORDER BY month;


#Customer Engagement Trends
SELECT month, total_transactions, total_transaction_value, avg_transaction_value
FROM transactions
ORDER BY month;


# Customer Retention Trends
SELECT 
  month, 
  total_churned_users,
  total_users_start,
  ROUND(total_churned_users * 1.0 / total_users_start, 4) AS churn_rate
FROM churn
ORDER BY month;




#KEY METRICS: CAC (Customer Acquisition Cost)
SELECT
  month,
  acquisition_channel,
  IF(SUM(new_users) = 0, NULL, SUM(acquisition_cost) / SUM(new_users)) AS cac
FROM user_acquisition
GROUP BY month, acquisition_channel
ORDER BY month;

#LTV (Customer Lifetime Value)
SELECT
  month,
  CASE 
    WHEN total_transactions = 0 THEN NULL
    ELSE (total_transaction_value / total_transactions) * 12
  END AS ltv_estimate
FROM transactions;

#churn rates 
SELECT 
  month,
  IF(total_users_start = 0, NULL, total_churned_users * 1.0 / total_users_start) AS churn_rate
FROM churn;

#Rentention rate
SELECT
  month,
  total_churned_users * 1.0 / NULLIF(total_users_start, 0) AS Rentention_rate
FROM churn;

