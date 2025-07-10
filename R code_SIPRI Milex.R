# Install the readxl package 
install.packages("readxl")

library(readxl)      # For reading Excel files
library(dplyr)       # For data manipulation
library(ggplot2)     # For plotting
library(tidyr)       # For reshaping data
library(stringr)     # For string operations


df <- read_excel("C:/Users/imdad/OneDrive/Desktop/SIPRI-Milex-data-1974-2024.xlsx", sheet = "Regional totals")

# View the first few rows
head(df)

# Keep only year columns and Region
year_cols <- as.character(1988:2024)
df_filtered <- df %>%
  select(Region, all_of(year_cols)) %>%
  filter(!is.na(Region))

# First, convert all year column names to character
colnames(df_filtered) <- c("Region", as.character(1988:2024))

# Now pivot to long format
df_long <- df_filtered %>%
  pivot_longer(
    cols = -Region,
    names_to = "Year",
    values_to = "Spending"
  ) %>%
  mutate(Year = as.integer(Year))

# Summarize total spending per region and get top 5
top_regions <- df_long %>%
  group_by(Region) %>%
  summarise(Total_Spending = sum(Spending, na.rm = TRUE)) %>%
  arrange(desc(Total_Spending)) %>%
  slice(1:5) %>%
  pull(Region)

# Filter for top 5 regions
df_top5 <- df_long %>%
  filter(Region %in% top_regions)

# Plot
ggplot(df_top5, aes(x = Year, y = Spending, color = Region)) +
  geom_line(size = 2) +
  labs(title = "Top 5 Regions by Military Spending (1988–2024)",
       x = "Year", y = "Military Spending (USD-Billions)",
       color = "Region") +
  theme_minimal()


# Set the path to your SIPRI Excel file
file_path <- "C:/Users/imdad/OneDrive/Desktop/SIPRI-Milex-data-1974-2024.xlsx"

# Load the relevant sheets
gdp_data <- read_excel(file_path, sheet = "Share of GDP")
gov_data <- read_excel(file_path, sheet = "Share of Govt. spending")


# Convert year columns to character for consistency
year_cols <- as.character(1988:2024)

western_europe <- c(
  "Austria", "Belgium", "France", "Germany", "Ireland", "Italy",
  "Luxembourg", "Netherlands", "Portugal", "Spain", "Switzerland", "United Kingdom"
)


# Filter GDP data
gdp_df <- gdp_data %>%
  filter(Country %in% western_europe) %>%
  select(Country, all_of(year_cols)) %>%
  pivot_longer(-Country, names_to = "Year", values_to = "Share_GDP") %>%
  mutate(Year = as.integer(Year))

# Filter Government Spending data
gov_df <- gov_data %>%
  filter(Country %in% western_europe) %>%
  select(Country, all_of(year_cols)) %>%
  pivot_longer(-Country, names_to = "Year", values_to = "Share_Gov") %>%
  mutate(Year = as.integer(Year))

merged_df <- left_join(gdp_df, gov_df, by = c("Country", "Year"))

avg_df <- merged_df %>%
  group_by(Year) %>%
  summarise(
    Avg_Share_GDP = mean(Share_GDP, na.rm = TRUE),
    Avg_Share_Gov = mean(Share_Gov, na.rm = TRUE)
  ) %>%
  drop_na()

unique(avg_long$Metric)

str(avg_df)

str(gdp_df)
str(gov_df)


gdp_df <- gdp_df %>%
  mutate(Share_GDP = as.numeric(Share_GDP))

# Convert Share_Gov to numeric (in-place)
gov_df <- gov_df %>%
  mutate(Share_Gov = as.numeric(Share_Gov))


# Join and compute averages
merged_df <- inner_join(gdp_df, gov_df, by = c("Country", "Year"))

avg_df <- merged_df %>%
  group_by(Year) %>%
  summarise(
    Avg_Share_GDP = mean(Share_GDP, na.rm = TRUE),
    Avg_Share_Gov = mean(Share_Gov, na.rm = TRUE)
  ) %>%
  ungroup()

# Check output
head(avg_df)


# Reshape and Plot Correlation Graph (Final Fix)

# Rename columns to match legend labels before plotting
avg_long <- avg_df %>%
  pivot_longer(cols = c(Avg_Share_GDP, Avg_Share_Gov),
               names_to = "Metric",
               values_to = "Value") %>%
  mutate(Metric = recode(Metric,
                         "Avg_Share_GDP" = "Share of GDP",
                         "Avg_Share_Gov" = "Share of Govt Spending"))

# Plot
ggplot(avg_long, aes(x = Year, y = Value, color = Metric)) +
  geom_line(size = 2) +
  labs(
    title = "Correlation between Share of GDP and Share of Govt Spending (Western Europe_1988-2024)",
    x = "Year",
    y = "Average Share",
    color = "Metric"
  ) +
  scale_color_manual(
    values = c("Share of GDP" = "purple", "Share of Govt Spending" = "red")
  ) +
  theme_minimal() +
  theme(legend.position = "bottom")




