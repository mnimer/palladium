package com.mikenimer.palladium.spring.mvc.views;

import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.InternalResourceView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.logging.Logger;

/**
 * @author: mikenimer@yahoo.com
 */
public class ColdFusionView extends InternalResourceView implements View
{
    private static Logger log = Logger.getLogger(ColdFusionView.class.getName());
    private static Properties buildProperties;
    private static int buildNumber = 0;
    protected static String buildFileName = "buildnumber.properties";
    protected static String buildKey = "build.number";

    private ColdFusionSerializer serializer;

    private Boolean convertKeys = false;
    private Boolean lowerCaseKeys = false;
    private Boolean convertCollections = false;
    private Boolean convertNulls = false;
    private Map beans = null;


    // Pull out the build number to include as a static REQUEST scope variable.
    // So users can check for it, before allowing the cfml to process
    // Simple security check in case a users calls the "views" .cfm files directly.
    static
    {
        try
        {
            buildProperties = new Properties();
            URL url = ColdFusionView.class.getClassLoader().getSystemResource( "/" +buildFileName );
            buildProperties.load(url.openStream());
            buildNumber = new Integer(buildProperties.getProperty( buildKey )) - 1;
        }
        catch (Exception ex)
        {
            buildNumber = 0;
        }
    }


    public Boolean getConvertCollections()
    {
        return convertCollections;
    }


    /**
     * Convert all Collections types in a Vector, which is a ColdFusion array
     * @param convertCollections
     */
    public void setConvertCollections( Boolean convertCollections )
    {
        this.convertCollections=convertCollections;
    }


    public Boolean getConvertKeys()
    {
        return convertKeys;
    }


    /**
     * Convert all keys to a String, to match the way CF handles collection keys
     * @param convertKeys
     */
    public void setConvertKeys( Boolean convertKeys )
    {
        this.convertKeys=convertKeys;
    }


    public Boolean getConvertNulls()
    {
        return convertNulls;
    }


    /**
     * Convert java nulls into an empty string, to make nulls work in CF
     * @param convertNulls
     */
    public void setConvertNulls( Boolean convertNulls )
    {
        this.convertNulls=convertNulls;
    }


    public Boolean getLowerCaseKeys()
    {
        return lowerCaseKeys;
    }


    public Map getBeans()
    {
        return beans;
    }


    /**
     * Map of all beans to pass into ColdFusion "request.palladium.beans" property
     * @param beans
     */
    public void setBeans( Map beans )
    {
        this.beans=beans;
    }


    /**
     * Convert all collect, vector keys to lowercase, to prevent any "case-sensitive" issues in CF
     * @param lowerCaseKeys
     */
    public void setLowerCaseKeys( Boolean lowerCaseKeys )
    {
        this.lowerCaseKeys=lowerCaseKeys;
    }


    @Override
    public String getContentType() {
        return "text/html";
    }

    /**
     * Set static attributes for this view from a Map. This allows to set
     * any kind of attribute values, for example bean references.
     * <p>"Static" attributes are fixed attributes that are specified in
     * the View instance configuration. "Dynamic" attributes, on the other hand,
     * are values passed in as part of the model.
     * <p>Can be populated with a "map" or "props" element in XML bean definitions.
     *
     * @param attributes Map with name Strings as keys and attribute objects as values
     */
    @Override
    public void setAttributesMap( Map<String, ?> attributes )
    {
        Map extraModel = new HashMap();

        for ( String key : attributes.keySet() )
        {
            if( key.equalsIgnoreCase( "ConvertKeys" ) )
            {
                setConvertKeys( new Boolean( (String) attributes.get( key ) ) );
            }
            else if( key.equalsIgnoreCase( "ConvertCollections" ) )
            {
                setConvertCollections( new Boolean( (String)attributes.get( key ) ) );
            }
            else if( key.equalsIgnoreCase( "ConvertNulls" ) )
            {
                setConvertNulls( new Boolean( (String) attributes.get( key ) ) );
            }
            else if( key.equalsIgnoreCase( "LowerCaseKeys" ) )
            {
                setLowerCaseKeys( new Boolean( (String) attributes.get( key ) ) );
            }
            else if( key.equalsIgnoreCase( "beans" ) )
            {
                setBeans( (Map) attributes.get( key ) );
            }
            else
            {
                extraModel.put( key, attributes.get( key ) );
            }
        }

        super.setAttributesMap( extraModel );
    }



    /** Render the internal resource given the specified model. This includes setting the model as request attributes. */
    @Override
    protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) throws Exception
    {
        // Add mvc model to CF request scope.
        if( model == null )
        {
            model = new HashMap();
        }

        if( serializer == null )
        {
            serializer = new ColdFusionSerializer(this.convertCollections, this.convertKeys, this.convertNulls, this.lowerCaseKeys);
        }


        // Handle the auto conversion features to make the java more CF friendly
        model = (Map)serializer.serialize( model );

        // init system scope
        setupSystemScope(model);


        // put java model in CF REQUEST SCOPE
        exposeModelAsRequestAttributes(model, request);
        // Render view
        super.renderMergedOutputModel(model, request, response);



    }

    protected void setupSystemScope(Map<String, Object> model) {
        // Properties to pass back to CF, under the "palladium" node.
        Map properties = new HashMap();
        properties.put( "version",   "1.0." +buildNumber );

        if( getBeans() != null )
        {
            properties.put( "beans",  getBeans() );
        }

        // create palladium node to pass properties back to cf
        model.put("palladium", properties );
    }
}
