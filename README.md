Role Name
=========
The following ansible role will deploy a Prometheus node_exporter agent on a remote host. 

Requirements
------------
The role was created to support node_exporter on RHEL 6 and RHEL 7 deployments. Its possible that it will work on other distributions, but this has not been validated for support.

Role Variables
--------------
defaults/main.yml
- NE_REPO is the remote directory where the node_exporter tarball will be deployed
- NE_TARBALL is the file name of the node_exporter tarball
- NE_FINAL_HOME is the renamed node_exporter directory where the final deployment will reside
- NE_URL is the endpoint where node_exporter will listen. Use for service validation at the end of the deployment.

Dependencies
------------
- None

Testing
-------
- Testing assumes that docker is available (tested with version 17.12.0-ce)
- To test the role:
```$ docker run --rm -it -w /workspace -v $(pwd):/workspace inhumantsar/ansible:centos7```
- To troubleshoot the role:
```$ docker run --rm -it -w /workspace -v $(pwd):/workspace inhumantsar/ansible:centos7 /bin/bash```


Example Playbook
----------------
site.yml:
```
---
- hosts: all
  become: yes
  roles:
    - ansible-role-nodeexporter
```

License
-------

BSD

Author Information
------------------
Greg Horie <greg.horie@telus.com>
