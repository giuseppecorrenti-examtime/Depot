$(document).ready(function() {
	$.ajaxSetup({
	  beforeSend: function(xhr) {
	    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
	  }
	});
	
	function ajax_call_add_to_cart (){
		var product_id = $(this).attr('data-product-id');
		$.ajax({
		 type: 'POST',
		 url:'/line_items',
		 data: {
		   product_id : product_id
		 },
		 success : function(responseText) {
		   alert('Added to cart');
		 },
		 
		 dataType: "html"
		 
		});
	};
 	
 	$('.add_to_cart').click( ajax_call_add_to_cart );
     
	$('.images').click( ajax_call_add_to_cart );
	
});
