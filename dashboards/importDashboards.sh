#!/bin/sh

BIN=$(dirname $0)

echo "Importing status dashboard into OpenSearch Dashboards"
curl -X POST "opensearch-dashboards:5601/api/saved_objects/_import" -H "osd-xsrf: true" --form file=@$BIN/status.ndjson -ku admin:Ae\$hJ\>D9FcLWQPa8T
echo ""

echo "Importing metrics dashboard into OpenSearch Dashboards"
curl -X POST "opensearch-dashboards:5601/api/saved_objects/_import" -H "osd-xsrf: true" --form file=@$BIN/metrics.ndjson -ku admin:Ae\$hJ\>D9FcLWQPa8T
echo ""

# Storm internal metrics
# curl -X POST "opensearch-dashboards:5601/api/saved_objects/_import" -H "kbn-xsrf: true" --form file=@$BIN/storm.ndjson -ku admin:Ae\$hJ\>D9FcLWQPa8T
