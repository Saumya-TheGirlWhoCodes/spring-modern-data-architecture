#
# /*
#  * Copyright 2023 VMware, Inc.
#  * SPDX-License-Identifier: GPL-3.0
#  */
#



# List Services

cf marketplace

## GemFire for Redis

cf create-service p-cloudcache dev-plan  retail-gf-redis -c '{"gemfire_for_redis_enabled":"true","gemfire_for_redis_redundant_copies":2,"gemfire_for_redis_region_name": "GF_REDIS"}' -t redis

## My SQL

cf create-service p.mysql db-small retail-mysql


## RabbitMQ

cf create-service p.rabbitmq single-node retail-rabbitmq



--------------------------------

# retail-cache-sink-app

cf push retail-cache-sink-app -f deployments/cloud/cloudFoundry/apps/retail-cache-sink-app/retail-cache-sink-app.yaml -p applications/retail-cache-sink-app/target/retail-cache-sink-app-0.0.1-SNAPSHOT.jar

# retail-source-app
cf push retail-source-app -f deployments/cloud/cloudFoundry/apps/retail-source-app/retail-source-app.yaml -p applications/retail-source-app/target/retail-source-app-0.0.1-SNAPSHOT.jar


# retail-web-app
cf push retail-web-app -f deployments/cloud/cloudFoundry/apps/retail-web-app/retail-web-app.yaml -p applications/retail-web-app/target/retail-web-app-0.0.1-SNAPSHOT.jar


# Create a service key by
cf create-service-key retail-gf-redis retail-gf-redis-key

# Inspect the service key:
cf service-key retail-gf-redis retail-gf-redis-key