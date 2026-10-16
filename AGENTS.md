# Video Workflow Kit

Windows workspace for editing existing video with video-use and publishing via Zernio REST API. Read `.agents/skills/video-workflow/SKILL.md` for end-to-end tasks. Read `START-HERE.md` for installation.

- Resolve all paths from this repository, never from the original author's machine. Keep media and outputs in `projects/<project>/`, credentials and publish checkpoints in ignored `local/`.
- Use `.venv/Scripts/python.exe` for video-use helpers through `setup/video-use.ps1`. Credentials are loaded in that child process from `local/secrets.env`; never create a secret inside the skill directory.
- Do not paste keys into prompts, command arguments, logs, documentation, screenshots or Git. Ask users to run `setup/configure.ps1` themselves for masked input.
- Skill installation copies are managed by `skills.lock.json`. No automatic upstream `git pull`. Read `docs/MAINTAINER.md` before upgrading or releasing.
- Keep the vendor skill and helpers together. Kit patches are recorded under `patches/`; the committed vendor snapshot already includes them.
- Publishing supports the requested subset of TikTok, YouTube, Facebook and LinkedIn. Account IDs come from the colleague's Zernio account. Never use someone else's keys, account selectors, branding or posting history.
- Preview the completed video and prepare the precise caption, target account IDs and visibility settings. Execute publishing when authorized by the user for that concrete plan; do not ask again if approval already covers it. CLI confirmation flags must reflect actual authorization.
- Resume existing publish runs. Never create another run to bypass an uncertain response or duplicate-content rejection. Review/reconcile ambiguous attempts before another external write.
- Do not transcribe or publish during setup. Local readiness checks do not prove that remote API permissions, billing or platform acceptance are valid.
