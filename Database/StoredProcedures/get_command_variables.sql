CREATE DEFINER=`root`@`localhost` PROCEDURE `get_command_variables`(IN command_id INT)
BEGIN

SELECT command_id as CommandID, 
V.id as VariableID, V.Name as VariableName, V.Description as VariableDescription,
P.ID as ParameterTypeID, P.Name as ParameterTypeName, P.Name as ParameterTypeDescription,
U.ID as UnitID, U.Name as UnitName, U.Description as UnitDescription
FROM command_device_variable AS CDV
INNER JOIN `smes_microgrid`.variable AS V ON CDV.variable_id = V.id
INNER JOIN `smes_microgrid`.parameter_type AS P ON CDV.parameter_type_id = P.id
LEFT JOIN `smes_microgrid`.variable_unit AS U ON U.id = V.unit_id
WHERE CDV.command_id = command_id 
ORDER BY P.ID
;

END