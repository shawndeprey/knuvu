App.BaseController = Ember.ObjectController.extend({
  needs: ['application'],
  modal_text: null,
  actions: {
    closeModal: function() {
      $('.modal').fadeOut(250);
    }
  },
  reset: function(){},
  scroll_to: function(element){
    $(element).scrollToElement();
  },
  showModal: function(text) {
    this.controllerFor('application').set('modal_text', text);
    $('div.modal').fadeIn(250);
    setTimeout(function(){ $('.modal').fadeOut(250); }, 20000);
  }
});