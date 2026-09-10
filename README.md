# 🚗 Car Manufacturing SQL Analysis — SQL Server Project

A SQL-based analysis of a car sales dataset using **Microsoft SQL Server**. This project covers aggregate functions, `GROUP BY`, `HAVING`, subqueries, and window functions to answer real business questions about pricing, sales performance, and manufacturer comparisons.

---

## 📊 Dataset

**Table:** `CarSales` (database: `Manufacture`)

Columns used in this project:

| Column | Description |
|---|---|
| Manufacturer | Car brand |
| Model | Model name |
| Sales_in_thousands | Units sold (in thousands) |
| Price_in_thousands | List price (in thousands USD) |
| Vehicle_type | Vehicle category |
| Horsepower | Engine horsepower |

---

## 🛠️ Tech Stack

- **Database:** Microsoft SQL Server
- **Tool:** SQL Server Management Studio (SSMS)
- **Language:** T-SQL

---

## 📁 Project Structure

```
├── Car_sales.csv     # Raw dataset
├── Project2.sql      # Full SQL script (all queries)
└── README.md          # Project documentation
```

---

## 🚀 Setup & Usage

1. Create/select the database:
   ```sql
   USE Manufacture;
   ```
2. Ensure the `CarSales` table is created and populated (import `Car_sales.csv` via SSMS's Import Flat File wizard, or `BULK INSERT`).
3. Verify the data:
   ```sql
   SELECT * FROM CarSales;
   ```
4. Run the queries in `Project2.sql` section by section.

---

## 🔍 Queries in This Project

### Basic Filtering & Sorting
- Cars priced under 20 (thousand)
- All Toyota models
- Models sorted by best-selling (`ORDER BY Sales_in_thousands DESC`)

### Aggregate Functions (COUNT, SUM, AVG, MIN, MAX)
- Total number of car models
- Total sales across all models
- Average price of all cars
- Cheapest and most expensive car overall
- Cheapest and most expensive car for a specific manufacturer (Toyota)

### GROUP BY
- Count of models per manufacturer
- Average price per manufacturer
- Average horsepower per vehicle type
- Min/max price per manufacturer
- Manufacturers ranked by total sales (highest first)
- Manufacturers ranked by average price (lowest first)

### HAVING
- Manufacturers with total sales above 100 (thousand units)

### Subqueries
1. Models priced above the overall average price *(flag premium-tier models)*
2. Manufacturers whose average price is above the company-wide average *(premium vs. mass-market brands)*
3. The single best-selling model in the dataset *(flagship model)*
4. Models priced above their own manufacturer's average price — correlated subquery *(which models pull a brand's average up)*

### Window Functions
1. `RANK()` — every model's sales rank within its own manufacturer
2. Top-selling model per manufacturer (flagship report), using `RANK()` in a subquery
3. Running total of sales across all models, ordered highest to lowest
4. Each model's price vs. its manufacturer's average price, using `AVG() OVER (PARTITION BY ...)`

---

## 💡 Key Insights

- Identified top-performing manufacturers by total sales volume.
- Flagged premium-priced models relative to both the overall market and their own brand average.
- Built a "flagship model per manufacturer" report using window functions.
- Compared each manufacturer's pricing and sales positioning side by side.

---

## 📌 Future Improvements

- Add data visualization (Power BI / Tableau) on top of these queries.
- Wrap frequently used queries into views or stored procedures.
- Expand with resale value and fuel efficiency analysis if those columns are included.

---

## 👤 Author

"Rishi Rokde"
Data Analyst|Aspiring Data Engineer 

