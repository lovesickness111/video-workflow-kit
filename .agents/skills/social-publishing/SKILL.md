---
name: social-publishing
description: Publish an existing reviewed MP4 to selected TikTok, YouTube, Facebook or LinkedIn accounts through Zernio REST API, with persistent status and recovery. Use for preparing, publishing and inspecting video posts from this kit.
---

# Publish an existing video

Work from kit root. Read `tools/publisher/README.md` for exact commands. Use `node tools/publisher/dist/cli.js`, built by `setup/setup.ps1`. No Studio backend or browser automation is needed.

1. Read `local/accounts.json`; run `accounts` to list connected IDs and `check` to validate selected accounts when setting up or recovering a connection. Do not guess destinations. One or multiple API keys are supported, with each selected platform owned by exactly one configured API profile.
2. Write metadata in the project directory using `config/publish.example.json`. Use the actual content: a human-recorded video edited by AI does not automatically require an AI-generated-media label. Ask/resolve YouTube kids audience, synthetic media, visibility, TikTok privacy and Facebook feed/reel type. Never impose personal branding or all four platforms.
3. Run `import --run <id> --video <mp4>` once to record the existing file, then `prepare --run <id> --metadata <json>`. Preparation uploads media to Zernio storage and validates payloads but creates no post. It produces `review.json` inside the ignored run folder; show the exact video, captions, destinations, visibility and immediate/scheduled mode to the user. Keep presigned/public media URLs private.
4. Run `publish --run <id> --confirm-publish` only when user authorization covers that reviewed plan. If inputs or plan change, prepare and review again. CLI flags are assertions of authorization, not substitutes for it.
5. Run `status --run <id>` for a local checkpoint or `inspect --run <id>` for fresh remote status. Report published/scheduled/partial/failed/publishing accurately. A successful profile must never be recreated to repair another profile.

For an uncertain response, inspect first. Do not start a new run or repeatedly retry creation. `retry --run <id> --confirm-publish` only retries recorded failed attempts with known post IDs using Zernio's retry endpoint; pending attempts known not to have been sent may resume. Uncertain attempts without an ID require manual reconciliation using `adopt --run <id> --profile <alias> --post-id <id>` after verifying the post in Zernio. This intentionally avoids relying on an assumed idempotency window.

TikTok direct posting may be unavailable due to account/platform limits. Report it; do not silently switch to Creator Inbox, change privacy, strip a platform or alter content to evade duplicate detection. This version does not automate an Inbox fallback. Stop and offer manual Zernio resolution.

Never print or commit keys. CLI reads only process environment or `local/secrets.env`; commands accept no key arguments. Do not copy the original author's credentials or account configuration.
