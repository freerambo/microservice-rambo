CREATE DEFINER=`root`@`localhost` PROCEDURE `get_variables`(IN device_id INT)
BEGIN

SELECT V.`id`,
    V.`device_id`,
    V.`name`,
    V.`description`,
    V.`unit_id`,
    V.`updating_duration`,
    V.`set_command_id`,
    V.`get_command_id`
FROM `smes_microgrid`.variable AS V
LEFT JOIN `smes_microgrid`.variable_unit AS U ON U.id = V.unit_id
WHERE V.device_id = device_id 
;

END