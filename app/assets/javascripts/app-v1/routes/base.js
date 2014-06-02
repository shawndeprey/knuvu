App.BaseRoute = Ember.Route.extend({
  /*actions: {
    loading: function(transition, originRoute) {
      $('#app-loading-indicator').addClass('on');
      return true;
    },
    didTransition: function(){
      $('#app-loading-indicator').removeClass('on');
    }
  },*/
  setupController: function(controller, model){
    controller.reset();
  }
});