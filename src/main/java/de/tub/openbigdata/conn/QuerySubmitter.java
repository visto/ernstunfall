package de.tub.openbigdata.conn;

import java.sql.*;

public class QuerySubmitter {
	
	String MYSQL_USERNAME = System.getenv("OPENSHIFT_MYSQL_DB_USERNAME");
    String MYSQL_PASSWORD = System.getenv("OPENSHIFT_MYSQL_DB_PASSWORD");
    String MYSQL_DATABASE_HOST = System.getenv("OPENSHIFT_MYSQL_DB_HOST");
    String MYSQL_DATABASE_PORT = System.getenv("OPENSHIFT_MYSQL_DB_PORT");
    String MYSQL_DATABASE_NAME = System.getenv( "OPENSHIFT_APP_NAME");
    String MYSQL_DATABASE_DRIVER = "com.mysql.jdbc.Driver";
    
    
//    String MYSQL_DATABASE_PORT = "48266";
//    String MYSQL_DATABASE_HOST = "52d533b64382ecc670000075-delysid.rhcloud.com";
//    String MYSQL_PASSWORD = "TzW6621jyUrG";
//    String MYSQL_USERNAME = "adminxzEwuJN";
//    String MYSQL_DATABASE_NAME = "ernstunfall";
//    String MYSQL_DATABASE_DRIVER = "com.mysql.jdbc.Driver";  
//    

    public synchronized Connection getConnection(){
    	
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
    
    
    public synchronized ResultSet displayAllAccidents(){
    	
    	String sql = "SELECT GPS_Long, GPS_Lat FROM unfaelle";
    	return submitQuery(sql);
    	
    }
    
    public synchronized ResultSet submitQuery(String queryString){
    	
    	
    	ResultSet rset = null;
    	Statement stmt = null;
    	Connection conn = getConnection();
		try {
			stmt = conn.createStatement();
			
			// for debugging
			System.out.println("Query statement is " + queryString);
			rset = stmt.executeQuery(queryString);
					
			//stmt.close();
			//conn.close();
			
//		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			
			
			
		}
		
		return rset;
    }

    
    public synchronized ResultSet getAccidentsForTimeRange(String rangeString){
    	    	
    	String[] range = rangeString.split(" - ");
    	String begin = range[0];
    	String end = range[1];
    	
    	String sqlStr = "SELECT * FROM unfaelle WHERE Uhrzeit2 > '" + begin + "' AND Uhrzeit2 < '" + end + "'";
    	return submitQuery(sqlStr);
    	
    	
    }
    
    
    public synchronized ResultSet getAccidentsForYear(String year){

    	String sqlStr = "SELECT * FROM unfaelle WHERE  YEAR(Datum)='"+ year +"'";
    	return submitQuery(sqlStr);


}

    
    
    public synchronized ResultSet getFilteredAccidents(String rangeString, String years, String participant){
    	
    	String[] range = rangeString.split(" - ");
    	String begin = range[0];
    	String end = range[1];
    	
    	String[] yearsArr = years.split("_");
    	
    	
    	String sqlStr = "SELECT * FROM unfaelle WHERE Uhrzeit2 > '" + begin + "' AND Uhrzeit2 < '" + end + "'";
    	
    	for (int i = 0; i < yearsArr.length; i++) {
    		if(i == 0 && yearsArr.length > 0){
    			sqlStr+= " AND (YEAR(Datum)='"+ yearsArr[i] +"'";
				if(yearsArr.length == 1) sqlStr += ")";
    		} else {
    			sqlStr+= " OR YEAR(Datum)='"+ yearsArr[i] +"'";
				
				if(i == (yearsArr.length - 1)) sqlStr += ")";
			}
		}
    	
    	if(!participant.equals("")){
    		sqlStr+= " AND VK_Beteiligung = '" + participant + "'" ;
    	}
    	
    	return submitQuery(sqlStr);
    	
    	
    }
    
    public ResultSet getReasons(){
    	
    	//SELECT DISTINCT Ursachen1 from unfaelle  where Ursachen1 != 0  UNION ALL SELECT DISTINCT Ursachen2 from unfaelle  where Ursachen2 != 0 UNION ALL SELECT DISTINCT Ursachen3 from unfaelle  where Ursachen3 != 0
    	String sql = "SELECT Ursachen1, (100*COUNT(Ursachen1)/(select count(*) from unfaelle  where Ursachen1 != 0 AND Ursachen1 is not null)) from unfaelle where Ursachen1 is not null and Ursachen1 != 0 group by Ursachen1;";
    	return submitQuery(sql);
    	
    }
      
    
    
    
}
