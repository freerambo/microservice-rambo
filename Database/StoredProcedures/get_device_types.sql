CREATE DEFINER=`root`@`localhost` PROCEDURE `get_device_types`()
BEGIN

SELECT T.id as TypeID, T.name as TypeName, T.description as TypeDescription, C.id as ClassID, C.Name as ClassName, C.Description as ClassDescription
FROM `smes_microgrid`.`device_type` T
LEFT JOIN `smes_microgrid`.`device_class` C ON T.device_class_id = C.id;

END