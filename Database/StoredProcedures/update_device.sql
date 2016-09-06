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
-- Note - COALESCE takes first non-null value. it means, using it we can't set value to NULL (that is OK for now as we can set empty string for all the string columns)
UPDATE smes_microgrid.device as D
SET 
`device_type_id` = COALESCE(device_type_id, D.device_type_id) ,
`name` = COALESCE(name, D.name) ,
`description` = COALESCE( description, D.description) ,
`microgrid_id` = COALESCE( microgrid_id , D.microgrid_id),

`vendor` = COALESCE( vendor, D.vendor),
`model` = COALESCE( model, D.model),
`location` = COALESCE(location , D.location),
`ip_adress` = COALESCE(ip_adress , D.ip_adress),
`port_number` = COALESCE( port_number, D.port_number),
`bus_id` = COALESCE(bus_id , D.bus_id),
`is_programmable` = COALESCE( is_programmable, D.is_programmable),
`is_connected` = COALESCE( is_connected, D.is_connected) 
WHERE D.id = id;




END