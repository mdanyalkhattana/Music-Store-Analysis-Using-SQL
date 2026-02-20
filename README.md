
# 🎵 Music Store Data Analysis (SQL)

## 📖 Project Overview

This project presents an in-depth analysis of a digital music store database to answer key business questions. Using PostgreSQL, the dataset containing information about artists, albums, tracks, customers, and invoices was explored to uncover actionable insights.

The goal of this analysis is to support data-driven decision-making for marketing, customer targeting, and inventory planning.

---

## 🎯 Business Objectives

* Identify the highest-grossing artists and genres to guide inventory strategy.
* Analyze customer spending behavior across different countries.
* Determine the most popular music genres by region for localized marketing campaigns.
* Detect high-value customers suitable for loyalty and VIP programs.

---

## 🛠️ Tech Stack & Tools

 **Database:** PostgreSQL
 **Interface:** pgAdmin 4 
 **SQL Concepts Used:**

  * Joins
  * Common Table Expressions (CTEs)
  * Window Functions (RANK, DENSE_RANK)
  * Subqueries
  * Aggregations

---

## 📊 Key Insights

### 🔹 Top Artist Performance

The analysis identified the artist with the highest number of rock tracks. Results indicate a strong relationship between catalog size and overall sales performance.

### 🔹 Regional Genre Preferences

Using `PARTITION BY`, the analysis revealed that while Rock dominates globally, certain countries show a stronger preference for Jazz and Metal. This insight can help tailor region-specific marketing campaigns.

### 🔹 Customer Segmentation

The top-spending customer in each country was identified, producing a ready-to-use VIP customer list for targeted marketing and loyalty programs.

---


## 📌 Future Improvements

* Build an interactive dashboard in Power BI.
* Add cohort and retention analysis.
* Create automated reporting pipelines.

---

