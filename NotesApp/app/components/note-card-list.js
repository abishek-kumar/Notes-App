import Ember from 'ember';

export default Ember.Component.extend({
  showEditLabels : false,
  selectedNote : null,
  selectedLabels : [],
  actions : {
    showEditLabelList(note){
      this.set("showEditLabels", true);
      let allLabels = this.get("model").labels;

      let noteLabels = note.get("labels");
      let selLabels = allLabels.map((label)=>{
        let isSelected = noteLabels.any( (l) => l.get('name') === label.get('name') );
        return { "label" : label, "isSelected" : isSelected };
      });

      this.set("selectedNote", note);
      this.set("selectedLabels", selLabels);
    },
    hideEditLabelList(){
      this.set("showEditLabels", false);
      this.set("selectedNote", null);
    },
    updateNoteLabels(selectedLabels){
      let note = this.get("selectedNote");
      note.set("labels", selectedLabels);
      note.save().then( ()=>{
        this.set("showEditLabels", false);
        this.set("selectedNote", null);
      });
    }
  }
});
