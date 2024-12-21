This has been generated by the StormCrawler Maven Archetype as a starting point for building your own crawler with [OpenSearch](https://opensearch.org/) as a backend.
Have a look at the code and resources and modify them to your heart's content. 

You need to have Apache Storm installed, as well as a running instance of OpenSearch.

First generate an uberjar:

``` sh
mvn clean package
```

The first step consists in creating a file _seeds.txt_ in the current directory and populating it with the URLs 
to be used as a starting point for the crawl, e.g. 

`echo "http://stormcrawler.net/" > seeds.txt`

You can start the crawl topology in local mode using the URLs in _seeds.txt_ as a starting point with

``` sh
storm local target/crawler-1.0-SNAPSHOT.jar  org.apache.storm.flux.Flux injection.flux --local-ttl 3600
```

Note that in local mode, Flux uses a default TTL for the topology of 20 secs. The command above runs the topology for 1 hour.

To start crawling, run the following command

``` sh
storm jar target/crawler-1.0-SNAPSHOT.jar  org.apache.storm.flux.Flux crawler.flux
```

Note that in the previous command, we ran the topology with `storm jar` to benefit from the Storm UI and logging. In that case, the topology runs continuously, as intended.
If you don't have a Storm cluster set up and/or want to run in local mode, simply replace _jar_ with _local_ and add _--local-ttl 3600_.


Index definitions
---------------------

Unlike in the Elastic module, the schemas are automatically created by the bolts. You can of course override them by using the script 'OS_IndexInit.sh', the index definitions are located in _src/main/resources_.


Dashboards
---------------------

To import the dashboards into a local instance of OpenSearch Dashboards, go into the folder _dashboards_ and run the script _importDashboards.sh_. 

You should see something like 

```
Importing status dashboard into OpenSearch Dashboards
{"successCount":4,"success":true,"successResults":[{"type":"index-pattern","id":"7445c390-7339-11e9-9289-ffa3ee6775e4","meta":{"title":"status","icon":"indexPatternApp"}},{"type":"visualization","id":"status-count","meta":{"title":"status count","icon":"visualizeApp"}},{"type":"visualization","id":"Top-Hosts","meta":{"title":"Top Hosts","icon":"visualizeApp"}},{"type":"dashboard","id":"Crawl-status","meta":{"title":"Crawl status","icon":"dashboardApp"}}]}
Importing metrics dashboard into OpenSearch Dashboards
{"successCount":9,"success":true,"successResults":[{"type":"index-pattern","id":"b5c3bbd0-7337-11e9-9289-ffa3ee6775e4","meta":{"title":"metrics","icon":"indexPatternApp"}},{"type":"visualization","id":"Fetcher-:-#-active-threads","meta":{"title":"Fetcher : # active threads","icon":"visualizeApp"}},{"type":"visualization","id":"Fetcher-:-num-queues","meta":{"title":"Fetcher : num queues","icon":"visualizeApp"}},{"type":"visualization","id":"Fetcher-:-pages-fetched","meta":{"title":"Fetcher : pages fetched","icon":"visualizeApp"}},{"type":"visualization","id":"Fetcher-:-URLs-waiting-in-queues","meta":{"title":"Fetcher : URLs waiting in queues","icon":"visualizeApp"}},{"type":"visualization","id":"Fetcher-:-average-bytes-per-second","meta":{"title":"Fetcher : average bytes per second","icon":"visualizeApp"}},{"type":"visualization","id":"Fetcher-:-average-pages-per-second","meta":{"title":"Fetcher : average pages per second","icon":"visualizeApp"}},{"type":"visualization","id":"Total-bytes-fetched","meta":{"title":"Total bytes fetched","icon":"visualizeApp"}},{"type":"dashboard","id":"Crawl-metrics","meta":{"title":"Crawl metrics","icon":"dashboardApp"}}]}

```

The [dashboard screen](http://localhost:5601/app/dashboards#/list?_g=(filters:!(),refreshInterval:(pause:!t,value:0),time:(from:now-15m,to:now))) should show both the status and metrics dashboards. If you click on `Crawl Status`, you should see 2 tables containing the count of URLs per status and the top hostnames per URL count.
The [Metrics dashboard](http://localhost:5601/app/dashboards#/view/Crawl-metrics) can be used to monitor the progress of the crawl.

The file _storm.ndjson_ is used to display some of Storm's internal metrics and is not added by default.



Happy crawling! If you have any questions, please ask on [StackOverflow with the tag stormcrawler](http://stackoverflow.com/questions/tagged/stormcrawler) or the [discussions](https://github.com/apache/incubator-stormcrawler/discussions) section on GitHub.



