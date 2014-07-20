App.ApplicationController = App.BaseController.extend({
  needs: ['signin'],
  menu_title: 'Knuvu',
  setTitle: function(title, use_suffix) {
    if (typeof use_suffix == 'undefined') {
      use_suffix = true;
    }

    if (typeof title != 'undefined') {
      document.title = title;

      if (use_suffix) {
        document.title += ' - Knuvu';
      }
    } else {
      document.title = 'Knuvu';
    }
  },
  session_user: function() {
    return this.get('controllers.signin.user');
  }.property('controllers.signin.user'),
  deauthenticate: function() {
    this.get('controllers.signin').deauthenticate();
  }
});