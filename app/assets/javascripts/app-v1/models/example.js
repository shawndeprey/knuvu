App.Example = DS.Model.extend(Ember.Validations.Mixin, {
  validations: {
    email: { presence: true }
  },
  email: DS.attr('string')
});