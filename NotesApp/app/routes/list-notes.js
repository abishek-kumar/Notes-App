import Ember from 'ember';
import RSVP from 'rsvp';

export default Ember.Route.extend({
  model(params){
    let isLabelParamsPresent = (params.label !== undefined && params.label !== "");
    let notesPromise = (isLabelParamsPresent) ? this.get("store").query("note",params) : this.get("store").findAll("note");
    return RSVP.hash({
      notes : notesPromise,
      labels : this.get("store").findAll("label"),
      showLabels : !isLabelParamsPresent
    });
  },
  queryParams : {
    label : {
      refreshModel: true
    }
  }
});
