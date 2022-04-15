FROM ubuntu:bionic

RUN apt-get update && apt-get install -y wget

RUN wget https://github.com/eosio/eos/releases/download/v2.0.7/eosio_2.0.7-1-ubuntu-18.04_amd64.deb
RUN apt-get install -y ./eosio_2.0.7-1-ubuntu-18.04_amd64.deb

RUN wget https://github.com/eosio/eosio.cdt/releases/download/v1.7.0/eosio.cdt_1.7.0-1-ubuntu-18.04_amd64.deb
RUN apt-get install -y ./eosio.cdt_1.7.0-1-ubuntu-18.04_amd64.deb

RUN apt-get install -y vim build-essential libssl-dev cmake

RUN echo 'alias cleosp="cleos -u https://proton.cryptolions.io"' >> ~/.bashrc
RUN echo 'alias cleospt="cleos -u https://testnet.protonchain.com"' >> ~/.bashrc
RUN echo 'alias clwu="cleos wallet unlock"' >> ~/.bashrc

CMD nodeos \
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
 --filter-out=eosio:onblock:''