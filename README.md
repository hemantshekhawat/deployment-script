# Deployment Script for Selffie Projects
      deployment script for Sellfie projects in laravel and Node


# Usage


    ## Arguments
     ${1} : branch Name
     ${2} : Tag Version
     ${3} : App name [ sellfie-admin,sellfy,sellfie-front-end ]
     ${4} : environment [ dev, qa, pre-prod, prod]
     ${3} : Sub App name [ sellfie-buyer,sellfie-webapp ]
    
    ### Command Structure 
            sh my-script-name.sh {BRANCH-NAME} {TAG-NAME} {APP-NAME} {ENVIRONMENT} {SUB-APP-NAME}

    ## Sample Command from Host Server : sh deploy-my-website.sh dev TagV2.0.1 sellfie-admin dev
    ## Sample Command from Local Environment :
    #         ssh -i ~/Documents/keys/Sellfie/selfie_staging.pem ec2-user@52.76.202.101 "sh /home/ec2-user/deploy-my-website.sh dev TagV2.0.1 sellfie-admin dev"
    #         ssh -i !/path/to/ssh/private/key user@host "command to be executed; multiple commands can be separated by | "
