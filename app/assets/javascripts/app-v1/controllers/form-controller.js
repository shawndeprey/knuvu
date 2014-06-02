App.FormController = App.BaseController.extend({
  errors: null,
  disabled: false,
  reset: function(){
    this.set('errors', null);
    this.set('disabled', false);
  },
  parseErrorsFromResponse: function(response){
    if(response.responseJSON){
      this.setErrors(response.responseJSON.errors);
    } else {
      this.setErrors(['There was an issue with your submission. Please check your entries and try again.']);
    }
  },
  setErrors: function(errors){
    this.set('errors', errors);
    $('.errors').scrollToElement();
    this.set('disabled', false);
  },
  clearErrors: function(){
    this.set('errors', null);
    this.set('disabled', true);
  }
});