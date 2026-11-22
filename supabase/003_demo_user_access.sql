-- ============================================================
-- Demo_gp - Accès utilisateurs de la démo
-- À exécuter APRÈS schema.sql et seed_demo.sql
--
-- Architecture :
-- Cloudflare Access authentifie l'utilisateur.
-- Le Worker récupère ensuite son rôle dans cette table.
--
-- Rôles :
--   * xyma_admin      : accès XYMA complet
--   * parfet_admin    : vue groupe Groupe Parfet
--   * company_manager : vue limitée à une seule société
--
-- Règle métier :
--   * un seul compte company_manager par société
--   * le poste réel de la personne (dirigeant, manager, salarié...)
--     n'a pas d'importance pour l'application
-- ============================================================

begin;

create table if not exists public.demo_user_access (
  email text primary key
    check (
      email = lower(trim(email))
      and email ~* '^[A-Z0-9._%+\-]+@[A-Z0-9.\-]+\.[A-Z]{2,}$'
    ),

  role text not null
    check (
      role in (
        'xyma_admin',
        'parfet_admin',
        'company_manager'
      )
    ),

  siren text
    references public.companies(siren)
    on update cascade
    on delete restrict,

  active boolean not null default true,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),

  constraint demo_user_access_role_siren_check
    check (
      (role = 'company_manager' and siren is not null)
      or
      (role in ('xyma_admin', 'parfet_admin') and siren is null)
    )
);

comment on table public.demo_user_access is
'Associe une identité Cloudflare Access à un rôle applicatif de la démo.';

comment on column public.demo_user_access.siren is
'Obligatoire uniquement pour company_manager. Le compte est alors limité à cette société.';

comment on column public.demo_user_access.active is
'Permet de désactiver un accès sans supprimer son historique ou sa configuration.';

create unique index if not exists demo_user_access_one_manager_per_company_idx
  on public.demo_user_access (siren)
  where role = 'company_manager';

create index if not exists demo_user_access_role_idx
  on public.demo_user_access (role);

drop trigger if exists demo_user_access_set_updated_at
  on public.demo_user_access;

create trigger demo_user_access_set_updated_at
before update on public.demo_user_access
for each row
execute function public.set_updated_at();

alter table public.demo_user_access enable row level security;

revoke all on table public.demo_user_access
from anon, authenticated;

grant select, insert, update, delete
on table public.demo_user_access
to service_role;

commit;

-- ============================================================
-- Vérifications
-- ============================================================

-- La table doit exister avec RLS activé :
--
-- select tablename, rowsecurity
-- from pg_tables
-- where schemaname = 'public'
--   and tablename = 'demo_user_access';

-- La table est volontairement vide à ce stade :
--
-- select *
-- from public.demo_user_access
-- order by role, email;
--
-- Les cinq identités de démonstration seront ajoutées après
-- validation de leurs adresses e-mail :
--   3 x xyma_admin
--   1 x parfet_admin
--   1 x company_manager + SIREN d'une société exemple
