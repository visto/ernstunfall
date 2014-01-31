  <%@ page import = "java.sql.*" %>
  <%@ page import = "de.tub.openbigdata.conn.*" %>
  <%
       QuerySubmitter queryMan = new QuerySubmitter();
       ResultSet rset = queryMan.displayAllAccidents();
       Double latitude = 0.0;
       Double longitude = 0.0;
	   out.println("hideRestOfMarkers('');");
	   while (rset.next()) {
	          latitude = rset.getDouble("GPS_Lat");
	  		  longitude = rset.getDouble("GPS_Long"); 
       out.println("displayAccident(" + String.valueOf(latitude) + ", " + String.valueOf(longitude) + ");");
  		}
	   /* out.println("hideRestOfMarkers('');"); */
	  
  %>
  