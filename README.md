# mongo-docker-compose
This repository provides a fully sharded mongo environment using docker-compose and local storage.

The MongoDB environment consists of the following docker containers

 - **mongors(1-2)n(1-3)**: Mongod data server with two replica sets containing 3 nodes each (2 replica + 1 arbiter * 2 : 6 containers)
 - **mongocfg(1-3)**: Stores metadata for sharded data distribution CSRS (3 containers)
 - **mongos(1-2)**: Mongo routing service to connect to the cluster through (2 containers)

## Caveats

 - This is designed to have a minimal disk footprint at the cost of durability.
 - This is designed in no way for production but as a cheap learning and exploration vehicle.

## Installation

### Check out the repository

    git clone git@github.com:singram/mongo-docker-compose.git
    cd mongo-docker-compose

### Setup Cluster
This will pull all the images from [Docker index](https://hub.docker.com/_/mongo) and run all the containers.

    make up

You will need to run the following *once* only to initialize all replica sets and shard data across them

    make init

Or both : 

    make start

Makefile documentation :  

    ⇒  make help

    ----- BUILD ------------------------------------------------------------------------------
    up                   Start docker-compose
    init                 Launch mongo cluster init
    clean                Stop docker containers and clean volumes
    start                Start container and init
    stop                 Stop docker containers
    watch                Watch logs
    restart              Clean and restart
    ----- OTHERS -----------------------------------------------------------------------------
    help                 print this message


You should now be able connect to mongos1 and the new sharded cluster from the mongos container itself using the mongo shell to connect to the running mongos process

    docker exec -it mongos1 mongo --port 21017

### Version

By default, it will start a MongoDb 4.0 cluster, but you can also start MongoDB in version 3.6 : 

    MONGO_VERSION=3.6 make start

## Persistent storage
Data is stored in docker volumes. To remove all data : `make clean`.

## TODO

 - Add local Ops Mananger
 - Implement authentication across cluster.  http://docs.mongodb.org/manual/tutorial/deploy-replica-set-with-auth/

## Built upon
 - [Docker-compose wait to start](http://brunorocha.org/python/dealing-with-linked-containers-dependency-in-docker-compose.html)
 - [Bi directional docker commuication](http://abdelrahmanhosny.com/2015/07/01/3-solutions-to-bi-directional-linking-problem-in-docker-compose/)
 - [MongoDB Sharded Cluster by Sebastian Voss](https://github.com/sebastianvoss/docker)
 - [MongoDB](http://www.mongodb.org/)
 - [Mongo Docker ](https://github.com/jacksoncage/mongo-docker)
 - [DnsDock](https://github.com/tonistiigi/dnsdock)
 - [Docker](https://github.com/dotcloud/docker/)
 - [WaitForIt](https://github.com/vishnubob/wait-for-it)
