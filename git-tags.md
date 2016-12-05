### GIT Installation v2.0 for centos [min-requirement]
    http://tecadmin.net/install-git-2-0-on-centos-rhel-fedora/#

### Create Tag
    git tag -a TagV1.0.1 -m "env update"
    git push --follow-tags

        
### Delete Tags [Local | Remote]    
    # Fetch remote tags.
    git fetch
    # Delete remote tags.
    git ls-remote --tags origin | awk '/^(.*)(s+)(.*[a-zA-Z0-9])$/ {print ":" $2}' | xargs git push origin
    # Delete local tasg.
    git tag -l | xargs git tag -d
    
    
