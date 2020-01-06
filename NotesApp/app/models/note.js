import DS from 'ember-data';

export default DS.Model.extend({
  title : DS.attr('string'),
  content : DS.attr('string'),
  labels : DS.hasMany('label', {async : false})
});
