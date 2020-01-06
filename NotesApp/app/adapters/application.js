import DS from 'ember-data';

export default DS.RESTAdapter.extend({
  host  :'http://localhost:3000',
  ajax : function(url, method, hash) {
    hash = hash || {};
    hash.crossDomain = true;
    hash.xhrFields = {withCredentials: true};
    return this._super(url, method, hash);
  }
});
