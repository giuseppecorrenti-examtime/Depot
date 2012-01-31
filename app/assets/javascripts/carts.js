$(document).ready(function() {
	$.ajaxSetup({
	  beforeSend: function(xhr) {
	    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
	  }
	});
	
  $('#delete_line_item').live('ajax:success', function(response, line_item) {
  	$(document).trigger('close.facebox');
  	$('.cart_item#' + line_item).remove();	
  });

  $('.cart_item').click(function (){
    var line_item_id = $(this).attr('id');        
    $.facebox({ ajax: '/line_items/'+ line_item_id + '/edit/' });

  });
});