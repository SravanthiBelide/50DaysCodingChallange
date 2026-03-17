&nbsp;                              Educational Analytics: Impact of Screen Time on Student Performance









##### **Dataset Columns:**

##### **----------------**

• Student\_ID: Unique identifier for each student 

• Age: Age of the student 

• Study\_Hours: Average hours spent studying per day 

• Screen\_Time: Average screen time per day (in hours) 

• Test\_Scores: Academic performance (out of 100) 

• Extra\_Curricular\_Hours: Time spent on extracurricular activities (per day)



##### **Data Cleaning:**

##### **---------------**

o Identify and handle missing values 

o Remove duplicate

o consistent formatting



##### **Pivot Tables:**

o Use pivot tables to analyze: 

▪ Average test scores by screen time category 

▪ Screen time vs. extracurricular activity trends 

▪ Age group-wise performance 

.  Age group by Avg screen time

. Study hours by Avg test score

&nbsp;Charts \& Dashboards 

##### **Create visualizations:** 

▪ Bar chart of Screen Time vs. Test Scores 

▪ pie chart comparing Age and Sum of test score





##### **Dataset Insights:**

**Screen Time Impact:** Students with over 4 hours of screen time show a performance dip, averaging scores of ~71.4%.

**The "Sweet Spot":** Peak academic results are found in students balancing 2–3 hours of study with 1–2 hours of extra-curriculars.

**Activity Buffer:** Participation in extra-curricular activities for at least 1 hour correlates with an 8% increase in average marks.

**Diminishing Returns:** Studying beyond 5 hours without breaks often leads to lower average scores than moderate, focused sessions.

**Digital Wellness:** High-risk students with 7+ hours of screen time (e.g., Student #108, #154, #189) frequently exhibit high score volatility.



##### **Technical Implementation:**

**Data Cleaning:** Handled missing values (NaN) in Study Hours and Test Scores using mean imputation.

**Categorization:** Utilized a VBA Macro to segment raw hours (0–10) into 5 distinct groups for dashboarding.

**Analysis:** Built Pivot Tables to aggregate average marks across grouped screen time and activity ranges.

**Visualization:** Created a dual-axis dashboard to compare lifestyle habits against academic benchmarks.

