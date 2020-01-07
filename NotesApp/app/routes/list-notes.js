import Ember from 'ember';
import RSVP from 'rsvp';

export default Ember.Route.extend({
  model(params){
    let isLabelParamsPresent = (params.label !== undefined && params.label !== "");
    let searchTermVal = (params.searchTerm !== undefined && params.searchTerm !== "") ? params.searchTerm : "";
    return RSVP.hash({
      notes : this.get("store").query("note",params),
      labels : this.get("store").findAll("label"),
      showLabels : !isLabelParamsPresent,
      searchTerm : searchTermVal
    });
  },
  queryParams : {
    label : {
      refreshModel: true
    },
    searchTerm : {
      refreshModel: true
    }
  }
});
