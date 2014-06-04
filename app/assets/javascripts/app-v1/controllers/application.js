App.ApplicationController = App.BaseController.extend({
  //needs: ['session'],
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
  }
});