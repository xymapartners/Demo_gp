-- ============================================================
-- Demo_gp - Schéma Supabase minimal pour la démo client
-- Architecture : Navigateur -> Cloudflare Worker -> Supabase
-- Aucun accès direct du navigateur aux tables.
-- ============================================================

begin;

-- ------------------------------------------------------------
-- 0. Fonction utilitaire : met updated_at à jour automatiquement
-- ------------------------------------------------------------
create or replace function public.set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

-- ------------------------------------------------------------
-- 1. Référentiel des sociétés
-- Source initiale : data/companies.json
-- Lecture seule côté client dans la démo.
-- ------------------------------------------------------------
create table if not exists public.companies (
  siren text primary key
    check (siren ~ '^[0-9]{9}$'),

  nom_complet text not null,
  nom_raison_sociale text,
  sigle text,

  date_creation date,
  date_fermeture date,
  etat_administratif text,

  activite_principale text,
  libelle_activite_principale text,
  nature_juridique text,
  section_activite_principale text,
  categorie_entreprise text,

  tranche_effectif_salarie text,
  annee_tranche_effectif_salarie integer,

  siret_siege text
    check (siret_siege is null or siret_siege ~ '^[0-9]{14}$'),

  adresse text,
  code_postal text,
  ville text,
  code_commune text,
  departement text,

  ca_public numeric,
  resultat_net_public numeric,
  annee_finances integer,

  dirigeant_robert boolean not null default false,
  dirigeant_kevin boolean not null default false,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

comment on table public.companies is
'Référentiel des sociétés utilisé par la démo. Données principalement publiques issues du fichier companies.json.';

-- ------------------------------------------------------------
-- 2. État partagé et modifiable de la démo
--
-- Ces valeurs sont fictives ou saisies pour la démonstration.
-- Elles ne doivent pas être présentées comme des données réelles
-- du Groupe Parfet.
-- ------------------------------------------------------------
create table if not exists public.company_demo_state (
  siren text primary key
    references public.companies(siren)
    on update cascade
    on delete cascade,

  effectif_interne integer
    check (effectif_interne is null or effectif_interne >= 0),

  ca_interne numeric
    check (ca_interne is null or ca_interne >= 0),

  objectif_ca numeric
    check (objectif_ca is null or objectif_ca >= 0),

  categorie_groupe text,
  commentaire text,

  accounting_software text,

  -- Exemple :
  -- [
  --   {"type":"CRM","name":"Salesforce"},
  --   {"type":"Trésorerie","name":"Agicap"}
  -- ]
  other_software jsonb not null default '[]'::jsonb
    check (jsonb_typeof(other_software) = 'array'),

  -- Exemple :
  -- [
  --   {"name":"Taux d'occupation","unit":"%","value":94,"target":92}
  -- ]
  kpis jsonb not null default '[]'::jsonb
    check (jsonb_typeof(kpis) = 'array'),

  -- État purement visuel de la connexion comptable.
  connection_status text not null default 'not_configured'
    check (
      connection_status in (
        'not_configured',
        'pending',
        'connected'
      )
    ),

  connection_synced_at timestamptz,

  -- Identité issue de Cloudflare Access.
  updated_by_email text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

comment on table public.company_demo_state is
'État partagé de la démo par société. Contient uniquement des valeurs fictives ou saisies pour la démonstration.';

comment on column public.company_demo_state.other_software is
'Liste JSONB souple des logiciels supposés pour la démonstration.';

comment on column public.company_demo_state.kpis is
'Liste JSONB souple des KPI fictifs de démonstration.';

comment on column public.company_demo_state.connection_status is
'État visuel simulé uniquement. Aucune connexion réelle à un logiciel comptable.';

-- ------------------------------------------------------------
-- 3. Triggers updated_at
-- ------------------------------------------------------------
drop trigger if exists companies_set_updated_at on public.companies;
create trigger companies_set_updated_at
before update on public.companies
for each row
execute function public.set_updated_at();

drop trigger if exists company_demo_state_set_updated_at on public.company_demo_state;
create trigger company_demo_state_set_updated_at
before update on public.company_demo_state
for each row
execute function public.set_updated_at();

-- ------------------------------------------------------------
-- 4. Index utiles à la démo
-- ------------------------------------------------------------
create index if not exists companies_nom_complet_idx
  on public.companies (nom_complet);

create index if not exists companies_ville_idx
  on public.companies (ville);

create index if not exists companies_activite_idx
  on public.companies (activite_principale);

create index if not exists company_demo_state_updated_at_idx
  on public.company_demo_state (updated_at desc);

-- ------------------------------------------------------------
-- 5. Sécurité
--
-- La démo n'utilise pas Supabase Auth pour ses utilisateurs.
-- Cloudflare Access identifie l'utilisateur.
-- Le Cloudflare Worker applique les droits puis accède à Supabase
-- avec un secret côté serveur.
--
-- Les rôles anon et authenticated ne doivent donc pas accéder
-- directement à ces tables.
-- ------------------------------------------------------------
alter table public.companies enable row level security;
alter table public.company_demo_state enable row level security;

revoke all on table public.companies
from anon, authenticated;

revoke all on table public.company_demo_state
from anon, authenticated;

grant select, insert, update, delete
on table public.companies
to service_role;

grant select, insert, update, delete
on table public.company_demo_state
to service_role;

commit;

-- ============================================================
-- Vérifications après création
-- ============================================================

-- Les deux tables doivent avoir rowsecurity = true :
--
-- select tablename, rowsecurity
-- from pg_tables
-- where schemaname = 'public'
--   and tablename in ('companies', 'company_demo_state')
-- order by tablename;

-- anon et authenticated ne doivent avoir aucun privilège :
--
-- select grantee, table_name, privilege_type
-- from information_schema.role_table_grants
-- where table_schema = 'public'
--   and table_name in ('companies', 'company_demo_state')
-- order by table_name, grantee, privilege_type;
