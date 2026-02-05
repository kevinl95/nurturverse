# BOINC Integration Notes

Nurturverse embeds the BOINC Android client **in-process** and allows it to run while the app is in the background.

## Background Execution
- BOINC runs in the app process.
- When BOINC is running, show a persistent notification:
  - **"Nurturverse is running scientific jobs in the background"**
- Provide a clear in-app toggle to stop BOINC.
- If BOINC is stopped, users do not receive compute credit or game rewards.

## Account Model
- BOINC should run under a global **"Nurturverse"** account so users do not need to sign up separately.

## Notes
- Background execution on Android should use a foreground service to comply with platform requirements.
- Ensure battery usage disclosure and user consent prior to enabling background compute.
- See the local BOINC clone (not committed) for build scripts and Android client sources.

## Flutter Platform Channels
The Flutter app expects these channels:
- MethodChannel: `nurturverse/boinc`
  - `start` → `bool`
  - `stop` → `bool`
  - `isRunning` → `bool`
- EventChannel: `nurturverse/boinc_events`
  - emits integer minutes of completed BOINC runtime

Native Android should forward BOINC runtime updates to the EventChannel and keep
the foreground service alive while running.
