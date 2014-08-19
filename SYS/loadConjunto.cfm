<html>
<head>
<script src="http://code.jquery.com/jquery-1.7.2.min.js" type="text/javascript"></script>
</head>
<body>

<script type="text/javascript">
function callAjax(){
	$.ajax({
	  url: "http://localhost:8301/grabbers/newcleaner.cfm",
	  async: false
	}).done(function ( data ) {
	    console.log(data);
	    callAjax();
	});
}
$(function(){
	callAjax();
})
</script>
</body>
</html>