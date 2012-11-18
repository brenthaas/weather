$(function() {
	if ($("#conditions-list").length > 0) {
		setTimeout(updateConditionsHistory, 5000);
	} else if ($(".location-details").length > 0) {
		setTimeout(updateCurrentConditions, 5000);
	}
});

function make_updates(url, callback, last_entry) {
	$.ajax({
		url: url,
		type: "GET",
		data: { since: last_entry },
		dataType: 'json',
		success: callback
	});
}

function updateCurrentConditions() {
	var location_id = $(".current-conditions").data("id");
	var last_entry = $(".current-conditions").data("time") + 1;
	var updateDetails = function(conditions) {
		$.each(conditions, function(index, update){
			updateConditions(location_id, update);
		});
	};
	make_updates(location_id + '/history', updateDetails, last_entry)
	setTimeout(updateCurrentConditions, 5000);
}

function updateConditions(location_id, conditions) {
	$(".current-conditions[data-id="+location_id+"]").data("time", conditions.timestamp);
	$(".current-conditions[data-id="+location_id+"] .temp").text(conditions.temp);
	$(".current-conditions[data-id="+location_id+"] .wind-speed").text(conditions.wind_speed);
	$(".current-conditions[data-id="+location_id+"] .wind-direction").text(conditions.wind_direction);
	$(".current-conditions[data-id="+location_id+"] .time").text(conditions.formatted_time);
	$(".current-conditions[data-id="+location_id+"]").effect("highlight", {}, 2500);
}

function updateConditionsHistory() {
	var location_id = $(".location").data("id");
	var last_entry = $(".conditions:last-child").data("time")+1;		//add 1 to cover rounding 
	var add_conditions = function(updates) {
			$.each(updates, function(index, update){
				content = "<tr class='conditions' data-time=" + update.timestamp + ">";
				content += conditions_cells(update);
				content += "</tr>";
				$(content).appendTo('#conditions-list').effect("highlight", {}, 2500);
			});
		}
	make_updates('history', add_conditions, last_entry)
	setTimeout(updateConditionsHistory, 5000);
}

function conditions_cells(conditions) {
	content += "<td class='temp'>" + conditions.temp + "</td>";
	content += "<td class='wind-speed'>" + conditions.wind_speed + " mph</td>";
	content += "<td class='wind-direction'>" + conditions.wind_direction + "</td>";
	content += "<td class='time'>" + conditions.formatted_time + "</td>";
	return content;
}

