#!/usr/bin/env zsh

set -e

if ! [[ $TRAVIS_REPO_SLUG == 'codurance/site'
     && $TRAVIS_PULL_REQUEST == 'false'
     && $TRAVIS_BRANCH == 'master'
]]; then
    return
fi

git clone --quiet --branch=gh-pages https://${GITHUB_TOKEN}@github.com/codurance/site.git /tmp/_site > /dev/null
bundle exec jekyll build --destination /tmp/_site

cd /tmp/_site
git add -A
git commit -m "Site built by CI build number ${TRAVIS_BUILD_NUMBER}."
git push --quiet origin gh-pages
