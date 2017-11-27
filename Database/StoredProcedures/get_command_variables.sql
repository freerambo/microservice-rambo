CREATE DEFINER=`root`@`localhost` PROCEDURE `get_command_variables`(IN command_id INT)
BEGIN

SELECT command_id as commandId, 
V.id as variableId, V.Name as variableName, V.Description as variableDescription,
P.ID as parameterTypeId, P.Name as parameterTypeName, P.Name as parameterTypeDescription,
U.ID as unitId, U.Name as unitName, U.Description as unitDescription
FROM command_device_variable AS CDV
INNER JOIN `smes_microgrid`.variable AS V ON CDV.variable_id = V.id
INNER JOIN `smes_microgrid`.parameter_type AS P ON CDV.parameter_type_id = P.id
LEFT JOIN `smes_microgrid`.variable_unit AS U ON U.id = V.unit_id
WHERE CDV.command_id = command_id 
ORDER BY P.ID
;

END