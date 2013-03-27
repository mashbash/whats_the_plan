var homepage = {
  init: function() {
    $('#singapur-plans').hide();
    $('#san-francisco-plans').hide();
    $('.icon-angle-right').on('click', function(){
      clearInterval(interval);
      if ($('#berlin').hasClass('opaque')) {
        $('#berlin').removeClass('opaque');
        $('#singapur').addClass('opaque');
        $('#berlin-plans').hide('slow');
        $('#singapur-plans').show('slow');
      } else if ($('#singapur').hasClass('opaque')) {
        $('#singapur').removeClass('opaque');
        $('#san-francisco').addClass('opaque');
        $('#singapur-plans').hide('slow');
        $('#san-francisco-plans').show('slow');
      } else if ($('#san-francisco').hasClass('opaque')) {
        $('#san-francisco').removeClass('opaque');
        $('#berlin').addClass('opaque');
        $('#san-francisco-plans').hide('slow');
        $('#berlin-plans').show('slow');
      }; 
    });
    $('.icon-angle-left').on('click', function(){
      clearInterval(interval);
      if ($('#berlin').hasClass('opaque')) {
        $('#berlin').removeClass('opaque');
        $('#san-francisco').addClass('opaque');
        $('#berlin-plans').hide('slow');
        $('#san-francisco-plans').show('slow');
      } else if ($('#singapur').hasClass('opaque')) {
        $('#singapur').removeClass('opaque');
        $('#berlin').addClass('opaque');
        $('#singapur-plans').hide('slow');
        $('#berlin-plans').show('slow');
      } else if ($('#san-francisco').hasClass('opaque')) {
        $('#san-francisco').removeClass('opaque');
        $('#singapur').addClass('opaque');
        $('#san-francisco-plans').hide('slow');
        $('#singapur-plans').show('slow');
      }; 
    });

    var interval = 0;
    $(function(){
      interval = setInterval(callFunc, 4000);
    });

    function callFunc(){
      $('.icon-angle-right').trigger('click');
    }
  }
};



