todolist-db
============

Ensure todo list db is configured

Requirements
------------

None

Role Variables
--------------
* db_host: localhost
* db_name: tododb
* db_user: username
* db_password: password
* db_admin_user: root
* db_admin_password: changeme

Dependencies
------------

* MySQL server must be available 

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - role: todolist-db

License
-------

BSD / MIT

Author Information
------------------

Mike Scott

NTT Data
