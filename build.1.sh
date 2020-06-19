sfdx --version

sfdx force:auth:jwt:grant \
    --clientid 3MVG97quAmFZJfVyOkWn6I.OXEkyd3kZx55eiuTwIjlg9QQoWkYrtUmtgO34UKAKu_ObE.IxctseUFv9kncK0 \
    --jwtkeyfile ./config/server.key \
    --username jkent@package.npsp.trial.movedata.io \
    --setalias NpspTrialPkgOrg

sfdx force:source:convert -d mdapi-source/unlocked-package -n "MoveData NPSP Trial Extensions"

sfdx force:mdapi:deploy -d mdapi-source/unlocked-package -u NpspTrialPkgOrg -l RunLocalTests -w 15

#Version 1.0
#sfdx force:package1:version:create -i 0332x000000LKinAAG -m -n "Version 1.1" -v "1.1" -u NpspTrialPkgOrg -w 15 --json

VERSION_CONFIG=$(aws dynamodb get-item --table-name build.movedata-npsp --key '{ "configKey": { "S": "version" } }')
VERSION_MAJOR=$(echo $VERSION_CONFIG | jq -r '.Item.major.S')
VERSION_MINOR=$(echo $VERSION_CONFIG | jq -r '.Item.minor.S')
((VERSION_MINOR=VERSION_MINOR+1))
VERSION="$VERSION_MAJOR.$VERSION_MINOR" && echo "New Version: $VERSION"

PACKAGE_JSON=$(sfdx force:package1:version:create -i $SFDX_PACKAGE_ID -m -n "Version $VERSION" -v "$VERSION" -u NpspPkgOrg -w 15 --json) && echo $PACKAGE_JSON
PACKAGE_VERSION=$(echo $PACKAGE_JSON | jq -r '.result.MetadataPackageVersionId') && echo $PACKAGE_VERSION

VERSION_JSON="{ \"configKey\": { \"S\": \"version\" }, \"major\": { \"S\": \"$VERSION_MAJOR\" }, \"minor\": { \"S\": \"$VERSION_MINOR\" } }" && echo $VERSION_JSON
PACKAGE_VERSION_JSON="{ \"configKey\": { \"S\": \"packageVersion\" }, \"value\": { \"S\": \"$test_var\" } }" && echo $PACKAGE_VERSION_JSON

eval "aws dynamodb put-item --table-name build.movedata-npsp --item '$VERSION_JSON'"
eval "aws dynamodb put-item --table-name build.movedata-npsp --item '$PACKAGE_VERSION_JSON'"

exit 0

aws dynamodb get-item --table-name build.movedata-npsp --key '{ "configKey": { "S": "version" } }' | jq -r '.Item.value.S'

exit 0

sfdx force:package:create --name "MoveData NPSP Extensions" - Unlocked

sfdx --version

 # 3MVG97quAmFZJfVwnWznE2u8fgf0TcPIsp7IO6x1nMzInQlbvpERQWpmDuY.HpSZU2O9ovTY2OLfILSSRgknZ \

sfdx force:auth:jwt:grant \
    --clientid 3MVG9d8..z.hDcPJAeUF5IL.PCmfupjKVHMhcjX2YZnXzapOUbbJuTB6vq52Oq7u8DGpvtNMgOdfjWufDQjrM \
    --jwtkeyfile ./config/server.key \
    --username jkent@blueberry.agency \
    --setdefaultdevhubusername \
    --setdefaultusername

sfdx force:package:update --name "MoveData NPSP Extensions" --package 0Ho2t0000004C93CAE

sfdx force:package:version:create \
    --package "MoveData NPSP Extensions" \
    --definitionfile config/project-scratch-def.json \
    --wait 15 \
    --installationkeybypass \
    --skipvalidation \
    --json

#sfdx force:package:create --name "MoveData NPSP Extensions" --packagetype Unlocked --nonamespace --path "force-app"