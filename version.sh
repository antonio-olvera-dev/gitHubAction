#!/bin/sh
git fetch -p

VERSION=`git describe --abbrev=0 --tags`
VERSION=${VERSION:-'0.9.9'}
if [ $VERSION == "0.9.9" ];
then
CURRENT_VERSION="1.0.0"
else
CURRENT_VERSION=$VERSION
fi




MAJOR="${VERSION%%.*}"; VERSION="${VERSION#*.}"
MINOR="${VERSION%%.*}"; VERSION="${VERSION#*.}"
PATCH="${VERSION%%.*}"; VERSION="${VERSION#*.}"

if [ $PATCH -lt 9 ];
then
PATCH=$(($PATCH + 1))
else
PATCH=0;
if [ $MINOR -lt 9 ];
then
MINOR=$(($MINOR + 1))
else
MINOR=0;
if [ $MAJOR -lt 20 ];
then
MAJOR=$(($MAJOR + 1))
else
MAJOR=0;
fi
fi
fi


NEW_TAG="$MAJOR.$MINOR.$PATCH"
echo "Current version $CURRENT_VERSION"
echo "Updating to $NEW_TAG"

git tag -a "$NEW_TAG" -m "version $NEW_TAG"
git push origin "$NEW_TAG"
exit 0