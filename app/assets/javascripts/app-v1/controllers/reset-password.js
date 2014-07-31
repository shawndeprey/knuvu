App.ResetPasswordController = App.FormController.extend({
  stageOne: true,
  email: null,
  resetHash: null,
  password: null,
  actions: {
    submit: function(event){
      var self = this;
      if(self.stageOne){
        $.ajax({type:'POST', url: '/'+namespace+'/users/password_reset_request.json?email='+self.email}).then(
          function(response){
            self.clearErrors();
            self.reset();
            self.set('stageOne', false);
            self.showModal('Please check your email for a confirmation code to complete password reset.');
          },
          function(response){
            self.parseErrorsFromResponse(response);
          }
        );
      } else {
        $.ajax({type:'POST', url: '/'+namespace+'/users/reset_password.json?reset_hash='+self.resetHash+'&password='+self.password}).then(
          function(response){
            self.showModal('Password reset successfully, welcome back to KnuVu!');
            self.transitionToRoute('signin');
          },
          function(response){
            self.parseErrorsFromResponse(response);
          }
        );
      }
    }
  }
});