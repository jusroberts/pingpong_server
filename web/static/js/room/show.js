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
