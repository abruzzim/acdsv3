$(function () {
	$('#navBarElapsed').countdown({
		since: 0, 
		padZeroes: true, 
		compact: true, 
		description: 'Elapsed'
	});
});
$(function () {
	$('#navBarTimeToTask').countdown({
		until: 900, 
		padZeroes: true, 
		compact: true, 
		description: 'Assess', 
		format: 'hMS',
		onExpiry: sendAlert
	});
	function sendAlert() {
		$('#navBarTimeToTask').countdown('option', 'until', '900');
		alert('Check Vital Signs');
	}
});
