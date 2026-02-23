## Day 1 – Data Validation

- Dataset contains ~42.4M events across millions of users and sessions
- Event distribution follows expected e-commerce behavior (View > Cart > Purchase)
- Data covers Oct–Nov 2019 with consistent daily activity
- No major NULL issues in critical fields
- Session structure is reliable for funnel and retention analysis


## Day 2 – Funnel Analysis

- Built a user-level funnel using 42M+ event records  
- Calculated unique users who viewed, added to cart, and purchased  
- Derived conversion rates:
- View → Cart
- Cart → Purchase
- View → Purchase  
- Established baseline metrics for further optimization

## Day 3 – Conversion Rate Trends

- Calculated daily views, carts, and purchases
- Tracked conversion rates over time
- Enabled identification of high and low performing days
- Established trend analysis for business performance monitoring


## Day 4 – Session Behavior Analysis

- Analyzed user sessions to understand engagement patterns  
- Calculated session duration and event counts  
- Measured average events per session  
- Identified proportion of sessions leading to purchases  
- Built foundation for retention and cohort analysis


## Day 5 – Retention Analysis

- Identified first activity date for every user  
- Measured returning users over time  
- Calculated Day-1 and Day-7 retention rates  
- Provided insights into user stickiness and engagement  
- Established core metric for long-term product success

## Day 6 – Cohort Analysis

- Grouped users based on their first activity month  
- Tracked user activity across subsequent months  
- Measured retention patterns by cohort  
- Enabled long-term engagement analysis  
- Identified how different user groups behave over time

## Day 7 – Revenue & LTV Analysis

- Calculated total and daily revenue  
- Measured paying user contribution  
- Derived ARPU (Average Revenue Per User)  
- Estimated basic Customer Lifetime Value (LTV)  
- Established revenue health metrics for the business

## Day 8 – Power User Analysis

- Identified high-revenue users (top 10%)  
- Measured revenue concentration among power users  
- Analyzed high-engagement users based on activity  
- Observed Pareto distribution in revenue contribution  
- Provided foundation for targeted retention strategy

## Day 9 – Growth Metrics

- Calculated Daily Active Users (DAU)  
- Calculated Monthly Active Users (MAU)  
- Derived stickiness metric (DAU / MAU)  
- Evaluated engagement consistency over time  
- Established core growth health indicators

## Day 10 – Feature / Category Adoption

- Analyzed product category engagement  
- Identified top revenue-generating categories  
- Measured category-level conversion rates  
- Evaluated brand-level revenue contribution  
- Highlighted high-performing and underperforming segments

## Day 12 – Analytics Layer Creation

- Built aggregated daily metrics table  
- Reduced dependency on scanning 42M raw rows  
- Improved performance for reporting queries  
- Applied indexing for optimized access  
- Shifted from analysis to analytics engineering mindset

## Day 13 – Star Schema Data Modeling

- Designed dimensional data model  
- Created fact table for event tracking  
- Built date, user, product, and session dimensions  
- Implemented indexing for optimized joins  
- Transitioned project toward data warehouse architecture