import React, { useEffect, useState } from "react";
import { TextField } from "@mui/material";
import { Table } from "./Table";
import axios from "axios";

const baseParams = {
  page: 1,
  per_page: 1000, // bypassing pagination for now
}

export const SearchAndTable = () => {
  const [query, setQuery] = useState('');
  const [data, setData] = useState(null);

  const fetchRecords = async () => {
    const queryParam = query.length ? query : undefined;
    const params = { ...baseParams, query: queryParam }
    const { data } = await axios.get('/records', { params });

    setData(data);
  }

  useEffect(async () => {
    fetchRecords();
  }, [query])

  const onChange = async (event) => {
    setQuery(event.target.value);
  }

  return (
    <>
      <TextField fullWidth onChange={onChange} value={query} variant="outlined" />
      <Table data={data} />
    </>
  );
}
