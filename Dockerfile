FROM jenkins/jenkins:latest

USER root

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - \ 
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list \
    && apt-get install yarn

USER jenkins

COPY --from=docker /usr/local/bin/docker /usr/local/bin/docker

ENV CASC_JENKINS_CONFIG=https://raw.githubusercontent.com/cmelgreen/JenkinsConfigAsCode/master/config.yml
ENV JAVA_OPTS "-Djenkins.install.runSetupWizard=false ${JAVA_OPTS:-}"


RUN /usr/local/bin/install-plugins.sh configuration-as-code git workflow-aggregator docker-plugin docker-workflow nodejs