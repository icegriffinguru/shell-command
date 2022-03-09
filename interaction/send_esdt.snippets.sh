PROXY=https://devnet-gateway.elrond.com
CHAIN_ID="D"

WALLET="./wallets/wallet.pem"

TOKEN_ID="SVEN-4b35b0"
ESDT_VALUE=1000000000000000000
DEST_ADDRESS="erd1ztc8zfm2hudu24s6t4wewpqkqm0v63mjq4r88g0ycu8n9835lx4qx8zd0l"


ascii_to_hex() {
    local TEXT=$1
    echo ${TEXT} | tr -d '\n' | xxd -pu -
}

number_to_hex() {
    local NUMBER=$1
    local HEX_NUMBER=$(printf '%x' $NUMBER)
    local HEX_NUMBER_LENGTH=${#HEX_NUMBER}
    local PADDED_LENGTH=$(($HEX_NUMBER_LENGTH % 2 + $HEX_NUMBER_LENGTH))
    printf "%0${PADDED_LENGTH}x" $NUMBER
}

TOKEN_ID_HEX=$(ascii_to_hex $TOKEN_ID)
ESDT_VALUE_HEX=$(number_to_hex $ESDT_VALUE)

sendEsdt() {
  erdpy tx new \
  --receiver $DEST_ADDRESS \
  --data "ESDTTransfer@$TOKEN_ID_HEX@${ESDT_VALUE_HEX}" \
  --gas-limit 1000000 \
  --proxy $PROXY --recall-nonce --chain $CHAIN_ID --pem $WALLET --send
}