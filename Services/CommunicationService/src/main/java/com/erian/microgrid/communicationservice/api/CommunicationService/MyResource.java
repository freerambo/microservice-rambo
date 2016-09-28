package com.erian.microgrid.communicationservice.api.CommunicationService;

import javax.servlet.ServletContext;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriBuilder;

import io.swagger.annotations.Api;

/**
 * Root resource (exposed at "myresource" path)
 */
@Path("/")
public class MyResource {

    /**
     * Method handling HTTP GET requests. The returned object will be sent
     * to the client as "text/plain" media type.
     *
     * @return String that will be returned as a text/plain response.
     */
//    @GET
//    @Path("myresource")
//    @Produces(MediaType.TEXT_PLAIN)
    public String getIt() {
        return "Got it!";
    }
    @GET
    public Response getRedirect(@Context ServletContext context) {
        UriBuilder builder = UriBuilder.fromPath(context.getContextPath());
        builder.path("index.html");
        System.out.print(builder.toString());
        return Response.seeOther(builder.build()).build();       
    }
}
