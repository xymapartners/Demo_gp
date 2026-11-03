const DEMO_ACCOUNTS_KEY = 'parfait_demo_accounts_v1';
const DEMO_SESSION_KEY = 'parfait_demo_session_v1';
const PASSWORD_ITERATIONS = 180000;

function demoAccounts() {
  try {
    const accounts = JSON.parse(localStorage.getItem(DEMO_ACCOUNTS_KEY));
    return accounts && typeof accounts === 'object' && !Array.isArray(accounts) ? accounts : {};
  } catch { return {}; }
}
function demoSession() {
  try {
    const session = JSON.parse(sessionStorage.getItem(DEMO_SESSION_KEY));
    return session?.email && Object.hasOwn(demoAccounts(), session.email) ? session : null;
  } catch { return null; }
}
function encodeBytes(bytes) { return btoa(String.fromCharCode(...bytes)); }
function decodeBytes(value) { return Uint8Array.from(atob(value), character => character.charCodeAt(0)); }
async function passwordDigest(password, salt, iterations = PASSWORD_ITERATIONS) {
  const key = await crypto.subtle.importKey('raw', new TextEncoder().encode(password), 'PBKDF2', false, ['deriveBits']);
  return encodeBytes(new Uint8Array(await crypto.subtle.deriveBits({name:'PBKDF2', salt, iterations, hash:'SHA-256'}, key, 256)));
}
function sameDigest(first, second) {
  if (first.length !== second.length) return false;
  let difference = 0;
  for (let index = 0; index < first.length; index++) difference |= first.charCodeAt(index) ^ second.charCodeAt(index);
  return difference === 0;
}
function setAccessMessage(form, message) {
  form.querySelector('.access-message').textContent = message;
}
function activateDemo(email) {
  sessionStorage.setItem(DEMO_SESSION_KEY, JSON.stringify({email, startedAt:Date.now()}));
  window.location.assign('dashboard.html');
}
function selectAccessTab(name) {
  for (const mode of ['login', 'signup']) {
    const active = mode === name;
    const tab = document.getElementById(`${mode}Tab`);
    document.getElementById(`${mode}Panel`).hidden = !active;
    tab.classList.toggle('active', active);
    tab.setAttribute('aria-selected', String(active));
    tab.tabIndex = active ? 0 : -1;
  }
  document.getElementById(`${name}Panel`).querySelector('input').focus();
}
function setupWelcome() {
  for (const mode of ['login', 'signup']) document.getElementById(`${mode}Tab`).addEventListener('click', () => selectAccessTab(mode));
  document.querySelector('.access-tabs').addEventListener('keydown', event => {
    if (!['ArrowLeft', 'ArrowRight', 'Home', 'End'].includes(event.key)) return;
    event.preventDefault();
    const current = document.getElementById('signupTab').classList.contains('active') ? 'signup' : 'login';
    const next = event.key === 'Home' ? 'login' : event.key === 'End' ? 'signup' : current === 'login' ? 'signup' : 'login';
    selectAccessTab(next);
  });
  if (demoSession()) {
    const button = document.createElement('a');
    button.className = 'access-resume';
    button.href = 'dashboard.html';
    button.textContent = 'Vous êtes déjà connecté · Continuer la démo ↗';
    document.querySelector('.access-card-heading').after(button);
  }
  document.getElementById('signupForm').addEventListener('submit', async event => {
    event.preventDefault();
    const form = event.currentTarget;
    const email = form.elements.email.value.trim().toLowerCase();
    const password = form.elements.password.value;
    const confirmation = form.elements.confirm.value;
    if (password !== confirmation) { setAccessMessage(form, 'Les mots de passe ne correspondent pas.'); return; }
    if (password.length < 8) { setAccessMessage(form, 'Choisissez au moins 8 caractères.'); return; }
    if (Object.hasOwn(demoAccounts(), email)) { setAccessMessage(form, 'Un compte existe déjà pour cette adresse sur ce navigateur. Connectez-vous.'); return; }
    if (!crypto?.subtle) { setAccessMessage(form, 'Ouvrez cette démo en HTTPS ou sur localhost pour créer un compte.'); return; }
    const button = form.querySelector('button[type="submit"]');
    button.disabled = true;
    setAccessMessage(form, 'Création de votre accès…');
    try {
      const salt = crypto.getRandomValues(new Uint8Array(16));
      const hash = await passwordDigest(password, salt);
      const accounts = demoAccounts();
      if (Object.hasOwn(accounts, email)) { setAccessMessage(form, 'Ce compte vient d’être créé. Connectez-vous.'); return; }
      accounts[email] = {salt:encodeBytes(salt), hash, iterations:PASSWORD_ITERATIONS, createdAt:new Date().toISOString()};
      localStorage.setItem(DEMO_ACCOUNTS_KEY, JSON.stringify(accounts));
      activateDemo(email);
    } catch { setAccessMessage(form, 'La création a échoué. Vérifiez que le stockage du navigateur est autorisé.'); }
    finally { button.disabled = false; }
  });
  document.getElementById('loginForm').addEventListener('submit', async event => {
    event.preventDefault();
    const form = event.currentTarget;
    const email = form.elements.email.value.trim().toLowerCase();
    const account = demoAccounts()[email];
    if (!account || !crypto?.subtle) { setAccessMessage(form, 'Identifiants introuvables sur ce navigateur. Créez un compte ici si nécessaire.'); return; }
    const button = form.querySelector('button[type="submit"]');
    button.disabled = true;
    setAccessMessage(form, 'Connexion en cours…');
    try {
      const hash = await passwordDigest(form.elements.password.value, decodeBytes(account.salt), account.iterations);
      if (!sameDigest(hash, account.hash)) { setAccessMessage(form, 'Adresse e-mail ou mot de passe incorrect.'); return; }
      activateDemo(email);
    } catch { setAccessMessage(form, 'Connexion impossible sur ce navigateur.'); }
    finally { button.disabled = false; }
  });
  if (window.location.hash === '#creer-un-compte') selectAccessTab('signup');
}
function setupDashboardAccess() {
  document.getElementById('logoutButton').addEventListener('click', () => {
    sessionStorage.removeItem(DEMO_SESSION_KEY);
    window.location.assign('index.html#acces');
  });
}
if (window.location.pathname.endsWith('/dashboard.html') && !demoSession()) window.location.replace('index.html#acces');
document.addEventListener('DOMContentLoaded', () => {
  if (document.body.dataset.page === 'welcome') setupWelcome();
  if (document.body.dataset.page === 'dashboard') setupDashboardAccess();
});
