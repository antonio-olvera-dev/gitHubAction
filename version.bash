#!/bin/sh

#Get the highest tag number
VERSION=`git describe --abbrev=0 --tags`
VERSION=${VERSION:-'0.0.0'}

#Get number parts
MAJOR="${VERSION%%.*}"; VERSION="${VERSION#*.}"
MINOR="${VERSION%%.*}"; VERSION="${VERSION#*.}"
PATCH="${VERSION%%.*}"; VERSION="${VERSION#*.}"

#Increase version
PATCH=$((PATCH+1))

#Get current hash and see if it already has a tag
GIT_COMMIT=`git rev-parse HEAD`
NEEDS_TAG=`git describe --contains $GIT_COMMIT`

#Create new tag
NEW_TAG="$MAJOR.$MINOR.$PATCH"
echo "Updating to $NEW_TAG"

#Only tag if no tag already (would be better if the git describe command above could have a silent option)
if [ -z "$NEEDS_TAG" ]; then
    echo "Tagged with $NEW_TAG (Ignoring fatal:cannot describe - this means commit is untagged) "
    git tag $NEW_TAG
else
    echo "Already a tag on this commit"
fi

#create new tag
NEW_TAG="$VNUM1.$VNUM2.$VNUM3"
echo "($VERSION) updating $CURRENT_VERSION to $NEW_TAG"

#get current hash and see if it already has a tag
GIT_COMMIT=`git rev-parse HEAD`
NEEDS_TAG=`git describe --contains $GIT_COMMIT 2>/dev/null`

#only tag if no tag already
#to publish, need to be logged in to npm, and with clean working directory: `npm login; git stash`
if [ -z "$NEEDS_TAG" ]; then
  npm version $NEW_TAG
  npm publish --access public
  echo "Tagged with $NEW_TAG"
  git push --tags
  git push
else
  echo "Already a tag on this commit"
fi

exit 0