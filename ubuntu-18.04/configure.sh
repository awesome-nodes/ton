#!/bin/bash
# Configuration sript for the official TON node

echo "==> Download global config"
wget -qO /var/ton-work/etc/ton-global.config.json \
  https://test.ton.org/ton-global.config.json

echo "==> Create initial configuration"
IPADDR=$(hostname -I | awk '{print $1}') && IPPORT=6503
/usr/local/bin/validator-engine -C /var/ton-work/etc/ton-global.config.json \
  --db /var/ton-work/db/ \
  --ip ${IPADDR}:${IPPORT}

cd ~
echo "==> Generate server certificate"
if [ -f "./server" ]; then
  echo -e "Found existing server certificate, skipping"
else 
  read -r SRV1 SRV2 <<< $(/usr/local/bin/generate-random-id -m keys -n server)
  echo "Generated server keys: $SRV1 $SRV2"
  cp server /var/ton-work/db/keyring/$SRV1
fi

echo "==> Generate client certificate"
if [ -f "./client" ]; then 
    echo -e "Found existing client certificate, skipping"
else
  read -r CLNT1 CLNT2 <<< $(/usr/local/bin/generate-random-id -m keys -n client)
  echo -e "Generate client private certificate $CLNT1 $CLNT2"
  cp client /var/ton-work/db/keyring/$CLNT1
  {
  echo "   \"control\" : ["
  echo "      {"
  echo "         \"@type\" : \"engine.controlInterface\","
  echo "         \"id\" : \"$SRV2\","
  echo "         \"port\" : 6000,"
  echo "         \"allowed\" : ["
  echo "            {"
  echo "               \"@type\" : \"engine.controlProcess\","
  echo "               \"id\" : \"$CLNT2\","
  echo "               \"permissions\" : 15"
  echo "            }"
  echo "         ]"
  echo "      }"
  } > control.config

  sed -i -e "/\"control\"\ \:\ \[/r control.config" -e "//d" /var/ton-work/db/config.json
fi
