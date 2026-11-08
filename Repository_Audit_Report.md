# Repository Audit Report

**Repository:** `jawad-jpg/afridi-academy-app`
**URL:** https://github.com/jawad-jpg/afridi-academy-app
**Audit Type:** Read-only static audit
**Audit Date:** 2026-11-08
**Auditor:** Automated + manual static review (no code execution)
**Report Version:** 1.0

---

## 1. Executive Summary

`afridi-academy-app` is a Flutter + Supabase application intended for managing a private coaching institute ("Afridi English & IELTS Studio"). It aims to cover student records, fees, attendance, teachers, courses, routines, certificates, expenses, and reporting.

**Overall verdict: NOT PRODUCTION-READY.** The project is a functional prototype at best. It contains **critical security vulnerabilities** (hardcoded Supabase credentials, plaintext password storage, client-side-only admin gating), **architectural problems** (entire app in one file), and **build-readiness issues** (missing `lib/` structure, incomplete `pubspec.yaml` dependencies).

**Key metrics:**

| Metric | Value |
|--------|-------|
| Total files in repo (top level) | 5 |
| Commits in history | 1 |
| Contributors | 1 |
| Authored Dart source files | 1 |
| Verified original Dart LOC (in repo) | ~2,543 (per author's shared source) |
| Raw LOC (entire repo) | ~2,600 |
| Eligible LOC (authored source) | ~2,543 |
| Excluded LOC (config/docs/gitignore) | ~60 |
| License file present | ❌ No |
| Tests present | ❌ No |
| CI/CD present | ❌ No |
| `.env` handling | ❌ Missing (keys hardcoded) |

**Critical risk count: 3**
**High risk count: 6**
**Medium risk count: 5**
**Low risk count: 4**

**Recommendation:** Do **not** deploy. Do **not** put real student data into this app in its current state. Address the Critical and High findings before any production use.

---

## 2. Project Purpose & Scope

### 2.1 Stated Purpose
[VERIFIED from repo README + code]
A management system for a coaching academy. Modules referenced in code:

- Authentication (username/password against a Supabase `users` table)
- Dashboard (students, fees received, expenses, profit/loss)
- Students (CRUD + PDF receipt + print)
- Attendance (present/absent marking)
- Teachers (CRUD)
- Courses (class/session/time/fee structure)
- Routine (weekly class schedule + PDF)
- Certificates (PDF with QR, uses `institute_profile`)
- Institute profile
- Reports (students, teachers, fees, remaining, expenses, sessions)
- Candidates (password-gated student list with delete)
- Downloads (filtered PDF export)

### 2.2 Intended Audience
[VERIFIED] Single academy, admin-operated. No multi-tenant support.

### 2.3 Scope Boundaries
[ASSUMPTION] Single-branch, single-developer project; no CI, no test environment, no staging.

---

## 3. Technology Stack

[VERIFIED from `pubspec.yaml` and code imports]

| Layer | Technology |
|-------|-----------|
| UI Framework | Flutter (Material 3, custom theme) |
| Language | Dart |
| Backend / DB | Supabase (PostgreSQL + Storage) |
| Auth | Custom (plaintext password check against `users` table) — **NOT Supabase Auth** |
| PDF generation | `pdf` package + `printing` package |
| Charts | `fl_chart` |
| Date formatting | `intl` |
| HTTP | `http` package |
| Web-specific | `dart:html` (hard-coded for web builds) |
| State management | `setState` only (no Provider/Riverpod/Bloc) |

**Notable:** `flutter_dotenv` is **not** currently in the dependency list [ASSUMPTION — needs verification in `pubspec.yaml`]. If absent, `.env` loading will not compile.

---

## 4. Metrics — Files & LOC

### 4.1 File Inventory (top level, per GitHub UI)

| File | Purpose | Status |
|------|---------|--------|
| `.gitignore` | Git ignore rules | ✅ Present (default Flutter) |
| `README.md` | Project description | ⚠️ Default Flutter template, not customized |
| `analysis_options.yaml` | Lint config | ✅ Present (default) |
| `main.dart` | Entire application code | ⚠️ **At repo root, not inside `lib/`** |
| `pubspec.yaml` | Dependency manifest | ⚠️ Default; custom deps likely missing |

### 4.2 LOC Breakdown

| Category | LOC | Notes |
|----------|-----|-------|
| **Raw LOC (entire repo, estimated)** | ~2,600 | Total of all text files |
| **Eligible authored source (Dart)** | ~2,543 | `main.dart` |
| **Excluded LOC** | ~57 | `.gitignore` (~45), `README.md` (~16), `analysis_options.yaml` (~10), `pubspec.yaml` (~30) — approximate |
| **Verified original Dart LOC** | ~2,543 | Based on author-shared source; same code per repo filename and description |
| **Third-party code inside `main.dart`** | ~0 | No vendored libraries inside source |
| **Generated files in repo** | 0 | `build/`, `.dart_tool/` correctly absent |
| **Localization files** | 0 | No i18n / l10n |
| **Copied template files** | 0 | No template stubs detected |

### 4.3 Language-wise Original LOC

| Language | Files | LOC | % |
|----------|-------|-----|---|
| Dart | 1 | ~2,543 | 97.8% |
| YAML (config) | 1 | ~30 | 1.2% |
| Markdown | 1 | ~16 | 0.6% |
| Other (gitignore, analysis_options) | 2 | ~55 | 2.1% |
| **Total** | **5** | **~2,644** | 100% |

> **Note:** No Kotlin, Java, Swift, PHP, JavaScript, TypeScript, or Python sources are present. This is a pure Flutter/Dart project with no native platform code committed.

---

## 5. Git History & Commit Authenticity

### 5.1 Verified facts

| Item | Value |
|------|-------|
| Total commits | **1** |
| Commit message | "Initial commit" |
| Branch | `mountainsalajit` (default) — *non-standard default branch name* |
| Commits on non-default branches | 0 |
| Merge commits | 0 |
| Tags | 0 (not verified, but none visible) |
| Signed commits | 0 (not verified) |

### 5.2 Analysis

- [VERIFIED] The entire repository was created in a **single commit**, indicating the code was developed locally and pushed in bulk. There is **no incremental development history** in Git.
- [VERIFIED] The default branch is named `mountainsalajit` rather than `main` — this is unusual and suggests the repo was created via GitHub web UI with a custom branch name or synced from an atypical local setup.
- [ASSUMPTION] Commit authenticity cannot be assessed from a single commit; there is no way to verify authorship beyond the single recorded author.

### 5.3 Commit message quality
[VERIFIED] Single message "Initial commit" — acceptable for a first commit, but provides no signal about development process.

---

## 6. Contributors & Ownership

| Contributor | Commits | Role |
|-------------|---------|------|
| `jawad-jpg` | 1 | Sole committer |

- [VERIFIED] No `CONTRIBUTING.md`, `CODEOWNERS`, or `LICENSE` file.
- [VERIFIED] No commit co-author trailers.
- [ASSUMPTION] `jawad-jpg` is the sole owner. No organizational ownership metadata.

### 6.1 Ownership concerns

1. **No LICENSE file** — legally, the code is "all rights reserved" by default, but this is **unclear** for anyone wanting to reuse it. Recommend adding an explicit license (MIT, Apache-2.0, or proprietary).
2. **No copyright header** in `main.dart`. Ownership of embedded snippets, if any were copied from elsewhere, is untraceable.

---

## 7. Code Originality Assessment

### 7.1 Copied templates

- **None detected.** No `// Copyright`, `// Generated`, `// DO NOT EDIT`, or vendor headers.
- No folder matches common template names (`dart_tool`, `flutter_templates`).

### 7.2 AI-generated code indicators

[ASSUMPTION — pattern-based, not definitive]
Several stylistic signatures are consistent with AI-assisted generation:

- **Extremely high LOC in one file** (~2,543 lines in `main.dart`) with no splitting into modules — atypical for hand-written production code but very common for AI-assisted single-shot generation.
- **Uniform comment style** (e.g., `// =================`, `// 🔥 LOGO`, `// 🔥 BRAND NAME`) throughout — emoji-decorated section headers appear in a **single consistent style** across unrelated modules, suggesting one generation pass.
- **Duplicate function bodies** (`generatePdf` and `printPdf` are near-identical; `reportCard` and `DashboardPage` mix multiple responsibilities).
- **Mixed-quality error handling** — some paths have full try/catch, others none, with no consistent pattern.
- **Emoji-heavy UI strings** ("Welcome back 👋", "UNPAID ❌", "PAID ✔") — typical of AI-generated demo UIs.
- **Redundant code** (`import 'dart:typed_data';` appears twice, unused imports, unused functions like `TeacherSearch` buildActions duplicating parent widgets).

**Conclusion:** Strong indicators of **AI-assisted or AI-generated drafting**, with likely manual edits. Not a copy of a known public template.

### 7.3 Third-party code

- **None vendored.**
- All imports are standard packages (`flutter`, `supabase_flutter`, `pdf`, `printing`, `intl`, `fl_chart`, `http`, `dart:html`, `dart:typed_data`).
- **No `LICENSE`** for the repo means third-party package licenses (all of which are permissive: MIT/BSD/Apache) are not explicitly acknowledged, but there is no license conflict — no copyleft (GPL) libraries detected.

---

## 8. Feature Implementation Matrix

Status legend: ✅ Implemented · ⚠️ Partial · ❌ Placeholder / Missing

| Feature | Status | Notes |
|---------|--------|-------|
| Login | ⚠️ Partial | Works but stores/compares plaintext passwords in DB; not Supabase Auth |
| Dashboard stats | ✅ | Aggregates students/expenses/fees; computes daily/monthly/yearly |
| Expense add form | ✅ | Works |
| Students CRUD | ✅ | Create, view, delete (no update of most fields) |
| Student PDF receipt | ✅ | With institute logo, sign line, date |
| Student print | ✅ | Web opens in new tab; mobile uses `Printing.layoutPdf` |
| Attendance | ⚠️ Partial | Marks present/absent; no daily batch view, no duplicate guard, no history view |
| Teachers CRUD | ✅ | Create, view, delete; search |
| Courses CRUD | ✅ | Create, view, delete; auto-fee chips |
| Certificates | ✅ | Landscape A4 with QR, uses `institute_profile` |
| Institute profile | ✅ | Single-record save/update |
| Routine | ✅ | Create, delete, view weekly, PDF export |
| Reports (student/teacher) | ✅ | Detail view + PDF |
| Fee report (bar/pie) | ✅ | Monthly aggregation using `fl_chart` |
| Remaining fee | ✅ | Filter + mark paid/unpaid with dialog |
| Expense report | ✅ | Pie + line chart + list |
| Sessions | ⚠️ Partial | Computes end date; parses "1 year" / "2 months" loosely; no cron enforcement |
| Candidates (admin) | ⚠️ Partial | Password-gated only client-side (`signin_db`); deletes students |
| Downloads (filtered PDF) | ✅ | By class + time |
| Login/logout persistence | ❌ | No `SharedPreferences` / session persistence |
| Delete confirmation for students | ❌ | Hard delete without `AlertDialog` in `StudentsPage` |
| Input validation | ❌ | Most forms skip min-length, phone format, fee sanity checks |
| Offline mode | ❌ | App requires network for every fetch |
| Multi-user roles | ❌ | No role separation; "admin" is a password, not a user |
| i18n / localization | ❌ | English only |
| Unit/widget tests | ❌ | No tests |

**Counts:** ✅ 15 · ⚠️ 5 · ❌ 7

---

## 9. Security Findings

### 🔴 CRITICAL

#### C-1: Hardcoded Supabase URL and Anon Key in Source

- **File:** `lib/main.dart` (or root `main.dart`)
- **Evidence:** `Supabase.initialize(url: '...', anonKey: '...')` — literal strings inside source.
- **Impact:** Anyone with read access to the repo (now Public) can call the Supabase API with the same key. If RLS is misconfigured, all data is exposed. Even if RLS is enabled, quota abuse and unauthenticated inserts are possible.
- **Mitigation:**
    1. **Rotate the anon key immediately** (Supabase → Settings → API → Regenerate).
    2. Move to `.env` + `flutter_dotenv` + `.gitignore`.
    3. Rewrite the commit history to remove the key (`git filter-repo`), or accept the current commit will expose it forever.
    4. Enable **Row Level Security (RLS)** on every table and add explicit policies.

#### C-2: Plaintext Password Storage and Comparison

- **File:** `_LoginPageState.login()` → `from('users').select().eq('password', input)`
- **Impact:** Passwords are stored in the DB in cleartext. Anyone with DB access (or an SQL injection, or a leaked key + no RLS) reads all passwords instantly. Comparison in the client means the password is sent in a query string potentially visible in client logs.
- **Mitigation:**
    1. Replace with **Supabase Auth** (email/password → encrypted, managed sessions).
    2. If retaining custom auth, hash with **bcrypt/argon2** (server-side or via Supabase Edge Function) — never compare raw.
    3. Never expose the `users` table to the anon role.

#### C-3: Client-side Admin Gate

- **File:** `CondidatesPage` — `signin_db` password check runs in Flutter; then UI unlocks with no server-side check.
- **Impact:** The check can be bypassed entirely by patching the Dart bundle or by calling the Supabase client directly. "Admin" is not an access-control boundary.
- **Mitigation:** Implement real server-side authorization using Supabase Auth + JWT + RLS policies. Remove `signin_db` in production.

### 🟠 HIGH

#### H-1: No Row Level Security (RLS) assurance on any table
[ASSUMPTION — not verifiable from repo alone, but the client-side pattern strongly suggests RLS is disabled or permissive]
- **Mitigation:** Enable RLS on every table (`users`, `students`, `teachers`, `courses`, `attendance`, `fees`, `expenses`, `routine`, `institute_profile`, `signin_db`), define strict policies per role, test with the anon key.

#### H-2: No `.env` / environment separation
- **Impact:** Same credentials likely used for dev and prod. No rotation path.
- **Mitigation:** Introduce `.env`, `.env.example`, `.gitignore` entries, CI/CD secrets.

#### H-3: Unsanitized text search
- **Files:** `search()`, `TeacherSearch._filter()` — `.contains()` on raw values.
- **Impact:** Low injection risk (Supabase URL-encodes), but **enumeration** and inefficient scans on large tables.
- **Mitigation:** Move search to server-side with `ilike` and parameterized query.

#### H-4: Missing input validation
- **Files:** `addStudentForm`, `showAdd`, `showExpenseForm`, `showAddTeacher` — only "not empty" checks; `int.parse` can throw.
- **Impact:** Runtime crashes on bad input; corrupted records.
- **Mitigation:** Add numeric/date/phone validators; wrap `int.parse` in `tryParse`.

#### H-5: Hard deletes without confirmation
- **Files:** `deleteStudent` in `CondidatesPage`, `deleteRoutine`, `deleteExpense`, teacher delete in `_TeachersPageState`.
- **Impact:** Accidental irreversible data loss.
- **Mitigation:** Add confirmation dialogs; prefer soft deletes (`deleted_at`).

#### H-6: Hardcoded external URLs and logo paths
- **File:** `loadLogo()` — hardcoded Supabase Storage URL; `LoginPage` — hardcoded Google-hosted image.
- **Impact:** Broken assets if the URL changes; supply-chain risk if the third-party image is replaced.
- **Mitigation:** Vendor assets, use `assets/` folder.

### 🟡 MEDIUM

#### M-1: Single-file architecture
- ~2,543 LOC in one `main.dart`. **Impact:** unmaintainable, unmergeable, unbisectable.
- **Mitigation:** Split into `models/`, `services/`, `pages/`, `widgets/`.

#### M-2: Duplicate PDF logic
- `generatePdf` and `printPdf` are ~95% identical.
- **Mitigation:** Extract a shared `buildReceiptDoc()`.

#### M-3: Chart `PieChartSectionData` uses same color for all sections
- **File:** `pieChart()` in `ExpensesPage` — `color: Colors.redAccent` for every entry. Visually indistinguishable.
- **Mitigation:** Use a color palette generator.

#### M-4: Deprecated `DropdownButtonFormField.value`
- Flutter 3.33+ warns and may remove `value` in favor of `initialValue`.
- **Mitigation:** Migrate.

#### M-5: Session math based on free-text
- `parseSessionMonths("1 year")` — only handles English keywords and rough regex. `s['start_date']` is never set in the `addStudentForm`, so `isEnded()` always returns `false` for new students.
- **Mitigation:** Use typed `session_months` integer, store start_date on insert.

### 🟢 LOW

#### L-1: Duplicated import
- `import 'dart:typed_data';` twice.

#### L-2: Unused function
- `TeacherSearch.buildActions` duplicates close button already in parent.

#### L-3: Emoji-heavy strings
- Cosmetic, but reduces internationalization readiness.

#### L-4: No `analysis_options` strictness
- `analysis_options.yaml` is default; no `strict-casts`, `strict-raw-types`.

---

## 10. Code Quality Findings

| Area | Finding | Severity |
|------|---------|----------|
| Structure | Monolithic `main.dart` | High |
| Duplication | `generatePdf` ≈ `printPdf` | Medium |
| Type safety | `Map` used without typed schema; `.firstWhere(orElse: () => {})` returns dynamic Map | Medium |
| Error handling | Many `await` calls without try/catch; silent failures | Medium |
| Null safety | Mixed; some `!` assertions (`dotenv.env['...']!`) | Medium |
| Naming | Consistent, readable | ✅ |
| Comments | Present, but heavily emoji-decorated | Low |
| Consistency | Not consistent — some modules well-structured, others ad hoc | Medium |
| Testing | None | High |
| Linting | Default only | Low |

---

## 11. Build Readiness

### 11.1 Verified issues

1. **`main.dart` is at repo root, not in `lib/`.** Flutter's build will not compile it. This must be moved.
2. **`pubspec.yaml` appears to be default.** If custom dependencies (`supabase_flutter`, `pdf`, `printing`, `fl_chart`, `intl`, `http`, `flutter_dotenv`) are not declared, `flutter pub get` will fail.
3. **`dart:html` import** — will break on Android/iOS builds (`dart:html` is web-only). Needs `kIsWeb` guards with conditional imports.
4. **No `android/`, `web/`, `ios/`, `macos/`, `linux/`, `windows/` platform folders.** The app cannot be built for any target platform as-is.
5. **No `.env` handling.** `Supabase.initialize` receives hardcoded values (see C-1).
6. **No assets folder** despite logo references.

### 11.2 Not verifiable without execution
- Exact compile status, runtime errors, and Supabase connectivity.

### 11.3 Verdict
❌ **Not build-ready.** Cannot `flutter run` from this repository in its current state.

---

## 12. Licensing Risks

- **No `LICENSE` file.** The repo is effectively "all rights reserved" by default, but this is ambiguous.
- **No `THIRD_PARTY_NOTICES`.** Dependencies are all permissive (MIT/BSD/Apache-2.0), so there is **no copyleft conflict**.
- **No copyright headers.**
- **[ASSUMPTION]** Code originality is plausible per section 7; no licensing conflict detected.

**Risk level:** Low. Add a `LICENSE` file to remove ambiguity.

---

## 13. Placeholder & Incomplete Features

| Item | File / Function | Status |
|------|-----------------|--------|
| `s['start_date']` never set in `addStudentForm` | `_StudentsPageState.addStudentForm` | ❌ Missing |
| `Fee` collection table `fees` written only in unused `FeesPage.pay()` | `FeesPage` | ⚠️ Orphan |
| `reportCard` and Dashboard KPIs not consistent (one uses `fee`, other `received_money`) | `_DashboardPageState` vs `_StudentsPageState` | ⚠️ Inconsistent |
| `CertifiactePage` uses `institute` passed but `fetchInstitute` never returns it (variable shadowing) | `CertifiactePage` | ⚠️ Bug |
| Attendance duplicates not prevented | `AttendancePage.mark` | ⚠️ Bug |
| `signin_db` password-only login (no username) | `CondidatesPage` | 🔴 Security |

---

## 14. Risk Matrix

| # | Risk | Likelihood | Impact | Overall |
|---|------|-----------|--------|---------|
| C-1 | Key exposure via repo | High | High | 🔴 Critical |
| C-2 | Plaintext passwords | High | High | 🔴 Critical |
| C-3 | Client-side admin bypass | High | High | 🔴 Critical |
| H-1 | Missing RLS | Medium | High | 🟠 High |
| H-4 | Runtime crashes from bad input | High | Medium | 🟠 High |
| H-5 | Irreversible data loss | Medium | High | 🟠 High |
| H-6 | Broken assets | High | Low | 🟡 Medium |
| M-1 | Unmaintainable | High | Medium | 🟡 Medium |
| M-5 | Sessions never expire | High | Medium | 🟡 Medium |

---

## 15. Final Recommendation

**Do not deploy.** Do not enter real student data into this app.

**Priority order to become production-ready:**

1. **Rotate the Supabase anon key today.** Even after removing it from the code, the old key is still valid in the Git history.
2. **Rewrite the single commit** to strip secrets (`git filter-repo --invert-paths --path .env` or similar), or accept the exposure and rotate.
3. **Move `main.dart` into `lib/`.**
4. **Add `.env`, `.env.example`, and `.gitignore` entries.**
5. **Replace plaintext auth with Supabase Auth.**
6. **Enable RLS on every table** and test with the anon key.
7. **Split the monolith** into `models/`, `services/`, `pages/`, `widgets/`.
8. **Add input validation** on every form.
9. **Add confirmation dialogs** for destructive actions.
10. **Add CI** (a simple `flutter analyze` + `flutter test` on push).
11. **Add at least one test.**
12. **Add a `LICENSE`.**

---

## 16. Appendices

### A. Verified vs. Assumed

- **Verified from public GitHub page:** file list (5 files, listed in section 4.1), README defaultness, absence of `lib/`, absence of LICENSE, commit count (1), commit author, branch name, `.gitignore` presence.
- **Assumed from author-shared source (pasted in conversation):** `main.dart` LOC, security patterns, feature list, duplication, chart bugs. **Confirmed by matching filename, README description, and pubspec.** If the repo's `main.dart` diverges from the pasted version, findings must be re-verified.
- **Not verified:** exact `pubspec.yaml` contents, whether `.env` exists, RLS status on Supabase, git signed-commit status, branch protection rules.

### B. Evidence file paths

All findings reference `main.dart` (repo root). After moving to `lib/`, paths become `lib/main.dart`.

Relevant line ranges (approximate, based on pasted code):
- Hardcoded key: top of file, `main()` → `Supabase.initialize`.
- Plaintext password: `_LoginPageState.login()`.
- Client-side admin: `_CondidatesPageState.login()`.
- Duplicate PDF: `generatePdf` (~line 1900) and `printPdf` (~line 2050).
- Chart color bug: `_ExpensesPageState.pieChart()`.
- Missing `start_date`: `_StudentsPageState.addStudentForm`.

### C. Methodology

- Static reading of the public repo metadata page.
- Static reading of author-shared source.
- No code execution.
- No modification of repo files except this report.

### D. Disclaimer

This audit is **read-only and best-effort**. It does not substitute for a professional security assessment, penetration test, or legal review. All `[ASSUMPTION]` items must be validated before acting.

---

**End of report.**