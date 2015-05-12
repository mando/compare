#!/bin/bash
set -e

BINDIR=$HOME/bin

setup() {
	if [ ! -d $BINDIR ]; then
	  echo "Uh oh - $BINDIR doesn't exist: bailing on install"
  else
	  echo "Copying compare.sh to $BINDIR/compare"
    cp $0 $BINDIR/compare
    echo "Done!"
  fi
}

uninstall() {
  echo "Removing $BINDIR/compare"
  rm $BINDIR/compare
  echo "Done!"
}

main() {
  CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
  BASE_BRANCH=development

  if [ "$CURRENT_BRANCH" = "development" ]; then
    BASE_BRANCH=master
  fi

  if [ "$CURRENT_BRANCH" = "master" ]; then
    BASE_BRANCH=master
    CURRENT_BRANCH=development
  fi

  REMOTE=$(git ls-remote --get-url | awk 'BEGIN{FS=":";}{print $2}' | sed 's/\.git//')

  REPO_URL=https://www.github.com/$REMOTE/compare/$BASE_BRANCH...$CURRENT_BRANCH

  open $REPO_URL
}

if [ "$1" = "--setup" ]; then
  setup
  exit 0
elif [ "$1" = "--uninstall" ]; then
  uninstall
  exit 0
fi

main
