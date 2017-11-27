SELECT * FROM smes_microgrid.device;
select * from smes_microgrid.variable;
 
START TRANSACTION;	

-- CALL `smes_microgrid`.`add_device`(4, 'chroma_63211_dc_load', 'DC LOAD chroma_63211_dc_load', 1, 'chroma', 'chroma_63211', 'Lab at level 5', '172.21.76.125', '3030', 2, 1, 1);

-- 22 is ID of new Device, change accordingly
-- CALL `smes_microgrid`.`add_variable`(22, 'Voltage', 'Voltage', 1, '5');
-- CALL `smes_microgrid`.`add_variable`(22, 'Current', 'Current', 1, '5');
-- CALL `smes_microgrid`.`add_variable`(22, 'Power', 'Power', 3, '5');

-- select * from variable where device_id=22;

delete from `smes_microgrid`.`variable_value` where variable_id=21;
delete from `smes_microgrid`.`variable_value` where variable_id=22;
delete from `smes_microgrid`.`variable_value` where variable_id=23;
-- delete from `smes_microgrid`.`variable_value`
INSERT INTO `smes_microgrid`.`variable_value`
											(`timestamp`,
											`variable_id`,
											`value`)
SELECT system_timestamp, 21 , voltage
FROM smartgrid.chroma_63211_dc_load;

INSERT INTO `smes_microgrid`.`variable_value`
											(`timestamp`,
											`variable_id`,
											`value`)
SELECT system_timestamp, 22 , smartgrid.chroma_63211_dc_load.current
FROM smartgrid.chroma_63211_dc_load;


INSERT INTO `smes_microgrid`.`variable_value`
											(`timestamp`,
											`variable_id`,
											`value`)
SELECT system_timestamp, 23 , power
FROM smartgrid.chroma_63211_dc_load;

COMMIT;

select * from `smes_microgrid`.`variable_value`;

