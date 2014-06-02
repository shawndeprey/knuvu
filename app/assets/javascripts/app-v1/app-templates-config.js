// Configure Ember to support additional attributes 
Ember.TextSupport.reopen({  
  attributeBindings: ['required', 'style', 'spellcheck']
});