// Allows for pausing of video stream
var playing = true;
var callback;

function reload_img() {
    var d = new Date();
    document.getElementById('live-stream').src="/latest.jpg?now="+d.getTime();
}

function play() {
    var btn = document.getElementById('btn');
    btn.innerText = 'Pause';
    callback = setInterval(reload_img, 500);
    playing = true;
}

function pause() {
    var btn = document.getElementById('btn');
    btn.innerText = 'Play';
    clearInterval(callback);
    playing = false;
}

function btn_clicked() {
    if (playing == true) { 
    pause();
    }
    else {
    play();
    }
}