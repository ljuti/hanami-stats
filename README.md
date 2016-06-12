# Hanami-stats


## Setup

To install the gems required by the application, run

```shell
% bundle install
```

Then, to run the application, run

```shell
% bundle exec hanami server
```

Now the application is running at [http://localhost:2300/](http://localhost:2300/)


## Available endpoints



## CSV Data

Statistical data is stored as CSV files in <code>data</code> directory. The CSV
files are parsed into an in-memory datastore at application boot. Updating the
results is simply a matter of replacing data files with updated ones and restarting
the application.
