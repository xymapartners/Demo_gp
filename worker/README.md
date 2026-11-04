# API Cloudflare Worker — démo Groupe Parfet

Cette API est volontairement limitée à la démo.

## Routes

- `GET /api/session` : identité Cloudflare Access et rôle de démo.
- `GET /api/companies` : 82 sociétés + `demo_state`.
- `PATCH /api/companies/:siren` : modifie uniquement les champs autorisés de `company_demo_state`.
- `POST /api/companies/:siren/reset` : réinitialise une société — XYMA uniquement.
- `POST /api/demo/reset-all` : réinitialise toute la démo — XYMA uniquement.

## Sécurité

Cloudflare Access doit protéger directement le Worker. Le Worker refuse les requêtes si `ctx.access` ne contient pas une identité Access valide.

Deux listes d'adresses e-mail définissent les rôles applicatifs :

- `XYMA_ADMIN_EMAILS`
- `PARFET_ADMIN_EMAILS`

Même si Cloudflare Access autorise quelqu'un à atteindre le Worker, son e-mail doit aussi être présent dans l'une de ces listes.

Le Worker utilise `SUPABASE_SECRET_KEY` uniquement côté serveur. Cette clé ne doit jamais être présente dans le JavaScript du navigateur, dans GitHub, ni dans un fichier versionné.

## Variables / secrets à configurer dans Cloudflare

- `SUPABASE_URL`
- `SUPABASE_SECRET_KEY` — secret
- `XYMA_ADMIN_EMAILS`
- `PARFET_ADMIN_EMAILS`
- `ALLOWED_ORIGIN` — facultatif si même origin

## Mise en place

1. Créer le projet Supabase **DEMO**.
2. Exécuter `../supabase/schema.sql`.
3. Exécuter `../supabase/seed_demo.sql`.
4. Créer une clé **secret** Supabase dédiée au Worker.
5. Déployer ce Worker depuis Cloudflare.
6. Ajouter les variables et secrets ci-dessus dans les paramètres du Worker.
7. Protéger le hostname/chemin du Worker avec Cloudflare Access.
8. Autoriser les 3 comptes XYMA et le compte administrateur Parfet dans Access.
9. Renseigner les mêmes e-mails dans `XYMA_ADMIN_EMAILS` et `PARFET_ADMIN_EMAILS`.
10. Tester `/api/session`, puis `/api/companies`.

## Routage recommandé

Idéalement, exposer l'API sous le même hostname que la démo, sur `/api/*`.
Cela évite CORS et garde le parcours plus simple.

Si l'API est placée sur un sous-domaine séparé, définir `ALLOWED_ORIGIN` avec l'origin exact du front et effectuer les appels navigateur avec les cookies Access appropriés.

## Important

Les valeurs KPI, logiciels, objectifs et connexions sont des données de démonstration. Le Worker n'établit aucune connexion réelle avec un logiciel comptable, une banque ou un SI client.
