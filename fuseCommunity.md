

#Shell envs setup
```shell
# FUSE_PK=pk_0XJPA5zo36PAxHt6fA4zMjTv
FUSE_PK=pk_test_5ubNCbjAxmCgg78-9AaiDLqa
echo "$FUSE_PK"
```

## Create the vegi GreenBeanToken ERC20 Token in the vegi community:

See [docs](https://docs.fuse.io/docs/admin-api/create-an-erc-20-token) and [initialSupply thoughts](https://docs.openzeppelin.com/contracts/2.x/erc20)

```shell
curl -L -X POST "https://api.fuse.io/api/v0/admin/tokens/create?apiKey=$FUSE_PK" \
-H "Content-Type: application/json" \
-H "Accept: application/json" \
-H "API-SECRET: sk_zzi0kZsSoWt_mimeSxAMDqpA" \
--data-raw "{
  "name": "Green Bean Token",
  "symbol": "GBT",
  "initialSupply": "1000000000"
}" \
| python -m json.tool

```
Or when using the test key:

```shell
FUSE_PK=pk_test_5ubNCbjAxmCgg78-9AaiDLqa

curl -L -X POST "https://api.fuse.io/api/v0/admin/tokens/create?apiKey=$FUSE_PK" \
-H "Content-Type: application/json" \
-H "Accept: application/json" \
-H "API-SECRET: sk_zzi0kZsSoWt_mimeSxAMDqpA" \
--data-raw '{
  "name": "Green Bean Spark Token",
  "symbol": "GBST",
  "initialSupply": "1000000000"
}' | python -m json.tool

```
### Output:
``` json
{"job":{"status":"pending","_id":"648305e25476b500196b3667","name":"createToken","data":{"bridgeType":"home","accountAddress":"0x13303F26b392755D6154Dc2Ef3603eD2b080fe11","name":"Green Bean Token","symbol":"GBT","initialSupplyInWei":"1000000000000000000000000000","tokenURI":"","expiryTimestamp":2524608000,"spendabilityIdsArr":[]},"createdAt":"2023-06-09T10:58:42.199Z","updatedAt":"2023-06-09T10:58:42.199Z","__v":0}}%
```

# Retrieve the new token's ETH address using the community address as owner:

See [docs](https://docs.fuse.io/docs/admin-api/get-tokens-by-owner)

```shell
curl -L -X GET "https://api.fuse.io/api/v0/admin/tokens/owner/0x13303F26b392755D6154Dc2Ef3603eD2b080fe11?apiKey=$FUSE_PK" \
-H "Accept: application/json" \
-H "API-SECRET: sk_zzi0kZsSoWt_mimeSxAMDqpA" \
| python -m json.tool

```
### Output:
``` json
{"object":"list","data":[{"decimals":18,"spendabilityIds":[],"_id":"648305e667eb31001ae914f4","address":"0x72438A9e3Af16C9A0D762900635baf96260E8b2a","name":"Green Bean Token","symbol":"GBT","tokenURI":"","totalSupply":"1000000000000000000000000000","owner":"0x13303F26b392755D6154Dc2Ef3603eD2b080fe11","blockNumber":23739327,"tokenType":"expirable","networkType":"home","expiryTimestamp":2524608000,"createdAt":"2023-06-09T10:58:46.146Z","updatedAt":"2023-06-09T10:58:46.146Z"}]}%
```

## Can also retrieve the token now using its address:

See [docs](https://docs.fuse.io/docs/admin-api/get-tokens-by-address)

```shell
curl -L -X GET "https://api.fuse.io/api/v0/admin/tokens/0x72438A9e3Af16C9A0D762900635baf96260E8b2a?apiKey=$FUSE_PK" \
-H "Accept: application/json" \
-H "API-SECRET: sk_zzi0kZsSoWt_mimeSxAMDqpA" \
| python -m json.tool

```
### Output:
``` json
{"data":{"decimals":18,"spendabilityIds":[],"_id":"648305e667eb31001ae914f4","address":"0x72438A9e3Af16C9A0D762900635baf96260E8b2a","name":"Green Bean Token","symbol":"GBT","tokenURI":"","totalSupply":"1000000000000000000000000000","owner":"0x13303F26b392755D6154Dc2Ef3603eD2b080fe11","blockNumber":23739327,"tokenType":"expirable","networkType":"home","expiryTimestamp":2524608000,"createdAt":"2023-06-09T10:58:46.146Z","updatedAt":"2023-06-09T10:58:46.146Z"}}%
```

# PayMasters

We need to set up a paymaster for the project to enable transactions without users having to pay the gas for them. Paymasters are sponsors for projects that sponsor the project by funding the gas for user operations on the web3 network.

Fuse notes on the subject are located [here](https://north-crocus-61d.notion.site/Creating-a-Sponsor-for-Your-Project-147bd22f21b94147b22f2fd4871ed91b)




# Minting
``` shell
curl -L -X POST "https://api.fuse.io/api/v0/admin/tokens/mint?apiKey=$FUSE_PK" \
-H "Content-Type: application/json" \
-H "Accept: application/json" \
-H "API-SECRET: sk_zzi0kZsSoWt_mimeSxAMDqpA" \
-H "Content-Type: application/json" \
--data-raw '{
  "tokenAddress": "0x72438A9e3Af16C9A0D762900635baf96260E8b2a",
  "amount": "10.0",
  "toAddress": "0x579b8830b87c53265b1939c06c17bf86d6fd51ca"
}' \
| python -m json.tool
```

```json
{"job":{"name":"mint","data":{"tokenAddress":"0x72438A9e3Af16C9A0D762900635baf96260E8b2a","bridgeType":"home","accountAddress":"0x13303F26b392755D6154Dc2Ef3603eD2b080fe11","amount":"10000000000000000000","toAddress":"0x579b8830b87c53265b1939c06c17bf86d6fd51ca"},"status":"pending","_id":"6512d56f81439518f398a4b9","createdAt":"2023-09-26T12:58:23.081Z","updatedAt":"2023-09-26T12:58:23.081Z","__v":0}}%
```

```shell
curl -L -X GET "https://api.fuse.io/api/v0/jobs/6512d56f81439518f398a4b9?apiKey=$FUSE_PK" \
-H "Accept: application/json" \
-H "API-SECRET: sk_zzi0kZsSoWt_mimeSxAMDqpA" \
| python -m json.tool
```
```json
{
  "data": {
    "_id": "6512d56f81439518f398a4b9",
    "name": "mint",
    "data": {
      "tokenAddress": "0x72438A9e3Af16C9A0D762900635baf96260E8b2a",
      "bridgeType": "home",
      "accountAddress": "0x13303F26b392755D6154Dc2Ef3603eD2b080fe11",
      "amount": "10000000000000000000",
      "toAddress": "0x579b8830b87c53265b1939c06c17bf86d6fd51ca",
      "txHash": "0x74c1438d8d58a4659851a1f10341d9e123ba61552aafcb412c987947f12b565e",
      "transactionBody": {
        "status": "confirmed",
        "blockNumber": 25601731
      },
      "txFee": {
        "$numberDecimal": "590799000000000"
      }
    },
    "status": "succeeded",
    "createdAt": "2023-09-26T12:58:23.081Z",
    "updatedAt": "2023-09-26T12:58:31.307Z",
    "__v": 0,
    "accountAddress": "0x13303F26b392755D6154Dc2Ef3603eD2b080fe11",
    "lastFinishedAt": "2023-09-26T12:58:31.307Z"
  }
}
```

## Check status of a job using the Jobs API

See [docs](https://docs.fuse.io/docs/admin-api/get-job-by-id)



## Create webhooks for fuse to notifiy vegi backend upon certain events:

See [docs](https://docs.fuse.io/docs/notification-api/webhooks)

& [eventTypes docs](https://docs.fuse.io/docs/notification-api/notifications-api#types-of-address-activity-events-in-fuse-notifications)

We are able to listen to eventTypes: ALL, FUSE (Native), ERC20, and ERC721 (includes ERC1155). [source](https://docs.fuse.io/docs/notification-api/notifications-api#3-internal-fuse-transfers)

Security, always check that the ip address of the sender (fuse) calling the vegi fuse-event-webhook is in:
- 3.72.127.173
- 3.72.200.191


```shell
curl -L -X POST "https://api.fuse.io/api/v0/notifications/webhook?apiKey=$FUSE_PK" \
-H "Content-Type: application/json" \
-H "Accept: application/json" \
-H "API-SECRET: sk_zzi0kZsSoWt_mimeSxAMDqpA" \
--data-raw '{
  "projectId": "643e38d088b131dd9a26a517",
  "webhookUrl": "https://qa-vegi.vegiapp.co.uk/api/v1/payments/fuse-event-webhook",
  "eventType": "ALL"
}' \
| python -m json.tool

```
### Output:
``` json
{"projectId":"643e38d088b131dd9a26a517","webhookUrl":"https://qa-vegi.vegiapp.co.uk/api/v1/payments/fuse-event-webhook","eventType":"ALL","_id":"64834857bbf7c4c0b5dd0795","createdAt":"2023-06-09T15:42:15.709Z","updatedAt":"2023-06-09T15:42:15.709Z","__v":0}%
```


## Fetch all webhooks for vegi project: 

See [docs](https://docs.fuse.io/docs/notification-api/get-webhooks-for-project)

```shell
curl -L -X GET "https://api.fuse.io/api/v0/notifications/webhooks/643e38d088b131dd9a26a517?apiKey=$FUSE_PK" \
-H "Accept: application/json" \
-H "API-SECRET: sk_zzi0kZsSoWt_mimeSxAMDqpA" \
| python -m json.tool

```
### Output:
``` json
[{"_id":"64834857bbf7c4c0b5dd0795","projectId":"643e38d088b131dd9a26a517","webhookUrl":"https://qa-vegi.vegiapp.co.uk/api/v1/payments/fuse-event-webhook","eventType":"ALL","createdAt":"2023-06-09T15:42:15.709Z","updatedAt":"2023-06-09T15:42:15.709Z","__v":0}]%
```

## Update the webhook for *Production*:

See [docs]()

```shell
curl -L -X PUT "https://api.fuse.io/api/v0/notifications/webhook?apiKey=$FUSE_PK" \
-H "Content-Type: application/json" \
-H "Accept: application/json" \
-H "API-SECRET: sk_zzi0kZsSoWt_mimeSxAMDqpA" \
--data-raw '{
  "webhookId": "64834857bbf7c4c0b5dd0795",
  "webhookUrl": "https://vegi.vegiapp.co.uk/api/v1/payments/fuse-event-webhook",
  "eventType": "ALL"
}' \
| python -m json.tool
```

## External Native Fuse Transfers
Note that the value field consists of the decimals of the token. In the below example 1 Fuse was transferred, and as Native Fuse has 18 decimals, we see the value 100000000000000000. For convenience, you can also refer to the valueEth field, which gives the value formatted without the decimals.

We can get the number of decimals using the GET "https://api.fuse.io/api/v0/admin/tokens/0x72438A9e3Af16C9A0D762900635baf96260E8b2a request detailed above and getting `response.data.decimals (i.e. 18 for GBT)`. We can then use `dataObj := inputs; dataObj.value / (Math.pow(10, tokenDecimals))`. Note the event object contains the token address which we can also use to check the decimals and symbol and confirm matches what we expect the token address to be from our server-side config.

### Outgoing
```json
{
  "to": "0x1ea1f375B5dA185eb51edcbED23F3d401f8368cE",
  "from": "0xcc95E80DA76bd41507b99d9b977Dc3062bcf6430",
  "value": "1000000000000000000",
  "valueEth": "0.1",
  "txHash": "0xf801c95b9325e69be8ccf8889f1b3245a5b48e6f783913bd4d41ec4c6ba9720b",
  "blockNumber": 18196049,
  "blockHash": "0x1160be538508f63e3917b61f7af84db8907f66290d568340050f97e16008cc0b",
  "tokenType": "FUSE",
  "tokenAddress": "0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE",
  "projectId": "62ce87c8131bbffe0f83af65",
  "direction": "outgoing"
}
```


## Create a Community Manager and Fetch it
```shell
curl -L -X POST "https://api.fuse.io/api/v0/admin/wallets/create?apiKey=$FUSE_PK" \
-H "Content-Type: application/json" \
-H "Accept: application/json" \
-H "API-SECRET: sk_zzi0kZsSoWt_mimeSxAMDqpA" \
--data-raw '{
  "phoneNumber": "+447905532512"
}' \
| python -m json.tool
```
### Output:
``` json
{"job":{"status":"pending","_id":"64985b20bc43660014d9db78","name":"createWallet","data":{"owner":"0x13303F26b392755D6154Dc2Ef3603eD2b080fe11","walletAddress":"0x30564BEc27136457a085771DE6eCD6A0FF52Ef4d","phoneNumber":"+447905532512","_id":"64985b20bc43660014d9db76","salt":"0x6cda2a40c8b288005208a8b407101f4b1d60bac3e28071c8f172866949396b09"},"createdAt":"2023-06-25T15:20:00.558Z","updatedAt":"2023-06-25T15:20:00.558Z","__v":0}}
```

## Get wallets with that phone number
```shell
curl -L -X GET "https://api.fuse.io/api/v0/admin/wallets/all/+447905532512?apiKey=$FUSE_PK" \
-H "Accept: application/json" \
-H "API-SECRET: sk_zzi0kZsSoWt_mimeSxAMDqpA" \
| python -m json.tool
```
### Output:
``` json
{"data":[{"myReferrals":[],"guardians":[],"_id":"64985b20bc43660014d9db76","isContractDeployed":false,"firebaseTokens":[],"backup":false,"salt":"0x6cda2a40c8b288005208a8b407101f4b1d60bac3e28071c8f172866949396b09","networks":["fuse"],"pendingNetworks":[],"balancesOnForeign":{},"upgradesInstalled":[],"version":"1.7.0","paddedVersion":"0001.0007.0000","phoneNumber":"+447905532512","accountAddress":"0x13303F26b392755D6154Dc2Ef3603eD2b080fe11","walletOwnerOriginalAddress":"0x13303F26b392755D6154Dc2Ef3603eD2b080fe11","walletFactoryOriginalAddress":"0x2FE1F9bBC9CE8Ea4E00F89FC1a8936DE6934b63D","walletFactoryCurrentAddress":"0x2FE1F9bBC9CE8Ea4E00F89FC1a8936DE6934b63D","walletImplementationOriginalAddress":"0x811A7F70d12fbd29Ec494eDc75645E66f5fCcCFc","walletImplementationCurrentAddress":"0x811A7F70d12fbd29Ec494eDc75645E66f5fCcCFc","walletModulesOriginal":{"GuardianManager":"0x1D91b84b22AC32B7928Dc6BdB2A66C42Fc32F1C3","LockManager":"0x8221d124f8255f61fC5f1dbb2382364B53355574","RecoveryManager":"0xcB4606396746Cd62Ac9ea9Cc0fCc5B16BE73E7aF","ApprovedTransfer":"0x2cbE5fE3d259313F25Ac2Dd10FAB8B851561F366","TransferManager":"0x2B3113B752645dfAFCe690706b5eCAd9d83977CF","TokenExchanger":"0xaA556969CB2782052A2eADEA32e660d40f4C4281","CommunityManager":"0x0D4926876ba1ada6E9b542e018eBeD517FFc8050","WalletOwnershipManager":"0x0134652f44006eE54f1E86d6a5786a28b9dCcD0b","DAIPointsManager":"0x602C6FbF83f5B758365DB51f38D311B09657f72c"},"walletModules":{"GuardianManager":"0x1D91b84b22AC32B7928Dc6BdB2A66C42Fc32F1C3","LockManager":"0x8221d124f8255f61fC5f1dbb2382364B53355574","RecoveryManager":"0xcB4606396746Cd62Ac9ea9Cc0fCc5B16BE73E7aF","ApprovedTransfer":"0x2cbE5fE3d259313F25Ac2Dd10FAB8B851561F366","TransferManager":"0x2B3113B752645dfAFCe690706b5eCAd9d83977CF","TokenExchanger":"0xaA556969CB2782052A2eADEA32e660d40f4C4281","CommunityManager":"0x0D4926876ba1ada6E9b542e018eBeD517FFc8050","WalletOwnershipManager":"0x0134652f44006eE54f1E86d6a5786a28b9dCcD0b","DAIPointsManager":"0x602C6FbF83f5B758365DB51f38D311B09657f72c"},"appName":"chargeApp_643e38d088b131dd9a26a517","walletAddress":"0x30564BEc27136457a085771DE6eCD6A0FF52Ef4d","createdAt":"2023-06-25T15:20:00.545Z","updatedAt":"2023-06-25T15:20:05.891Z","__v":0}]}
```

### and fetch:

```shell
curl -L -X GET "https://api.fuse.io/api/v0/admin/wallets/exists/0x13303F26b392755D6154Dc2Ef3603eD2b080fe11?apiKey=$FUSE_PK" \
-H "Accept: application/json" \
-H "API-SECRET: sk_zzi0kZsSoWt_mimeSxAMDqpA" \
| python -m json.tool
```