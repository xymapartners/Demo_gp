(() => {
  const base = String(window.DEMO_API_BASE || '').replace(/\/+$/, '');

  async function request(path, options = {}) {
    const response = await fetch(base + path, {
      credentials: 'include',
      ...options,
      headers: {
        'content-type': 'application/json',
        ...(options.headers || {})
      }
    });

    let payload = null;
    const text = await response.text();
    if (text) {
      try { payload = JSON.parse(text); }
      catch { payload = { error: text }; }
    }

    if (!response.ok) {
      const error = new Error(payload?.error || `API de démonstration indisponible (${response.status}).`);
      error.status = response.status;
      throw error;
    }

    return payload;
  }

  window.DemoApi = Object.freeze({
    session() {
      return request('/api/session');
    },
    companies() {
      return request('/api/companies');
    },
    updateCompany(siren, patch) {
      return request('/api/companies/' + encodeURIComponent(siren), {
        method: 'PATCH',
        body: JSON.stringify(patch)
      });
    },
    resetCompany(siren) {
      return request('/api/companies/' + encodeURIComponent(siren) + '/reset', {
        method: 'POST',
        body: '{}'
      });
    },
    resetAll() {
      return request('/api/demo/reset-all', {
        method: 'POST',
        body: '{}'
      });
    }
  });
})();
