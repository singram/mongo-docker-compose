# mongo-docker-compose
This repoisitory provides a fully sharded mongo environment using docker-compose and local storage.

The MongoDB environment consistes of the following docker containers

 - **mongosrs(1-3)n(1-3)**: Mongod data server with three replica sets containing 3 nodes each (9 containers)
 - **mongocfg(1-3)**: Stores metadata for sharded data distribution (3 containers)
 - **mongos1**:	Mongo routing service to connect to the cluster through (1 container)

## Installation (Debian base):

### Install Docker

  sudo apt-get install -y apparmor lxc cgroup-lite curl
  wget -qO- https://get.docker.com/ | sh
  sudo usermod -aG docker YourUserNameHere
  sudo service docker restart

### Install Docker-compose

  sudo su
  curl -L https://github.com/docker/compose/releases/download/1.3.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
  exit

## Check out the repository

  git clone git@github.com:singram/mongo-docker-compose.git
  cd mongo-docker-compose

## Verify host systems docker0 interface

  ifconfig docker0 | grep "inet addr" | awk -F'[: ]+' '{ print $4 }'

This usually defaults to

  172.17.42.1

And is what the codebase assumes.  If yours is different run the following

  sed -i 's/172.17.42.1/NEW_IP_HERE/g' docker-compose.yml

To replace all instances with your docker0 ip.

## Configure docker daemon

Edit the docker configuration file and incoportate --dns and --bip options in the DOCKER_OPTS environment variable, something like

  DOCKER_OPTS="--bip=172.17.42.1/24 --dns=172.17.42.1"

  sudo nano /etc/defaults/docker

Restart the service for the new options to take effect

  sudo service docker restart


## Setup Cluster
This will pull all the images from [Docker index](https://index.docker.io/u/jacksoncage/mongo/) and setup Mongodb sharded cluster. Please make sure `DOCKERIP` in `docker_mongodb_cluster/start_cluster.sh` is using docker0 interface or public IP if you prefere that.

  docker-compose up

You will need to run the following *once* only to initialize all replica sets and shards

  ./initiate

You should now be able connect to mongos1 and the new sharded cluster:

  mongo --port 49550



## Persistent storage
Data is stored at `./data/` and are excluded from version control. Data will be persistent between container runs. To remove all data `./reset`


## Built upon
 - [MongoDB Sharded Cluster by Sebastian Voss](https://github.com/sebastianvoss/docker)
 - [MongoDB](http://www.mongodb.org/)
 - [Mongo Docker ](https://github.com/jacksoncage/mongo-docker)
 - [DnsDock](https://github.com/tonistiigi/dnsdock)
 - [Docker](https://github.com/dotcloud/docker/)
