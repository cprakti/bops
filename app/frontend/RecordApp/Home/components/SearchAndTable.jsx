import React, { useState } from "react";
import { TextField } from "@mui/material";
import { Table } from "./Table";

export const SearchAndTable = () => {
  const [query, setQuery] = useState('');

  const onChange = (event) => {
    setQuery(event.target.value);
  }

  // Will be replaced with proper axios call on debounce
  const data = [
    {
        "id": 1,
        "artist_name": "Radiohead",
        "title": "OK Computer",
        "release_year": 1997,
        "condition": 10
    },
    {
        "id": 2,
        "artist_name": "Radiohead",
        "title": "OK Computer",
        "release_year": 1997,
        "condition": 9
    },
    {
        "id": 3,
        "artist_name": "Radiohead",
        "title": "Kid A",
        "release_year": 2000,
        "condition": 6
    },
    {
        "id": 4,
        "artist_name": "Radiohead",
        "title": "Kid A",
        "release_year": 2000,
        "condition": 1
    },
    {
        "id": 5,
        "artist_name": "Queens of the Stone Age",
        "title": "Queens of the Stone Age",
        "release_year": 1998,
        "condition": 4
    },
    {
        "id": 6,
        "artist_name": "Queens of the Stone Age",
        "title": "Queens of the Stone Age",
        "release_year": 1998,
        "condition": 2
    },
    {
        "id": 7,
        "artist_name": "Queens of the Stone Age",
        "title": "Rated R",
        "release_year": 2000,
        "condition": 8
    },
    {
        "id": 8,
        "artist_name": "Queens of the Stone Age",
        "title": "Rated R",
        "release_year": 2000,
        "condition": 5
    }
  ];

  return (
    <>
      <TextField fullWidth onChange={onChange} value={query} variant="outlined" />
      <Table data={data} />
    </>
  );
}
