#!/bin/bash
#
#> Usage:
#>    init RIAK_PATH [PBC_PORT]

set -e

if [ ! -e earthquake ]
then
    echo "The tweet corpus must first be downloaded and extracted."
    echo "See http://www.infochimps.com/datasets/twitter-haiti-earthquake-data"
    exit 1
fi

if [ $# -lt 1 ]
then
    grep '#>' $0 | tr -d '#>' | sed '$d'
    exit 1
fi

RIAK=$1
PORT=${2:-8087}
i=0

echo "Install tweets schema..."
$RIAK/bin/search-cmd set-schema tweets tweets-schema.txt

echo "Install Search precommit hook..."
$RIAK/bin/search-cmd install tweets

printf "Upload data"
python upload.py $PORT < earthquake