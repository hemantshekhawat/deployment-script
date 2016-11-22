## SSH Config for Deployment Keys
    ~/.ssh/config for multiple SSH Keys


### Create SSH Keys for GITHUB Deploy Keys
     ssh-keygen -t rsa -b 4096 -C "hemant.singh@payu.in"
        --Give name as "id_rsa.$APP_NAME"

### Permisisons
    sudo chown -R $USER:$USER $HOME/.ssh
    sudo chmod -R 700 $HOME/.ssh
    sudo chmod 0600 ~/.ssh/*
    sudo chown -v $USER ~/.ssh/known_hosts

### Add the SSH Private keys to the cached data
     ssh-add ~/.ssh/id_rsa.sellfie-admin
     ssh-add ~/.ssh/id_rsa.sellfie-api
     ssh-add ~/.ssh/id_rsa.sellfie-frontend
     ssh-add ~/.ssh/id_rsa.sellfie-static-site
     ssh-add ~/.ssh/id_rsa
     ssh-add -l


#### create the file if missing and add the entries
    ~/.ssh/config 

#Content

    Host github.com-sellfie-admin
    HostName github.com
     IdentityFile ~/.ssh/id_rsa.sellfie-admin
     IdentitiesOnly yes
     
    Host github.com-sellfy
     HostName github.com
      IdentityFile ~/.ssh/id_rsa.sellfie-api
      IdentitiesOnly yes
    
    Host github.com-sellfie-front-end
     HostName github.com
      IdentityFile ~/.ssh/id_rsa.sellfie-frontend
      IdentitiesOnly yes


