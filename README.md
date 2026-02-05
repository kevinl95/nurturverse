# Nurturverse

Nurturverse is an Android idle garden game that rewards users for contributing compute cycles to World Community Grid through an embedded BOINC client. The longer BOINC runs, the more plants grow and the more points players can earn toward a leaderboard.

## Assets (Required)
The Full Garden Game Pack is **not** included in this repository due to copyright. Purchase it here:
https://penzilla.itch.io/garden-game-pack

After purchase, extract the pack to:
- [nurturverse/assets/Full_Garden_Game](nurturverse/assets/Full_Garden_Game)

See [nurturverse/assets/README.md](nurturverse/assets/README.md) for expected subfolders.

## BOINC Integration
See [nurturverse/docs/boinc.md](nurturverse/docs/boinc.md) for the in-process BOINC client plan and background notification requirements.

## Leaderboard & Identity
- Firebase project name: **nurturverse**
- Leaderboard identity: anonymous handles with optional display names

## Web + Backend
A Firebase-backed web site and API are scaffolded in [nurturverse/web](nurturverse/web). The site provides a basic landing page, leaderboard display, and a placeholder Play Store link.

## License
See [nurturverse/LICENSE](nurturverse/LICENSE).