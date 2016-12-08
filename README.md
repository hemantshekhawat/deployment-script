## Deployment Script for Selffie Projects
      deployment script for Sellfie projects in laravel and Node


## Usage


#### Arguments
     ${1} : branch Name
     ${2} : Tag Version
     ${3} : App name [ sellfie-admin,sellfy,sellfie-front-end ]
     ${4} : environment [ dev, qa, pre-prod, prod]
     ${3} : Sub App name [ sellfie-buyer,sellfie-webapp ]
    
#### Command Structure 
    sh my-script-name.sh {BRANCH-NAME} {TAG-NAME} {APP-NAME} {ENVIRONMENT} {SUB-APP-NAME}

##### Sample Command from Host Server : 
    sh deploy-my-website.sh dev TagV2.0.1 sellfie-admin dev
##### Sample Command from Local Environment :
    ssh -i ~/Documents/keys/Sellfie/selfie_staging.pem ec2-user@52.76.202.101 "sh /home/ec2-user/deploy-my-website.sh dev TagV2.0.1 sellfie-admin dev"
------
    ssh -i !/path/to/ssh/private/key user@host "command to be executed; multiple commands can be separated by | "




----

## DOMAINS 
###mappings for virtual host directories

#### sellfie-admin
     stg-sellfie-admin.sellfie.com         ----> /var/www/dev-admin.sellfie.com
     qa-sellfie-admin.sellfie.com          ----> /var/www/qa-admin.sellfie.com
     sbox-sellfie-admin.sellfie.com        ----> /var/www/pre-prod-sellfie-admin.sellfie.com

#### sellfy
     stg-sellfy.sellfie.com                ----> /var/www/dev-sellfy
     qa-sellfy.sellfie.com                 ----> /var/www/
     sbox-sellfy.sellfie.com               ----> /var/www/




##### Active Domains
    
    # ADMIN
    https://stg-admin.sellfie.me
    https://qa-admin.sellfie.me
    https://sbox-admin.sellfie.me
    
    # APIs
    https://stg-mobile-api.sellfie.me
    https://qa-mobile-api.sellfie.me
    https://sbox-mobile-api.sellfie.me
    
    # PRODUCT/PAYMENT LINK URLS
    https://stg.sellfie.me/product/xxxxx        ----> /var/www/stg-sellfy
    https://qa.sellfie.me/product/xxxx          ----> /var/www/qa-sellfy
    https://sbox.sellfie.me/product/xxxxx       ----> /var/www/sbox-sellfy
    
    # PROFILE URLS
    https://stg-profile.sellfie.me/profile-name       ----> /var/www/stg-sellfie-front-end-sellfie-buyer/
    https://qa-profile.sellfie.me/profile-name        ----> /var/www/qa-sellfie-front-end-sellfie-buyer/
    https://sbox-profile.sellfie.me/profile-name      ----> /var/www/sbox-sellfie-front-end-sellfie-buyer/
    
    
    # WEB APP
    https://stg-app.sellfie.com
    https://qa-app.sellfie.com
    https://sbox-app.sellfie.com



-----

### Server Installation Guide


#### GIT
    https://git-scm.com/book/en/v2/Getting-Started-Installing-Git
#### Node
    sudo yum update
    sudo yum install epel-release
    sudo yum install nodejs
    node --version
    sudo yum install npm

    --- OR ----

    sudo wget https://nodejs.org/dist/latest/node-v7.2.0.tar.gz
    sudo tar xzvf node-v* && cd node-v*
    sudo yum install gcc gcc-c++
    sudo ./configure
    sudo make
    sudo make install
    node --version



#### MySQL 

      sudo yum install mariadb-server mariadb
      sudo systemctl start mariadb
      sudo systemctl status mariadb
      sudo mysql_secure_installation
      
      
