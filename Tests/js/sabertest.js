// Create sliders
$('#x').slider({});
$('#y').slider({});
$('#z').slider({});

// Setup listeners
$('#x').change(function() {
  updateFrequency();
});
$('#y').change(function() {
  updateFrequency();
});
$('#z').change(function() {
  updateFrequency();
});

// Setup constraintslider because it seems to work differently than the others
var slider = new Slider('#constraintslider');
slider.on('slide', function(slideEvt) {
  updateFrequency();
});

// Update frequency value
function updateFrequency() {
  humfreq = parseFloat($('#humfreq').val());
  multiplier = parseInt($('#multiplier').val());
  x = $('#x').slider().slider('getValue');
  y = $('#y').slider().slider('getValue');
  z = $('#z').slider().slider('getValue');
  average = (x + y + z) / 3;
  constraints = slider.getValue();
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
