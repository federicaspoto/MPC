# How to use Fortran with Dockers

#Build the basic container 
FROM ubuntu:18.04
MAINTAINER Federica Spoto @ MPC <federica.spoto@cfa.harvard.edu>

#Update 
RUN apt-get -y update
 
#Install gfortran
RUN apt-get install -y gfortran 
#Install make
RUN apt-get install -y make
#Install git
RUN apt-get install -y git

#Create the /sa/ directory (to replicate what we have in marsden)
RUN mkdir sa/
#COPY god_fit files
ADD . /sa/god_fit

#Change directory
WORKDIR /sa/god_fit/

#Config and make
RUN ./config -O gfortran
RUN make && cd src/ && make nondistribution
#Link ephemeris
RUN cd ../ && ln -s /sa/god_fit/ast_files/jpleph.431 /sa/god_fit/lib/jpleph

