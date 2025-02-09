#!/usr/bin/env bash
set -Eeuo pipefail

SHELLCHECK_VERSION="0.9.0" # temp workaround for macOS. TODO: change to latest

step() {
	echo "--> ${*}"
}

main() {
	step "installing shellcheck plugin..."
	asdf plugin add shellcheck ./.git

	step "installing shellcheck ${SHELLCHECK_VERSION}..."
	asdf install shellcheck "${SHELLCHECK_VERSION}"
	asdf local shellcheck "${SHELLCHECK_VERSION}"

	step "testing shellcheck path..."
	shellcheck_path="$(asdf which shellcheck)"
	echo "${shellcheck_path}" |
		grep --fixed-strings --color=always "asdf/installs/shellcheck"

	test_cmd=(
		"${shellcheck_path}"
		--version
	)
	step "running ${test_cmd[*]}..."
	"${test_cmd[@]}"
}

main
