const express = require('express');
const WebSocket = require('ws');

const app = express();
const port = 3000;

app.use(express.static('public'));

const server = app.listen(port, () => {
  console.log(`Servidor corriendo en http://localhost:${port}`);
});

const wss = new WebSocket.Server({ server });

const clients = new Map(); // ws -> { username }
const MAX_LEN = 500;

function broadcast(data, exclude = null) {
  const payload = JSON.stringify(data);
  for (const [client] of clients) {
    if (client !== exclude && client.readyState === WebSocket.OPEN) {
      client.send(payload);
    }
  }
}

function sendUserCount() {
  broadcast({ type: 'count', count: clients.size });
}

wss.on('connection', (ws) => {
  clients.set(ws, { username: null });
  console.log('Cliente conectado. Total:', clients.size);

  ws.on('message', (data) => {
    let msg;
    try {
      msg = JSON.parse(data);
    } catch {
      return;
    }

    // Join
    if (msg.type === 'join') {
      const name = (msg.username || '').trim().slice(0, 20);
      const meta = clients.get(ws);
      if (name) {
        meta.username = name;
        ws.send(JSON.stringify({ type: 'joined', username: name }));
        broadcast({ type: 'system', text: `${name} se unió al chat` }, ws);
        sendUserCount();
      }
      return;
    }

    // Typing
    if (msg.type === 'typing') {
      const meta = clients.get(ws);
      if (meta.username) {
        broadcast({ type: 'typing', username: meta.username }, ws);
      }
      return;
    }

    // Chat message
    if (msg.type === 'message') {
      const meta = clients.get(ws);
      if (!meta.username) return;

      const text = (msg.text || '').trim();
      if (!text || text.length > MAX_LEN) {
        ws.send(JSON.stringify({ type: 'error', text: 'Mensaje vacío o demasiado largo' }));
        return;
      }

      const payload = {
        type: 'message',
        username: meta.username,
        text,
        timestamp: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
      };
      // echo to sender + everyone else
      ws.send(JSON.stringify(payload));
      broadcast(payload, ws);
      return;
    }
  });

  ws.on('close', () => {
    const meta = clients.get(ws);
    clients.delete(ws);
    if (meta && meta.username) {
      broadcast({ type: 'system', text: `${meta.username} salió del chat` });
    }
    sendUserCount();
    console.log('Cliente desconectado. Total:', clients.size);
  });

  ws.on('error', (error) => {
    console.error('Error WebSocket:', error);
    clients.delete(ws);
    sendUserCount();
  });
});
