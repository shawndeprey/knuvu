App.User = DS.Model.extend(Ember.Validations.Mixin, {
  validations: {
    email: { presence: true }
  },
  full_name: DS.attr('string'),
  email: DS.attr('string'),
  phone: DS.attr('string'),
  password: DS.attr('string'),
  verified: DS.attr('boolean'),
  admin: DS.attr('boolean'),
  created_at: DS.attr('date'),
  updated_at: DS.attr('date')
});