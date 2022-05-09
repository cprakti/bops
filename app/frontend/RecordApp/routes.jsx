import React from "react";
import { Route, Routes } from "react-router-dom";
import Placeholder from "./Placeholder";

const RecordAppRoutes = () => (
  <Routes>
    <Route
      index
      element={<div>Home</div>}
    />
    <Route
      path={'/placeholder'}
      element={<Placeholder />}
    />

  </Routes> 
);

export default RecordAppRoutes;
