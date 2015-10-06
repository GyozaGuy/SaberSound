// Create sliders
var xslider = new Slider('#x');
var yslider = new Slider('#y');
var zslider = new Slider('#z');
var cslider = new Slider('#constraintslider');

// Setup listeners
xslider.on('slide', function(slideEvt) {
  updateFrequency();
});
yslider.on('slide', function(slideEvt) {
  updateFrequency();
});
zslider.on('slide', function(slideEvt) {
  updateFrequency();
});
cslider.on('slide', function(slideEvt) {
  updateFrequency();
});

// Update frequency value
function updateFrequency() {
  humfreq = parseFloat($('#humfreq').val());
  multiplier = parseInt($('#multiplier').val());
  x = xslider.getValue();
  y = yslider.getValue();
  z = zslider.getValue();
  average = (x + y + z) / 3;
  constraints = cslider.getValue();
  min = constraints[0];
  max = constraints[1];
  change = map(constrain(average, min, max), min, max, 0, multiplier);
  $('#average').text(average);
  $('#freq').text(humfreq + change);
}

function map(x, in_min, in_max, out_min, out_max) {
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}

function constrain(x, a, b) {
  if (x > a && x < b) {
    return x;
  } else if (x < a) {
    return a;
  } else if (x > b) {
    return b;
  } else {
    return null; // I guess?
  }
}
