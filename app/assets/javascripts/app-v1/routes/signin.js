App.SigninRoute = App.BaseRoute.extend({
  model: function(){
    return this.store.createRecord('user');
  },
  setupController: function(controller, model){
    controller.reset();
    controller.set('model', model);
  }
});