import Ember from 'ember';

export default Ember.Component.extend({
  store : Ember.inject.service(),
  actions : {
    deleteNote(note){
      note.destroyRecord();
    },
    persistNote(note){
      note.save();
    },
    editLabels(note){
      this.get('onEditLabel')( note );
    }
  }
});
