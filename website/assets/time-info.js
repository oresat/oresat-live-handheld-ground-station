var toggle = true;
setInterval(function() {
  var d = new Date().toLocaleTimeString('en-US', { hour12: false, hour: 'numeric', minute: 'numeric' , second: 'numeric'});
  var parts = d.split(":");
  $('#hours').text(parts[0]);
  $('#minutes').text(parts[1]);
  $('#seconds').text(parts[2]);

  // Blink all colons
  var c = document.getElementsByClassName("colon");
  for(var i=0; i<c.length; i++){
    $(c[i]).css({ visibility: toggle?"visible":"hidden"});
  }
  toggle=!toggle;
},1000);
