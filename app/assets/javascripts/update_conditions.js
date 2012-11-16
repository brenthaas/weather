$(function() {
	if ($("#conditions-list").length > 0) {
		setTimeout(updateConditionsList, 5000);
	}
});

function updateConditionsList() {
	var location_id = $(".location").data("id");
	var last_entry = $(".conditions:last-child").data("time")+1;		//add 1 to cover rounding 
	$.ajax({
		url: 'history',
		type: "GET",
		data: { since: last_entry },
		dataType: 'json',
		success: function(updates) {
			$.each(updates, function(index, update){
				content = "<tr class='conditions' data-time=" + update.timestamp + ">";
				content += "<td class='condition temp'>" + update.temp + "</td>";
				content += "<td class='condition wind-speed'>" + update.wind_speed + " mph</td>";
				content += "<td class='condition wind-direction'>" + update.wind_direction + "</td>";
				content += "<td class='condition time'>" + update.formatted_time + "</td>";
				content += "</tr>";
				$(content).appendTo('#conditions-list');
			});
		}
	})

	setTimeout(updateConditionsList, 5000);
}