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
      this.setErrors(['Error object not found in request. Please contact an administrator about this issue.']);
    }
  },
  setErrors: function(errors){
    this.set('errors', errors);
    $('.errors').scrollToElement();
    this.set('disabled', false);
    $('div#app-loading-indicator').addClass('off');
  },
  clearErrors: function(){
    this.set('errors', null);
    this.set('disabled', true);
    $('div#app-loading-indicator').removeClass('on');
  }
});