CREATE DEFINER=`root`@`localhost` PROCEDURE `update_device`(  IN id INT,
									IN device_type_id TINYINT,
									IN name VARCHAR(255),
									IN description VARCHAR(255),
									IN microgrid_id TINYINT,

									IN vendor VARCHAR(100),
									IN model VARCHAR(100),
									IN location VARCHAR(100),
									IN ip_adress VARCHAR(255),
									IN port_number VARCHAR(10),
									IN bus_id TINYINT,
									IN is_programmable BIT,
									IN is_connected BIT)
BEGIN

UPDATE smes_microgrid.device 
SET 
`device_type_id` = device_type_id,
`name` = name,
`description` = description,
`microgrid_id` = microgrid_id,

`vendor` = vendor,
`model` = model,
`location` = location,
`ip_adress` = ip_adress,
`port_number` = port_number,
`bus_id` = bus_id,
`is_programmable` = is_programmable,
`is_connected` = is_connected
WHERE `id` = id;

END