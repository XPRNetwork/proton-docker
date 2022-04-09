# Installation
Install docker from [Install Docker](https://docs.docker.com/get-docker/)

# Usage

**Run command below to start docker container (Replace `<HOME>` with your own working directory)**
```
docker pull jafri/proton:latest;
docker run \
  -d \
  --name proton \
  --platform linux/amd64 \
  --user 0 \
  -v <HOME>:<HOME> \
  -v <HOME>/eosio-wallet:/root/eosio-wallet \
  -w <HOME> \
  -e HOME=<HOME> \
  jafri/proton:1.0;
```

**Open container**

```
docker exec -it -u 0 proton /bin/sh
```

**Start node**
```
nodeos \
  -e -p eosio \
 --data-dir ./data \
 --config-dir ./config \
 --plugin eosio::http_plugin \
 --plugin eosio::chain_plugin \
 --plugin eosio::chain_api_plugin \
 --plugin eosio::producer_plugin \
 --http-server-address=0.0.0.0:8888 \
 --access-control-allow-origin='*' \
 --http-validate-host=false \
 --max-transaction-time=200000 \
 --disable-replay-opts \
 --hard-replay \
 --contracts-console \
 --filter-on='*' \
 --filter-out=eosio:onblock:"" &
```

**Start keosd**
```
keosd &
```

**Exit and re-enter**
```
exit
docker exec -it -u 0 proton /bin/sh
```

**Verify Running**
```
cleos get info
```

# Manual building

```
docker build --platform linux/amd64 -t proton .
```

# Credits
Thanks to @poplexity for the initial instructions!
