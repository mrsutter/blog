//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require select2
//= require_tree .

$(function() {
  $('#tag-select').select2({
    theme: 'bootstrap',
    tags: true
  });

  $('#category-select').select2({
    theme: 'bootstrap',
    templateResult: function (data) {
      if (!data.element) {
        return data.text;
      }
      var $element = $(data.element);

      var categoryDepth = $element.attr('depth');
      var className = 'select-option-with-depth-' + categoryDepth

      var $wrapper = $('<span></span>');
      $wrapper.addClass(className);
      $wrapper.text(data.text);

      return $wrapper;
    }
  });
});
