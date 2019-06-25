#!/usr/bin/env bash

set -e
source .env_build
if [ "$ENV" != "BUILD" ]; then source .env_dev; fi;

echo "Creating build paths"

build_path=build
mkdir -p $build_path

for year in `seq $FIRST_YEAR $LAST_YEAR`;
do
  echo "Fetching year $year..."
  wget -q https://www.camara.leg.br/cotas/Ano-$year.csv.zip -O $build_path/$year.zip
done;

echo "Unziping CSV files"

cd $build_path
for year in `seq $FIRST_YEAR $LAST_YEAR`;
do
  unzip $year.zip
  mv *$year.csv $year.csv
done;

rm *.zip

