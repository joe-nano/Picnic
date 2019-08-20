#!/bin/bash
set -e

# OS X has shasum, but no sha1sum.
if [[ "$TRAVIS_OS_NAME" == "osx" ]]
then
  function sha1sum
  {
    shasum "$@"
  }
fi

directory=build-$(echo "$@" "$CMAKE_TOOLCHAIN" "$CMAKE_GENERATOR" | sha1sum | awk '{print $1}')
set -x

function run_cmake
{
  declare -a ARGS
  if [[ -n "$CMAKE_GENERATOR" ]]
  then
    ARGS+=(-G "$CMAKE_GENERATOR")
  fi

  if [[ -n "$CMAKE_TOOLCHAIN" ]]
  then
    ARGS+=("-DCMAKE_TOOLCHAIN_FILE=$CMAKE_TOOLCHAIN")
  fi

  if [[ ${#ARGS[@]} -eq 0 ]]
  then
    cmake "$@"
  else
    cmake "${ARGS[@]}" "$@"
  fi
}

mkdir -p "$directory"
cd "$directory"
if [[ $# -eq 1 ]] && [[ -z $1 ]]
then
  run_cmake ..
else
  run_cmake .. "$@"
fi
cd ..

MAKEFLAGS=-j cmake --build "$directory"
case "$CMAKE_GENERATOR" in
  Visual*)
    cmake --build "$directory" --target RUN_TESTS
    ;;
  *)
    cmake --build "$directory" --target test
    ;;
esac
