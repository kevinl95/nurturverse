# Nurturverse Web

This folder contains the Firebase-backed web site and API for Nurturverse.

## Structure
- frontend/ — static landing page + leaderboard UI
- functions/ — Firebase Cloud Functions (score submission + leaderboard endpoints)
- firebase.json — hosting + functions config
- .firebaserc — default Firebase project name

## Firebase Project
Default project: **nurturverse**

## Local Development
1. Install Firebase CLI.
2. Initialize Firebase in this folder if you need to regenerate configs.
3. Use Firebase emulators to run hosting + functions locally.
## Deployment
GitHub Actions workflow: [nurturverse/.github/workflows/web-deploy.yml](nurturverse/.github/workflows/web-deploy.yml)

Required secrets:
- FIREBASE_SERVICE_ACCOUNT_NURTURVERSE — JSON service account key with Hosting + Functions deploy permissions

Deployment checklist:
1. Create Firebase project `nurturverse`.
2. Enable Firestore in production mode.
3. Enable required Google Cloud APIs:
	- Cloud Functions API (`cloudfunctions.googleapis.com`)
	- Cloud Build API (`cloudbuild.googleapis.com`)
	- Artifact Registry API (`artifactregistry.googleapis.com`)
	- Firestore API (`firestore.googleapis.com`)
	- Cloud Logging API (`logging.googleapis.com`)
3. Add `FIREBASE_SERVICE_ACCOUNT_NURTURVERSE` GitHub repo secret.
4. Push changes to `main` to trigger deployment.

## Common Deploy Error: Service Account Permissions
Deploying identity must have both roles:
- **Service Account User** (`roles/iam.serviceAccountUser`) on `nurturverse@appspot.gserviceaccount.com`
- **Service Usage Consumer** (`roles/serviceusage.serviceUsageConsumer`)

If you see:
"Error: Missing permissions required for functions deploy. You must have permission iam.serviceAccounts.ActAs on service account nurturverse@appspot.gserviceaccount.com."

Ask a project Owner to grant the roles above.

## Leaderboard Identity
Anonymous handles only (no login). Users can choose an optional display name.

## Auth Model (Anonymous)
- No third-party auth or tokens.
- Client submits a locally generated anonymous handle with a display name.
- Backend accepts submissions as-is and sums points per handle.

## Handle Generation (Client)
Suggested format: `adjective-noun-####` (example: `solar-sprout-4821`).
Store it locally on first launch and reuse it for all submissions.

## Profanity Filter
The backend uses the `bad-words` library to screen `handle` and `displayName`.
If a name is blocked, the API returns a 400 error.

## API
Base URL: Firebase Hosting origin

### Submit Score
`POST /submitScore`

Payload:
- `handle` (string)
- `displayName` (string, optional)
- `points` (number, positive)

Response:
`{ "ok": true, "handle": "..." }`

### Leaderboard
`GET /leaderboard`

Response:
`{ "leaders": [{ "rank": 1, "handle": "...", "displayName": "...", "points": 123 }] }`
