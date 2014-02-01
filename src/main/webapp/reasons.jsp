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
		Double percentage = rset.getDouble("percentage");
		
		evalthis+= "addToReasons('" + String.valueOf(percentage) + "', '" + String.valueOf(description) + "');";
		
 
 
}
evalthis+="drawPieForReasons();";
out.println(evalthis); %>
