$(document).ready(function() {
	$.ajaxSetup({
    beforeSend: function(xhr) {
      xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
    }
  });
  
  $(document).live('click', '#edit_line_item',function(){
  	var line_item_id = $(this).attr('data-line-item-id');
  	$('#edit_line_item').modal('show');
  });
     
  $(document).on('click','.delete_line_item', function() {
    var line_item_id = $(this).attr('data-line-item-id');
    $.ajax({
     type: 'DELETE',
     url:'/line_items/'+line_item_id,
     
     success : function(responseText) {
        $(document).trigger('close.facebox');
        $('#cart').html(responseText);
     },
     
     dataType: "html"
     
    });
  });
  
});