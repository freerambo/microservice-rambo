CREATE DEFINER=`root`@`localhost` PROCEDURE `get_commands`(IN device_id INT)
BEGIN

SELECT C.`id` as ID,
    C.`name` as Name,
    C.`description` as Description,
    C.`format_string` as FormatString,
    C.`device_id`
FROM `smes_microgrid`.`command` as C
WHERE C.device_id = device_id 
;

END