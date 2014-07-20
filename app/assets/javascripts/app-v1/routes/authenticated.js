App.AuthenticatedRoute = App.BaseRoute.extend({
  beforeModel: function(transition){
    var user = this.controllerFor('signin').get('user');
    if(user == undefined || user == null){
      this.redirectToSignin(transition);
    }
  },
  redirectToSignin: function(transition) {
    var signinController = this.controllerFor('signin');
    signinController.set('attemptedTransition', transition);
    signinController.set('errors', ['You must sign in to access this resource.']);
    this.transitionTo('signin');
  },
  actions: {
    error: function(reason, transition) {
      if (reason.status === 401) {
        //this.redirectToSignin(transition);
      } else {
        //alert('Something went wrong with authenticated route (reason: ' + reason.status + ')');
      }
    }
  }
});