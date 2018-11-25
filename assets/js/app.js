// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.scss"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative paths, for example:
import socket from "./socket"

$(document).ready( () => {
 $("body").on("submit", "form.remote", function(e) {
    e.preventDefault();
    let $form = $(this);

    $.ajax({
      method: $form.attr("method"),
      url: $form.attr("action"),
      data: $form.serialize(),
      dataType: "script",
      beforeSend: function(_jqXHR, _settings) {
        // add a loader or whatever
      },
      complete: function(_jqXHR,_textStatus) {
        // remove a loader or whatever
      }
    });
  });
  new Chartkick.PieChart("cake-output", []);
  $("#cake-submit").on("click", (e) => {
    const $button = $("#cake-submit");
    $button.attr('disabled', 'disabled');
    $button.html('Cloning....');
  })
});
