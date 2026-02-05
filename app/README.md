# Nurturverse Flutter App

This folder contains the Flutter Android app prototype for Nurturverse.

## What’s Implemented
- Garden grid with plants and growth stages.
- Simulated BOINC minutes to advance plant growth.
- Harvesting plants to earn points.
- Basic state model to be wired to real BOINC runtime later.

## Run
1. Install Flutter.
2. From this folder:
   - `flutter pub get`
   - `flutter run`

## Notes
- BOINC integration is currently simulated with +5/+30 minute buttons.
- Replace tile visuals with the Full Garden Game sprites when assets are available.

## BOINC Bridge
The app expects native Android to implement:
- MethodChannel: `nurturverse/boinc` (`start`, `stop`, `isRunning`)
- EventChannel: `nurturverse/boinc_events` (emits completed minutes)
