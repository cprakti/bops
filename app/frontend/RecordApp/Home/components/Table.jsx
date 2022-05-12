import * as React from 'react';
import { Typography } from "@mui/material";
import { DataGrid } from '@mui/x-data-grid';

const rightAlign = {
  align: 'right',
  headerAlign: 'right',
}

const columns = [
  {
    field: 'title',
    flex: 4,
    headerName: 'Album Name',
  },
  {
    field: 'artist_name',
    flex: 3,
    headerName: 'Artist Name',
  },
  {
    ...rightAlign,
    field: 'release_year',
    headerName: 'Release Year',
    sortable: false,
    width: 110,
  },
  {
    ...rightAlign,
    field: 'condition',
    headerName: 'Condition',
    renderCell: (params) => `${params.row.condition} / 10`,
    sortable: false,
    width: 100,
  },
];

export const Table = ({ data }) => {
  if (!data) return <Typography variant="h3">Loading...</Typography>

  return (
    <DataGrid
      columns={columns}
      disableColumnMenu
      hideFooter
      rows={data}
    />
  );
}
