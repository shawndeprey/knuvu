App.BaseRoute = Ember.Route.extend({
  actions: {
    loading: function(transition, originRoute) {
      $('div#app-loading-indicator').addClass('on');
      return true;
    },
    didTransition: function(){
      $('div#app-loading-indicator').removeClass('on');
    },
    error: function(reason, transition) {
      if (reason.status === 404) {
        this.transitionTo('/not-found');
      } else {
        console.log('Something went wrong in the base route (reason: ' + reason.status + ')');
      }
    }
  },
  setupController: function(controller, model){
    controller.reset();
  }
});