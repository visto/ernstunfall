<%@ page import = "java.sql.*" %>
 <%@ page import = "de.tub.openbigdata.conn.*" %>
 <% 
 QuerySubmitter queryMan = new QuerySubmitter();
 ResultSet rset = queryMan.getReasons();

 while(rset.next()){
		String description = rset.getString("Description");
		if(rset.wasNull()){
			description = "";
		}
		
		description = description.replace("\"", "");
		Double percentage = rset.getDouble("percentage");
		out.println("addToReasons('" + String.valueOf(percentage) + "', '" + String.valueOf(description) + "');");
 
 
}
 
 out.println("drawPieForReasons()");
 
 %>