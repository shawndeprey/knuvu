App.ResetPasswordRoute = App.BaseRoute.extend({
  setupController: function(controller, model){
    controller.reset();
  }
});