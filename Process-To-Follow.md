### Process To Follow for making a release
- Add the changes to the repo from local machine to DEV branch
    
        git add <changes/to/files>
        git commit -m "Comment for the changes; keep it brief and self explanatory"
        git push origin dev
        
- Add a minor-change TAG to the commit
        
        git tag -a TagV1.0.1 -m "tag description"
        git push --follow-tags
    
    ### TAG Nomenclature  
    ####  3 types of tags
    #####- Top Level Tag
    #####- Middle Level Tag
    #####- Minor-Change Tag
        
        Tag Name = TagVX.Y.Z
        
            X : - Top level versions number of the repository
                - change in this represents a substantial change of code structure and calls for a major change in consumption of code 
                -  Ex:
                        1. TagV1.0.0
                        2. TagV2.0.0
            
            Y : - Middle level Tag version
                - Normally used for addition of new features/ major bug fixes,etc.
                -  Ex:
                        1. TagV1.1.0
                        2. TagV1.2.0
                 
            Z : - Minor-Change Tag version
                - regular bug fixes
                - smaller add-ons to the repository
                -  Ex:
                        1. TagV1.1.2
                        2. TagV1.1.3
- On the Staging Server, execute the command
    #### Arguments
         ${1} : branch Name
         ${2} : Tag Version
         ${3} : App name [ sellfie-admin,sellfy,sellfie-front-end ]
         ${4} : environment [ dev, qa, pre-prod, prod]
         ${3} : Sub App name [ sellfie-buyer,sellfie-webapp ]
    
    #### Command Structure 
        sh /home/ec2-user/deploy-my-website.sh {BRANCH-NAME} {TAG-NAME} {APP-NAME} {ENVIRONMENT} {SUB-APP-NAME}

- ### Example: 

    1.  ##### Sample Command from Host Server : 
            sh /home/ec2-user/deploy-my-website.sh dev TagV2.0.1 sellfie-admin dev
    2.  ##### Sample Command from Local Environment :
            ssh -i ~/Documents/keys/Sellfie/selfie_staging.pem ec2-user@52.76.202.101 "sh /home/ec2-user/deploy-my-website.sh dev TagV2.0.1 sellfie-admin dev"
        ------
            ssh -i !/path/to/ssh/private/key user@host "command to be executed; multiple commands can be separated by | "
    3.  ##### Deploy new commit to #Dev# environment
            
            sh /home/ec2-user/deploy-my-website.sh dev LATEST sellfie-admin dev

- ### TAG Exception
     #####  Only For "DEV" environment release 
 
     ###### Instead of creating a TAG every time, you can use "LATEST" in the shell command to execute and deploy the latest code commited in the repository.
        
        sh /home/ec2-user/deploy-my-website.sh dev LATEST sellfie-admin dev
