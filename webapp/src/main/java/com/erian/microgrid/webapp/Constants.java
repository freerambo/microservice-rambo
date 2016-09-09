package com.erian.microgrid.webapp;
/**
 * 
 * function description： Constants used in app i.e. api urls 
 *
 * @author <a href="mailto:zhuyb@ntu.edu.sg">zhuyuanbo </a>
 * @version v 1.0 
 * Create:  Sep 8, 2016 11:40:23 AM
 */
public final class Constants {

    /**
     * prefix of REST API
     */
    public static final String URI_API = "/api";

    public static final String URI_POSTS = "/posts";

    public static final String URI_COMMENTS = "/comments";
    
    public static final String URI_DEVICES = "/devices";
    
    private Constants() {
        throw new InstantiationError( "Must not instantiate this class" );
    }
    
}
