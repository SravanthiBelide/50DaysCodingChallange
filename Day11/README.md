# &#x20;Insurance and Claim Incident Analysis

##### 

##### Dataset :



• Policy number, state, annual premium, deductible, umbrella limit 

• Insured's age, zip, occupation, education, and hobbies 

• Incident date, type, severity, location, hour, property damage, injuries 

• Total claim amount, breakdown by injury/property/vehicle claims 

• Vehicle details, fraud reported status.



##### Data cleaning and processes:



.chage date coloum

.Remove duplicates

.clam amount coloums change type decimal number



##### Visualizations:



##### KPI (Cards):





Total Claim Amount: Sum of total\_claim\_amount.





Total Claims: Distinct count of policy\_number.





Average Fraud Rate: Average of your new IsFraud column.



Claims Trends (Bar/Line Charts):



Use a Line Chart to show Total Claim Amount over time (using the Calendar Table).



Use a Bar Chart to compare Claim Count by incident\_type (e.g., Single vs. Multi-vehicle Collision).



Geographic Analysis (Maps):



Create a Map visual using incident\_state or incident\_city to visualize claim density and total value across regions.



Demographic Segmentation (Tables/Donut Charts):



Analyze customer segments using insured\_education\_level, insured\_occupation, and insured\_sex against claim frequency.



Fraud and Loss Analysis:





Loss Ratio: Create a DAX measure: DIVIDE(SUM(total\_claim\_amount), SUM(policy\_annual\_premium)).



Plot Fraud Rate against incident\_severity or insured\_hobbies to identify high-risk patterns.



&#x20;Interactive Elements



Slicers: Add slicers for policy\_state, incident\_type, incident\_severity, and a Date Range slicer for incident\_date.





Cross-Filtering: Ensure visuals interact so clicking a specific "State" on the map filters the KPIs and charts for that region.





##### Summary:



Key Finding: High-severity incidents (e.g., "Major Damage") often correlate with a higher probability of "Fraud Reported".





Regional Insight: Identify specific states  that exhibit higher-than-average claim frequencies or loss ratios.





Demographic Insight: Certain occupations or education levels may show distinct patterns in claim types or amounts.





##### Recommendations:  

##### 

Fraud Mitigation: Implement stricter verification for claims involving "Major Damage" or specific incident types that show high fraud rates.





Pricing Strategy: Adjust annual premiums for segments with consistently high loss ratios.





Resource Allocation: Direct more adjusters to high-claim-density cities identified in the map visual.

