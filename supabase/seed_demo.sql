-- ============================================================
-- Demo_gp - Import initial Supabase
-- Généré depuis la branche demo-local-storage-warnings
-- Référentiel : data/companies.json
-- Exemples : mapSamples (app.js) + connectionDemoExamples (connections.js)
--
-- Comportement :
--   * companies : UPSERT -> le référentiel public peut être resynchronisé.
--   * company_demo_state : INSERT ... ON CONFLICT DO NOTHING ->
--     une réexécution n'écrase PAS les modifications déjà faites dans la démo.
--
-- À exécuter APRÈS le script de création des tables.
-- ============================================================

begin;

-- ------------------------------------------------------------
-- 1. Import / mise à jour des 82 sociétés
-- ------------------------------------------------------------
insert into public.companies (
  siren,
  nom_complet,
  nom_raison_sociale,
  sigle,
  date_creation,
  date_fermeture,
  etat_administratif,
  activite_principale,
  libelle_activite_principale,
  nature_juridique,
  section_activite_principale,
  categorie_entreprise,
  tranche_effectif_salarie,
  annee_tranche_effectif_salarie,
  siret_siege,
  adresse,
  code_postal,
  ville,
  code_commune,
  departement,
  ca_public,
  resultat_net_public,
  annee_finances,
  dirigeant_robert,
  dirigeant_kevin
)
values
  ('338539232', 'ACAJOU DEVELOPPEMENT SA', 'ACAJOU DEVELOPPEMENT SA', null, '1986-07-11', null, 'A', '68.20B', null, '5599', 'L', 'ETI', 'NN', null, '33853923200029', 'CENTRE CCIAL LA GALLERIA CHEZ SOCODIS  STE NOUVELLE 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', 0, 127570, 2024, true, true),
  ('404427221', 'ACAJOU SYNDIC', 'ACAJOU SYNDIC', null, '1996-02-15', null, 'A', '68.32A', null, '5499', 'L', 'ETI', 'NN', null, '40442722100019', 'CENTRE CCIAL LA GALLERIA CHEZ SOCODIS STE NLLE 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', 0, 0, 2024, false, true),
  ('992667766', 'AGM ELEC', 'AGM ELEC', null, '2025-10-03', null, 'A', '00.00Z', null, '5499', null, null, 'NN', null, '99266776600016', 'LOTISSEMENT LA BRISE ACAJOU 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', null, null, null, true, true),
  ('303169411', 'AGM HOLDING', 'AGM HOLDING', null, '1972-01-01', null, 'A', '70.10Z', null, '5599', 'M', 'ETI', '03', 2024, '30316941100020', 'ACAJOU 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', 0, 6121484, 2024, true, true),
  ('488308198', 'AGM IMPORT', 'AGM IMPORT', null, '2006-02-01', null, 'A', '45.11Z', null, '5499', 'G', 'ETI', 'NN', null, '48830819800016', 'ACAJOU C/O AUTOS GM 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', 0, 131829, 2024, true, true),
  ('450252747', 'ALU DISCOUNT', 'ALU DISCOUNT', null, '2003-09-01', null, 'A', '46.73A', null, '5499', 'G', 'ETI', 'NN', null, '45025274700016', 'PLACE D''ARMES CHEZ SOCOMI 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', 0, -4584, 2024, true, false),
  ('349917211', 'ANTILLES BOIS MENUISERIES (ABM)', 'ANTILLES BOIS MENUISERIES', 'ABM', '1989-02-15', null, 'A', '47.59A', null, '5710', 'G', 'ETI', '11', 2024, '34991721100022', 'ZI PETITE COCOTTE CANAL 2 97224 DUCOS', '97224', 'DUCOS', '97207', '972', 0, 35492, 2024, true, false),
  ('451715767', 'AUTO QUICK', 'AUTO QUICK', null, '2004-01-15', null, 'A', '45.32Z', null, '5499', 'G', 'ETI', '11', 2024, '45171576700013', 'ACAJOU CZ AUTO GM 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', 0, 82987, 2024, true, true),
  ('390147007', 'AUTOMOBILES GENERALES MARTINIQUAISES', 'AUTOMOBILES GENERALES MARTINIQUAISES', null, '1993-03-09', null, 'A', '45.11Z', null, '5499', 'G', 'ETI', '22', 2024, '39014700700020', 'ACAJOU 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', 0, -3473524, 2024, true, false),
  ('388670945', 'B.K.J.', 'B.K.J.', null, '1992-09-02', null, 'A', '68.20B', null, '6540', 'L', 'PME', 'NN', null, '38867094500012', 'CENTRE CCIAL LA GALLERIA CHEZ : STE 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', null, null, null, true, false),
  ('510498264', 'BERGONDELEC', 'BERGONDELEC', null, '2008-11-27', null, 'A', '35.11Z', null, '5499', 'D', 'PME', 'NN', null, '51049826400017', 'ACAJOU CZ JKB-CTRE COMMERCIAL LA GALLERIA 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', null, null, null, true, false),
  ('902719640', 'BRIKEJEN', 'BRIKEJEN', null, '2021-09-01', null, 'A', '68.32A', null, '5710', 'L', 'PME', 'NN', null, '90271964000010', '218 IMPASSE DES PALMIERS C/O M. PARFAIT ROBERT -   ACAJOU 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', 0, 739705, 2024, true, false),
  ('444879977', 'CAP EST', 'CAP EST', null, '2002-12-13', null, 'A', '68.20A', null, '6540', 'L', 'PME', 'NN', null, '44487997700015', 'ACAJOU CZ JKB CTRE CC  GALLERIA 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', null, null, null, true, false),
  ('510181274', 'COFINLEC', 'COFINLEC', null, '2008-11-25', null, 'A', '35.11Z', null, '5499', 'D', 'ETI', 'NN', null, '51018127400018', 'ZI DE PLACE D''ARMES IMM SOCOMI CZ CONFINDUS 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', 0, 2128, 2024, true, false),
  ('303169692', 'COMPAGNIE FINANCIERE POUR L''INDUSTRIE (COFINDUS)', 'COMPAGNIE FINANCIERE POUR L''INDUSTRIE', 'COFINDUS', '1974-01-01', null, 'A', '68.20B', null, '5710', 'L', 'ETI', '01', 2024, '30316969200025', 'PLACE D''ARMES IMM.SOCOMI 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', 0, 1399596, 2024, true, false),
  ('316866672', 'COMPAGNIE MARTINIQUAISE DE LOCATION D''AUTOMOBILES (COMALOC)', 'COMPAGNIE MARTINIQUAISE DE LOCATION D''AUTOMOBILES', 'COMALOC', '1979-01-01', null, 'A', '77.11A', null, '5499', 'N', 'ETI', '12', 2024, '31686667200074', 'ACAJOU C/AUTO GM- QUARTIER ACAJOU GALLERIA 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', 0, -1411536, 2024, true, false),
  ('799299565', 'DELI INVEST', 'DELI INVEST', null, '2013-12-20', null, 'A', '68.20A', null, '6540', 'L', 'PME', 'NN', null, '79929956500017', 'ACAJOU CENTRE COMM LA GALLERIA C/ J.K.B. 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', null, null, null, true, false),
  ('451369318', 'DELIPOINT', 'DELIPOINT', null, '2003-12-30', null, 'A', '56.10C', null, '5499', 'I', 'PME', '03', 2024, '45136931800014', 'LA POINTE DES NEGRES CENTRE COMMERCIAL LE ROND 97200 FORT-DE-FRANCE', '97200', 'FORT-DE-FRANCE', '97209', '972', 0, 189982, 2024, true, false),
  ('799388277', 'EARL HABITATION MAUPEOU', 'EARL HABITATION MAUPEOU', null, '2013-11-05', null, 'A', '00.00Z', null, '6598', null, null, 'NN', null, '79938827700011', 'CENTRE CCIAL LA GALLERIA CHEZ JKB 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', null, null, null, true, false),
  ('750645541', 'GENERALE IMMOBILIERE DE L''ACAJOU', 'GENERALE IMMOBILIERE DE L''ACAJOU', null, '2012-03-27', null, 'A', '00.00Z', null, '6540', null, 'PME', 'NN', null, '75064554100012', 'ACAJOU CHEZ AGM HOLDING 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', null, null, null, true, false),
  ('510181373', 'GONDELEC', 'GONDELEC', null, '2008-11-28', null, 'A', '35.11Z', null, '5499', 'D', 'PME', 'NN', null, '51018137300018', 'CENTRE CCIAL LA GALLERIA CZ J.K.B ACAJOU 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', null, null, null, true, false),
  ('822243010', 'IMMOPAR', 'IMMOPAR', null, '2016-08-03', null, 'A', '68.20B', null, '5499', 'L', 'PME', 'NN', null, '82224301000029', 'MANGOT VULCIN CZ SOCIPAR IMM ALBIZIA BOIS CARRE 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', null, null, null, true, false),
  ('799301072', 'INVEST LOG 1', 'INVEST LOG 1', null, '2013-12-20', null, 'A', '68.20A', null, '6540', 'L', 'PME', 'NN', null, '79930107200010', 'ACAJOU CENTRE COMM LA GALLERIA - C/ J.K.B. 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', null, null, null, true, false),
  ('799419189', 'INVEST LOG DIAMANT BLEU', 'INVEST LOG DIAMANT BLEU', null, '2013-12-27', null, 'A', '68.20A', null, '6540', 'L', 'PME', 'NN', null, '79941918900011', 'ACAJOU LA GALLERIA - C/ JKB CENTRE COMMERC 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', null, null, null, true, false),
  ('799301106', 'INVEST LOG II', 'INVEST LOG II', null, '2013-12-20', null, 'A', '68.20A', null, '6540', 'L', 'PME', 'NN', null, '79930110600016', 'ACAJOU CENTRE COMM LA GALLERIA - C/ J.K.B. 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', null, null, null, true, false),
  ('350310520', 'J K B', 'J K B', null, '1989-02-01', null, 'A', '64.20Z', null, '5710', 'K', 'PME', 'NN', null, '35031052000019', 'CENTRE CCIAL LA GALLERIA ACAJOU 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', 0, 386943, 2024, true, false),
  ('535243398', 'JFR', 'JFR', null, '2011-10-01', null, 'A', '68.20B', null, '6540', 'L', null, 'NN', null, '53524339800018', 'LOTISSEMENT LA BRISE ACAJOU CHEZ M.& MME PARFAIT 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', null, null, null, true, false),
  ('535243380', 'JK BOLOGNE', 'JK BOLOGNE', null, '2011-10-01', null, 'A', '68.20B', null, '6540', 'L', 'PME', 'NN', null, '53524338000016', 'CENTRE CCIAL LA GALLERIA ACAJOU - CHEZ JKB 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', null, null, null, true, false),
  ('951403591', 'JK BOLOGNE II', 'JK BOLOGNE II', null, '2023-03-05', null, 'A', '68.32B', null, '6599', 'L', 'PME', 'NN', null, '95140359100013', 'CENTRE CCIAL LA GALLERIA C O JKB 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', null, null, null, true, false),
  ('510520158', 'MERCELEC', 'MERCELEC', null, '2008-11-28', null, 'A', '35.11Z', null, '5499', 'D', 'ETI', 'NN', null, '51052015800013', 'ZI DE PLACE D''ARMES IMM:SOCOMI 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', 0, -4339, 2024, true, false),
  ('421594896', 'MONYV', 'MONYV', null, '1998-12-10', null, 'A', '70.10Z', null, '5599', 'M', 'ETI', '02', 2024, '42159489600050', '231 RUE SAINT-HONORE CHEZ KANDBAZ 75001 PARIS', '75001', 'PARIS', '75101', '75', 570845000, 17583000, 2023, true, true),
  ('345237580', 'PARACA', 'PARACA', null, '1988-03-18', null, 'A', '68.20A', null, '6540', 'L', null, 'NN', null, '34523758000013', 'LOTISSEMENT LA BRISE ACAJOU 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', null, null, null, true, false),
  ('817510191', 'PARACA II', 'PARACA II', null, '2015-12-23', null, 'A', '68.20A', null, '6540', 'L', null, 'NN', null, '81751019100015', 'RPT ACAJOU CTRE COMMERCIAL LA GALLERIA - C/JKB 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', null, null, null, true, true),
  ('817510167', 'PARACA III', 'PARACA III', null, '2015-12-23', null, 'A', '68.20A', null, '6540', 'L', null, 'NN', null, '81751016700015', 'RPT ACAJOU CTRE COMMERCIAL LA GALLERIA - C/JKB 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', null, null, null, true, true),
  ('503403743', 'PARELEC 1', 'PARELEC 1', null, '2007-11-22', null, 'A', '35.11Z', null, '5499', 'D', 'ETI', 'NN', null, '50340374300027', 'ZI DE PLACE D''ARMES IMM SOCOMI 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', 0, 5884, 2024, true, false),
  ('380105148', 'PARGUY', 'PARGUY', null, '1990-11-01', null, 'A', '68.31Z', null, '5499', 'L', 'PME', 'NN', null, '38010514800015', 'LOTISSEMENT LA BRISE ACAJOU CHEZ YVES PARFAIT 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', 0, 323394, 2024, true, true),
  ('491359055', 'PATRI  III', 'PATRI  III', null, '2006-07-13', null, 'A', '68.20B', null, '6540', 'L', 'PME', 'NN', null, '49135905500010', 'ACAJOU CZ JKB CTRE CCIAL GALLERIA 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', null, null, null, true, false),
  ('488439100', 'PATRI I', 'PATRI I', null, '2005-11-09', null, 'A', '68.20B', null, '6599', 'L', 'PME', 'NN', null, '48843910000014', 'ACAJOU CZ JKB CCIAL DE LA GALLERIA 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', null, null, null, true, false),
  ('489615864', 'PATRI I I', 'PATRI I I', null, '2005-12-27', null, 'A', '68.20B', null, '6540', 'L', 'PME', 'NN', null, '48961586400019', 'ACAJOU CZ J K B  CCIAL LA GALLERIA 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', null, null, null, true, false),
  ('503032203', 'PATRI IV', 'PATRI IV', null, '2007-12-21', null, 'A', '68.10Z', null, '6540', 'L', 'PME', 'NN', null, '50303220300013', 'ACAJOU CZ JKB CC LA GALLERIA 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', null, null, null, true, false),
  ('522352590', 'PATRI V', 'PATRI V', null, '2009-12-23', null, 'A', '68.20B', null, '6540', 'L', 'PME', 'NN', null, '52235259000015', 'CENTRE CCIAL LA GALLERIA CHEZ JKB 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', null, null, null, true, false),
  ('522352574', 'PATRI VI', 'PATRI VI', null, '2009-12-22', null, 'A', '68.20B', null, '6540', 'L', 'PME', 'NN', null, '52235257400019', 'CENTRE CCIAL LA GALLERIA CHEZ JKB 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', null, null, null, true, false),
  ('531507358', 'PATRI VII', 'PATRI VII', null, '2010-12-27', null, 'A', '68.20B', null, '6540', 'L', 'PME', 'NN', null, '53150735800012', 'CENTRE CCIAL LA GALLERIA CHEZ JKB - ACAJOU 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', null, null, null, true, false),
  ('790596274', 'PATRI VIII', 'PATRI VIII', null, '2012-01-01', null, 'A', '68.20B', null, '6540', 'L', 'PME', 'NN', null, '79059627400015', 'ACAJOU CENTRE COMMERCIAL GALLERIA CHEZ JKB 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', null, null, null, true, false),
  ('377770839', 'POP''S CAR MARTINIQUE', 'POP''S CAR MARTINIQUE', null, '1990-04-02', null, 'A', '77.11A', null, '5710', 'N', 'ETI', '11', 2024, '37777083900019', 'AEROPORT 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', 0, -454870, 2024, true, false),
  ('107810202', 'R & M HOLDING', 'R & M HOLDING', null, '2026-07-07', null, 'A', '70.10Z', null, '5710', 'M', null, 'NN', null, '10781020200013', 'LOTISSEMENT LA BRISE ACAJOU 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', null, null, null, true, true),
  ('985152529', 'ROSEGUALEC', 'ROSEGUALEC', null, '2024-02-26', null, 'A', '35.11Z', null, '5499', 'D', 'PME', 'NN', null, '98515252900014', 'CCIAL LA GALLERIA 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', 0, -1309, 2024, true, true),
  ('503032245', 'SCI BERGONDEAU', 'SCI BERGONDEAU', null, '2007-12-23', null, 'A', '68.20B', null, '6540', 'L', 'PME', 'NN', null, '50303224500014', 'CENTRE CCIAL LA GALLERIA CZ JKB 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', null, null, null, true, false),
  ('331703702', 'SCI COLIBRI', 'SCI COLIBRI', null, '1984-05-01', null, 'A', '68.20B', null, '6540', 'L', null, 'NN', null, '33170370200018', 'LOTISSEMENT LA BRISE ACAJOU 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', null, null, null, true, false),
  ('453690935', 'SCI COPREST', 'SCI COPREST', null, '2004-01-18', null, 'A', '68.20A', null, '6599', 'L', 'PME', 'NN', null, '45369093500011', 'ACAJOU CZ JKB CTRE CCIAL LA GALLE 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', null, null, null, true, false),
  ('491359147', 'SCI INVESTISARDE', 'SCI INVESTISARDE', null, '2006-07-19', null, 'A', '68.20B', null, '6540', 'L', 'PME', 'NN', null, '49135914700015', 'CENTRE CCIAL LA GALLERIA CZ JKB ACAJOU 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', null, null, null, true, false),
  ('803019223', 'SCI ROSEGUA', 'SCI ROSEGUA', null, '2014-09-01', null, 'A', '68.20B', null, '6540', 'L', 'PME', 'NN', null, '80301922300020', 'CENTRE CCIAL LA GALLERIA CHEZ. JKB ACAJOU 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', null, null, null, true, false),
  ('797403094', 'SCPI RP', 'SCPI RP', null, '2013-09-05', null, 'A', '68.32B', null, '6599', 'L', 'PME', 'NN', null, '79740309400015', 'IMPASSE DES PALMIERS ACAJOU 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', null, null, null, true, false),
  ('342377629', 'SOC COMMERCIALISATION DISTRIBUTION (SOCODIS)', 'SOC COMMERCIALISATION DISTRIBUTION', 'SOCODIS', '1987-07-31', null, 'A', '68.20B', null, '5710', 'L', 'ETI', '11', 2024, '34237762900023', 'CENTRE CCIAL LA GALLERIA ACAJOU 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', 22660141, 8104797, 2024, true, true),
  ('387618721', 'SOC CONSTR MENUIS INDUST', 'SOC CONSTR MENUIS INDUST', null, '1992-06-15', null, 'A', '25.12Z', null, '5499', 'C', 'ETI', '21', 2024, '38761872100022', 'PLACE D''ARMES 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', null, null, null, true, false),
  ('394667745', 'SOC DE PRODUCTION ET DE RESTAURATION (SOPROREST)', 'SOC DE PRODUCTION ET DE RESTAURATION', 'SOPROREST', '1994-02-24', '2016-12-31', 'C', '56.10C', null, '5499', 'I', null, 'NN', null, '39466774500019', 'CTRE CCIAL LA GALLERIA ACAJOU 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', null, null, null, true, false),
  ('823904008', 'SOC DE PRODUCTION ET DE RESTAURATION BIS (SO PRO REST BIS)', 'SOC DE PRODUCTION ET DE RESTAURATION BIS', null, '2016-11-03', null, 'A', '56.10A', null, '5710', 'I', 'PME', '12', 2024, '82390400800013', 'CENTRE CCIAL LA GALLERIA 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', 0, 27642, 2024, true, false),
  ('380348607', 'SOC GENER LOCATION AUTOMOBILES', 'SOC GENER LOCATION AUTOMOBILES', null, '1990-12-15', null, 'A', '77.11A', null, '5202', 'N', 'ETI', 'NN', null, '38034860700025', 'ACAJOU CHEZ AUTOS GM 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', 0, -600163, 2024, true, false),
  ('880216908', 'SOC IMMO INVEST (SOC IMMO INVEST)', 'SOC IMMO INVEST', null, '2019-12-16', null, 'A', '68.31Z', null, '5710', 'L', 'ETI', 'NN', null, '88021690800017', 'CENTRE CCIAL LA GALLERIA ACAJOU 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', 0, -3632, 2024, true, true),
  ('993884493', 'SOC IMMO RES PLACE D''ARMES', 'SOC IMMO RES PLACE D''ARMES', null, '2025-11-12', null, 'A', '68.20B', null, '5710', 'L', null, 'NN', null, '99388449300012', 'LA GALLERIA ACAJOU 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', null, null, null, true, true),
  ('985159268', 'SOC IMMOLEC', 'SOC IMMOLEC', null, '2024-02-26', null, 'A', '35.11Z', null, '5499', 'D', 'PME', 'NN', null, '98515926800012', 'CCIAL LA GALLERIA 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', 0, 0, 2024, true, true),
  ('494546005', 'SOCAUMAR ATELIER                             SOCIETE AUTOMOBILE MARTINIQUAISE ATELIER', 'SOCAUMAR ATELIER                             SOCIETE AUTOMOBILE MARTINIQUAISE ATELIER', null, '2007-03-01', '2007-11-29', 'C', '45.20A', null, '5499', 'G', null, 'NN', null, '49454600500013', 'ACAJOU C/Z AGM HOLDING  IMM AUTOS GM 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', null, null, null, true, false),
  ('494544430', 'SOCAUMAR S A V                               SOCIETE AUTOMOBILE MARTINIQUAISE S A V', 'SOCAUMAR S A V                               SOCIETE AUTOMOBILE MARTINIQUAISE S A V', null, '2007-03-01', '2019-06-26', 'C', '45.20A', null, '5499', 'G', null, 'NN', null, '49454443000015', 'ACAJOU C/Z AGM HOLDING  IMM AUTOS GM 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', null, null, null, true, false),
  ('831070735', 'SOCIETE GUADELOUPEENNE BUDGET (SOGUABUD) (SOGUABUD)', 'SOCIETE GUADELOUPEENNE BUDGET', 'SOGUABUD', '2017-07-01', null, 'A', '77.11A', null, '5499', 'N', 'PME', 'NN', null, '83107073500012', 'ACAJOU C/ AUTOS GM 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', null, null, null, true, false),
  ('488130212', 'SOCIETE GUADELOUPEENNE DE LOCATION (SOGUALOC)', 'SOCIETE GUADELOUPEENNE DE LOCATION', 'SOGUALOC', '2006-01-02', null, 'A', '77.11A', null, '5499', 'N', 'ETI', '11', 2024, '48813021200019', 'ACAJOU C/O AUTOS GM 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', 0, -1024941, 2024, true, true),
  ('344000484', 'SOCIETE HOTELIERE DE L''ACAJOU (SHA)', 'SOCIETE HOTELIERE DE L''ACAJOU', 'SHA', '1990-01-01', null, 'A', '55.10Z', null, '5710', 'I', 'ETI', '11', 2024, '34400048400024', 'CENTRE CCIAL LA GALLERIA CHEZ SOCODIS STE NOUVELLE 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', 0, 60437, 2024, false, true),
  ('444714745', 'SOCIETE MARTINIQUAISE DE LOCATION (SOMARLOC)', 'SOCIETE MARTINIQUAISE DE LOCATION', 'SOMARLOC', '2003-01-02', null, 'A', '77.11A', null, '5499', 'N', 'ETI', '11', 2024, '44471474500015', 'ACAJOU CZ AUTO GM 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', 0, -582504, 2024, true, false),
  ('452402621', 'SOCO', 'SOCO', null, '2004-01-15', null, 'A', '70.22Z', null, '6220', 'M', 'PME', '11', 2024, '45240262100018', 'CITE ACAJOU CTRE COMM GALLERIA CZ SOCO 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', null, null, null, true, true),
  ('799840954', 'SOCO SAINTE ROSE', 'SOCO SAINTE ROSE', null, '2014-02-01', null, 'A', '47.11D', null, '5710', 'G', 'ETI', '11', 2024, '79984095400017', 'CENTRE CCIAL LA GALLERIA ACAJOU CHEZ SOCOHOLD SAS 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', 0, 110163, 2024, false, true),
  ('539677682', 'SOCOARMES', 'SOCOARMES', null, '2012-02-03', null, 'A', '47.11F', null, '5710', 'G', 'ETI', '22', 2024, '53967768200012', 'CTRE CCIAL LA GALLERIA ACAJOU 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', 0, 462538, 2024, true, true),
  ('502065568', 'SOCOCAZ', 'SOCOCAZ', null, '2008-01-01', null, 'A', '45.11Z', null, '5499', 'G', 'ETI', '03', 2024, '50206556800011', 'ACAJOU CZ AUTOS GM 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', 0, -147400, 2024, true, false),
  ('985144526', 'SOCODELEC', 'SOCODELEC', null, '2024-02-26', null, 'A', '35.11Z', null, '5499', 'D', 'ETI', 'NN', null, '98514452600011', 'CCIAL LA GALLERIA 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', 0, -13436, 2024, true, true),
  ('530132158', 'SOCOFORT', 'SOCOFORT', null, '2011-02-07', null, 'A', '47.11F', null, '5710', 'G', 'ETI', '22', 2024, '53013215800037', 'BAS DU FORT C/ SOC IMMO 97190 LE GOSIER', '97190', 'LE GOSIER', '97113', '971', 59583829, 560033, 2024, false, true),
  ('488053620', 'SOCOHOLD', 'SOCOHOLD', null, '2005-11-01', null, 'A', '64.20Z', null, '5710', 'K', 'ETI', '03', 2024, '48805362000016', 'CENTRE CCIAL LA GALLERIA ACAJOU 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', 0, 2977644, 2024, false, true),
  ('500881388', 'SOCOLUCE', 'SOCOLUCE', null, '2007-11-08', null, 'A', '47.11D', null, '5710', 'G', 'ETI', '11', 2024, '50088138800010', 'CENTRE CCIAL LA GALLERIA C/O SOCOMEX ACAJOU 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', 0, 195685, 2024, false, true),
  ('445081987', 'SOCOPOINT', 'SOCOPOINT', null, '2003-01-21', null, 'A', '47.11F', null, '5710', 'G', 'ETI', '32', 2024, '44508198700015', 'RTE DU PHARE CTRE COMM LE ROND PONIT 97200 FORT DE FRANCE', '97200', 'FORT DE FRANCE', '97209', '972', 83501285, 1364545, 2024, true, true),
  ('539634402', 'SOCOPRE', 'SOCOPRE', null, '2012-02-03', '2022-10-12', 'C', '47.11D', null, '5710', 'G', null, 'NN', null, '53963440200017', 'CTRE CCIAL LA GALLERIA ACAJOU 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', null, null, null, true, true),
  ('429210495', 'SOCOPREST', 'SOCOPREST', null, '2000-01-20', null, 'A', '56.10C', null, '5499', 'I', null, 'NN', null, '42921049500025', 'LOTISSEMENT MARVEL ACAJOU 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', null, null, null, true, false),
  ('494547425', 'SODAUTO S A V', 'SODAUTO S A V', null, '2007-02-15', null, 'A', '45.11Z', null, '5499', 'G', 'ETI', 'NN', null, '49454742500012', 'ACAJOU CZ SODAUTO 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', 0, -2579, 2024, true, false),
  ('523746857', 'SOEXPRES', 'SOEXPRES', null, '2010-08-12', null, 'A', '56.10A', null, '5499', 'I', 'PME', '02', 2024, '52374685700011', 'CENTRE CCIAL LA GALLERIA LOCAL N TT17-3E TRANCHE 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', null, null, null, true, true),
  ('329060495', 'SOGEX', 'SOGEX', null, '1984-01-23', null, 'A', '68.20B', null, '6599', 'L', null, 'NN', null, '32906049500044', 'ACAJOU C/O AGM HOLDING 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', null, null, null, true, false),
  ('352881593', 'STE COMMER EXPLO GRANDES SURFACES (SOCOMEX)', 'STE COMMER EXPLO GRANDES SURFACES', 'SOCOMEX', '1990-01-01', null, 'A', '47.11F', null, '5710', 'G', 'ETI', '32', 2024, '35288159300011', 'CENTRE CCIAL LA GALLERIA 97232 LE LAMENTIN', '97232', 'LE LAMENTIN', '97213', '972', 123504287, 520614, 2024, false, true)
on conflict (siren) do update set
  nom_complet = excluded.nom_complet,
  nom_raison_sociale = excluded.nom_raison_sociale,
  sigle = excluded.sigle,
  date_creation = excluded.date_creation,
  date_fermeture = excluded.date_fermeture,
  etat_administratif = excluded.etat_administratif,
  activite_principale = excluded.activite_principale,
  libelle_activite_principale = excluded.libelle_activite_principale,
  nature_juridique = excluded.nature_juridique,
  section_activite_principale = excluded.section_activite_principale,
  categorie_entreprise = excluded.categorie_entreprise,
  tranche_effectif_salarie = excluded.tranche_effectif_salarie,
  annee_tranche_effectif_salarie = excluded.annee_tranche_effectif_salarie,
  siret_siege = excluded.siret_siege,
  adresse = excluded.adresse,
  code_postal = excluded.code_postal,
  ville = excluded.ville,
  code_commune = excluded.code_commune,
  departement = excluded.departement,
  ca_public = excluded.ca_public,
  resultat_net_public = excluded.resultat_net_public,
  annee_finances = excluded.annee_finances,
  dirigeant_robert = excluded.dirigeant_robert,
  dirigeant_kevin = excluded.dirigeant_kevin;

-- ------------------------------------------------------------
-- 2. État initial de démonstration pour les 82 sociétés
--
-- Valeurs internes (effectif, CA, objectif, commentaire) :
-- NULL au départ, car elles ne proviennent pas de données client validées.
--
-- Les catégories sont reprises de la logique actuelle de la démo.
-- Les logiciels/KPI ne sont préremplis que pour les 8 exemples
-- déjà présents dans app.js.
-- Les 2 connexions "connected" reproduisent connections.js.
-- ------------------------------------------------------------
insert into public.company_demo_state (
  siren,
  effectif_interne,
  ca_interne,
  objectif_ca,
  categorie_groupe,
  commentaire,
  accounting_software,
  other_software,
  kpis,
  connection_status,
  connection_synced_at,
  updated_by_email
)
values
  ('338539232', null, null, null, 'Immobilier', null, 'Sage', '[{"type":"Gestion immobilière","name":"Odoo"},{"type":"CRM","name":"Salesforce"},{"type":"Trésorerie","name":"Agicap"}]'::jsonb, '[{"name":"Taux d’occupation","unit":"%","value":94,"target":92},{"name":"Loyers encaissés","unit":"%","value":97,"target":96},{"name":"Délai de relocation","unit":"jours","value":24,"target":20}]'::jsonb, 'connected', now() - interval '8 minutes', null),
  ('404427221', null, null, null, 'Immobilier', null, 'Cegid', '[{"type":"Gestion immobilière","name":"Odoo"},{"type":"Paie / RH","name":"Silae"},{"type":"Gestion documentaire","name":"SharePoint"},{"type":"Formation","name":"360Learning"}]'::jsonb, '[{"name":"Lots gérés","unit":"lots","value":1280,"target":1250},{"name":"Charges recouvrées","unit":"%","value":95,"target":97},{"name":"Dossiers traités","unit":"%","value":89,"target":90}]'::jsonb, 'pending', null, null),
  ('992667766', null, null, null, null, null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('303169411', null, null, null, null, null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('488308198', null, null, null, 'Automobile', null, 'Sage', '[{"type":"Gestion commerciale","name":"Odoo"},{"type":"CRM","name":"Salesforce"},{"type":"Facturation","name":"Sellsy"}]'::jsonb, '[{"name":"Véhicules vendus","unit":"unités","value":68,"target":72},{"name":"Marge commerciale","unit":"%","value":19,"target":18},{"name":"Rotation du stock","unit":"jours","value":41,"target":38}]'::jsonb, 'pending', null, null),
  ('450252747', null, null, null, null, null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('349917211', null, null, null, null, null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('451715767', null, null, null, 'Automobile', null, 'EBP', '[{"type":"Gestion commerciale","name":"Odoo"}]'::jsonb, '[{"name":"Interventions réalisées","unit":"unités","value":156,"target":150},{"name":"Satisfaction client","unit":"%","value":91,"target":92},{"name":"Délai moyen","unit":"jours","value":3,"target":4}]'::jsonb, 'pending', null, null),
  ('390147007', null, null, null, 'Automobile', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('388670945', null, null, null, 'Immobilier', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('510498264', null, null, null, 'Industrie', null, 'Sage', '[{"type":"ERP","name":"SAP"},{"type":"Stocks","name":"SAP"}]'::jsonb, '[{"name":"Production mensuelle","unit":"unités","value":12400,"target":12000},{"name":"Taux de disponibilité","unit":"%","value":93,"target":95},{"name":"Rebuts","unit":"%","value":1.9,"target":2}]'::jsonb, 'pending', null, null),
  ('902719640', null, null, null, 'Immobilier', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('444879977', null, null, null, 'Immobilier', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('510181274', null, null, null, 'Industrie', null, 'EBP', '[{"type":"ERP","name":"Odoo"},{"type":"Paie / RH","name":"PayFit"},{"type":"Gestion de projets","name":"Monday.com"}]'::jsonb, '[{"name":"Commandes produites","unit":"unités","value":410,"target":400},{"name":"Livraisons à temps","unit":"%","value":88,"target":92},{"name":"Accidents avec arrêt","unit":"unités","value":0,"target":0}]'::jsonb, 'pending', null, null),
  ('303169692', null, null, null, 'Immobilier', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('316866672', null, null, null, 'Automobile', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('799299565', null, null, null, 'Immobilier', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('451369318', null, null, null, 'Alimentaire', null, 'Pennylane', '[{"type":"Stocks","name":"Odoo"},{"type":"Gestion commerciale","name":"Shopify"}]'::jsonb, '[{"name":"Commandes livrées","unit":"unités","value":840,"target":800},{"name":"Ruptures de stock","unit":"%","value":4,"target":3},{"name":"Marge brute","unit":"%","value":27,"target":26}]'::jsonb, 'connected', now() - interval '32 minutes', null),
  ('799388277', null, null, null, null, null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('750645541', null, null, null, null, null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('510181373', null, null, null, 'Industrie', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('822243010', null, null, null, 'Immobilier', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('799301072', null, null, null, 'Immobilier', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('799419189', null, null, null, 'Immobilier', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('799301106', null, null, null, 'Immobilier', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('350310520', null, null, null, null, null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('535243398', null, null, null, 'Immobilier', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('535243380', null, null, null, 'Immobilier', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('951403591', null, null, null, 'Immobilier', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('510520158', null, null, null, 'Industrie', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('421594896', null, null, null, null, null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('345237580', null, null, null, 'Immobilier', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('817510191', null, null, null, 'Immobilier', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('817510167', null, null, null, 'Immobilier', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('503403743', null, null, null, 'Industrie', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('380105148', null, null, null, 'Immobilier', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('491359055', null, null, null, 'Immobilier', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('488439100', null, null, null, 'Immobilier', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('489615864', null, null, null, 'Immobilier', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('503032203', null, null, null, 'Immobilier', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('522352590', null, null, null, 'Immobilier', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('522352574', null, null, null, 'Immobilier', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('531507358', null, null, null, 'Immobilier', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('790596274', null, null, null, 'Immobilier', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('377770839', null, null, null, 'Automobile', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('107810202', null, null, null, null, null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('985152529', null, null, null, 'Industrie', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('503032245', null, null, null, 'Immobilier', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('331703702', null, null, null, 'Immobilier', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('453690935', null, null, null, 'Immobilier', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('491359147', null, null, null, 'Immobilier', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('803019223', null, null, null, 'Immobilier', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('797403094', null, null, null, 'Immobilier', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('342377629', null, null, null, 'Immobilier', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('387618721', null, null, null, 'Industrie', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('394667745', null, null, null, 'Alimentaire', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('823904008', null, null, null, 'Alimentaire', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('380348607', null, null, null, 'Automobile', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('880216908', null, null, null, 'Immobilier', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('993884493', null, null, null, 'Immobilier', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('985159268', null, null, null, 'Industrie', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('494546005', null, null, null, 'Automobile', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('494544430', null, null, null, 'Automobile', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('831070735', null, null, null, 'Automobile', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('488130212', null, null, null, 'Automobile', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('344000484', null, null, null, null, null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('444714745', null, null, null, 'Automobile', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('452402621', null, null, null, null, null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('799840954', null, null, null, 'Alimentaire', null, 'Cegid', '[{"type":"Stocks","name":"SAP"},{"type":"CRM","name":"Salesforce"},{"type":"Reporting et BI","name":"Power BI"}]'::jsonb, '[{"name":"Points de vente actifs","unit":"sites","value":23,"target":22},{"name":"Disponibilité produits","unit":"%","value":96,"target":97},{"name":"Pertes alimentaires","unit":"%","value":2.8,"target":2.5}]'::jsonb, 'pending', null, null),
  ('539677682', null, null, null, 'Alimentaire', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('502065568', null, null, null, 'Automobile', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('985144526', null, null, null, 'Industrie', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('530132158', null, null, null, 'Alimentaire', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('488053620', null, null, null, null, null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('500881388', null, null, null, 'Alimentaire', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('445081987', null, null, null, 'Alimentaire', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('539634402', null, null, null, 'Alimentaire', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('429210495', null, null, null, 'Alimentaire', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('494547425', null, null, null, 'Automobile', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('523746857', null, null, null, 'Alimentaire', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('329060495', null, null, null, 'Immobilier', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null),
  ('352881593', null, null, null, 'Alimentaire', null, null, '[]'::jsonb, '[]'::jsonb, 'not_configured', null, null)
on conflict (siren) do nothing;

commit;

-- ============================================================
-- 3. Vérifications
-- ============================================================

-- Doit retourner 82.
select count(*) as companies_count
from public.companies;

-- Doit retourner 82 au premier import.
select count(*) as demo_state_count
from public.company_demo_state;

-- Doit retourner 8 sociétés avec un logiciel d'exemple.
select count(*) as companies_with_demo_software
from public.company_demo_state
where accounting_software is not null;

-- Doit retourner 2 connexions simulées actives.
select count(*) as simulated_connected_count
from public.company_demo_state
where connection_status = 'connected';

-- Contrôle visuel des 8 sociétés enrichies.
select
  d.siren,
  c.nom_complet,
  d.categorie_groupe,
  d.accounting_software,
  d.other_software,
  d.kpis,
  d.connection_status,
  d.connection_synced_at
from public.company_demo_state d
join public.companies c using (siren)
where d.accounting_software is not null
order by c.nom_complet;
