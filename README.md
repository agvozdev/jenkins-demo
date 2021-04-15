# Built-in Registry/Jenkins Demo

This repo contains scripts to run Jenkins and docker registry from docker-compose file along with one pre-defined job which builds docker images and pushes them to embedded registry



## Prerequisites

1. Centos 7 machine (any modern distribution should be relevant)
2. Docker
3. bash
4. default gateway to internet - all dependencies are downloaded from default internet repos



## Deployment and Directory Structure

Startup procedure builds and fires up containers with Jenkins and docker registry, which both save their persistent data in the working directory of start-up script (demo.sh) under 'work' directory. See directory tree with explanation below.



```
.
├── cleanup.sh					# Cleanup script, may be run anytime
├── demo.sh						# Run this to initiate demo
├── docker-compose.yml			# Docker-compose file used by demo.sh
└── jenkins
    ├── default-user.groovy		# admin registration script for Jenkins
    ├── jenkins.Dockerfile		# Custom Jenkins Dockerfile
    └── jobs
        └── docker-builder
            └── config.xml		# Jenkins job config for docker builds

```







## Startup, Usage and Cleanup

Ensure that docker and bash are available on your centos machine, you are a superuser and then - fire up `demo.sh` This will drop some auxiliary text with instructions and build and run Jenkins and registry. Follow the link provided in the script output and go through one of cases provided below.

Output should look like this:

```
[root@box jenkins-demo]# ./demo.sh
Starting up docker, docker registry and triggering default build job
Creating network "jenkinsdemo_default" with the default driver
Creating registry ... done
Creating registry ...
Will wait for Jenkins to appear at http://admin:admin@192.168.153.193:8081/job/docker-builder
Waiting for Jenkins to become available
Waiting for Jenkins to become available
Jenkins running
Go to http://admin:admin@192.168.153.193:8081/job/docker-builder and build the job, you may leave all parameters intact by default
You may terminate this demo with Ctrl+C, otherwise try to send this to foreground, if you know how ahahaha!
```

Upon hitting Ctrl+C cleanup script will be fired. If you don't want that, you should start this demo with `docker-compose up`  - and using `cleanup.sh` afterwards. Cleanup script deletes all Jenkins working files and registry data files.

To delete working files aside from using `demo.sh` just run `cleanup.sh`. 



## Cases

### Pre-defined Dockerfile build

Use docker-builder job with CUSTOM_DOCKERFILE parameter to build custom docker image and push it accordingly. This was proven to work.

### Build from remote GIT-based context and custom Dockerfile name

Use docker-builder job with CUSTOM_GIT_SOURCE and CUSTOM_DOCKER_BUILD_CONTEXT_PATH. This case was not checked.



## Parameters

| Parameter              | Explanation                                                  |
| ---------------------- | ------------------------------------------------------------ |
| CUSTOM_GIT_SOURCE      | Git repository to fetch docker build context from. Should be anonymously pullable. Alternative to CUSTOM_DOCKERFILE |
| CUSTOM_DOCKERFILE_NAME | Use in conjunction with CUSTOM_GIT_SOURCE in case if Dockerfile has non-default name |
| CUSTOM_DOCKERFILE      | Text of Dockerfile to build. Alternative to CUSTOM_GIT_SOURCE |
| CUSTOM_IMAGE_TAG       | Destination docker image tag - where to push.                |


