import React, { useEffect, useState } from "react";
import { Container, Grid, TextField } from "@mui/material";
import { Table, Title } from "./components";

import axios from "axios";
import { useDebounce } from './hooks';

const baseParams = {
  page: 1,
  per_page: 1000, // bypassing pagination for now
}

const DEBOUNCE_DELAY_MS = 500;

export const Home = () => {
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
    <Container fixed>
      <Grid container flexDirection="column" spacing={2} sx={{ height: '100vh' }}>
        <Grid item>
          <Title />
          <TextField fullWidth onChange={onChange} label="Search" sx={{ mt: 1 }} value={query} variant="outlined" />
        </Grid>
        <Grid item sx={{ flexGrow: 1 }}>
          <Table data={data} />
        </Grid>
      </Grid>
    </Container>
  );
}
