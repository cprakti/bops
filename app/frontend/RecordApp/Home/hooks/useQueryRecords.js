import { useEffect, useState } from "react";

import axios from "axios";
import { useDebounce } from "./useDebounce";

const baseParams = {
  page: 1,
  per_page: 1000, // bypassing pagination for now
};

const DEBOUNCE_DELAY_MS = 500;

export const useQueryRecords = () => {
  const [query, setQuery] = useState("");
  const [data, setData] = useState(null);
  const debouncedQuery = useDebounce(query, DEBOUNCE_DELAY_MS);

  const fetchRecords = async () => {
    const params = { ...baseParams, query: debouncedQuery };
    const { data } = await axios.get("/records", { params });

    setData(data);
  };

  useEffect(async () => {
    fetchRecords();
  }, [debouncedQuery]);

  return { data, query, setQuery };
};
