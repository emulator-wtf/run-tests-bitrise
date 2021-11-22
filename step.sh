#!/bin/bash
set -eu

curl -s -S https://maven.emulator.wtf/releases/ew-cli -o ./ew-cli  && chmod a+x ./ew-cli

ARGS="--token ${token} --app ${app} --test ${test} "
if [ ! -z ${num_shards} ]; then ARGS+="--num-shards ${num_shards} "; fi
if [ ! -z ${device} ]; then ARGS+="--device ${device} "; fi
if [ ${use_orchestrator} == "yes" ]; then ARGS+="--use-orchestrator "; fi
if [ ${clear_package_data} == "yes" ]; then ARGS+="--clear-package-data "; fi
if [ ${with_coverage} == "yes" ]; then ARGS+="--with-coverage "; fi
if [ ! -z ${outputs_dir} ]; then ARGS+="--outputs-dir ${outputs_dir} "; fi
if [ ! -z ${additional_apks} ]; then ARGS+="--additional-apks ${additional_apks} "; fi
if [ ! -z ${environment_variables} ]; then ARGS+="--environment-variables ${environment_variables} "; fi
if [ ! -z ${directories_to_pull} ]; then ARGS+="--directories-to-pull ${directories_to_pull} "; fi

sh ./ew-cli ${ARGS}
#
# --- Export Environment Variables for other Steps:
# You can export Environment Variables for other Steps with
#  envman, which is automatically installed by `bitrise setup`.
# A very simple example:
envman add --key EMULATORWTF_TEST_RESULT_DIR --value ${outputs_dir}
# Envman can handle piped inputs, which is useful if the text you want to
# share is complex and you don't want to deal with proper bash escaping:
#  cat file_with_complex_input | envman add --KEY EXAMPLE_STEP_OUTPUT
# You can find more usage examples on envman's GitHub page
#  at: https://github.com/bitrise-io/envman

#
# --- Exit codes:
# The exit code of your Step is very important. If you return
#  with a 0 exit code `bitrise` will register your Step as "successful".
# Any non zero exit code will be registered as "failed" by `bitrise`.
