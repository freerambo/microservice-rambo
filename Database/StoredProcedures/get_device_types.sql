CREATE DEFINER=`root`@`localhost` PROCEDURE `get_device_types`()
BEGIN

SELECT T.id as typeId, T.name as typeName, T.description as typeDescription, C.id as classId, C.Name as className, C.Description as classDescription
FROM `smes_microgrid`.`device_type` T
LEFT JOIN `smes_microgrid`.`device_class` C ON T.device_class_id = C.id;

END