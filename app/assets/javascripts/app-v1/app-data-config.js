// Ensure we tell ember to use an adapter which conforms to Active Record style naming schemes
App.Store = DS.Store.extend({
  adapter: 'DS.ActiveModelAdapter'
});

// Configure jquery to preface non-GET requests with a CSRF token
$(function() {
  var token = $('meta[name="csrf-token"]').attr('content');
  return $.ajaxPrefilter(function(options, originalOptions, xhr) {
      return xhr.setRequestHeader('X-CSRF-Token', token);
  });
});

// Configure Ember Data to use underscore urls instead of camel-cased urls
DS.RESTAdapter.reopen({
  namespace: namespace,
  pathForType: function(type) {
    var underscored = Ember.String.underscore(type)
    return Ember.String.pluralize(underscored);
  }
});

// Configure Ember to conform to Active Record style serialization
App.ApplicationSerializer = DS.ActiveModelSerializer.extend({});