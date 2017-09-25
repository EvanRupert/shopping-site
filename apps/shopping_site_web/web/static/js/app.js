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

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

// import item from './item.js'

import socket from './socket'

import Elm from './itemlist.js'

let items = document.getElementById('elm_item_list_transfer').innerHTML;

let staticPath = document.getElementById('static_path');

var app = Elm.ItemList.embed(node, {
    payload: items
});



// (function() {
//     let channel = socket.channel("item:1", {});

//     channel.on("items", items => {
//         console.log("JavaScript Received items");

//         // let node = document.getElementById('elm_test');

//         // if(node) {
//         //     console.log('JavaScript found elm_test');
//         //     Elm.ItemList.embed(node, {
//         //         payload: items.payload
//         //     });
//         // } else {
//         //     console.log('JavaScript did not find elm_test');
//         // }

//         app.ports.itemLoad.send(items.payload);
//     });


//     channel.join()
//         .receive("ok", resp => { console.log("Joined item channel") })
//         .receive("error", resp => { console.log("Error joining item channel") });
// })();