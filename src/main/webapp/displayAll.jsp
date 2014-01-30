  <%@ page import = "java.sql.*" %>
  <%@ page import = "de.tub.openbigdata.conn.*" %>
  <%
       QuerySubmitter queryMan = new QuerySubmitter();
       ResultSet rset = queryMan.displayAllAccidents();
	   while (rset.next()) {
	          Double latitude = rset.getDouble("GPS_Lat");
	  		  Double longitude = rset.getDouble("GPS_Long"); 
  		}
	   out.println("hideRestOfMarkers('');");
       out.println("displayAccident(" + String.valueOf(latitude) + ", " + String.valueOf(longitude) + ");");
	  
	  //rset.close();
      stmt.close();
      conn.close();
	  
  %>
  