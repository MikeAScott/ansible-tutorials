Get Dist from S3
=========
Gets an application distributable (war) from and S3 bucket andf copies to dist folder

Requirements
------------

None

Role Variables
--------------

* app_dist_bucket: 'com-nttdata-ta-demo'
* app_package: todo
* app_version: '0.0.1-SNAPSHOT'

Dependencies
------------

none

Example Playbook
----------------

    - hosts: servers
      roles:
         - { role: get-dist-from-s3 }

License
-------

BSD
