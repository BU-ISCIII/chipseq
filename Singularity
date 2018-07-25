Bootstrap: docker
From: centos:6.9

%help
	This is a container using Centos:6.9 base image from DockerHub. It includes software needed for Chipseq-nf pipeline(https://github.com/BU-ISCIII/chipseq-nf).

%labels
	Maintainer BU-ISCIII
	Author S.Monzon
	Date 25/07/2018
	Version 1.0

%post
	echo "Installing container-wide requirements gcc,pip, zlib, libssl, make, libncurses, fortran77, g++, R"
	echo "Install Development Tools"
	yum -y groupinstall "Development Tools"

	yum -y update && yum -y install wget

	echo "Install repel repository"
	wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm && \
	rpm -ivh epel-release-6-8.noarch.rpm && \
	rm epel-release-6-8.noarch.rpm

	echo "Install gawk and devel libraries needed"
	yum -y install gawk \
				boost \
				boost-devel \
				bzip2 \
				bzip2-libs \
				bzip2-devel \
				libcurl \
				libcurl-devel \
				perl-DBD-MySQL \
				libdbi-dbd-mysql \
				python-devel \
				make \
				gsl \
				gsl-devel \
				xz \
				xz-libs \
				xz-devel \
				ncurses \
				ncurses-libs \
				ncurses-devel \
				pcre2 \
				pcre2-devel \
				readline \
				readline-devel \
				openssl \
				openssl-devel \
				libxml2 \
				libxml2-devel \
				zlib \
				zlib-Development

	echo "Install python3.4 and pip3.4"
	yum -y install python34 python34-devel python34-setuptools
	easy-install-3.4 pip

	echo "Install FastQC"
	FASTQC_BIN="fastqc_v0.11.5.zip"

	curl -fsSL http://www.bioinformatics.babraham.ac.uk/projects/fastqc/$FASTQC_BIN -o /opt/$FASTQC_BIN && \
	unzip /opt/$FASTQC_BIN -d /opt/ && \
	chmod 755 /opt/FastQC/fastqc && \
	rm /opt/$FASTQC_BIN

	echo "export PATH=$PATH:/opt/FastQC/fastqc" >> $SINGULARITY_ENVIRONMENT

