# Apple App Store Data Analysis

## About the Dataset

The dataset comprises two tables, AppleStore and appleStore_description. The AppleStore table includes information such as the app name, category, price, rating, total rating count, category, number of languages supported, and the number of supported devices for 7195 apps. The appleStore_description table provides four pieces of information: id, app name, size in bytes, and app description. It is publicly available at [Kaggle - App Store (Apple) Data Set (10k Apps)](https://www.kaggle.com/datasets/ramamet4/app-store-apple-data-set-10k-apps).

## Identifying the Stakeholder

Our stakeholder is an aspiring app developer seeking data-driven insights to make informed decisions about the type of app to develop.

## EDA (Exploratory Data Analysis)

1. Checked the number of unique apps in both tables and found the count to be consistent.
2. Checked for missing values in key fields. No missing values were observed.
3. Number of apps per Genre – Games lead the market with a total of 3862 apps, followed by the Entertainment genre with 535 apps and Education with 453 apps.
4. Overview of overall app ratings – Min: 0, Max: 5, Avg: 3.53

## Data Analysis

1. **Rating Comparison between Free and Paid Apps:**
   - Free: 3.38
   - Paid: 3.72

2. **Price Analysis for Paid Apps:**
   - Min: 0.99
   - MAX: 299.99
   - AVG: 3.95

3. **Price Distribution for Paid Apps:**
   - "$10.01 - $20": 61
   - "> $20": 36
   - "$5.01 - $10": 341
   - "$0.99 - $2.5": 1349
   - "$2.51 - $5": 1354

4. **Top 5 Categories with Higher User Ratings:**
   - "Productivity": 4.01
   - "Music": 3.98
   - "Photo & Video": 3.80
   - "Business": 3.75
   - "Health & Fitness": 3.70

5. **Bottom 5 Categories with Low Ratings:**
   - "Catalogs": 2.10
   - "Finance": 2.43
   - "Books": 2.48
   - "Navigation": 2.68
   - "Lifestyle": 2.81

6. **Average Price Across Different Genres:**
   - Including Free Apps: Max – Medical: $8.77, Business: $5.11, Minimum – Shopping: $0.016
   - Excluding Free Apps: Max – Medical: $13.46, Music: $9.40, Minimum – Shopping: 1.99

7. **App Size Statistics:**
   - Max: 4026 MB
   - Min: 0.59 MB
   - Avg: 199.13 MB

8. **App Size Distribution:**
   - "< 50 MB": 1924
   - "50-200 MB": 3686
   - "200 -500 MB": 986
   - "> 500 MB": 601

9. **App Size by Genre:**
   - Top 3 genres by app size are Medical: 376.39 MB, Games: 283.66 MB, and Education: 180.42 MB.
   - Bottom 3 genres by app size are Catalogs: 50.18 MB, Utilities: 54.29 MB, and Weather: 61.44 MB.

10. **Impact of Language Support on Ratings:**
   - 10 - 30 languages: 4.13
   - > 30 languages: 3.78
   - <10 languages: 3.37

11. **Correlation Between App Description Length and User Ratings:**
   - Long (1000 +): 3.86
   - Medium (500-1000): 3.23
   - Short (< 500): 2.53

12. **Combinations of Price and User Satisfaction:**
   - For Book genre, the maximum average rating (4.5) is for the apps priced at $27.99. Free apps had an average rating of 1.60.
   - For Finance genre, the maximum average rating (4.75) is for the apps priced at $1.99 and free apps received an average 2.22 rating.
   - For Games, the maximum average rating (4.5) is for the apps priced at $29.99, $20.99, and $13.99. Whereas free games had an average rating of 3.52.

## Recommendations

1. **Paid apps generally have better ratings:**
   - This observation suggests that users who invest in an app are more likely to engage with it. Consider developing a paid version or implementing in-app purchases for enhanced user experience.

2. **Apps supporting between 10 and 30 languages tend to have better overall ratings:**
   - Language diversity positively correlates with user satisfaction. Ensure app content is localized and consider expanding language support for wider reach.

3. **Focus on genres with low average ratings:**
   - Genres such as Finance, Books, and Catalogs show lower average ratings, indicating potential areas for improvement. Identify specific pain points in low-rated genres such as Finance, Books, and Catalogs. Implement features or updates addressing these pain points to improve user satisfaction and ratings.

4. **A longer app description correlates positively with user ratings:**
   - Users appreciate detailed app descriptions. Invest time in crafting comprehensive and engaging descriptions to positively impact user perception.

5. **Aim for a new app with an average rating above 3.5:**
   - Setting a goal for a minimum average rating ensures that the new app meets user expectations. Regularly monitor user feedback and iterate on the app to maintain high satisfaction levels.

6. **While the Games genre is highly competitive:**
   - The Games genre has high competition, making it challenging for new entries. However, creating a game could result in more downloads and greater revenue. Consider innovative features to stand out in the crowded market.
