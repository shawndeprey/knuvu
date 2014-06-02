App.IndexRoute = App.BaseRoute.extend({
  model: function(){
    //return this.store.createRecord('betalist');
    return {test: 'Test Attribute'};
  }
});