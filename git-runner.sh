#!/bin/bash
#set -e

branch=$1
tag=$2
dt=$(date '+%d%m%Y_%H%M%S');
repo_url='https://iliha1-tools-git.euro.apple.com/scm/fg/flash-gordon.git';

base_folder_name="repo_"$branch_$dt;
echo "base folder name: "$base_folder_name;
if [ -d "$base_folder_name" ]; then rm -Rf $base_folder_name; fi
mkdir $base_folder_name;
cd $base_folder_name;

echo "Checking out branch '$branch'..."
git clone $repo_url && git checkout $branch;

cd flash-gordon

#front-end processing
echo "Processing front-end";
cd flash-gordon-frontend;
npm install --save && ng build dale-arden && ng build --prod;
if [ -d "dist" ]; then mkdir -p ../../artifacts/frontend && cp -R dist/. ../../artifacts/frontend; fi

cd ..
#backend TBD
echo "Processing backend";

cd ..

#git tag -a $tag -m "$tag"
#git push origin $tag

#rm -fd repo-$branch