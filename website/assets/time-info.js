var toggle = true;
var countDownDate = "May 2, 2019 19:30:00";
var CDDate = new Date(countDownDate).toLocaleTimeString('en-US', { hour12: false, hour: 'numeric', minute: 'numeric' , second: 'numeric'});;
setInterval(function() {
  // Display current time
  var d = new Date().toLocaleTimeString('en-US', { hour12: false, hour: 'numeric', minute: 'numeric' , second: 'numeric'});
  var parts = d.split(":");
  $('#hours').text(parts[0]);
  $('#minutes').text(parts[1]);
  $('#seconds').text(parts[2]);

  // Display LOS hours
  var parts2 = CDDate.split(":");
  $('#LOS-hours').text(parts2[0]);
  $('#LOS-minutes').text(parts2[1]);
  $('#LOS-seconds').text(parts2[2]);

  // Blink all colons
  var c = document.getElementsByClassName("colon");
  for(var i=0; i<c.length; i++){
    $(c[i]).css({ visibility: toggle?"visible":"hidden"});
  }
  toggle=!toggle;


  var LOS = new Date(countDownDate).getTime() - new Date().getTime()
  // Calculate number of seconds till the specified time (ignoring days)
  var seconds = Math.floor((LOS % (1000*60*60*24))/1000);
  $('#LOS-T').text(seconds)

},1000);
