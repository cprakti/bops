import React, { useEffect, useState } from "react";
import { TextField } from "@mui/material";
import { Table } from "./Table";
import axios from "axios";
import { useDebounce } from '../hooks';

const baseParams = {
  page: 1,
  per_page: 1000, // bypassing pagination for now
}

const DEBOUNCE_DELAY_MS = 500;

export const SearchAndTable = () => {
  const [query, setQuery] = useState('');
  const [data, setData] = useState(null);
  const debouncedQuery = useDebounce(query, DEBOUNCE_DELAY_MS);

  const fetchRecords = async () => {
    const params = { ...baseParams, query: debouncedQuery }
    const { data } = await axios.get('/records', { params });

    setData(data);
  };

  useEffect(async () => {
    fetchRecords();
  }, [debouncedQuery]);

  const onChange = async (event) => {
    setQuery(event.target.value);
  };

  return (
    <>
      <TextField fullWidth onChange={onChange} value={query} variant="outlined" />
      <Table data={data} />
    </>
  );
}
