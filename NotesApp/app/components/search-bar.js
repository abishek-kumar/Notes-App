import Ember from 'ember';

export default Ember.Component.extend({
  change(){
    let searchTerm = this.get("searchTerm");
    this.get('onSearch')(searchTerm);
  }
});
