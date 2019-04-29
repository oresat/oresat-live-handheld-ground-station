var toggle = true;
setInterval(function() {
  var d = new Date().toLocaleTimeString('en-US', { hour12: false, hour: 'numeric', minute: 'numeric' , second: 'numeric'});
  var parts = d.split(":");
  $('#hours').text(parts[0]);
  $('#minutes').text(parts[1]);
  $('#seconds').text(parts[2]);
  $("#colon").css({ visibility: toggle?"visible":"hidden"});
  $("#colon2").css({ visibility: toggle?"visible":"hidden"});
  toggle=!toggle;
},1000);
