App.ToolbarView = Ember.View.extend({
  templateName: 'toolbar',
  classNames: ['toolbar'],
  classNameBindings: ['openBar'],
  openBar: true,
  toggleToolbar: function(){
    this.set('openBar', !this.get('openBar'));
  }
});