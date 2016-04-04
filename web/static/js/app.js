// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

$('#team-a-score').change(function() {
  updateBothPanelColors()
});
$('#team-b-score').change(function() {
  updateBothPanelColors()
});

var changePanelColor = function(score) {
  var panel = score.parent().parent()
  var body = score.text()
  var allClasses = 'panel-default panel-danger panel-success'
  if (body === "W") {
    panel.removeClass(allClasses).addClass('panel-success')
  } else if (body === "L") {
    panel.removeClass(allClasses).addClass('panel-danger')
  } else {
    panel.removeClass(allClasses).addClass('panel-default')
  }
}

var updateBothPanelColors = function() {
  changePanelColor($('#team-a-score'))
  changePanelColor($('#team-b-score'))
}

updateBothPanelColors()

export var RoomShow = {
  run: function(){
    var background = "url(\"/images/match_backgrounds/bg_";
    background += Math.floor(Math.random() * 121) + 1;
    background += ".gif\")";
    background += " no-repeat center center fixed";
    $("body").css({
      "background": background,
      "-webkit-background-size": "cover", /* For WebKit*/
      "-moz-background-size": "cover",    /* Mozilla*/
      "-o-background-size": "cover",      /* Opera*/
      "background-size": "cover"         /* Generic*/
    });
  }
}



import socket from "./socket"
