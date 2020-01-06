import Ember from 'ember';

export default Ember.Component.extend({
  actions : {
    closeList(){
      this.get("onClose")();
    },
    saveLabels(){
      var saveAction = this.get("onSave");
      var selectedLabels = this.get("labels")
                            .filter( (l)=>l.isSelected )
                            .map( l=>l.label );
      saveAction(selectedLabels);
    }
  }
});
