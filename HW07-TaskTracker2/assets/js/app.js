// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"
import $ from "jquery";

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

// Code Credits : Nat tuck's video lecture on JSON and Relations 
// Code Source Reformatted from: https://raw.githubusercontent.com/NatTuck/microblog/part-three-done/assets/js/app.js

var startdate = 0, enddate = 0;
var running = false;

function update_buttons() {
  $('.timeblock-btn').each( (_, bb) => {
    let task_id = $(bb).data('task-id');
    let run_id = $(bb).data('run-id');
    if (run_id == "started") {
    	 $(bb).removeClass("btn-secondary")
      $(bb).addClass("btn-primary")
      $(bb).text("Stop Working on Task");
    }
    else {
    	$(bb).removeClass("btn-primary")
      $(bb).addClass("btn-secondary")
      $(bb).text("Start Working on Task");
    }  
  });
}

function set_button(task_id, value) {
  $('.timeblock-btn').each( (_, bb) => {
    if (task_id == $(bb).data('task-id')) {
      $(bb).data('run-id', value);
    }
  });
  update_buttons();
}

function stopTracking(task_id) {
  enddate = new Date($.now());
  set_button(task_id,"notstarted")
  
  let text = JSON.stringify({
    block: {
        task_id: task_id,
        starts: startdate,
        ends: enddate
      },
  });
  $.ajax(startstopcreate, {
    method: "post",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => { set_button(task_id, "notstarted"); alert("Time Block added successfully from "
     + startdate + " to " + enddate); },
    error: () => {alert("failed to update time");}
  });
}

function startTracking(task_id) {
  startdate = new Date($.now());
  set_button(task_id,"started")
}

function timeblock_click(ev) {
  let btn = $(ev.target);
  let task_id = btn.data('task-id');
  let run_id = btn.data('run-id');

  if (run_id == "notstarted") {
    startTracking(task_id);
  }
  else {
    stopTracking(task_id);
  }
}

$(".delete-block-btn").click(function(ev){
	let delbtn = $(ev.target);
	let block_id = delbtn.data("block-id");
	$.ajax(deleteditpath + "/" + block_id , {
    method: "delete",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: "",
    success: () => { alert("Time Block deleted successfully"); location.reload();},
    error: () => {alert("failed to delete time block");}
  });
});

function init() {
  if (!$('.timeblock-btn')) {
    return;
  }

  $(".timeblock-btn").click(timeblock_click);

  update_buttons();
}

$(init);