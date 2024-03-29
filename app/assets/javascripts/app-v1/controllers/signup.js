App.SignupController = App.FormController.extend({
  actions: {
    submit: function(event){
      var self = this;
      self.clearErrors();
      self.get('model').save().then(
        function(inquiry){
          self.showModal('Welcome to KnuVu, You\'re almost done! Please sign in to verify your account credentials.');
          self.resetModel();
          self.transitionToRoute('signin');
        },
        function(response){
          self.parseErrorsFromResponse(response);
        }
      );
    }
  },
  resetModel: function(){
    this.set('model', this.store.createRecord('user'));
    this.set('disabled', false);
  }
});