# Android BOINC Bridge (Flutter)

These files provide the native Android side of the BOINC bridge used by Flutter.

## Channels
- MethodChannel: `nurturverse/boinc`
  - `start`, `stop`, `isRunning`
- EventChannel: `nurturverse/boinc_events`
  - Emits completed BOINC minutes

## Notes
- `BoincForegroundService` keeps BOINC running in the background.
- `BoincRuntime` is a placeholder; replace the timer with real BOINC runtime data.
- Ensure the Flutter Android module includes these files (package: `com.nurturverse.app`).
