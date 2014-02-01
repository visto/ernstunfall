<html>
<head>
  <title>Ernst-Reuter-Platz Unf&aumllle</title>
 
  <script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
   <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
  <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
  <script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
  <script src="scripts/raphael-min.js" type="text/javascript"></script>
  <script src="scripts/g.raphael-min.js"></script>
  <script src="scripts/g.pie-min.js"></script>
  
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
      
      
       #map-canvas {
        height: 45%;
      }
      
	  #feedback { font-size: 1.4em; }
	  #selectable .ui-selecting { background: #FECA40; }
	  #selectable .ui-selected { background: #F39814; color: white; }
	  #selectable { list-style-type: none; margin: 0; padding: 0; width: 200px; }
	  #selectable li { margin: 3px; padding: 0.4em; font-size: 1.4em; height: 18px; }
		      
		table
		{
			float:left; margin-right:20px
		}
		
		td{
		border:1px solid black;
		}
		</style>
      
      
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
	
	}


function hideRestOfMarkers(markersToDisplay){

	 for(var i = 0; i < markersArray.length; i++){
		markersArray[i].setMap(null);
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

  
  $( document ).ready(function() {
  $("#amount" ).val("0:00 -  23:59" );
  

  $("#activateTimeRange").change(function() {
      if(this.checked) {
		
    	  $( "#amount" ).val("10:30 - 12:59");
    	  $("#sliderdiv").show();
      
      }else{
    	  
    	  $("#amount" ).val("0:00 -  23:59" );
    	  $("#sliderdiv").hide();
    	  
      }
      
      filterAccidents();
  });
 
  
  
  $.ajax({
      url: "reasons.jsp",
      success: function(data){
          eval(data);
       }
    });
  
  
  
  
	});
  
  
  
function filterAccidents(){

	 
	    $.ajax({
            url: "filteredRequest.jsp?range="+$( "#amount" ).val()+"&years="+ $( "#selectable").find($(".ui-selected")).map(function() {return $(this).text();}).toArray().join("_")+"&participant=" + $("#participant").val(),
            success: function(data){
                eval(data);
             }
          });
		
}

function showAll(){

    $.ajax({
        url: "displayAll.jsp",
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
			filterAccidents();
		  	break;
		case 2:
			$( "#amount" ).val("6:00 - 7:59");
			filterAccidents();
		  break;
		case 3:
			$( "#amount" ).val("8:00 - 10:29");
			filterAccidents();
		  break;
		case 4:
			$( "#amount" ).val("10:30 - 12:59");
			filterAccidents();
		  break;
		case 5:
			$( "#amount" ).val( "13:00 - 15:29");
			filterAccidents();
		  	break;
		case 6:
			$( "#amount" ).val("15:30 - 17:59");
			filterAccidents();
		  break;
		case 7:
			$( "#amount" ).val( "18:00 - 20:29" );
			filterAccidents();
		  break;
		case 8:
			$( "#amount" ).val( "20:30 - 23:59" );
			filterAccidents();
		  break;
  
		default:
			filterAccidents();
		  break;
		}
		
		
			
	          
      }
    });
    
   $( "#amount" ).val("0:00 -  23:59" );
   filterAccidents();
  });
  
  $(function() {
	    $( "#selectable" ).selectable({
	    	  selected: function( event, ui ) {
	    		  
	    		  filterAccidents();
	    		          
	    	      }
	    		  
	    		  
	    		  
	    });
	});
  
  
  
  var percentages = [];
  var descriptions = [];
  
  function addToReasons(percentage, description){
	  
	  percentages.push(percentage);
	  descriptions.push(description);
	  
  }
  
  function drawPieForReasons(){
	  
	  var paper = Raphael("pie");
	  var pie = paper.piechart(
	    100, // pie center x coordinate
	    100, // pie center y coordinate
	    90,  // pie radius
	    percentages, // values
	     {
	     legend: descriptions
	     }
	   );
	  
	  
	  pie.hover(function () {
	      this.sector.stop();
	      this.sector.scale(1.1, 1.1, this.cx, this.cy);

	      if (this.label) {
	          this.label[0].stop();
	          this.label[0].attr({ r: 7.5 });
	          this.label[1].attr({ "font-weight": 800 });
	      }
	  }, function () {
	      this.sector.animate({ transform: 's1 1 ' + this.cx + ' ' + this.cy }, 500, "bounce");

	      if (this.label) {
	          this.label[0].animate({ r: 5 }, 500, "bounce");
	          this.label[1].attr({ "font-weight": 400 });
	      }
	  });
	  
  }
  
  
  </script> 



  
  
</head>
<body>
  <h1>Unf&aumllle am Ernst-Reuter-Platz</h1>
<!--   <h3>by Viktor Stoitschev, Jakob und Mandy</h3> -->
  

<table cellpadding="10">

<tr>
<td>
<p>
  <label for="showALl">Alle Unf&aumllle:</label>
  <BR>
  <input type="button" value="Anzeigen" onclick="showAll()" id="showALl" style="border:0; color:#f6931f; font-weight:bold;">
  <input type="button" value="Verstecken" onclick="hideRestOfMarkers('')" id="showALl" style="border:0; color:#f6931f; font-weight:bold;">	
</p>

</td>
</tr>
<tr>
<td>
<input id="activateTimeRange" type="checkbox" name="fulltime" value="activateTimeRange">Zeitbereich ausw&aumlhlen<br>
<p>
  <label for="amount">Uhrzeit:</label>
  <input type="text" id="amount" style="border:0; color:#f6931f; font-weight:bold;" readonly>
</p> 
<div id="sliderdiv" style="width: 200px; display:none">
<div id="slider-range-max"></div>
</div>
</td>
</tr>

<tr>
<td>
<label for="amount">Jahr:</label>
 <ol id="selectable">
  <li class="ui-widget-content">2009</li>
  <li class="ui-widget-content">2010</li>
  <li class="ui-widget-content">2011</li>
  <li class="ui-widget-content ui-selected">2012</li>
</ol>   
</td>
</tr>

<tr>
<td>
 
 <label for="">Beteiligung:</label>
 <BR>
<select id="participant" onChange="javascript:filterAccidents();">
  <option value=''">Egal</option>
  <option value='Bus'">Bus</option>
  <option value='Fu'">Fu</option>
  <option value='Lkw'">Lkw</option>
  <option value='mot. Zweirad'">mot. Zweirad</option>
  <option value='Pkw'">Pkw</option>
  <option value='Pkw mit Anh'">Pkw mit Anh</option>
  <option value='Radfahrer'">Radfahrer</option>
  <option value='sonstiges Fahrzeug'">sonstiges Fahrzeug</option>
  
</select>
</td>
</tr>

</table>
<div id="map-canvas"></div>
<div style="border:1px solid black; position:absolute; left:80px; width:400px; height: 200px" id="pie"></div>

</body>
</html>
  
  