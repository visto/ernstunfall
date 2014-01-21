package de.tub.openbigdata.conn;

import java.sql.*;

public class QuerySubmitter {
	
	String MYSQL_USERNAME = System.getenv("OPENSHIFT_MYSQL_DB_USERNAME");
    String MYSQL_PASSWORD = System.getenv("OPENSHIFT_MYSQL_DB_PASSWORD");
    String MYSQL_DATABASE_HOST = System.getenv("OPENSHIFT_MYSQL_DB_HOST");
    String MYSQL_DATABASE_PORT = System.getenv("OPENSHIFT_MYSQL_DB_PORT");
    String MYSQL_DATABASE_NAME = System.getenv( "OPENSHIFT_APP_NAME");
    String MYSQL_DATABASE_DRIVER = "com.mysql.jdbc.Driver";
    
    
/*     String MYSQL_DATABASE_PORT = "48266";
    String MYSQL_DATABASE_HOST = "52d533b64382ecc670000075-delysid.rhcloud.com";
    String MYSQL_PASSWORD = "TzW6621jyUrG";
    String MYSQL_USERNAME = "adminxzEwuJN";
    String MYSQL_DATABASE_NAME = "ernstunfall";
    String MYSQL_DATABASE_DRIVER = "com.mysql.jdbc.Driver";  */
    
    
    public Connection getConnection(){
    	
    	Connection conn = null;
//    	ResultSet rset = null;
//    	Statement stmt = null;
    	
	    try {
                Class.forName("com.mysql.jdbc.Driver");
            } catch (ClassNotFoundException cnfe) {
                cnfe.getMessage();
            }
			String url = "";
  
                url = "jdbc:mysql://" + MYSQL_DATABASE_HOST + ":" + MYSQL_DATABASE_PORT + "/" + MYSQL_DATABASE_NAME;
                try {
					conn = DriverManager.getConnection(url, MYSQL_USERNAME, MYSQL_PASSWORD);
//					stmt = conn.createStatement();
//					
//					String sqlStr = "SELECT * FROM unfaelle";
//					
//					// for debugging
//					System.out.println("Query statement is " + sqlStr);
//					rset = stmt.executeQuery(sqlStr);
//					
//
//					  
//					  rset.close();
//				      stmt.close();
//				      conn.close();
//					
					
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

//	      while (rset.next()) {
//        Double latitude = rset.getDouble("GPS_Lat");
//		Double longitude = rset.getDouble("GPS_Long");
//		
//		out.println("displayAccident(" + String.valueOf(latitude) + ", " + String.valueOf(longitude) + ");");
//		}
//	  
	  
	  
                return conn;
    	
    }
    
    public ResultSet submitQuery(String queryString){
    	
    	
    	ResultSet rset = null;
    	Statement stmt = null;
    	Connection conn = getConnection();
		try {
			stmt = conn.createStatement();
			
			// for debugging
			System.out.println("Query statement is " + queryString);
			rset = stmt.executeQuery(queryString);
					
			//stmt.close();
			conn.close();
			
//		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return rset;
    }

    
    public ResultSet getAccidentsForTimeRange(String rangeString){
    	    	
    	String[] range = rangeString.split(" - ");
    	String begin = range[0];
    	String end = range[1];
    	
    	String sqlStr = "SELECT * FROM unfaelle WHERE Uhrzeit2 > '" + begin + "' AND Uhrzeit2 < '" + end + "'";
    	return submitQuery(sqlStr);
    	
    	
    }

}
