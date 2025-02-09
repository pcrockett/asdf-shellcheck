#!/usr/bin/env bash
set -Eeuo pipefail

step() {
	echo "--> ${*}"
}

main() {
	step "installing shellcheck plugin..."
	asdf plugin add shellcheck ./.git

	step "installing shellcheck latest..."
	asdf install shellcheck latest
	asdf local shellcheck latest

	step "testing shellcheck path..."
	shellcheck_path="$(asdf which shellcheck)"
	echo "${shellcheck_path}" \
		| grep --fixed-strings --color=always "asdf/installs/shellcheck"

	test_cmd=(
		"${shellcheck_path}"
		--version
	)
	step "running ${test_cmd[*]}..."
	"${test_cmd[@]}"
}

main
