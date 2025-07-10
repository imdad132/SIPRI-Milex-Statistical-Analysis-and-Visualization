# 1. Load Libraries
This section loads the necessary R packages:

readxl for reading Excel files.
dplyr for data manipulation.
ggplot2 for creating plots.
tidyr for reshaping data.
stringr for string operations (though not used directly in this script).

# 2. Load and Prepare Regional Military Spending Data
The script reads an Excel sheet containing military spending data by region. It selects only the columns for the years 1988 to 2024 and reshapes the data from wide format (one column per year) to long format (one row per year per region). This makes it easier to analyze and visualize.

# 3. Identify Top 5 Regions by Total Spending
It calculates the total military spending for each region across all years, ranks them in descending order, and selects the top 5 regions with the highest total spending.

# 4. Plot Top 5 Regions
This part creates a line plot showing how military spending has changed over time for the top 5 regions. Each region is represented by a different color line.

## Line Plot of Top 5 Regions by Military Spending
Purpose:
To show how military spending has changed over time (1988–2024) for the five regions with the highest total spending.

Key Features:
X-axis: Year
Y-axis: Military spending (in USD billions)
Color: Each line represents a different region
Line Thickness: Emphasizes trends clearly
Theme: theme_minimal() for a clean, modern look
What You Can Learn:
Which regions consistently spend the most
Whether spending is increasing, decreasing, or stable
How regions compare to each other over time

# 5. Analyze Western Europe: Share of GDP and Government Spending
The script reads two more sheets from the Excel file: one showing military spending as a percentage of GDP, and another as a percentage of government spending. It filters the data to include only Western European countries and reshapes both datasets into long format.

# 6. Merge and Compute Averages
It merges the two datasets (GDP share and government spending share) by country and year. Then, it calculates the average values for each year across all Western European countries.

# 7. Visualize Correlation
Finally, the script reshapes the average data again to prepare it for plotting. It creates a line plot showing the trends of average military spending as a share of GDP and as a share of government spending over time, allowing for visual comparison.

## Correlation Plot: Share of GDP vs. Share of Government Spending
Purpose:
To compare two economic indicators of military spending in Western Europe:

Military spending as a percentage of GDP
Military spending as a percentage of government spending
Key Features:
X-axis: Year
Y-axis: Average share (percentage)
Color: One line for each metric
Legend: Clearly distinguishes between the two metrics
Custom Colors: Purple for GDP share, red for government share
Legend Position: At the bottom for better readability
What You Can Learn:
Whether military spending is becoming a larger or smaller part of the economy
How closely the two metrics move together (i.e., correlation)
Periods of divergence or convergence between the two indicators
