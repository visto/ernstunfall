 <%@ page import = "java.sql.*" %>
 <%@ page import = "de.tub.openbigdata.conn.*" %>
 <% 
 QuerySubmitter queryMan = new QuerySubmitter();
 ResultSet rset = queryMan.getAccidentsForTimeRange(request.getParameter("range"));
 out.println("hideRestOfMarkers('');");
 while(rset.next()){

		Double latitude = rset.getDouble("GPS_Lat");
		Double longitude = rset.getDouble("GPS_Long");
	
		out.println("displayAccident(" + String.valueOf(latitude) + ", " + String.valueOf(longitude) + ");");
 
 
}
  
 %>
