# deployment-script
      deployment script for Sellfie projects in laravel and Node



#!/bin/sh
    # Arguments
    # ${1} : branch Name
    # ${2} : Tag Version
    # ${3} : App name
    # ${4} : environment [ dev, qa, pre-prod, prod]

    ## Sample Command from Host Server : sh deploy-my-website.sh dev TagV2.0.1 sellfie-admin dev
    ## Sample Command from Local Environment :
    #         ssh -i ~/Documents/keys/Sellfie/selfie_staging.pem ec2-user@52.76.202.101 "sh /home/ec2-user/deploy-my-website.sh dev TagV2.0.1 sellfie-admin dev"
    #         ssh -i !/path/to/ssh/private/key user@host "command to be executed; multiple commands can be separated by | "
