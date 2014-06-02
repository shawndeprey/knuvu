Ember.Handlebars.helper('format_date', function(date, options) {
  return moment(date).format('LL');
});

Ember.Handlebars.helper('default_value', function(obj, options) {
  return obj || 'N/A';
});