#!/bin/bash

set -e
images=()
repobase="${REPOBASE:-ghcr.io/nethserver}"

reponame="promtail"
container=$(buildah from scratch)

buildah add "${container}" imageroot /imageroot
buildah add "${container}" ui /ui
buildah config --entrypoint=/ "${container}"
buildah config --label="org.nethserver.rootfull=1" \
    --label="org.nethserver.flags=core_module no_data_backup" \
	--label="org.nethserver.images=docker.io/grafana/promtail:2.8.2" \
	"${container}"
buildah commit "${container}" "${repobase}/${reponame}"
images+=("${repobase}/${reponame}")

#
#
#

if [[ -n "${CI}" ]]; then
    # Set output value for Github Actions
    printf "::set-output name=images::%s\n" "${images[*]}"
else
    printf "Publish the images with:\n\n"
    for image in "${images[@]}"; do printf "  buildah push %s docker://%s:latest\n" "${image}" "${image}" ; done
    printf "\n"
fi
