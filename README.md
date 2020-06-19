# Create Scratch User
sfdx force:user:create --setalias qa-user --definitionfile config/user-def.json
sfdx force:user:display -u tester@npsp.dev1.movedata.io

# Install MoveData
Install the latest version of MoveData.
- https://login.salesforce.com/packaging/installPackage.apexp?p0=04t2w000004NSJK 

# Install NPSP
If you already have Salesforce, but don't have NPSP - https://powerofus.force.com/s/article/NPSP-Install#ariaid-title4
- https://install.salesforce.org/products/npsp/install 
- https://powerofus.force.com/s/article/NPSP-Post-Install-Configuration-Steps
