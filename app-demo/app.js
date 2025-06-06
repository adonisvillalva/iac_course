// app.js
const express = require('express');
const app = express();
const PORT = process.env.PORT || 8080;

// Ruta raíz que devuelve “Hello, World!”
app.get('/', (req, res) => {
  res.send('Hello, World!');
});

// Iniciar el servidor
app.listen(PORT, () => {
  console.log(`Servidor escuchando en el puerto ${PORT}`);
});
