CREATE DEFINER=`root`@`localhost` PROCEDURE `add_variable`(IN device_id INT, IN name VARCHAR(45), IN description VARCHAR(255), IN unit_id TINYINT, IN updating_duration TINYINT)
BEGIN
INSERT INTO `smes_microgrid`.`variable`
(
`device_id`,
`name`,
`description`,
`unit_id`,
`updating_duration`
)
VALUES
(
device_id,
name,
description,
unit_id,
updating_duration

-- Get and Set commands can be added only when variable is assigned to IN/OUR parameter list
-- set_command_id,
-- get_command_id
);

END