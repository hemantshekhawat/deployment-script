#!/usr/bin/env bash


printf "\n\n Deploying Sellfie Admin - Dev Server with TagV1.0 \n\n"
sh deployment-script/deploy.sh dev TagV1.0.0 sellfie-admin dev
printf "\n\n Deploying Sellfie Admin - QA Server with TagV1.0 \n\n"
sh deployment-script/deploy.sh dev TagV1.0.0 sellfie-admin qa

printf "\n\n Deploying Sellfie API base - Dev Server with TagV1.0 \n\n"
sh deployment-script/deploy.sh dev TagV1.0.0  sellfy dev
printf "\n\n Deploying Sellfie API base - QA Server with TagV1.0 \n\n"
sh depdeployment-script/deploy.shh dev TagV1.0.0 sellfy qa



printf "\n\n Deploying Sellfie Buyer App(Node) - Dev Server with TagV1.0 \n\n"
sh deployment-script/deploy.sh dev TagV1.0.0 sellfie-front-end dev sellfie-buyer
printf "\n\n Deploying Sellfie Buyer App(Node)  - QA Server with TagV1.0 \n\n"
sh deployment-script/deploy.sh dev TagV1.0.0 sellfie-front-end qa sellfie-buyer

printf "\n\n Deploying Sellfie Web App(Node) - Dev Server with TagV1.0 \n\n"
sh deployment-script/deploy.sh dev TagV1.0.0 sellfie-front-end dev sellfie-webapp
printf "\n\n Deploying Sellfie Web App(Node) - QA Server with TagV1.0 \n\n"
sh deployment-script/deploy.sh dev TagV1.0.0 sellfie-front-end qa sellfie-webapp



#sh deploy-my-website.sh dev TagV1.0  sellfie-admin pre-prod
#sh deploy-my-website.sh dev TagV1.0 sellfie-admin prod
#sh deploy-my-website.sh dev TagV1.0 sellfy pre-prod
#sh deploy-my-website.sh dev TagV1.0 sellfy prod
