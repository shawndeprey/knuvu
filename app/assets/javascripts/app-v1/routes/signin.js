App.SigninRoute = App.BaseRoute.extend({
  model: function(){
    return this.store.createRecord('user');
  }
});