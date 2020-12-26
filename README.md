# README

## Requirements to run this app

* Ruby version: `2.7.2`
* Database: `postgresql`

## How to setup this app
```sh
bin/setup && rails db:setup
```

## Useful commands

* `bin/rails test` - it will run the test suite.

## Examples of CURL requests to interact with the API

First, run the application:

```sh
bin/rails s
```

Then, use some of the following commands to interact with the API resources:

### Create a survivor
```sh
curl -X POST "http://api.localhost:3000/survivors" \
  -H "Accept: application/vnd.api+json" \
  -H "Content-Type: application/vnd.api+json" \
  -d '{"survivor":{"name": "Chuck Norris", "age": "40", "gender": "male", "latitude": "-90.0", "longitude": "-180.0", "inventory": {"water": "1", "food": "2", "ammunition": "1", "medication": "1"}}}'
```

### Update a survivor location
```sh
curl -X PUT "http://api.localhost:3000/survivors/1" \
  -H "Accept: application/vnd.api+json" \
  -H "Content-Type: application/vnd.api+json" \
  -d '{"survivor":{"latitude": "-80.0", "longitude": "-150.0"}}'
```

### Create an infection report
```sh
curl -X POST "http://api.localhost:3000/survivors/1/infection_reports" \
  -H "Accept: application/vnd.api+json" \
  -H "Content-Type: application/vnd.api+json" \
  -d '{"infection_report":{"infected_id": "2"}}'
```

### Trade items between survivors
```sh
curl -X POST "http://api.localhost:3000/survivors/1/trades" \
  -H "Accept: application/vnd.api+json" \
  -H "Content-Type: application/vnd.api+json" \
  -d '{"trade":{"offer":{"items":{"food": 1}},"for":{"survivor_id":3, "items":{"water": 1}}}}'
```

### Get reports links
```sh
curl -X GET "http://api.localhost:3000/reports" \
  -H "Accept: application/vnd.api+json" \
  -H "Content-Type: application/vnd.api+json"
```

### Get infected survivors report
```sh
curl -X GET "http://api.localhost:3000/reports/infected" \
  -H "Accept: application/vnd.api+json" \
  -H "Content-Type: application/vnd.api+json"
```

### Get non-infected survivors report
```sh
curl -X GET "http://api.localhost:3000/reports/non_infected" \
  -H "Accept: application/vnd.api+json" \
  -H "Content-Type: application/vnd.api+json"
```

### Get inventories overview report
```sh
curl -X GET "http://api.localhost:3000/reports/non_infected" \
  -H "Accept: application/vnd.api+json" \
  -H "Content-Type: application/vnd.api+json"
```

### Get resources lost report
```sh
curl -X GET "http://api.localhost:3000/reports/non_infected" \
  -H "Accept: application/vnd.api+json" \
  -H "Content-Type: application/vnd.api+json"
```
