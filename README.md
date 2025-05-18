IT-Service-Desk-Ticket-Analytics

This project demonstrates how customer service analytics and interaction data can be leveraged to understand customer churn, satisfaction, and service quality. It simulates a Business Analyst’s workflow using Excel, SQL, and Power BI to extract insights, answer business questions, and visualize KPIs.
---

## 📊 Project Overview

This project simulates a helpdesk analytics use case, where a business analyst is responsible for evaluating:
- Customer churn
- Agent efficiency
- Customer satisfaction
- Support interaction trends

The goal is to create a 360° view of customer support interactions to improve retention and service quality.

---

## 🧾 Dataset Description

The project uses 5 tables:

### `Customers`
| Column Name  | Description                     |
|--------------|----------------------------------|
| CustomerID   | Unique customer identifier       |
| FirstName    | Customer's first name            |
| LastName     | Customer's last name             |
| Age          | Customer's age                   |
| Start_Date   | Customer onboarding date         |
| Churn        | 1 = Churned, 0 = Active          |

### `Subscriptions`
| Column Name        | Description                        |
|--------------------|------------------------------------|
| CustomerID         | Foreign key to Customers           |
| Plan_Type          | Subscription type (Basic, Pro etc.)|
| Payment_Method     | Card, Wallet, NetBanking, etc.     |
| Subscription_Date  | Start date of subscription         |
| Contract_Type      | Monthly, Yearly                    |
| Monthly_Charges    | Charges per month (in USD)         |

### `Interactions`
| Column Name             | Description                         |
|-------------------------|-------------------------------------|
| InteractionID           | Unique interaction ID               |
| CustomerID              | Foreign key to Customers            |
| Interaction_Date        | Date of interaction                 |
| Interaction_Type        | Call, Chat, Email, etc.             |
| Resolution_Time_Minutes| Time taken to resolve (in minutes)  |
| AgentID                 | Assigned support agent              |

### `Agents`
| Column Name   | Description                |
|---------------|----------------------------|
| AgentID       | Unique identifier          |
| AgentName     | Support agent name         |
| Region        | Working region             |

### `Satisfaction_Score`
| Column Name      | Description                    |
|------------------|--------------------------------|
| InteractionID    | Foreign key to Interactions    |
| Rating           | Customer rating (1 to 5)       |

---

## 🛠 Tools Used

- **MySQL** – Data querying and transformation
- **Excel** – Raw data handling and dashboarding
- **Power BI** – Interactive visual dashboards
- **GitHub** – Version control and portfolio hosting

---

## 🎯 Objectives

- Identify key reasons for customer churn
- Track agent performance across regions
- Evaluate customer satisfaction trends
- Analyze interaction load and resolution time
- Create dashboards for reporting

---

## 📌 Key KPIs & Metrics

- Monthly churn trend
- Churn % by region and gender
- Average satisfaction score per agent
- Resolution time distribution
- Total interactions per month
- Churned customers with highest spend

---

## 💻 SQL Queries

All queries used for analysis are available in the [`sql/customer_360_queries.sql`](sql/customer_360_queries.sql) file.

Highlights:
- CTEs for aggregating satisfaction by agent
- Window functions for churn trend
- JOINs to connect multiple tables
- CASE statements for churn flagging
- DATE functions to calculate monthly metrics

---

## 📈 Dashboards

### 📊 Power BI Dashboard
Interactive Power BI dashboard visualizing:
- Monthly churn trend
- Top 10 churned customers
- Agent-wise satisfaction
- Region-wise performance

➡️ [Customer_360_PowerBI.pbix](dashboards/Customer_360_PowerBI.pbix)

---

### 📊 Excel Dashboard

Includes:
- Pivot tables
- Heatmaps
- Bar & Line charts
- KPI cards

➡️ [Customer_360_Excel_Dashboard.xlsx](dashboards/Customer_360_Excel_Dashboard.xlsx)

---

## 📌 Insights & Recommendations

- Customers with high monthly charges had a higher churn rate.
- Region B experienced the highest churn, likely due to longer resolution times.
- Agents with the highest satisfaction score resolved tickets in under 15 minutes.
- Yearly contract customers churned 40% less than monthly ones.
- Interaction type "Chat" had quicker resolution but lower satisfaction than calls.

---

