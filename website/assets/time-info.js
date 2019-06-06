var toggle = true;
var AOSdate = "June 7, 2019 15:00:00";
var LOSdate = "June 7, 2019 17:00:00";

var AOStime = new Date(AOSdate).toLocaleTimeString('en-US', { hour12: false, hour: 'numeric', minute: 'numeric' , second: 'numeric'});;
var LOStime = new Date(LOSdate).toLocaleTimeString('en-US', { hour12: false, hour: 'numeric', minute: 'numeric' , second: 'numeric'});;
setInterval(function() {
  // Display current time
  var d = new Date().toLocaleTimeString('en-US', { hour12: false, hour: 'numeric', minute: 'numeric' , second: 'numeric'});
  var parts = d.split(":");
  $('#hours').text(parts[0]);
  $('#minutes').text(parts[1]);
  $('#seconds').text(parts[2]);

  // Display LOS hours
  var LOS = LOStime.split(":");
  $('#LOS-hours').text(LOS[0]);
  $('#LOS-minutes').text(LOS[1]);
  $('#LOS-seconds').text(LOS[2]);

  // Display AOS hours
  var AOS = AOStime.split(":");
  $('#AOS-hours').text(AOS[0]);
  $('#AOS-minutes').text(AOS[1]);
  $('#AOS-seconds').text(AOS[2]);

  // Blink all colons
  var c = document.getElementsByClassName("colon");
  for(var i=0; i<c.length; i++){
    $(c[i]).css({ visibility: toggle?"visible":"hidden"});
  }
  toggle=!toggle;


  var LOScountdown = new Date(LOSdate).getTime() - new Date().getTime()
  // Calculate number of seconds till the specified time (ignoring days)
  var LOSseconds = Math.floor((LOScountdown % (1000*60*60*24))/1000);
  // Display seconds at HTML element with id LOS-T
  $('#LOS-T').text(LOSseconds)

  var AOScountdown = new Date(AOSdate).getTime() - new Date().getTime()
  var AOSseconds = Math.floor((AOScountdown % (1000*60*60*24))/1000);
  $('#AOS-T').text(AOSseconds)

},1000);
