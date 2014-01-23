<html>
<head>
  <title>Ernst-Reuter-Platz Unf&aumllle</title>
 
  <script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
   <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
  <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
  <script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
  
  <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
  <meta charset="utf-8">
  <style>
      html, body, #map-canvas {
        height: 100%;
        margin: 20px;
        padding: 20px;
       	font-family: "Trebuchet MS", "Helvetica", "Arial",  "Verdana", "sans-serif";
		font-size: 100%;
      }
      
      
	  #feedback { font-size: 1.4em; }
	  #selectable .ui-selecting { background: #FECA40; }
	  #selectable .ui-selected { background: #F39814; color: white; }
	  #selectable { list-style-type: none; margin: 0; padding: 0; width: 200px; }
	  #selectable li { margin: 3px; padding: 0.4em; font-size: 1.4em; height: 18px; }
      
    </style>

    <script src="https://maps.googleapis.com/maps/api/js?sensor=false&libraries=places"></script>
	<script type="text/javascript" src="http://www.google.com/jsapi"></script>
    <script type="text/javascript">
      google.load('visualization', '1', {packages: ['linechart']});
    </script>
    <script type="text/javascript">
    var visualization;
var map;
var service;
var infowindow;
var berlin;
function initialize() {
  berlin = new google.maps.LatLng(52.512061800000, 13.321974500000);

  map = new google.maps.Map(document.getElementById('map-canvas'), {
      center: berlin,
      zoom: 17,
	  mapTypeId: google.maps.MapTypeId.SATELLITE
    });

 <%@ page import = "java.sql.*" %>
  <%
  
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
		
		out.println("displayAccident(" + String.valueOf(latitude) + ", " + String.valueOf(longitude) + ");");
		}
	  
	  
	  
	  
	  //rset.close();
      stmt.close();
      conn.close();
	  
  %>
  
}


function hideRestOfMarkers(markersToDisplay){

	 for(var i = 0; i < markersArray.length; i++){
		markersArray[i].setVisible(false);
	 }
	 markersArray = [];
	 
}

function displayAccident(lat, lon) {
  

      var placeLatlng  = new google.maps.LatLng(lat,lon);
      createMarker(placeLatlng);

 
}

var markersArray = [];

function createMarker(placeLatlng) {

  var marker = new google.maps.Marker({
      position: placeLatlng,
      map: map,
      title: 'Hello World!'
  });
  
  markersArray.push(marker);

  google.maps.event.addListener(marker, 'click', function() {
    infowindow.setContent(place.name);
    infowindow.open(map, this);
  });
}


google.maps.event.addDomListener(window, 'load', initialize);
</script>

  <script>


function filterAccidents(){

	 
	    $.ajax({
            url: "filteredRequest.jsp?range="+$( "#amount" ).val()+"&years="+ $( "#selectable").find($(".ui-selected")).map(function() {return $(this).text();}).toArray().join("_"),
            success: function(data){
                eval(data);
             }
          });
		
}
  
  

  
  
  $(function() {
    $( "#slider-range-max" ).slider({
      range: "max",
      min: 1,
      max: 8,
      value: 2,
      slide: function( event, ui ) {
	  switch(ui.value)
		{
		case 1:
			$( "#amount" ).val("0:00 - 5:59");
		  	break;
		case 2:
			$( "#amount" ).val("6:00 - 7:59");
		  break;
		case 3:
			$( "#amount" ).val("8:00 - 10:29");			
		  break;
		case 4:
			$( "#amount" ).val("10:30 - 12:59");
		  break;
		case 5:
			$( "#amount" ).val( "13:00 - 15:29");
		  	break;
		case 6:
			$( "#amount" ).val("15:30 - 17:59");
		  break;
		case 7:
			$( "#amount" ).val( "18:00 - 20:29" );
		  break;
		case 8:
			$( "#amount" ).val( "20:30 - 23:59" );
		  break;
  
		default:
			filterAccidents();
		  break;
		}
		
		
			
	          
      }
    });
    
   $( "#amount" ).val("6:00 - 7:59" );
  });
  
  $(function() {
	    $( "#selectable" ).selectable({
	    	  selected: function( event, ui ) {
	    		  
	    		  filterAccidents();
	    		          
	    	      }
	    		  
	    		  
	    		  
	    });
	});
  
  
  
  
  </script> 



  
  
</head>
<body>
  <h1>Unf&aumllle am Ernst-Reuter-Platz</h1>
<!--   <h3>by Viktor Stoitschev, Jakob und Mandy</h3> -->
  

<table style="float:left;">

<tr>
<td>
<p>
  <label for="amount">Uhrzeit:</label>
  <input type="text" id="amount" style="border:0; color:#f6931f; font-weight:bold;">
</p> 
<div style="width: 200px">
<div id="slider-range-max"></div>
</div>
</td>
</tr>

<tr>
<td>
 <ol id="selectable">
  <li class="ui-widget-content">2009</li>
  <li class="ui-widget-content">2010</li>
  <li class="ui-widget-content">2011</li>
  <li class="ui-widget-content">2012</li>
</ol>   
</td>
</tr>
</table>
<div id="map-canvas"></div>
</body>
</html>
  
  