$(document).ready(function() {
	$("#timestamp_btn").click(function() {
		var inp = $("#timestamp_inp").val();
	    var url = "./time/" + inp;
		//var url = "./time/123456";
        //alert(url);
        $.get(url, function(rs){
            //alert(rs);
	        $("#timestamp_sta").html(rs);
        });
    });
});
