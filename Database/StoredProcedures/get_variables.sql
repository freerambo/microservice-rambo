CREATE DEFINER=`root`@`localhost` PROCEDURE `get_variables`(IN device_id INT)
BEGIN

SELECT V.`id` as ID,
    V.`device_id` as DeviceID,
    V.`name` as Name,
    V.`description` as Description,
    V.`unit_id` as UnitID,
    V.`updating_duration` as UpdatingDuration,
    V.`set_command_id` as SetCommandID,
    V.`get_command_id` as GetCommandID
FROM `smes_microgrid`.variable AS V
LEFT JOIN `smes_microgrid`.variable_unit AS U ON U.id = V.unit_id
WHERE V.device_id = device_id 
;

END