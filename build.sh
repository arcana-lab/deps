#!/usr/bin/env bash


ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/"


pushd $ROOT


LLVM_VERSION=9.0.1
LLVM_DIR=${ROOT}/llvm/${LLVM_VERSION}

if [ ! -f "${LLVM_DIR}/enable" ]; then
	mkdir -p llvm
	pushd llvm

		git clone https://github.com/scampanoni/LLVM_installer.git ${LLVM_VERSION}
		pushd ${LLVM_VERSION}
			# Build
			make
		popd

	popd
fi



source ${ROOT}/enable

NOELLE_VERSION=9.7.0

# Compile noelle if we need to
if [ ! -f ${ROOT}/noelle/enable ]; then
	pushd ${ROOT}/
		# Download the noelle release
		wget -O noelle.zip https://github.com/arcana-lab/noelle/archive/refs/tags/v${NOELLE_VERSION}.zip

		unzip noelle.zip
		mv "noelle-${NOELLE_VERSION}" noelle

		pushd noelle
			# noelle depends on executing in a git repo,
			# and we downloaded it from a release zip file.
			git init

			make

		popd
	popd
fi
