FROM jenkins/jenkins:lts-centos7

USER 0

RUN yum -y install docker git && yum clean all && rm -rf /var/cache/yum

ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

COPY default-user.groovy /usr/share/jenkins/ref/init.groovy.d/

RUN /usr/local/bin/install-plugins.sh matrix-auth credentials-binding
