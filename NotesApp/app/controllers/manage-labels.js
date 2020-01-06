import Ember from 'ember';

export default Ember.Controller.extend({
  actions : {
    newLabel(){
      this.get("store").createRecord("label");
    },
    saveLabel(label){
      label.save();
    },
    deleteLabel(label){
      label.destroyRecord();
    }
  }
});
