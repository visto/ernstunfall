<%@ page import = "java.sql.*" %>
 <%@ page import = "de.tub.openbigdata.conn.*" %>
 <%QuerySubmitter queryMan = new QuerySubmitter();
 ResultSet rset = queryMan.getReasons();
 String evalthis = "";
 while(rset.next()){
		String description = rset.getString("Description");
		if(rset.wasNull()){
			description = "";
		}
		
		description = description.replace("\"", "");
		float percentage = rset.getFloat("percentage");
		
		evalthis+= "addToReasons('" + String.valueOf((int)percentage) + "', '" + String.valueOf(description) + "');";
		
 
 
}
evalthis+="drawPieForReasons();";
out.println(evalthis); %>
