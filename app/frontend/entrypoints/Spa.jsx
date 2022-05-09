import React from "react";
import { render } from "react-dom";
import { BrowserRouter } from "react-router-dom";
import Routes from "../RecordApp/routes";

const RecordApp = () => (
  <BrowserRouter>
    <Routes />
  </BrowserRouter>
);

document.addEventListener("DOMContentLoaded", () => {
  render(<RecordApp />, document.getElementById("root"));
});
