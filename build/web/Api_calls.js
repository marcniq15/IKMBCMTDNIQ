// Example of how a React component would use it

import React, { useState, useEffect } from 'react';
import { callApi } from '../api/itemsApi'; // Import the function

function ItemList() {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    async function fetchData() {
      try {
        const response = await callApi(); // Calling the function
        setData(response);
      } catch (err) {
        setError(err);
      } finally {
        setLoading(false);
      }
    }
    fetchData();
  }, []);

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error: {error.message}</p>;

  return (
    // Render your data here
  );
}
