<html>
<head>
<body>
 <%@ page import = "java.sql.*" %>
 <%@ page import = "de.tub.openbigdata.conn.*" %>
 <% 
 QuerySubmitter queryMan = new QuerySubmitter();
 ResultSet rset = queryMan.getAccidentsForTimeRange(request.getParameter("range"));
 %>
</body>
</head>

</html>