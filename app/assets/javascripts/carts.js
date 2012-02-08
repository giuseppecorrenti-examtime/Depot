$(document).ready(function() {
	$.ajaxSetup({
    beforeSend: function(xhr) {
      xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
    }
  });
  
  $(document).on('click', '.edit',function(){
  	var line_item_id = $(this).attr('data-line-item-id');
  	$(this).siblings('.edit_line_item').modal('show', { backdrop: false});
  });
  
  $(document).on('click','#delete_cart', function() {
    var cart_id = $(this).attr('data-cart-id');
    $.ajax({
     type: 'DELETE',
     url:'/carts/'+cart_id,
     
     success : function(responseText) {
        $('#cart').html(responseText);
        
     },
     
     dataType: "html"
     
    });
  });
  
  $(document).on('click','#delete_line_item', function() {
    var line_item_id = $(this).attr('data-line-item-id');
    $.ajax({
     type: 'DELETE',
     url:'/line_items/'+line_item_id,
     
     success : function(responseText) {
        $('#cart').html(responseText);
        
     },
     
     dataType: "html"
     
    });
  });
  
  $(document).on('ajax:complete','.edit_line_item',function(e, response, status){
    $('#cart').html(response.responseText);
    $('.modal-backdrop').hide();
    $(this).siblings('.edit_line_item').modal('close');
  });
/*  
  $(document).on('click','#update_line_item', function() {
    var line_item_id = $(this).attr('data-line-item-id');
    $.ajax({
     type: 'PUT',
     url:'/line_items/'+line_item_id,
     
     success : function(responseText) {
        $('#cart').html(responseText);        
     },
     
     dataType: "html"
     
    });
  });
*/  
});