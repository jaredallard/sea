# pre-process the array.
for file in ${!FILES[@]}; do
  FILEPATH="${EXTRACT_PATH}/${file}"

  echo ${FILES[$file]} > "${FILEPATH}.b64"

  # Process the files.
  base64 -d "${FILEPATH}.b64" > "${FILEPATH}.gz"
  gunzip "${FILEPATH}.gz"

  chmod +x ${FILEPATH} # todo keep permissions
done

pushd "${EXTRACT_PATH}" > /dev/null
if [[ ${SHELL_SCRIPT} == true ]]; then
  /usr/bin/env bash ${SHELL_SCRIPT_NAME}
elif [[ ${EXECUTE} ]]; then
  /usr/bin/env bash -c "${EXECUTE_CMD}"
fi

popd > /dev/null

if [[ ${DELETE} == true ]]; then
  if [[ ${EXTRACT_PATH} == "/" ]]; then
    exit 1
  fi
  rm -r ${EXTRACT_PATH}
fi
