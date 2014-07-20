App.SigninController = App.FormController.extend({
  user: null,
  email: null,
  password: null,
  attemptedTransition: null,
  actions: {
    submit: function(event){
      var self = this;
      var email = this.get('email');
      var password = this.get('password');
      self.clearErrors();

      if(email && password){
        $.ajax({type:'POST', url: '/'+namespace+'/session.json?email='+email+'&password='+password}).then(
          function(response){
            self.store.pushPayload('user', {user:response.user});
            self.set('user', self.store.find('user', response.user.id));

            var attemptedTransition = self.get('attemptedTransition');
            if(attemptedTransition) {
              self.set('attemptedTransition', null);
              attemptedTransition.retry();
            } else {
              // Redirect to 'index' by default.
              self.transitionToRoute('dashboard');
            }
          },
          function(response){
            self.parseErrorsFromResponse(response);
          }
        );
      } else {
        if(!email){
          self.setErrors(['A valid email is required to sign in to KnuVu.']);
        } else {
          self.setErrors(['A password is required to sign in to KnuVu.']);
        }
      }
    }
  },
  deauthenticate: function() {
    // Call server de-auth route
    var self = this;
    $.ajax({type:'DELETE', url: '/'+namespace+'/session.json'}).then(
      function(session){
        self.set('user', null);
      },
      function(response){
        // Handle Fail Cases
      }
    );
  }
});