function doneProcessing() {
  if ($('h1#processing').html()=="Calculating best route! Page will load in a few seconds.") {
    window.location.reload(true);
  }
}
