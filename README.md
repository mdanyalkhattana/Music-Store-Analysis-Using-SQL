
📖 ##Project Overview
This project performs a deep dive into a digital music store's database to answer critical business questions. Using PostgreSQL, I analyzed datasets containing information about artists, albums, tracks, customers, and invoices to help the store optimize its marketing strategy and understand user behavior.
🎯 ##Business Objectives
Identify the highest-grossing artists and genres to inform inventory
Analyze customer spending patterns across different countries.
Determine the most popular music genres by region to target localized ad campaigns.
Find high-value customers for loyalty program invitations.
🛠️ Tech Stack & Tools
##Database: PostgreSQL
##Interface: pgAdmin 4
Concepts Used: Joins, CTEs, Window Functions (RANK, DENSE_RANK), Subqueries, and Aggregations.
📊 ##Key Insights from the Analysis
Top Artist Performance: The artist with the most rock tracks was identified, showing a strong correlation between library size and sales.
Regional Popularity: Using PARTITION BY, I discovered that while Rock is globally dominant, specific countries show a high preference for Jazz and Metal.
Customer Segments: Identified the "Top Spender" in each country, providing a ready-to-use list for the marketing team's VIP outreach.
