<html>
<head>
<body>
 <%@ page import = "java.sql.*" %>
 <%@ page import = "de.tub.openbigdata.conn.*" %>
 <% 
 QuerySubmitter queryMan = new QuerySubmitter();
 ResultSet rset = queryMan.getAccidentsForTimeRange(request.getParameter("range"));
 String result;
 while(rset.next()){

result=rset.getString(0);

}
 
 out.println(result);
 
 %>
</body>
</head>

</html>