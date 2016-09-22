CREATE DEFINER=`root`@`localhost` PROCEDURE `get_device_data`(IN id INT, IN dateFrom DATETIME, IN dateTo DATETIME)
BEGIN

-- TODO - make columns list dynamioc. Now 3 hardcoded volumns/variables to return some data for  API and GUI
SELECT
    VV.timestamp,
    coalesce(sum(case when V.id = "9" then VV.value end), 0) as Power,
    coalesce(sum(case when V.id= "10" then VV.value end), 0) as Voltage,
    coalesce(sum(case when V.id = "11" then VV.value end), 0) as Current
FROM smes_microgrid.variable_value as VV
LEFT JOIN smes_microgrid.variable as V ON V.id= VV.variable_id
WHERE V.device_id = 22
AND (dateFrom IS NULL OR VV.timestamp> dateFrom ) 
AND (dateTo IS NULL OR VV.timestamp<dateTo)
GROUP BY VV.`timestamp`;


END