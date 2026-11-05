/* ============================================
   app.js — Lógica del chat (WebSocket)
   EPN FIS · Angel Pastaz
   ============================================ */

const $ = (id) => document.getElementById(id);

const els = {
  login:     $('loginScreen'),
  chat:      $('chatScreen'),
  loginForm: $('loginForm'),
  nameInput: $('nameInput'),
  messages:  $('messages'),
  msgForm:   $('msgForm'),
  msgInput:  $('msgInput'),
  charCount: $('charCount'),
  userCount: $('userCount'),
  connText:  $('connText'),
  connDot:   $('connDot'),
  themeBtn:  $('themeBtn'),
  typingBar: $('typingBar'),
};

const MAX_LEN = 500;
let ws = null;
let username = '';
let lastSender = null;       // último emisor renderizado (para agrupar estilo WhatsApp)
let typingTimer = null;
let typingUsers = new Map(); // username -> timeoutId

/* ---------- Tema ---------- */
function setTheme(dark) {
  document.documentElement.classList.toggle('dark', dark);
  els.themeBtn.textContent = dark ? '☀️' : '🌙';
  localStorage.setItem('theme', dark ? 'dark' : 'light');
}
const savedTheme = localStorage.getItem('theme');
setTheme(savedTheme ? savedTheme === 'dark' : true);

els.themeBtn.addEventListener('click', () => {
  setTheme(!document.documentElement.classList.contains('dark'));
});

/* ---------- Login ---------- */
els.loginForm.addEventListener('submit', (e) => {
  e.preventDefault();
  const name = els.nameInput.value.trim();
  if (!name) return;
  username = name;
  els.login.classList.add('hidden');
  els.chat.classList.remove('hidden');
  connect();
});

/* ---------- WebSocket ---------- */
function connect() {
  const proto = location.protocol === 'https:' ? 'wss' : 'ws';
  ws = new WebSocket(`${proto}://${location.host}`);

  ws.onopen = () => {
    setConn(true);
    ws.send(JSON.stringify({ type: 'join', username }));
  };

  ws.onmessage = (ev) => {
    let data;
    try { data = JSON.parse(ev.data); } catch { return; }

    switch (data.type) {
      case 'joined':    onJoined(data);            break;
      case 'message':   onMessage(data);           break;
      case 'system':    addSystem(data.text);      break;
      case 'count':     els.userCount.textContent = data.count; break;
      case 'typing':    onTyping(data.username);   break;
      case 'error':     flashError(data.text);     break;
    }
  };

  ws.onclose = () => {
    setConn(false);
    setTimeout(connect, 3000);
  };

  ws.onerror = () => {};
}

function setConn(ok) {
  els.connText.textContent = ok ? 'Conectado' : 'Reconectando…';
  els.connDot.className = `inline-block w-2 h-2 rounded-full mr-1 ${ok ? 'bg-green-300' : 'bg-red-400'}`;
}

function onJoined() { /* ack silencioso */ }

/* ---------- Render de mensajes ---------- */
function onMessage(data) {
  const mine = data.username === username;
  const showSender = !mine && data.username !== lastSender;
  addBubble(data.text, data.timestamp, mine, showSender ? data.username : null);
  lastSender = data.username;
}

function addBubble(text, time, mine, senderName) {
  const wrap = document.createElement('div');
  wrap.className = 'flex flex-col';

  const bubble = document.createElement('div');
  bubble.className = `msg-bubble ${mine ? 'msg-sent' : 'msg-recv'}`;

  if (senderName) {
    const sn = document.createElement('div');
    sn.className = 'msg-sender';
    sn.textContent = senderName;
    bubble.appendChild(sn);
  }

  const txt = document.createElement('div');
  txt.textContent = text;
  bubble.appendChild(txt);

  if (time && mine) {
    const t = document.createElement('div');
    t.className = 'msg-time';
    t.textContent = time;
    bubble.appendChild(t);
  }

  wrap.appendChild(bubble);
  els.messages.appendChild(wrap);
  els.messages.scrollTop = els.messages.scrollHeight;
}

function addSystem(text) {
  const el = document.createElement('div');
  el.className = 'msg-system';
  el.textContent = text;
  els.messages.appendChild(el);
  els.messages.scrollTop = els.messages.scrollHeight;
}

/* ---------- Typing ---------- */
function onTyping(name) {
  if (name === username) return;
  clearTimeout(typingUsers.get(name));
  typingUsers.set(name, setTimeout(() => {
    typingUsers.delete(name);
    renderTyping();
  }, 3500));
  renderTyping();
}

function renderTyping() {
  const names = [...typingUsers.keys()];
  if (names.length === 0) {
    els.typingBar.classList.add('hidden');
    return;
  }
  els.typingBar.classList.remove('hidden');
  const label = names.length === 1
    ? `${names[0]} está escribiendo`
    : `${names.slice(0, 2).join(', ')} están escribiendo`;
  els.typingBar.innerHTML = `${label} <span class="typing-dots"><span></span><span></span><span></span></span>`;
}

/* ---------- Envío ---------- */
els.msgForm.addEventListener('submit', (e) => {
  e.preventDefault();
  sendMessage();
});

els.msgInput.addEventListener('input', () => {
  const len = els.msgInput.value.length;
  els.charCount.textContent = `${len}/${MAX_LEN}`;
  els.charCount.style.color = len > MAX_LEN ? '#ef4444' : '';

  if (ws && ws.readyState === WebSocket.OPEN && els.msgInput.value.trim()) {
    ws.send(JSON.stringify({ type: 'typing', username }));
  }
});

function sendMessage() {
  const text = els.msgInput.value.trim();

  if (!text) {
    els.msgInput.focus();
    return;
  }
  if (text.length > MAX_LEN) {
    flashError(`El mensaje excede ${MAX_LEN} caracteres`);
    return;
  }
  if (!ws || ws.readyState !== WebSocket.OPEN) {
    flashError('Sin conexión al servidor');
    return;
  }

  ws.send(JSON.stringify({ type: 'message', text }));
  els.msgInput.value = '';
  els.charCount.textContent = `0/${MAX_LEN}`;
}

/* ---------- Feedback temporal ---------- */
function flashError(msg) {
  const toast = document.createElement('div');
  toast.className = 'fixed bottom-20 left-1/2 -translate-x-1/2 bg-red-500 text-white text-sm px-4 py-2 rounded-full shadow-lg z-50';
  toast.textContent = msg;
  document.body.appendChild(toast);
  setTimeout(() => toast.remove(), 2200);
}
