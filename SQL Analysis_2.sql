CREATE DATABASE KEYSTRA_SOLUTION2;
USE KEYSTRA_SOLUTION2;
select count(*) from pipeline_incidents;
select count(*) as Total_Incidents 
from pipeline_incidents;
SELECT
    REPORT_NUMBER,
    COUNT(*) AS Duplicate_Count
FROM pipeline_incidents
GROUP BY REPORT_NUMBER
HAVING COUNT(*) > 1;
SELECT
    MIN(LOCAL_DATETIME) AS First_Incident,
    MAX(LOCAL_DATETIME) AS Last_Incident
FROM pipeline_incidents;
SELECT
COUNT(DISTINCT ONSHORE_STATE_ABBREVIATION) AS States_Covered
FROM pipeline_incidents;
SELECT
COUNT(DISTINCT OPERATOR_ID) AS Operators
FROM pipeline_incidents;
SELECT
    YEAR,
    COUNT(*) AS Incident_Count
FROM pipeline_incidents
GROUP BY YEAR
ORDER BY YEAR;
SELECT
    MONTHNAME(LOCAL_DATETIME) AS Month_Name,
    MONTH(LOCAL_DATETIME) AS Month_Number,
    COUNT(*) AS Incident_Count
FROM pipeline_incidents
GROUP BY Month_Number, Month_Name
ORDER BY Month_Number;
SELECT
    ONSHORE_STATE_ABBREVIATION,
    COUNT(*) AS Incident_Count
FROM pipeline_incidents
GROUP BY ONSHORE_STATE_ABBREVIATION
ORDER BY Incident_Count DESC
LIMIT 10;
SELECT
    NAME AS Operator_Name,
    COUNT(*) AS Incident_Count
FROM pipeline_incidents
GROUP BY NAME
ORDER BY Incident_Count DESC
LIMIT 10;
DESCRIBE pipeline_incidents;
SELECT
LOCAL_DATETIME
FROM pipeline_incidents
LIMIT 10;
SELECT
    LOCAL_DATETIME,
    STR_TO_DATE(LOCAL_DATETIME, '%d/%m/%Y %H:%i') AS Converted_Date
FROM pipeline_incidents
LIMIT 10;
ALTER TABLE pipeline_incidents
CHANGE COLUMN `ï»¿CAUSE` CAUSE TEXT;
DESCRIBE pipeline_incidents;
SELECT
LOCAL_DATETIME,
STR_TO_DATE(LOCAL_DATETIME,'%d/%m/%Y %H:%i')
FROM pipeline_incidents
LIMIT 10;
SELECT
REPORT_RECEIVED_DATE,
INCIDENT_IDENTIFIED_DATETIME,
SHUTDOWN_DATETIME,
RESTART_DATETIME
FROM pipeline_incidents
LIMIT 10;
SELECT COUNT(*) AS Total_Incidents
FROM pipeline_incidents;
SELECT
    YEAR(STR_TO_DATE(LOCAL_DATETIME,'%d/%m/%Y %H:%i')) AS Incident_Year,
    COUNT(*) AS Total_Incidents
FROM pipeline_incidents
GROUP BY Incident_Year
ORDER BY Incident_Year;
SELECT
    MONTHNAME(STR_TO_DATE(LOCAL_DATETIME,'%d/%m/%Y %H:%i')) AS Month_Name,
    MONTH(STR_TO_DATE(LOCAL_DATETIME,'%d/%m/%Y %H:%i')) AS Month_Number,
    COUNT(*) AS Total_Incidents
FROM pipeline_incidents
GROUP BY Month_Number, Month_Name
ORDER BY Month_Number;
SELECT
    ONSHORE_STATE_ABBREVIATION,
    COUNT(*) AS Incident_Count
FROM pipeline_incidents
GROUP BY ONSHORE_STATE_ABBREVIATION
ORDER BY Incident_Count DESC;
SELECT
    NAME,
    COUNT(*) AS Incident_Count
FROM pipeline_incidents
GROUP BY NAME
ORDER BY Incident_Count DESC
LIMIT 10;
SELECT
    ONSHORE_STATE_ABBREVIATION AS State,
    COUNT(*) AS Incident_Count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM pipeline_incidents),2) AS Percentage_of_Total
FROM pipeline_incidents
GROUP BY ONSHORE_STATE_ABBREVIATION
ORDER BY Incident_Count DESC;
SELECT
    REPORT_TYPE,
    COUNT(*) AS Incident_Count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM pipeline_incidents),2) AS Percentage
FROM pipeline_incidents
GROUP BY REPORT_TYPE
ORDER BY Incident_Count DESC;
SELECT
    COUNT(*) AS Total_Incidents,
    COUNT(DISTINCT IYEAR) AS Study_Years,
    ROUND(COUNT(*) / COUNT(DISTINCT IYEAR),2) AS Avg_Incidents_Per_Year,
    ROUND(COUNT(*) / (COUNT(DISTINCT IYEAR) * 12),2) AS Avg_Incidents_Per_Month,
    ROUND(COUNT(*) / 365.25 / COUNT(DISTINCT IYEAR),2) AS Avg_Incidents_Per_Day
FROM pipeline_incidents;
SELECT
    IYEAR,
    COUNT(*) AS Incident_Count
FROM pipeline_incidents
GROUP BY IYEAR
ORDER BY Incident_Count DESC;
SELECT
    ONSHORE_STATE_ABBREVIATION AS State,

    SUM(
        IFNULL(EST_COST_PROP_DAMAGE,0)
      + IFNULL(EST_COST_ENVIRONMENTAL,0)
      + IFNULL(EST_COST_EMERGENCY,0)
      + IFNULL(EST_COST_GAS_RELEASED,0)
      + IFNULL(EST_COST_OTHER,0)
    ) AS Total_Financial_Loss,

    COUNT(*) AS Incident_Count,

    ROUND(
        SUM(
            IFNULL(EST_COST_PROP_DAMAGE,0)
          + IFNULL(EST_COST_ENVIRONMENTAL,0)
          + IFNULL(EST_COST_EMERGENCY,0)
          + IFNULL(EST_COST_GAS_RELEASED,0)
          + IFNULL(EST_COST_OTHER,0)
        ) / COUNT(*),
        2
    ) AS Avg_Loss_Per_Incident

FROM pipeline_incidents

GROUP BY ONSHORE_STATE_ABBREVIATION

ORDER BY Total_Financial_Loss DESC;
SELECT
    ONSHORE_STATE_ABBREVIATION AS State,

    ROUND(SUM(UNINTENTIONAL_RELEASE_BBLS),2) AS Total_Released_Barrels,

    ROUND(SUM(RECOVERED_BBLS),2) AS Total_Recovered_Barrels,

    ROUND(
        SUM(UNINTENTIONAL_RELEASE_BBLS) -
        SUM(RECOVERED_BBLS),
        2
    ) AS Net_Unrecovered_Barrels,

    COUNT(*) AS Incident_Count

FROM pipeline_incidents

GROUP BY ONSHORE_STATE_ABBREVIATION

ORDER BY Net_Unrecovered_Barrels DESC;
SELECT
    ONSHORE_STATE_ABBREVIATION AS State,
    SUM(FATAL) AS Total_Fatalities,
    SUM(INJURE) AS Total_Injuries,
    COUNT(*) AS Incident_Count,
    ROUND(
        (SUM(FATAL) + SUM(INJURE)) / COUNT(*),
        2
    ) AS Avg_Casualties_Per_Incident
FROM pipeline_incidents
GROUP BY ONSHORE_STATE_ABBREVIATION
ORDER BY (SUM(FATAL) + SUM(INJURE)) DESC;

SELECT
    PIPE_FACILITY_TYPE,
    COUNT(*) AS Incident_Count,
    ROUND(COUNT(*)*100/(SELECT COUNT(*) FROM pipeline_incidents),2) AS Percentage
FROM pipeline_incidents
GROUP BY PIPE_FACILITY_TYPE
ORDER BY Incident_Count DESC;
SELECT
    SYSTEM_PART_INVOLVED,
    COUNT(*) AS Incident_Count
FROM pipeline_incidents
GROUP BY SYSTEM_PART_INVOLVED
ORDER BY Incident_Count DESC;
SELECT
    COMMODITY_RELEASED_TYPE,
    COUNT(*) AS Incident_Count
FROM pipeline_incidents
GROUP BY COMMODITY_RELEASED_TYPE
ORDER BY Incident_Count DESC;
SELECT
    FLOOR((IYEAR - CAST(INSTALLATION_YEAR AS UNSIGNED))/10)*10 AS Age_Group,
    COUNT(*) AS Incident_Count
FROM pipeline_incidents
WHERE INSTALLATION_YEAR IS NOT NULL
AND INSTALLATION_YEAR <> ''
GROUP BY Age_Group
ORDER BY Age_Group;
SELECT
    PIPE_DIAMETER,
    COUNT(*) AS Incident_Count
FROM pipeline_incidents
WHERE PIPE_DIAMETER IS NOT NULL
AND PIPE_DIAMETER <> ''
GROUP BY PIPE_DIAMETER
ORDER BY Incident_Count DESC
LIMIT 15;
SELECT
    OPERATOR_TYPE,
    COUNT(*) AS Incident_Count
FROM pipeline_incidents
GROUP BY OPERATOR_TYPE
ORDER BY Incident_Count DESC;

SELECT
    CAUSE,
    COUNT(*) AS Incident_Count,
    ROUND(COUNT(*) * 100.0 /
          (SELECT COUNT(*) FROM pipeline_incidents),2) AS Percentage
FROM pipeline_incidents
GROUP BY CAUSE
ORDER BY Incident_Count DESC;
SELECT
    LEAK_TYPE,
    COUNT(*) AS Incident_Count,
    ROUND(COUNT(*) * 100.0 /
          (SELECT COUNT(*) FROM pipeline_incidents),2) AS Percentage
FROM pipeline_incidents
GROUP BY LEAK_TYPE
ORDER BY Incident_Count DESC;

SELECT
    CAUSE,

    SUM(
        IFNULL(EST_COST_PROP_DAMAGE,0)
      + IFNULL(EST_COST_ENVIRONMENTAL,0)
      + IFNULL(EST_COST_EMERGENCY,0)
      + IFNULL(EST_COST_GAS_RELEASED,0)
      + IFNULL(EST_COST_OTHER,0)
    ) AS Total_Financial_Loss

FROM pipeline_incidents

GROUP BY CAUSE

ORDER BY Total_Financial_Loss DESC;

SELECT
    CAUSE,

    ROUND(SUM(UNINTENTIONAL_RELEASE_BBLS),2) AS Released_Barrels,

    ROUND(SUM(RECOVERED_BBLS),2) AS Recovered_Barrels,

    ROUND(
        SUM(UNINTENTIONAL_RELEASE_BBLS) -
        SUM(RECOVERED_BBLS),
        2
    ) AS Net_Unrecovered

FROM pipeline_incidents

GROUP BY CAUSE

ORDER BY Net_Unrecovered DESC;

SELECT
    CAUSE,

    SUM(FATAL) AS Fatalities,

    SUM(INJURE) AS Injuries,

    COUNT(*) AS Incidents

FROM pipeline_incidents

GROUP BY CAUSE

ORDER BY (SUM(FATAL)+SUM(INJURE)) DESC;

SELECT
    ROUND(SUM(EST_COST_PROP_DAMAGE),2) AS Property_Damage_Cost,

    ROUND(SUM(EST_COST_ENVIRONMENTAL),2) AS Environmental_Cost,

    ROUND(SUM(EST_COST_EMERGENCY),2) AS Emergency_Response_Cost,

    ROUND(SUM(EST_COST_GAS_RELEASED),2) AS Product_Loss_Cost,

    ROUND(SUM(EST_COST_OTHER),2) AS Other_Costs,

    ROUND(
        SUM(
            IFNULL(EST_COST_PROP_DAMAGE,0)
          + IFNULL(EST_COST_ENVIRONMENTAL,0)
          + IFNULL(EST_COST_EMERGENCY,0)
          + IFNULL(EST_COST_GAS_RELEASED,0)
          + IFNULL(EST_COST_OTHER,0)
        ),2
    ) AS Total_Incident_Cost

FROM pipeline_incidents;
SELECT
SUM(`UNINTENTIONAL_RELEASE_BBLS`)
FROM pipeline_incidents;
SELECT
SUM(`RECOVERED_BBLS`)
FROM pipeline_incidents;
SELECT
ROUND(SUM(`UNINTENTIONAL_RELEASE_BBLS`),2) AS Total_Released,
ROUND(SUM(`RECOVERED_BBLS`),2) AS Total_Recovered,
ROUND(
SUM(`UNINTENTIONAL_RELEASE_BBLS`) -
SUM(`RECOVERED_BBLS`),2
) AS Net_Unrecovered
FROM pipeline_incidents;

SELECT
    SUM(FATAL) AS Total_Fatalities,
    SUM(INJURE) AS Total_Injuries,
    ROUND(
        (SUM(FATAL) + SUM(INJURE)) / COUNT(*),
        4
    ) AS Average_Casualties_Per_Incident
FROM pipeline_incidents;
SELECT
CASE
WHEN (
IFNULL(EST_COST_PROP_DAMAGE,0)+
IFNULL(EST_COST_ENVIRONMENTAL,0)+
IFNULL(EST_COST_EMERGENCY,0)+
IFNULL(EST_COST_GAS_RELEASED,0)+
IFNULL(EST_COST_OTHER,0)
) < 100000
THEN 'Low Impact'

WHEN (
IFNULL(EST_COST_PROP_DAMAGE,0)+
IFNULL(EST_COST_ENVIRONMENTAL,0)+
IFNULL(EST_COST_EMERGENCY,0)+
IFNULL(EST_COST_GAS_RELEASED,0)+
IFNULL(EST_COST_OTHER,0)
) < 1000000
THEN 'Medium Impact'

ELSE 'High Impact'

END AS Severity,

COUNT(*) AS Incident_Count

FROM pipeline_incidents

GROUP BY Severity

ORDER BY Incident_Count DESC;


