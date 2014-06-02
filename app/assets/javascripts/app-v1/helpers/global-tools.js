(function ( $ ) {
  $.fn.scrollToElement = function( options ) {
    $('html,body').animate({
      scrollTop: this.offset().top
    }, 500);
  };
}( jQuery ));