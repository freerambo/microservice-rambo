CREATE DEFINER=`root`@`localhost` PROCEDURE `add_device`(
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
IN is_connected BIT
)
BEGIN

INSERT INTO `smes_microgrid`.`device`
(`device_type_id`,
`name`,
`description`,
`microgrid_id`,

`vendor`,
`model`,
`location`,
`ip_adress`,
`port_number`,
`bus_id`,
`is_programmable`,
`is_connected`)
VALUES
(device_type_id,
name,
description,
microgrid_id,

vendor,
model,
location,
ip_adress,
port_number,
bus_id,
is_programmable,
is_connected
);


END