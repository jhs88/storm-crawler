#!/bin/bash
alias mvn='mvn -Dmaven.repo.local=$PWD/.repository'

cd "$PWD"/dashboards || exit
./importDashboards.sh

cd ..
./OS_IndexInit.sh "http://opensearch-node1:9200"
# ./OS_IndexInit.sh "https://opensearch-node1:9200" "-ku admin:Ae\$hJ>D9FcLWQPa8T"

# storm jar target/crawler-1.0-SNAPSHOT.jar org.apache.storm.flux.Flux injection.flux
# storm jar target/crawler-1.0-SNAPSHOT.jar org.apache.storm.flux.Flux crawler.flux

# storm local target/crawler-1.0-SNAPSHOT.jar org.apache.storm.flux.Flux injection.flux
storm local target/crawler-1.0-SNAPSHOT.jar org.apache.storm.flux.Flux crawler.flux
