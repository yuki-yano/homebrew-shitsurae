# homebrew-shitsurae

Custom Homebrew tap for [Shitsurae](https://github.com/yuki-yano/shitsurae).

## Install

```bash
brew tap yuki-yano/shitsurae
brew install --cask shitsurae
xattr -dr com.apple.quarantine /Applications/Shitsurae.app
open /Applications/Shitsurae.app
```

This installs:

- `Shitsurae.app` into `/Applications`
- `shitsurae` into Homebrew's `bin` directory, so the CLI is available from your shell `PATH`

> [!WARNING]
> Current Homebrew releases are not signed or notarized with an Apple Developer ID.
> Run `xattr -dr com.apple.quarantine /Applications/Shitsurae.app` before the first launch.
> This removes macOS Gatekeeper quarantine for the app bundle, so only do it if you trust `https://github.com/yuki-yano/shitsurae`.

## Upgrade and recovery

```bash
brew upgrade --cask shitsurae
brew reinstall --cask shitsurae
brew uninstall --cask shitsurae
brew zap shitsurae    # optional: also remove config and logs
```

## Maintainers

- Release asset source repo: `yuki-yano/shitsurae`
- Release tag format: `app-vX.Y.Z`
- Release asset name: `Shitsurae.app.tar.gz`
- Update workflow: `.github/workflows/update-cask.yml`
- Audit script: `./scripts/audit-cask.sh`
- Local audit tap name: `local/shitsurae-working`

This tap expects the release asset to already exist on GitHub Releases. Until `app-vX.Y.Z` is published from the main repo, `brew audit --online` and `brew install --cask shitsurae` will fail with a 404.

To update the cask manually, run the `update-cask` workflow with:

- `version`: app version without the `app-v` prefix
- `sha256`: SHA256 for `Shitsurae.app.tar.gz`
