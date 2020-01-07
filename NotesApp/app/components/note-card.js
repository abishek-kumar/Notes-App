import Ember from 'ember';

export default Ember.Component.extend({
  store : Ember.inject.service(),
  actions : {
    deleteNote(note){
      note.destroyRecord();
      this.get("onDelete")();
    },
    persistNote(note){
      note.save();
      this.get("onPersist")();
    },
    editLabels(note){
      this.get('onEditLabel')( note );
    }
  }
});
