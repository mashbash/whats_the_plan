var homepage = {

  images:      ['berlin', 'singapur', 'san-francisco'],
  image_links: ['https://s3-us-west-1.amazonaws.com/wtpphotos/berlin.jpg',
                'https://s3-us-west-1.amazonaws.com/wtpphotos/singapur.jpg',
                'https://s3-us-west-1.amazonaws.com/wtpphotos/san-francisco.jpg'],
  imageIndex: 0,

  init: function() {
    if (location.pathname !== "/") return

    this.displayImage();

    $('.icon-angle-right').on('click', function(){
      clearInterval(interval);
      homepage.displayNextImage();
    });
    $('.icon-angle-left').on('click', function(){
      clearInterval(interval);
      homepage.displayPreviousImage();
    });

    var interval = 0;
    $(function(){
      interval = setInterval(callFunc, 4000);
    });

    function callFunc(){
      $('.icon-angle-right').trigger('click');
      interval = setInterval(callFunc, 4000);
    }
  },

  displayNextImage: function() {
    this.setImageIndex('next');
    this.displayImage();
  },

  displayPreviousImage: function() {
    this.setImageIndex('previous');
    this.displayImage();
  },

  displayImage: function() {
    var image = this.images[this.imageIndex]
    $('.source-image').append(this.imageTemplate(image));
    $('.source-image img:hidden').fadeIn('slow', function() {
      $('.'+image).siblings('img').remove();
    });
    $('.listofplans .city-plans').remove();
    $('.listofplans').append(this.textTemplate());
    $('.listofplans').fadeIn('slow', function() {
    });
  },

  setImageIndex: function(direction) {
    if(direction == 'next') {
      this.imageIndex++;
      if(this.imageIndex == this.images.length) this.imageIndex = 0;
    } else if(direction == 'previous') {
      this.imageIndex--;
      if(this.imageIndex == -1) this.imageIndex = this.images.length-1;
    }
  },

  imageTemplate: function(name) {
    var imageLink = this.image_links[this.imageIndex]
    return '<img class="'+name+'" src="' + imageLink + '">'
  },

  textTemplate: function() {
    template = "templates/index_page_text_" + this.imageIndex
    return JST[template]();
  }
};
