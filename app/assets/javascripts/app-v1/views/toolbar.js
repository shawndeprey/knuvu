App.ToolbarView = Ember.View.extend({
  templateName: 'toolbar',
  classNames: ['toolbar'],
  classNameBindings: ['openBar'],
  openBar: true,
  openUserMenu: false,
  toggleMenuOption: function(menuOption){
    this.set(menuOption, !this.get(menuOption));
  }
});