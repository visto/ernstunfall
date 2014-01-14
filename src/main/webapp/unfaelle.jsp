<html>
<head>
  <title>Book Query</title>
  <link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.0/jquery.mobile-1.4.0.min.css" />
  <script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
  <script src="http://code.jquery.com/mobile/1.4.0/jquery.mobile-1.4.0.min.js"></script>
  
</head>
<body>
  <h1>Unfälle am Ernst-Reuter-Platz</h1>
  <h3>by Viktor Stoitschev, Jakob und Mandy</h3>

 <%@ page import = "java.sql.*" %>
  <%
  
	String MYSQL_USERNAME = System.getenv("OPENSHIFT_MYSQL_DB_USERNAME");
    String MYSQL_PASSWORD = System.getenv("OPENSHIFT_MYSQL_DB_PASSWORD");
    String MYSQL_DATABASE_HOST = System.getenv("OPENSHIFT_MYSQL_DB_HOST");
    String MYSQL_DATABASE_PORT = System.getenv("OPENSHIFT_MYSQL_DB_PORT");
    String MYSQL_DATABASE_NAME = System.getenv( "OPENSHIFT_APP_NAME");
    String MYSQL_DATABASE_DRIVER = "com.mysql.jdbc.Driver";
	Connection conn = null;
	
	
	    try {
                Class.forName("com.mysql.jdbc.Driver");
            } catch (ClassNotFoundException cnfe) {
                cnfe.getMessage();
            }
	 String url = "";
  
                url = "jdbc:mysql://" + MYSQL_DATABASE_HOST + ":" + MYSQL_DATABASE_PORT + "/" + MYSQL_DATABASE_NAME;
                conn = DriverManager.getConnection(url, MYSQL_USERNAME, MYSQL_PASSWORD);
	Statement stmt = conn.createStatement();
	
      String sqlStr = "SELECT * FROM unfaelle";
 
      // for debugging
      System.out.println("Query statement is " + sqlStr);
      			

			
			ResultSet rset = stmt.executeQuery(sqlStr);

	      while (rset.next()) {
        Double latitude = rset.getDouble("GPS_Lat");
		Double longitude = rset.getDouble("GPS_Long");
		
		out.println(String.valueOf(latitude) + ", " + String.valueOf(longitude));
		}
	  
	  
	  
	  
	  rset.close();
      stmt.close();
      conn.close();
	  
  %>
 
 </body>
 <html>
  
  