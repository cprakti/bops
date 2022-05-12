import React from "react";
import { TextField } from "@mui/material";

export const SearchField = (props) => {
  return <TextField
    {...props}
    fullWidth
    label="Search"
    sx={{ mt: 1 }}
    variant="outlined"
  />
}
