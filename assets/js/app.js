// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.scss";

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html";

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

switch (localStorage.getItem("theme")) {
  case "dark":
    document.body.classList.add("ds-theme--dark");
    break;
  case "solarized-dark":
    document.body.classList.add("ds-theme--solarized-dark");
    break;
  case "solarized-light":
    document.body.classList.add("ds-theme--solarized-light");
    break;
  default:
    document.body.classList.add("ds-theme--light");
}

let toggle = document.getElementById("theme-toggle");

toggle.addEventListener("click", function(e) {
  e.preventDefault();

  if (document.body.classList.contains("ds-theme--dark")) {
    document.body.classList.remove("ds-theme--dark");
    localStorage.removeItem("theme", "dark");
  } else {
    document.body.classList.add("ds-theme--dark");
    localStorage.setItem("theme", "dark");
  }
});
