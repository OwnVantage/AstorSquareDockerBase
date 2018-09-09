# Use an official Python runtime as a parent image
FROM centos:latest
#node:4.3.2
#FROM python:2.7-slim
ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

# Set the working directory to /app
WORKDIR /var
ADD requirements.txt /var

RUN yum -y update
RUN yum -y install python-setuptools python-dev build-essential
RUN yum -y install epel-release
RUN yum -y install python-pip
RUN pip install --upgrade pip
RUN yum -y install httpd httpd-tools

RUN yum -y install npm
# Install any needed packages specified in requirements.txt
RUN pip install --trusted-host pypi.python.org -r requirements.txt

# Define environment variable
ENV NAME World


