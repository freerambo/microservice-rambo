SELECT * FROM smes_microgrid.device;
select * from smes_microgrid.variable;
 
START TRANSACTION;	

-- CALL `smes_microgrid`.`add_device`(4, 'chroma_63211_dc_load', 'DC LOAD chroma_63211_dc_load', 1, 'chroma', 'chroma_63211', 'Lab at level 5', '172.21.76.125', '3030', 2, 1, 1);

-- 27 is ID of dc source, change accordingly

CALL `smes_microgrid`.`add_variable`(27, 'Current', 'Current', 			2, '5');
CALL `smes_microgrid`.`add_variable`(27, 'Voltage', 'Voltage', 			3, '5');

-- CALL `smes_microgrid`.`add_variable`(27, 'Frequency', 'Frequency', 		4, '5');
-- CALL `smes_microgrid`.`add_variable`(27, 'Power', 'Power', 				1, '5');
-- CALL `smes_microgrid`.`add_variable`(27, 'Resistance', 'Resistance', 	5, '5');



-- select * from variable where device_id=22;

delete from `smes_microgrid`.`variable_value` where variable_id=27;
delete from `smes_microgrid`.`variable_value` where variable_id=28;


-- delete from `smes_microgrid`.`variable_value`
INSERT INTO `smes_microgrid`.`variable_value`
											(`timestamp`,
											`variable_id`,
											`value`)
SELECT system_timestamp, 27 , magnapower_dc_source.source_voltage
FROM smartgrid.magnapower_dc_source;

INSERT INTO `smes_microgrid`.`variable_value`
											(`timestamp`,
											`variable_id`,
											`value`)
SELECT system_timestamp, 28 , magnapower_dc_source.source_current
FROM smartgrid.magnapower_dc_source;

COMMIT;

select * from `smes_microgrid`.`variable_value`;

