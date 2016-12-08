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

if [ $# -eq 0 ]
  then
    printf "\nNo arguments supplied: \n\n Exiting..."
    exit 1
fi
if [ -z "$1" ]
  then
    printf "\nNo Branch Name given: Argument[1] \n\n Exiting... "
    exit 1
fi
if [ -z "$2" ]
  then
    printf "\nNo Tag Version given: Argument[2] \n\n Exiting... "
    exit 1
fi

if [ -z "$3" ]
  then
  	   printf "\nMissing  App name : Argument[3] \n\n"
     	 printf "\nPlease Select one of the following and try again
       1. sellfie-admin
       2. sellfy
       3. sellfie-front-end

       ... Exiting... \n\n"
       exit 1
fi

case "$3" in
  "sellfie-admin")
  ;;
  "sellfie-front-end")
      if [ -z "$5" ]
        then
              printf "\nFrom the Front-End Project, please enter one of the below as 5th Argument"
              printf "\n\n"
              printf "1. sellfie-buyer\n"
              printf "2. sellfie-webapp\n"

              printf "\n\n Exiting...\n\n"
              exit 1

        else
          case "$5" in
              "sellfie-buyer")
                  printf "\nSellfie Front End Buyer App Selected for deployment"
                  SUB_APP_NAME="${5}"
                  ;;
              "sellfie-webapp")
                  printf "\nSellfie Front End Web App Selected for deployment"
                  SUB_APP_NAME="${5}"
                  ;;
              *)
                  printf "\nFrom the Front-End Project, please enter on of the below as 5th Argument"
                  printf "\n\n"
                  printf "1. sellfie-buyer\n"
                  printf "2. sellfie-webapp\n"

                  printf "\n\n Exiting...\n\n"
                  exit 1
                  ;;
          esac
      fi
      ;;
  "sellfy")
      ;;
  *)
      printf "\n\nInvalid option for App name : Argument[3] \n\n"
      printf "\n\nPlease Select one of the following and try again
      1. sellfie-admin
      2. sellfy
      3. sellfie-front-end

      ... Exiting... \n\n"
      exit 1
esac

if [ -z "$4" ]
  then
    printf "\n\nNo Environment selected for the execution : Argument[4] \n\n Please Select one of
    1. dev
    2. qa
    3. pre-prod
    4. prod

    You have not select one of the above options.

    ... Exiting... "
    exit 1
fi


if [ "$2" = LATEST ] && [ "$4" != dev ]
then
  #statements
  printf "\n\nLATEST Code can only be deployed to DEV server; \n\n For other environments, please use TAGs ...\n\n"
  exit 1

fi

case "$4" in
dev)
      printf "\n\nSelected environment is Development"
	    ENV=".env.dev"
	    ;;
qa)
      printf "\n\nSelected environment is QA"
	    ENV=".env.qa"
	    ;;
pre-prod)
      printf "\n\nSelected environment is Pre-Production"
	    ENV=".env.pre-prod"
	    ;;
prod)
      printf "\n\nSelected environment is Production"
	    ENV=".env.prod"
	    ;;
*)
      printf "Invalid option : Argument[4] \n\n"
      printf "\n\nNo Environment selected for the execution. Please Select one of
        1. dev
        2. qa
        3. pre-prod
        4. prod

        You have not select one of the above options.

        ... Exiting... "
      exit 1
      ;;
esac

ENVIRONMENT="${4}"
BRANCH_NAME="${1}"
TAG_VERSION="${2}"
APP_NAME="${3}"

RIGHT_NOW=$(date +"%Y%m%d-%H%M%S")"$APP_NAME--Tag-version-$TAG_VERSION"


if [ -z "$5" ]
then
  REPO_CHECKOUT_PATH="$HOME/Sellfie/Release/$APP_NAME/$RIGHT_NOW"
else
  REPO_CHECKOUT_PATH="$HOME/Sellfie/Release/$APP_NAME/$SUB_APP_NAME/$RIGHT_NOW"
fi

GIT_ROOT_DIR="$HOME/Sellfie/RepoCheckout/"
ROOT_DIR="$GIT_ROOT_DIR$APP_NAME"
VIRTUAL_HOST_DIR="/var/www/"

GIT_REPO_LINK="git@github.com-$APP_NAME:citruspay/$APP_NAME.git"

# creating the REPO_CHECKOUT_PATH directories
printf "\n\nCreating directory $REPO_CHECKOUT_PATH\n\n"
sudo mkdir -p $REPO_CHECKOUT_PATH
sudo mkdir -p $VIRTUAL_HOST_DIR
sudo mkdir -p $GIT_ROOT_DIR

sudo chmod -R 777 $HOME/Sellfie
sudo chown -R $USER:$USER $HOME/Sellfie
sudo chmod -R 700 $HOME/.ssh
sudo chmod 0600 ~/.ssh/*
sudo chown -v $USER ~/.ssh/known_hosts

printf "\n\nRoot Directory: $ROOT_DIR\n\n"

if [[ ! -d $ROOT_DIR ]]; then
  printf "\nGIT Repo not cloned. Clonning now... \n\n"
  #sudo mkdir -p $ROOT_DIR
  sudo chmod -R 777 $HOME/Sellfie/
  # ssh-agent bash -c 'ssh-add $HOME/.ssh/id_rsa.$APP_NAME;'
  git clone $GIT_REPO_LINK $ROOT_DIR
elif [[ ! -d $ROOT_DIR/.git ]]; then
  printf "\nGIT Repo not cloned. Clonning now... \n\n GIT init in progress\n\n"
  sudo mkdir -p $ROOT_DIR
  sudo chmod -R 777 $HOME/Sellfie/
  cd $ROOT_DIR
  # ssh-agent bash -c 'ssh-add $HOME/.ssh/id_rsa.$APP_NAME;'
  git init
  git remote set-url origin $GIT_REPO_LINK
  git pull origin master
fi

cd $ROOT_DIR
# 1. GIT pull for latest updates
git reset --hard HEAD
git checkout  $BRANCH_NAME
git pull origin $BRANCH_NAME
git fetch --prune --tags
# Check if the tag exists
# 	if GIT_DIR=$HOME/$APP_NAME/.git git rev-parse $TAG_VERSION >/dev/null 2>&1


if [[ $TAG_VERSION -eq 'LATEST' ]];
  then
    printf "Checking out Latest Code into 'release' branch ...\n"
    git checkout  -B release
else

    printf "\n\nLast 3 tags ...\n"
    git tag | sort -n | tail -3
    	if GIT_DIR=$ROOT_DIR/.git git rev-parse $TAG_VERSION >/dev/null 2>&1
    	then
        	printf "\nFound tag $TAG_VERSION\n\n"
    	else
    	    printf "\n${2} Tag not found. \n\nExiting..."
    	    exit 1
    	fi

    printf "Checking out ${TAG_VERION} into 'release branch' ...\n"
    git checkout tags/$TAG_VERSION -B release
fi


##############################################################
##############################################################
case "$APP_NAME" in
sellfie-admin)

        sudo rm -rf composer.lock
        sudo chmod -R 777 composer.json
        composer update --no-scripts
        printf "Composer Updated successfully\n\n"
        # Creating necessary directory for the project
        printf "Creating necessary directories \n\n"
        sudo mkdir -p {bootstrap/cache,storage/logs,storage/framework/{cache,sessions,temp,views}}
        # Setting folder permissions
        printf "Setting permissions \n\n"
        sudo chmod -R 777 storage resources public vendor bootstrap
        cd $ROOT_DIR

        printf "$APP_NAME files for vendor  will be copied...\n\n"
        sudo cp -r production_cp_files/EloquentUser.php vendor/cartalyst/sentinel/src/Users/EloquentUser.php
        # 2. export/checkout the repo files to $REPO_CHECKOUT_PATH
        # git archive --format=tar --prefix=$REPO_CHECKOUT_PATH/ $TAG_VERSION | (cd / && tar xf -)
        # 2. [Optional] Copy all the files to $REPO_CHECKOUT_PATH using rsync
        # rsync -azh --exclude '.git*' $ROOT_DIR $REPO_CHECKOUT_PATH/
        sudo rsync -azh $ROOT_DIR/* $REPO_CHECKOUT_PATH/
        sudo cp -r $ROOT_DIR/.en* $REPO_CHECKOUT_PATH/
        # 3. Change directory to newly exported directory $REPO_CHECKOUT_PATH
        printf "Changing directory to exported file location ...\n"
        cd $REPO_CHECKOUT_PATH
        # 5. overwriting the existing env with $ENV
        printf "Writing .env() file : $ENV ...\n"
        sudo rm -rf .env
        sudo rsync -azh "$REPO_CHECKOUT_PATH/$ENV" "$REPO_CHECKOUT_PATH/.env"
        # Setting folder permissions
        printf "\n\nSetting permissions \n"
        sudo chmod -R 777 storage/ resources/ public/ vendor/ bootstrap/
        composer dump-autoload
        php artisan cache:clear
        php artisan config:clear
        php artisan view:clear
        #  Clear Configuration of Laravel


        sudo chown -R $USER:$USER .
        sudo chmod -R g+rw .

        cd $VIRTUAL_HOST_DIR
        sudo rm -rf $ENVIRONMENT-$APP_NAME
        sudo ln -s $REPO_CHECKOUT_PATH $VIRTUAL_HOST_DIR$ENVIRONMENT-$APP_NAME

        ########################################################################
        ;;
sellfy)

        sudo rm -rf composer.lock
        sudo chmod -R 777 composer.json
        composer update --no-scripts
        printf "Composer Updated successfully\n\n"
        # Creating necessary directory for the project
        printf "Creating necessary directories \n\n"
        sudo mkdir -p {bootstrap/cache,storage/logs,storage/framework/{cache,sessions,temp,views}}
        # Setting folder permissions
        printf "Setting permissions \n\n"
        sudo chmod -R 777 storage resources public vendor bootstrap
        cd $ROOT_DIR

        printf "$APP_NAME files for vendor  will be copied...\n\n"
        sudo cp production_cp_files/ArraySerializer.php vendor/league/fractal/src/Serializer/ArraySerializer.php
        sudo cp production_cp_files/ResponseLoggerMiddleware.php vendor/prettus/laravel-request-logger/src/Prettus/RequestLogger/Middlewares/ResponseLoggerMiddleware.php
        sudo cp production_cp_files/ResponseLogger.php vendor/prettus/laravel-request-logger/src/Prettus/RequestLogger/ResponseLogger.php
        sudo cp production_cp_files/RequestInterpolation.php vendor/prettus/laravel-request-logger/src/Prettus/RequestLogger/Helpers/RequestInterpolation.php
        sudo cp production_cp_files/RequestCriteria.php vendor/prettus/l5-repository/src/Prettus/Repository/Criteria/RequestCriteria.php
        sudo cp production_cp_files/EloquentUser.php vendor/cartalyst/sentinel/src/Users/EloquentUser.php

        # 2. export/checkout the repo files to $REPO_CHECKOUT_PATH
        # git archive --format=tar --prefix=$REPO_CHECKOUT_PATH/ $TAG_VERSION | (cd / && tar xf -)
        # 2. [Optional] Copy all the files to $REPO_CHECKOUT_PATH using rsync
        # rsync -azh --exclude '.git*' $ROOT_DIR $REPO_CHECKOUT_PATH/
        sudo rsync -azh $ROOT_DIR/* $REPO_CHECKOUT_PATH/
        sudo cp -r $ROOT_DIR/.en* $REPO_CHECKOUT_PATH/
        # 3. Change directory to newly exported directory $REPO_CHECKOUT_PATH
        printf "Changing directory to exported file location ...\n"
        cd $REPO_CHECKOUT_PATH
        # 5. overwriting the existing env with $ENV
        printf "Writing .env() file : $ENV ...\n"
        sudo rm -rf .env
        sudo rsync -azh "$REPO_CHECKOUT_PATH/$ENV" "$REPO_CHECKOUT_PATH/.env"
        # Setting folder permissions
        printf "\n\nSetting permissions \n"
        sudo chmod -R 777 storage/ resources/ public/ vendor/ bootstrap/
        php artisan migrate
        composer dump-autoload
        php artisan cache:clear
        php artisan config:clear
        php artisan view:clear
        #  Clear Configuration of Laravel

        sudo chown -R $USER:$USER .
        sudo chmod -R g+rw .

        cd $VIRTUAL_HOST_DIR
        sudo rm -rf $ENVIRONMENT-$APP_NAME
        sudo ln -s $REPO_CHECKOUT_PATH $VIRTUAL_HOST_DIR$ENVIRONMENT-$APP_NAME



        ########################################################################
        ;;
sellfie-front-end)
        printf "$APP_NAME  build in progress\n\n"
        cd $ROOT_DIR
        cd $SUB_APP_NAME

        printf "\n ---- Cache Clean"
        npm cache clean
        printf "\n ---- Removed Node Modules\n\n"
        rm -rf node_modules
#        printf "\n ---- Installing gulp globally\n\n"
#        npm install -g gulp
        printf "\n ---- Installing gulp locally\n\n"
        npm install gulp
        # sudo npm install process
        printf "\n ---- NPM Install begins.. \n\n"
        npm install
        npm install gulp-util --save-dev
        printf "\n ---- Setting Permissions.. \n\n"
        chown -R $USER: node_modules
        printf "\n ---- Executing Gulp build with environment=$ENVIRONMENT .. \n\n"
        gulp build --env=$ENVIRONMENT

        ls -la $ROOT_DIR/$SUB_APP_NAME/dist/

        printf "\n\n Build Completed. Copying the distribution to release directory.. \n\n"
        sudo rsync -azh $ROOT_DIR/$SUB_APP_NAME/dist/* $REPO_CHECKOUT_PATH/
        cd $REPO_CHECKOUT_PATH

        sudo chown -R $USER:$USER .
        sudo chmod -R g+rw .

        cd $VIRTUAL_HOST_DIR
        sudo rm -rf $ENVIRONMENT-$APP_NAME-$SUB_APP_NAME
        sudo ln -s $REPO_CHECKOUT_PATH $VIRTUAL_HOST_DIR$ENVIRONMENT-$APP_NAME-$SUB_APP_NAME



        ########################################################################
        ;;
*)
        printf "Invalid option for App name : Argument[3]"
      	printf "Option provided: $APP_NAME"
        printf "Please Select one of the following and try again
          1. sellfie-admin
          2. sellfy
          3. sellfie-front-end

          ... Exiting... \n\n"
          exit 1
        ;;
esac

sudo usermod -a -G $USER apache
sudo usermod -a -G apache $USER
sudo chmod -R o+x $REPO_CHECKOUT_PATH
sudo chmod -R o+x $VIRTUAL_HOST_DIR
sudo chmod -R g+x $REPO_CHECKOUT_PATH $GIT_ROOT_DIR

sudo chown -R $USER:apache $HOME  $VIRTUAL_HOST_DIR $REPO_CHECKOUT_PATH


printf "\n\nThe new symbolic link has been associated with the Virtual Host Directory"

printf "\n\n Please make sure the virtual Host configuration points to $VIRTUAL_HOST_DIR$ENVIRONMENT-$APP_NAME\n"

ls -la $VIRTUAL_HOST_DIR$ENVIRONMENT-$APP_NAME*

printf "\n\n********************************************************************************"
printf "\n\n Awesome ! We are done here\n\n"
printf "********************************************************************************\n\n"




