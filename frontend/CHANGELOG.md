## 0.3.0 (2026-08-14)

### 🚀 Features

- expose competition roster authority contract ([#4](https://github.com/sneat-co/ext-sportius/pull/4))
- extend sport catalogue for Competios events ([5f68fb8](https://github.com/sneat-co/ext-sportius/commit/5f68fb8))

### ❤️ Thank You

- Alexander Trakhimenok @trakhimenok

## 0.1.1 (2026-08-06)

This was a version bump only, there were no code changes.

## 0.2.0 (2026-07-25)

### 🚀 Features

- define Sportius extension contract ([c1bbef8](https://github.com/sneat-co/ext-sportius/commit/c1bbef8))
- add stable sport catalogue ([92e1000](https://github.com/sneat-co/ext-sportius/commit/92e1000))
- complete participant and invitation contract ([caccc95](https://github.com/sneat-co/ext-sportius/commit/caccc95))
- expose reusable team guardians ([ac653b3](https://github.com/sneat-co/ext-sportius/commit/ac653b3))

### 🩹 Fixes

- make the contract template buildable, and publish it ([855cc44](https://github.com/sneat-co/ext-sportius/commit/855cc44))
- allow general coaching roles on profiles ([abff0be](https://github.com/sneat-co/ext-sportius/commit/abff0be))
- target invitations at stable contacts ([2151202](https://github.com/sneat-co/ext-sportius/commit/2151202))
- allow guardians as team participants ([dc60608](https://github.com/sneat-co/ext-sportius/commit/dc60608))
- require invitation claim proof ([148c2fe](https://github.com/sneat-co/ext-sportius/commit/148c2fe))
- keep invite proof out of projections ([4f57d25](https://github.com/sneat-co/ext-sportius/commit/4f57d25))
- protect invitation-based team joins ([51a9e33](https://github.com/sneat-co/ext-sportius/commit/51a9e33))
- preserve Sportius command and viewer context ([8938d25](https://github.com/sneat-co/ext-sportius/commit/8938d25))
- **release:** make nx release non-interactive, and seedable ([015723a](https://github.com/sneat-co/ext-sportius/commit/015723a))

### ❤️ Thank You

- Alexander Trakhimenok
- Claude Opus 4.8

# Changelog

## 0.1.0

- Define the first Sportius contract for personal sports profiles, teams,
  clubs, participants, guardians, invitations, and team-to-club linkage.
- Publish stable sport and role identifiers independently from display copy.
- Keep membership rules in the facade, expose guardians through player views,
  and support invitation preview/acceptance with stable errors.
