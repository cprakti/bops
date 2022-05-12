import React from "react";
import { Route, Routes } from "react-router-dom";

import { Home } from "./Home";

const RecordAppRoutes = () => (
  <Routes>
    <Route index element={<Home />} />
  </Routes>
);

export default RecordAppRoutes;
