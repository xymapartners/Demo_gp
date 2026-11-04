const DEMO_SAMPLES = {
  "338539232": {
    accounting_software: "Sage",
    other_software: [
      { type: "Gestion immobilière", name: "Odoo" },
      { type: "CRM", name: "Salesforce" },
      { type: "Trésorerie", name: "Agicap" }
    ],
    kpis: [
      { name: "Taux d’occupation", unit: "%", value: 94, target: 92 },
      { name: "Loyers encaissés", unit: "%", value: 97, target: 96 },
      { name: "Délai de relocation", unit: "jours", value: 24, target: 20 }
    ]
  },
  "404427221": {
    accounting_software: "Cegid",
    other_software: [
      { type: "Gestion immobilière", name: "Odoo" },
      { type: "Paie / RH", name: "Silae" },
      { type: "Gestion documentaire", name: "SharePoint" },
      { type: "Formation", name: "360Learning" }
    ],
    kpis: [
      { name: "Lots gérés", unit: "lots", value: 1280, target: 1250 },
      { name: "Charges recouvrées", unit: "%", value: 95, target: 97 },
      { name: "Dossiers traités", unit: "%", value: 89, target: 90 }
    ]
  },
  "488308198": {
    accounting_software: "Sage",
    other_software: [
      { type: "Gestion commerciale", name: "Odoo" },
      { type: "CRM", name: "Salesforce" },
      { type: "Facturation", name: "Sellsy" }
    ],
    kpis: [
      { name: "Véhicules vendus", unit: "unités", value: 68, target: 72 },
      { name: "Marge commerciale", unit: "%", value: 19, target: 18 },
      { name: "Rotation du stock", unit: "jours", value: 41, target: 38 }
    ]
  },
  "451715767": {
    accounting_software: "EBP",
    other_software: [
      { type: "Gestion commerciale", name: "Odoo" }
    ],
    kpis: [
      { name: "Interventions réalisées", unit: "unités", value: 156, target: 150 },
      { name: "Satisfaction client", unit: "%", value: 91, target: 92 },
      { name: "Délai moyen", unit: "jours", value: 3, target: 4 }
    ]
  },
  "451369318": {
    accounting_software: "Pennylane",
    other_software: [
      { type: "Stocks", name: "Odoo" },
      { type: "Gestion commerciale", name: "Shopify" }
    ],
    kpis: [
      { name: "Commandes livrées", unit: "unités", value: 840, target: 800 },
      { name: "Ruptures de stock", unit: "%", value: 4, target: 3 },
      { name: "Marge brute", unit: "%", value: 27, target: 26 }
    ]
  },
  "799840954": {
    accounting_software: "Cegid",
    other_software: [
      { type: "Stocks", name: "SAP" },
      { type: "CRM", name: "Salesforce" },
      { type: "Reporting et BI", name: "Power BI" }
    ],
    kpis: [
      { name: "Points de vente actifs", unit: "sites", value: 23, target: 22 },
      { name: "Disponibilité produits", unit: "%", value: 96, target: 97 },
      { name: "Pertes alimentaires", unit: "%", value: 2.8, target: 2.5 }
    ]
  },
  "510498264": {
    accounting_software: "Sage",
    other_software: [
      { type: "ERP", name: "SAP" },
      { type: "Stocks", name: "SAP" }
    ],
    kpis: [
      { name: "Production mensuelle", unit: "unités", value: 12400, target: 12000 },
      { name: "Taux de disponibilité", unit: "%", value: 93, target: 95 },
      { name: "Rebuts", unit: "%", value: 1.9, target: 2 }
    ]
  },
  "510181274": {
    accounting_software: "EBP",
    other_software: [
      { type: "ERP", name: "Odoo" },
      { type: "Paie / RH", name: "PayFit" },
      { type: "Gestion de projets", name: "Monday.com" }
    ],
    kpis: [
      { name: "Commandes produites", unit: "unités", value: 410, target: 400 },
      { name: "Livraisons à temps", unit: "%", value: 88, target: 92 },
      { name: "Accidents avec arrêt", unit: "unités", value: 0, target: 0 }
    ]
  }
};

const CONNECTED_DEMO_MINUTES = {
  "338539232": 8,
  "451369318": 32
};

const ALLOWED_PATCH_FIELDS = new Set([
  "effectif_interne",
  "ca_interne",
  "objectif_ca",
  "categorie_groupe",
  "commentaire",
  "accounting_software",
  "other_software",
  "kpis",
  "connection_status"
]);

const GROUP_CATEGORIES = new Set([
  "Immobilier",
  "Automobile",
  "Alimentaire",
  "Industrie"
]);

const CONNECTION_STATUSES = new Set([
  "not_configured",
  "pending",
  "connected"
]);

const MAX_BODY_BYTES = 64 * 1024;

function json(data, status = 200, headers = {}) {
  return new Response(JSON.stringify(data), {
    status,
    headers: {
      "content-type": "application/json; charset=utf-8",
      "cache-control": "no-store",
      "x-content-type-options": "nosniff",
      ...headers
    }
  });
}

function parseEmailList(value) {
  return new Set(
    String(value || "")
      .split(",")
      .map((item) => item.trim().toLowerCase())
      .filter(Boolean)
  );
}

async function getIdentity(ctx, env) {
  if (!ctx.access) {
    throw new Response("Cloudflare Access requis.", { status: 403 });
  }

  const identity = await ctx.access.getIdentity();
  const email = String(identity?.email || "").trim().toLowerCase();

  if (!email) {
    throw new Response("Identité Cloudflare Access introuvable.", { status: 403 });
  }

  const xymaAdmins = parseEmailList(env.XYMA_ADMIN_EMAILS);
  const parfetAdmins = parseEmailList(env.PARFET_ADMIN_EMAILS);

  if (xymaAdmins.has(email)) {
    return { email, role: "xyma_admin" };
  }

  if (parfetAdmins.has(email)) {
    return { email, role: "parfet_admin" };
  }

  throw new Response("Utilisateur non autorisé pour la démo.", { status: 403 });
}

function corsHeaders(request, env) {
  const origin = request.headers.get("origin");
  if (!origin) return {};

  const requestOrigin = new URL(request.url).origin;
  const allowedOrigin = String(env.ALLOWED_ORIGIN || requestOrigin).replace(/\/+$/, "");

  if (origin !== allowedOrigin) {
    return null;
  }

  return {
    "access-control-allow-origin": origin,
    "access-control-allow-credentials": "true",
    "access-control-allow-methods": "GET,PATCH,POST,OPTIONS",
    "access-control-allow-headers": "content-type",
    "vary": "Origin"
  };
}

function assertSiren(value) {
  const siren = String(value || "");
  if (!/^\d{9}$/.test(siren)) {
    throw new Response("SIREN invalide.", { status: 400 });
  }
  return siren;
}

function groupCategory(company) {
  const code = company.activite_principale || "";

  if (code.startsWith("68.")) return "Immobilier";
  if (code.startsWith("45.") || code.startsWith("77.11")) return "Automobile";
  if (
    code.startsWith("10.") ||
    code.startsWith("46.3") ||
    code.startsWith("47.11") ||
    code.startsWith("47.2") ||
    code.startsWith("56.")
  ) return "Alimentaire";

  if (["B", "C", "D", "E"].includes(company.section_activite_principale)) {
    return "Industrie";
  }

  return null;
}

function baselineForCompany(company, actorEmail = null) {
  const siren = company.siren;
  const sample = DEMO_SAMPLES[siren] || {};
  const connectedDelay = Object.prototype.hasOwnProperty.call(CONNECTED_DEMO_MINUTES, siren)
    ? CONNECTED_DEMO_MINUTES[siren]
    : null;

  return {
    siren,
    effectif_interne: null,
    ca_interne: null,
    objectif_ca: null,
    categorie_groupe: groupCategory(company),
    commentaire: null,
    accounting_software: sample.accounting_software || null,
    other_software: sample.other_software || [],
    kpis: sample.kpis || [],
    connection_status: connectedDelay === null
      ? (sample.accounting_software ? "pending" : "not_configured")
      : "connected",
    connection_synced_at: connectedDelay === null
      ? null
      : new Date(Date.now() - connectedDelay * 60_000).toISOString(),
    updated_by_email: actorEmail
  };
}

function normalizeNullableString(value, maxLength) {
  if (value === null || value === "") return null;
  if (typeof value !== "string") throw new Response("Valeur texte invalide.", { status: 400 });

  const clean = value.trim();
  if (clean.length > maxLength) {
    throw new Response("Texte trop long.", { status: 400 });
  }

  return clean || null;
}

function normalizeNonNegativeNumber(value, integer = false) {
  if (value === null || value === "") return null;

  const number = Number(value);
  if (!Number.isFinite(number) || number < 0 || (integer && !Number.isInteger(number))) {
    throw new Response("Valeur numérique invalide.", { status: 400 });
  }

  return number;
}

function normalizeOtherSoftware(value) {
  if (!Array.isArray(value) || value.length > 20) {
    throw new Response("Liste de logiciels invalide.", { status: 400 });
  }

  return value.map((item) => {
    if (!item || typeof item !== "object" || Array.isArray(item)) {
      throw new Response("Logiciel invalide.", { status: 400 });
    }

    const type = normalizeNullableString(item.type, 80);
    const name = normalizeNullableString(item.name, 80);

    if (!type || !name) {
      throw new Response("Chaque logiciel doit avoir un type et un nom.", { status: 400 });
    }

    return { type, name };
  });
}

function normalizeKpis(value) {
  if (!Array.isArray(value) || value.length > 20) {
    throw new Response("Liste de KPI invalide.", { status: 400 });
  }

  return value.map((item) => {
    if (!item || typeof item !== "object" || Array.isArray(item)) {
      throw new Response("KPI invalide.", { status: 400 });
    }

    const name = normalizeNullableString(item.name, 120);
    const unit = normalizeNullableString(item.unit, 30);
    const comment = normalizeNullableString(item.comment ?? null, 500);

    if (!name || !unit) {
      throw new Response("Chaque KPI doit avoir un nom et une unité.", { status: 400 });
    }

    const current = Number(item.value);
    const target = Number(item.target);

    if (!Number.isFinite(current) || !Number.isFinite(target)) {
      throw new Response("Valeur ou objectif KPI invalide.", { status: 400 });
    }

    return {
      name,
      unit,
      value: current,
      target,
      ...(comment ? { comment } : {})
    };
  });
}

async function readJsonBody(request) {
  const length = Number(request.headers.get("content-length") || 0);
  if (length > MAX_BODY_BYTES) {
    throw new Response("Requête trop volumineuse.", { status: 413 });
  }

  try {
    return await request.json();
  } catch {
    throw new Response("Corps JSON invalide.", { status: 400 });
  }
}

function normalizePatch(body, actorEmail) {
  if (!body || typeof body !== "object" || Array.isArray(body)) {
    throw new Response("Corps de requête invalide.", { status: 400 });
  }

  for (const key of Object.keys(body)) {
    if (!ALLOWED_PATCH_FIELDS.has(key)) {
      throw new Response(\`Champ non modifiable dans la démo : \${key}\`, { status: 400 });
    }
  }

  const patch = {};

  if ("effectif_interne" in body) {
    patch.effectif_interne = normalizeNonNegativeNumber(body.effectif_interne, true);
  }
  if ("ca_interne" in body) {
    patch.ca_interne = normalizeNonNegativeNumber(body.ca_interne);
  }
  if ("objectif_ca" in body) {
    patch.objectif_ca = normalizeNonNegativeNumber(body.objectif_ca);
  }
  if ("categorie_groupe" in body) {
    const category = normalizeNullableString(body.categorie_groupe, 40);
    if (category !== null && !GROUP_CATEGORIES.has(category)) {
      throw new Response("Catégorie groupe invalide.", { status: 400 });
    }
    patch.categorie_groupe = category;
  }
  if ("commentaire" in body) {
    patch.commentaire = normalizeNullableString(body.commentaire, 2000);
  }
  if ("accounting_software" in body) {
    patch.accounting_software = normalizeNullableString(body.accounting_software, 80);
  }
  if ("other_software" in body) {
    patch.other_software = normalizeOtherSoftware(body.other_software);
  }
  if ("kpis" in body) {
    patch.kpis = normalizeKpis(body.kpis);
  }
  if ("connection_status" in body) {
    if (!CONNECTION_STATUSES.has(body.connection_status)) {
      throw new Response("Statut de connexion invalide.", { status: 400 });
    }
    patch.connection_status = body.connection_status;
    patch.connection_synced_at = body.connection_status === "connected"
      ? new Date().toISOString()
      : null;
  }

  patch.updated_by_email = actorEmail;
  return patch;
}

async function supabase(env, path, options = {}) {
  if (!env.SUPABASE_URL || !env.SUPABASE_SECRET_KEY) {
    throw new Error("Configuration Supabase manquante.");
  }

  const base = String(env.SUPABASE_URL).replace(/\/+$/, "");
  const response = await fetch(\`\${base}/rest/v1/\${path}\`, {
    ...options,
    headers: {
      "apikey": env.SUPABASE_SECRET_KEY,
      "content-type": "application/json",
      ...(options.headers || {})
    }
  });

  if (!response.ok) {
    const detail = await response.text();
    console.error("Supabase error", response.status, detail);
    throw new Error(\`Supabase \${response.status}\`);
  }

  if (response.status === 204) return null;

  const text = await response.text();
  return text ? JSON.parse(text) : null;
}

async function getCompany(env, siren) {
  const rows = await supabase(
    env,
    \`companies?siren=eq.\${encodeURIComponent(siren)}&select=*\`
  );
  return rows?.[0] || null;
}

async function handleSession(identity) {
  return json({
    email: identity.email,
    role: identity.role
  });
}

async function handleCompanies(env) {
  const [companies, states] = await Promise.all([
    supabase(env, "companies?select=*&order=nom_complet.asc"),
    supabase(env, "company_demo_state?select=*")
  ]);

  const stateBySiren = new Map(
    (states || []).map((state) => [state.siren, state])
  );

  return json(
    (companies || []).map((company) => ({
      ...company,
      demo_state: stateBySiren.get(company.siren) || null
    }))
  );
}

async function handlePatchCompany(request, env, identity, siren) {
  const body = await readJsonBody(request);
  const patch = normalizePatch(body, identity.email);

  if (Object.keys(patch).length === 1) {
    throw new Response("Aucune modification fournie.", { status: 400 });
  }

  const rows = await supabase(
    env,
    \`company_demo_state?siren=eq.\${encodeURIComponent(siren)}\`,
    {
      method: "PATCH",
      headers: { "prefer": "return=representation" },
      body: JSON.stringify(patch)
    }
  );

  if (!rows?.length) {
    throw new Response("Société introuvable.", { status: 404 });
  }

  return json(rows[0]);
}

async function handleResetCompany(env, identity, siren) {
  if (identity.role !== "xyma_admin") {
    throw new Response("Réinitialisation réservée à XYMA.", { status: 403 });
  }

  const company = await getCompany(env, siren);
  if (!company) {
    throw new Response("Société introuvable.", { status: 404 });
  }

  const baseline = baselineForCompany(company, identity.email);
  const rows = await supabase(
    env,
    \`company_demo_state?siren=eq.\${encodeURIComponent(siren)}\`,
    {
      method: "PATCH",
      headers: { "prefer": "return=representation" },
      body: JSON.stringify(baseline)
    }
  );

  return json(rows?.[0] || baseline);
}

async function handleResetAll(env, identity) {
  if (identity.role !== "xyma_admin") {
    throw new Response("Réinitialisation globale réservée à XYMA.", { status: 403 });
  }

  const companies = await supabase(env, "companies?select=*");
  const baseline = (companies || []).map((company) =>
    baselineForCompany(company, identity.email)
  );

  await supabase(
    env,
    "company_demo_state?on_conflict=siren",
    {
      method: "POST",
      headers: {
        "prefer": "resolution=merge-duplicates,return=minimal"
      },
      body: JSON.stringify(baseline)
    }
  );

  return json({
    reset: baseline.length,
    by: identity.email
  });
}

function route(pathname, method) {
  if (pathname === "/api/session" && method === "GET") {
    return { name: "session" };
  }

  if (pathname === "/api/companies" && method === "GET") {
    return { name: "companies" };
  }

  const companyMatch = pathname.match(/^\/api\/companies\/(\d{9})$/);
  if (companyMatch && method === "PATCH") {
    return { name: "patchCompany", siren: companyMatch[1] };
  }

  const resetMatch = pathname.match(/^\/api\/companies\/(\d{9})\/reset$/);
  if (resetMatch && method === "POST") {
    return { name: "resetCompany", siren: resetMatch[1] };
  }

  if (pathname === "/api/demo/reset-all" && method === "POST") {
    return { name: "resetAll" };
  }

  return null;
}

export default {
  async fetch(request, env, ctx) {
    const cors = corsHeaders(request, env);

    if (cors === null) {
      return json({ error: "Origine non autorisée." }, 403);
    }

    if (request.method === "OPTIONS") {
      return new Response(null, { status: 204, headers: cors });
    }

    try {
      const identity = await getIdentity(ctx, env);
      const url = new URL(request.url);
      const matched = route(url.pathname, request.method);

      if (!matched) {
        return json({ error: "Route API introuvable." }, 404, cors);
      }

      let response;

      switch (matched.name) {
        case "session":
          response = await handleSession(identity);
          break;
        case "companies":
          response = await handleCompanies(env);
          break;
        case "patchCompany":
          response = await handlePatchCompany(
            request,
            env,
            identity,
            assertSiren(matched.siren)
          );
          break;
        case "resetCompany":
          response = await handleResetCompany(
            env,
            identity,
            assertSiren(matched.siren)
          );
          break;
        case "resetAll":
          response = await handleResetAll(env, identity);
          break;
        default:
          response = json({ error: "Route API introuvable." }, 404);
      }

      const headers = new Headers(response.headers);
      for (const [key, value] of Object.entries(cors)) {
        headers.set(key, value);
      }

      return new Response(response.body, {
        status: response.status,
        headers
      });
    } catch (error) {
      if (error instanceof Response) {
        const message = await error.text();
        return json(
          { error: message || "Requête refusée." },
          error.status || 500,
          cors || {}
        );
      }

      console.error("Unhandled API error", error);
      return json(
        { error: "Erreur interne de l’API de démonstration." },
        500,
        cors || {}
      );
    }
  }
};
