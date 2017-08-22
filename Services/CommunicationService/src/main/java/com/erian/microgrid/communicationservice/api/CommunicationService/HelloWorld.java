package com.erian.microgrid.communicationservice.api.CommunicationService;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiResponse;
import io.swagger.annotations.ApiResponses;

import javax.ws.rs.DefaultValue;
import javax.ws.rs.GET;
import javax.ws.rs.HeaderParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

@Path("/hello")
@Api(value = "/hello")
public class HelloWorld {

	@GET
	@Path("/{xyz}")
	@ApiOperation(value = "/{xyz}", notes = "Hello world example - java code.")
	@ApiResponses(value = { @ApiResponse(code = 200, message = "OK - java code"),
			@ApiResponse(code = 400, message = "Bad Request examp - java code.") })
	@ApiImplicitParams(value = { @ApiImplicitParam(name = "xyz", dataType = "string", paramType = "path"),
			@ApiImplicitParam(name = "abc", dataType = "string", paramType = "query"),
			@ApiImplicitParam(name = "my-header", dataType = "string", paramType = "header") })
	@Produces(MediaType.APPLICATION_XML)
	public Response responseMsg(@PathParam("xyz") String parameter,
			@DefaultValue("Nothing to say") @QueryParam("abc") String qwe,
			@HeaderParam("my-header") final String header, @Context final HttpHeaders httpHeaders, String payload) {

		System.out.println("  helloWorldREST  received : " + parameter);

		System.out.println("path param " + parameter + " query param " + qwe + " header param " + header);

		String output = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<letter>\n Dear "+parameter+", Keep up the good work! </letter>\n";

		return Response.status(200).entity(output).build();
	}

	@POST
	@Path("/{xyz}")
	@ApiOperation(value = "/{xyz}", notes = "Hello world example - java code.")
	@ApiResponses(value = { @ApiResponse(code = 200, message = "OK - java code"),
			@ApiResponse(code = 400, message = "Bad Request examp - java code.") })
	@ApiImplicitParams(value = { @ApiImplicitParam(name = "xyz", dataType = "string", paramType = "path"),
			@ApiImplicitParam(name = "abc", dataType = "string", paramType = "query"),
			@ApiImplicitParam(name = "my-header", dataType = "string", paramType = "header") })
	@Produces(MediaType.APPLICATION_XML)
	public Response responseMsgPost(@PathParam("xyz") String parameter,
			@DefaultValue("Nothing to say") @QueryParam("abc") String qwe,
			@HeaderParam("my-header") final String header, @Context final HttpHeaders httpHeaders, String payload) {

		System.out.println("  helloWorldREST  received : " + parameter);

		System.out.println("path param " + parameter + " query param " + qwe + " header param " + header);

		String output = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<letter>\n Dear Daniel, Keep up the good work! </letter>\n";

		return Response.status(200).entity(output).build();
	}
}