$(function() {
	var update_function;
	if ($("#conditions-list").length > 0) {
		update_function = updateConditionsHistory;
	} else if ($("table#location-list").length > 0) {
		update_function = updateLocationList;
	} else if ($(".location-details").length > 0) {
		update_function = updateCurrentConditions;
	}
	setTimeout(update_function, 5000)
});

// Adds new Locations to table and updates current conditions as they happen
function updateLocationList() {
	// Get the timestamp of when the list was generated
	var last_entry = $("#location-list").data("time");
	// function to pass to ajax call
	var updateEntries = function(conditions) {
		// loop through each conditions update
		$.each(conditions, function(index, update) {
			// update the list timestamp
			$("table#location-list").data("time", update.timestamp+1)
			//If the location for these conditions already exists...
			if($(".current-conditions[data-id=" + update.location_id + "]").length > 0){
				//change the content of the fields
				updateConditions(update.location_id, update);
			}
			//New location to add
			else {
				//build the HTML for the new row
				var new_row = "<tr class='current-conditions' data-id=" + update.location_id + " data-time=" + update.timestamp + ">";
				new_row += "<td class='location'> <a href='/locations/" + update.location_id + "'>" + update.location.name + "</a></td>";
				new_row += conditions_cells(update);
				new_row += "</tr>";
				// find the location ID of the next alphabetical location name after the location being inserted
				var id_after = location_id_after(update.location.name);
				// if a location name was found
				if(id_after){
					// get the row corresponding to that location name
					var element_after = $('.current-conditions[data-id=' + id_after + ']');
					// insert the new location row before the location found
					$(new_row).insertBefore(element_after).effect("highlight", {}, 2500);
				}else{	// No location name found that comes after this location 
					// append to the table
					$(new_row).appendTo('table#location-list').effect("highlight", {}, 2500);
				}
			}
		});
	}
	//request json from /conditions on server
	make_updates('conditions', updateEntries, last_entry);
	//run this function again after a few seconds
	setTimeout(updateLocationList, 5000);
}

//updates current conditions on a locations page
function updateCurrentConditions() {
	// get the location_id of the location displayed
	var location_id = $(".current-conditions").data("id");
	// get the time of last update (+round up)
	var last_entry = $(".current-conditions").data("time") + 1;
	// function to call with server response
	var updateDetails = function(conditions) {
		// in case there were multiple updates
		$.each(conditions, function(index, update){
			// update the fields with new conditions
			updateConditions(location_id, update);
		});
	};
	//request updates from the server
	make_updates(location_id + '/history', updateDetails, last_entry)
	//call this function again every few seconds
	setTimeout(updateCurrentConditions, 5000);
}

// Add new conditions to location conditions history 
function updateConditionsHistory() {
	//get the location we are viewing the history of
	var location_id = $("#conditions-list").data("id");
	//get the last weather condition entered
	var last_entry = $("#conditions-list").data("time")+1;		//add 1 to cover rounding 
	//function to call for ajax response
	var add_conditions = function(updates) {
		//go through each new weather condition returned
		$.each(updates, function(index, update){
			$("#conditions-list").data("time", update.timestamp)
			//build html for the new row to add
			var new_stuff = "<tr class='conditions' data-time=" + update.timestamp + ">";
			//add the conditions info as cells
			new_stuff += conditions_cells(update);
			new_stuff += "</tr>";
			//append this new row to the table
			$(new_stuff).appendTo('#conditions-list').effect("highlight", {}, 2500);
		});
	}
	//call server to get new conditions
	make_updates('history', add_conditions, last_entry)
	//call this function every few seconds
	setTimeout(updateConditionsHistory, 5000);
}

// update the values in elements associated with location_id with content in conditions
function updateConditions(location_id, conditions) {
	$(".current-conditions[data-id="+location_id+"]").data("time", conditions.timestamp);
	$(".current-conditions[data-id="+location_id+"] .temp").text(conditions.temp);
	$(".current-conditions[data-id="+location_id+"] .wind-speed").text(conditions.wind_speed);
	$(".current-conditions[data-id="+location_id+"] .wind-direction").text(conditions.wind_direction);
	$(".current-conditions[data-id="+location_id+"] .time").text(conditions.formatted_time);
	$(".current-conditions[data-id="+location_id+"]").effect("highlight", {}, 2500);
}

//-------------- Helper Functions ---------------------

//given conditions data, returns html content for table cells 
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
		if(name.toLowerCase() > location_name.toLowerCase()){
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
