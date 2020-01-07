import Ember from 'ember';

export default Ember.Component.extend({
  store : Ember.inject.service(),
  newNote : null,
  showPopup : false,
  actions : {
    showNewNote(){
      let note = this.get("store").createRecord("note");
      this.set("showPopup", true);
      this.set("newNote",note);
    },
    hideNewNote(){
      this.set("showPopup", false);
      this.set("newNote",null);
    }
  }
});
