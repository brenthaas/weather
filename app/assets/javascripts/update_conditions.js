$(function() {
	var update_function;
	if ($("#conditions-list").length > 0) {
		update_function = updateConditionsHistory;
	} else if ($("#location-list").length > 0) {
		update_function = updateLocationList;
	} else if ($(".location-details").length > 0) {
		update_function = updateCurrentConditions;
	}
	setTimeout(update_function, 5000)
});

function updateLocationList() {
	var last_entry = $("#location-list").data("time");
	var updateEntries = function(conditions) {
		$.each(conditions, function(index, update) {
			$("#location-list").data("time", update.timestamp+1)
			//If the location exists
			if($(".current-conditions[data-id=" + update.location_id + "]").length > 0){
				updateConditions(update.location_id, update);
			}
			//New location to add
			else {
				var new_row = "<tr class='current-conditions' data-id=" + update.location_id + " data-time=" + update.timestamp + ">";
				new_row += "<td class='location'> <a href='/locations/" + update.location_id + "'>" + update.location.name + "</a></td>";
				new_row += conditions_cells(update);
				new_row += "</tr>";
				var id_after = location_id_after(update.location.name);
				if(id_after){
					var element_after = $('.current-conditions[data-id=' + id_after + ']');
					$(new_row).insertBefore(element_after).effect("highlight", {}, 2500);
				}else{
					$(new_row).appendTo('#location-list').effect("highlight", {}, 2500);
				}
			}
		});
	}
	make_updates('conditions', updateEntries, last_entry);
	setTimeout(updateLocationList, 5000);
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
				var new_stuff = "<tr class='conditions' data-time=" + update.timestamp + ">";
				new_stuff += conditions_cells(update);
				new_stuff += "</tr>";
				$(new_stuff).appendTo('#conditions-list').effect("highlight", {}, 2500);
			});
		}
	make_updates('history', add_conditions, last_entry)
	setTimeout(updateConditionsHistory, 5000);
}

function conditions_cells(conditions) {
	var new_stuff = "<td class='temp'>" + conditions.temp + "</td>";
	new_stuff += "<td class='wind-speed'>" + conditions.wind_speed + " mph</td>";
	new_stuff += "<td class='wind-direction'>" + conditions.wind_direction + "</td>";
	new_stuff += "<td class='time'>" + conditions.formatted_time + "</td>";
	return new_stuff;
}

// returns the data-id of the field after the one to insert
function location_id_after(location_name){
	var found_at;
	//go through each conditions row
	$.each($(".current-conditions"), function(index, cond){
		//get the name of the location
		var name = $(this).find(".location").text();
		//if we found a location named after what we are looking for,
		if(name > location_name){
			//set the found index
			found_at = $(this).data("id");
			//break from the loop
			return false;
		}
	});
	return found_at;
}

//makes AJAX call to given URL and runs callback on success
function make_updates(url, callback, last_entry) {
	$.ajax({
		url: url,
		type: "GET",
		data: { since: last_entry },
		dataType: 'json',
		success: callback
	});
}
