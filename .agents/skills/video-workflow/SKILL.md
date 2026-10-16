---
name: video-workflow
description: Set up this Windows video kit, edit existing footage with video-use and publish reviewed outputs through Zernio. Use for the complete edit-to-publish workflow and local setup or recovery.
---

# Video workflow

Locate the kit root by `skills.lock.json` and `START-HERE.md`, then read its `AGENTS.md`. Use the user's language; guide nontechnical users with one concrete next step when human action is needed.

## Setup

Run `setup/setup.ps1` from the kit root. It installs missing Windows prerequisites via winget when available, creates an isolated Python environment, and builds the standalone publisher. Use `setup/doctor.ps1` to report local readiness. Do not transcribe a sample or publish during setup. Ask the user to enter secrets themselves using `setup/configure.ps1` in an interactive terminal; do not request pasted keys in chat. Login/consent on ElevenLabs, Zernio or social platforms belongs to the user.

## Edit

Create `projects/<project>/input/` and keep edit outputs under that project. Read the complete adjacent `../video-use/SKILL.md` and its relevant helpers. Kit integration: invoke helpers using `setup/video-use.ps1 <helper.py> <arguments>` so the isolated Python runtime and `local/secrets.env` apply. Do not follow upstream global install or `.env` instructions; the kit has already supplied the skill and helpers. Keep skill files unchanged during editing.

Inspect footage, reuse transcripts, agree an edit strategy and obtain authorization before rendering. Explain that ElevenLabs receives extracted audio and consumes STT quota. Source speech and a cached word-level transcript can be reused without another transcription. If the user requests music, use music they provide or establish its license, offer previews when taste matters, duck under speech and retain license notes. Do not claim to have listened when only metrics were checked.

Show the output using an absolute path to the MP4. Record edit decisions in the project's `edit/project.md`.

## Publish

Read `../social-publishing/SKILL.md`. Use the existing MP4; Studio generation is not part of this kit. Select only requested platforms and verify the colleague's account IDs. Prepare the concrete plan and obtain publishing authorization unless already given for that exact plan. Retain run IDs and report each platform's actual status and permalink when supplied. Scheduled is not published. If interrupted, inspect and resume the recorded run.

## Update

Read `docs/MAINTAINER.md` at kit root for maintenance. For colleagues, use `setup/update.ps1` with an approved kit release tag or extracted release folder. Never update vendor directly from upstream main in daily use. Preserve local credentials, projects and publish history.
