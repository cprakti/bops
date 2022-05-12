import React from "react";
import { Container, Grid } from "@mui/material";
import { SearchField, Table, Title } from "./components";
import { useQueryRecords } from "./hooks";

export const Home = () => {
  const { data, query, setQuery } = useQueryRecords();

  const onChange = async (event) => {
    setQuery(event.target.value);
  };

  return (
    <Container fixed>
      <Grid container flexDirection="column" spacing={2} sx={{ height: '100vh' }}>
        <Grid item>
          <Title />
          <SearchField onChange={onChange} value={query} />
        </Grid>
        <Grid item sx={{ flexGrow: 1 }}>
          <Table data={data} />
        </Grid>
      </Grid>
    </Container>
  );
}
