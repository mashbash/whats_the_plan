function doneProcessing() {
  if ($('h1#processing').html()=="Calculating best route. Please reload in a few seconds") {
    window.location.reload(true);
  }
}