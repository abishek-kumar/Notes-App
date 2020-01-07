import Ember from 'ember';

export default Ember.Controller.extend({
  queryParams : ["label","searchTerm"],
  actions : {
    queryTitle(queryVal){
      this.transitionToRoute({queryParams: {searchTerm: queryVal}});
    }
  }
});
