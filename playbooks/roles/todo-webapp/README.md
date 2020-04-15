ToDo Web App
=========
Installs todo web app on tomcat server

Requirements
------------

None

Role Variables
--------------

* db_host: localhost
* db_user: username
* db_password: password
* app_package: todo
* app_version: '0.0.1-SNAPSHOT'
* tomcat_home: '/usr/share/tomcat/' 

Dependencies
------------

* tomcat-server

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: todo-webapp }

License
-------

BSD
