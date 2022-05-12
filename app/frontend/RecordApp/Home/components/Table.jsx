import * as React from 'react';
import { DataGrid } from '@mui/x-data-grid';

const rightAlign = {
  align: 'right',
  headerAlign: 'right',
}

const columns = [
  {
    field: 'title',
    flex: 3,
    headerName: 'Album Name',
  },
  {
    field: 'artist_name',
    flex: 1,
    headerName: 'Artist Name',
  },
  {
    ...rightAlign,
    field: 'release_year',
    headerName: 'Release Year',
    width: 120,
  },
  {
    ...rightAlign,
    field: 'condition',
    headerName: 'Condition',
    renderCell: (params) => `${params.row.condition} / 10`,
    width: 120,
  },
];

export const Table = ({ data }) => {
  return (
    <div style={{ height: 400, width: '100%' }}>
      <DataGrid
        columns={columns}
        hideFooter
        rows={data}
      />
    </div>
  );
}
