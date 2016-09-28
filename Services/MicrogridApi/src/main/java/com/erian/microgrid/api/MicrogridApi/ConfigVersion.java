package com.erian.microgrid.api.MicrogridApi;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

/**
 * ConfigVersion class to manage the API to return the versions
 */
@Path("version")
public class ConfigVersion {

	private String api;
	private String webApp;
	
	public ConfigVersion() {

	}

	/**
	 * Get the hardcoded version SHA from the config file
	 * @return  
	 * ConfigVersion object
	 *
	 */
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public ConfigVersion readVersion() {
		api = "1.0";
		webApp = "1.0";
		// Retrieve the versions here and it can be extensible to more versions
		
		String val = "";
		try {
			// The version.properties is put under webapp/WEB-INF/
			InputStream i = getClass().getClassLoader().getResourceAsStream("../version.properties");
			BufferedReader r = new BufferedReader(new InputStreamReader(i));
			String l;
			while((l = r.readLine()) != null) {
				val = val + l;
				api = val;
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}

		return this;
	}

	public String getApi() {
		return api;
	}

	public void setApi(String api) {
		this.api = api;
	}

	public String getWebApp() {
		return webApp;
	}

	public void setWebApp(String webApp) {
		this.webApp = webApp;
	}
	
	
}
