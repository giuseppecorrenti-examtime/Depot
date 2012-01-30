$(document).ready(function() {
	$.ajaxSetup({
	  beforeSend: function(xhr) {
	    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
	  }
	});

  $('.add_to_cart').click(function (){
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
  });
});