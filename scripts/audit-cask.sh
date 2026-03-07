#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CASK_NAME="${CASK_NAME:-shitsurae}"
CASK_PATH="${REPO_ROOT}/Casks/${CASK_NAME}.rb"
AUDIT_TAP_NAME="${AUDIT_TAP_NAME:-local/shitsurae-working}"
BREW_REPOSITORY="$(brew --repository)"
TAP_OWNER="${AUDIT_TAP_NAME%%/*}"
TAP_REPO="${AUDIT_TAP_NAME##*/}"
TAP_PATH="${BREW_REPOSITORY}/Library/Taps/${TAP_OWNER}/homebrew-${TAP_REPO}"

brew style "${CASK_PATH}"

if ! git -C "${REPO_ROOT}" rev-parse --verify HEAD >/dev/null 2>&1; then
  echo "skip brew audit: no commits in repository yet"
  exit 0
fi

created_tap=0
if [[ ! -e "${TAP_PATH}" ]]; then
  mkdir -p "$(dirname "${TAP_PATH}")"
  ln -s "${REPO_ROOT}" "${TAP_PATH}"
  created_tap=1
fi

cleanup() {
  if [[ "${created_tap}" -eq 1 ]]; then
    brew untap "${AUDIT_TAP_NAME}" >/dev/null 2>&1 || true
  fi
}
trap cleanup EXIT

brew audit --cask --strict --online --no-signing "${AUDIT_TAP_NAME}/${CASK_NAME}"
