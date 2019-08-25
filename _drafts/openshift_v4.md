# Openshift

## Authenticate etc...
oc login --server=https://api.us-east-1.online-starter.openshift.com:6443
oc status
oc project fun

## Source-to-image
[Source-to-Image (S2I) build](https://docs.openshift.com/container-platform/4.1/builds/build-strategies.html#build-strategy-s2i_build-strategies)

[Getting started with Java S2I](https://developers.redhat.com/blog/2017/02/23/getting-started-with-openshift-java-s2i/)

oc new-app --image-stream=java:11 --code=https://github.com/timvw/oc-jvm.git

## Manual toying around...

oc create -f https://gist.githubusercontent.com/tqvarnst/3ca512b01b7b7c1a1da0532939350e23/raw/3869a54c7dd960965f0e66907cdc3eba6d160cad/openjdk-s2i-imagestream.json

oc get templates -n openshift

oc new-app \
    -e JENKINS_PASSWORD=password \
    openshift/jenkins-2-centos7

oc expose svc/jenkins-2-centos7

-> Edit route to expose port 8080-tcp instead of 53-tcp


oc new-app jenkins-ephemeral
oc create -f ./nodejs-sample-pipeline.yaml

oc new-app https://github.com/sclorg/nodejs-ex -l name=myapp

oc delete all --all


https://docs.openshift.com/container-platform/3.4/using_images/other_images/jenkins.html#jenkins-creating-jenkins-service-from-template