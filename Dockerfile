FROM jenkins/jenkins:latest

USER root

RUN curl https://deb.nodesource.com/setup_14.x | bash && apt-get install nodejs && npm install -g react react-scripts react-dom

USER jenkins

COPY --from=docker /usr/local/bin/docker /usr/local/bin/docker

ENV CASC_JENKINS_CONFIG=https://raw.githubusercontent.com/cmelgreen/JenkinsConfigAsCode/master/config.yml
ENV JAVA_OPTS "-Djenkins.install.runSetupWizard=false ${JAVA_OPTS:-}"



RUN /usr/local/bin/install-plugins.sh configuration-as-code git workflow-aggregator docker-plugin docker-workflow nodejs