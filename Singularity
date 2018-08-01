Bootstrap: docker
From: centos:latest

%help
	This is a container using Centos:7 base image from DockerHub. It includes software needed for Chipseq-nf pipeline(https://github.com/BU-ISCIII/chipseq-nf).

%labels
	Maintainer BU-ISCIII
	Author S.Monzon
	Date 25/07/2018
	Version 1.0

%files
ngsplotdb_hg19_75_3.00.tar.gz /opt
ngsplotdb_mm10_75_3.00.tar.gz /opt
ngsplotdb_StrepPneumo1_40_3.00.tar.gz /opt

%environment

	FASTQC_VERSION="fastqc_v0.11.5.zip"
	TRIMGALORE_VERSION="0.4.5"
	BWA_VERSION="0.7.15"
	CUTADAPT_VERSION="1.16"
    SAMTOOLS_VERSION="1.6"
	PICARD_VERSION="2.0.1"
	BEDTOOLS_VERSION="2.26.0"
	R_VERSION="R-3.4.2"
	SPP_VERSION="1.15"
	PHANTOMPEAKQUALTOOLS_VERSION="v.1.1"
	DEEPTOOLS_VERSION="2.5.4"
	NGSPLOT_VERSION="2.63"
	MACS_VERSION="2.1.1.20160309"
	MUSIC_VERSION="github-master"
	EPIC_VERSION="0.2.9"
	MULTIQC_VERSION="1.4"

%post
	echo "Installing container-wide requirements gcc,pip, zlib, libssl, make, libncurses, fortran77, g++, R"
	echo "Install Development Tools"
	yum -y groupinstall "Development Tools"

	yum -y update && yum -y install wget curl

	echo "Install repel repository"
	wget http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
	rpm -ivh epel-release-latest-7.noarch.rpm && \
	rm epel-release-latest-7.noarch.rpm

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
				libX11 \
				libX11-devel \
				xorg-x11-server-Xvfb \
				mesa-libGL \
				mesa-libGL-devel \
				mesa-libGLU \
				mesa-libGLU-devel \
				freeglut \
				freeglut-devel \
				freetype-devel \
				libpng-devel \
				xorg-x11-server-devel \
				libXt-devel \
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
				cairo-devel \
				udunits2 \
				udunits2-devel \
				geos \
				geos-devel \
				mariadb-devel \
				libxml2-devel \
				libjpeg-turbo-devel \
				zlib \
				zlib-Development

	echo "Install python3.4 and pip3.4"
	yum -y install python34 python34-devel python34-setuptools
	easy_install-3.4 pip

	echo "Install python2.7 setuptools and pip. We will hava pip and python for v2.7 and pip3 and python3 for v3.4"
	yum -y install python-setuptools
	easy_install pip

	echo "Install java"
	yum -y install java-1.8.0-openjdk.x86_64

	echo "Install FastQC"
	FASTQC_VERSION="0.11.5"

	curl -fsSL http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v${FASTQC_VERSION}.zip -o /opt/fastqc_v${FASTQC_VERSION}.zip && \
	unzip /opt/fastqc_v${FASTQC_VERSION}.zip -d /opt/ && \
	chmod 755 /opt/FastQC/fastqc && \
	rm /opt/fastqc_v${FASTQC_VERSION}.zip
	echo 'export PATH=${PATH}:/opt/FastQC' >> $SINGULARITY_ENVIRONMENT
	export PATH=${PATH}:/opt/FastQC

	echo "Install cutadapt"
	CUTADAPT_VERSION="1.16"
	pip3 install cutadapt==${CUTADAPT_VERSION}

	# Install TrimGalore
	TRIMGALORE_VERSION="0.4.5"
	curl -fsSL https://github.com/FelixKrueger/TrimGalore/archive/${TRIMGALORE_VERSION}.tar.gz -o /opt/trimgalore_${TRIMGALORE_VERSION}.tar.gz && \
    tar xvzf /opt/trimgalore_${TRIMGALORE_VERSION}.tar.gz -C /opt/ && \
    rm /opt/trimgalore_${TRIMGALORE_VERSION}.tar.gz

	echo 'export PATH=${PATH}:/opt/trimgalore_${TRIMGALORE_VERSION}' >> $SINGULARITY_ENVIRONMENT
	export PATH=${PATH}:/opt/trimgalor_${TRIMGALORE_VERSION}

	echo "Install BWA"
	BWA_VERSION="0.7.15"

	curl -fsSL https://downloads.sourceforge.net/project/bio-bwa/bwa-${BWA_VERSION}.tar.bz2 -o /opt/bwa-${BWA_VERSION}.tar.bz2 && \
    tar xvjf /opt/bwa-${BWA_VERSION}.tar.bz2 -C /opt/ && \
    cd /opt/bwa-${BWA_VERSION};make;cd - && \
    rm /opt/bwa-${BWA_VERSION}.tar.bz2

    echo 'export PATH=${PATH}:/opt/bwa-${BWA_VERSION}' >> $SINGULARITY_ENVIRONMENT
	export PATH=${PATH}:/opt/bwa-${BWA_VERSION}

    echo "Install SAMTools"
    SAMTOOLS_VERSION="1.6"

	curl -fsSL https://github.com/samtools/samtools/releases/download/${SAMTOOLS_VERSION}/samtools-${SAMTOOLS_VERSION}.tar.bz2 -o /opt/samtools-${SAMTOOLS_VERSION}.tar.bz2 && \
    tar xvjf /opt/samtools-${SAMTOOLS_VERSION}.tar.bz2 -C /opt/ && \
    cd /opt/samtools-${SAMTOOLS_VERSION};make;cd - && \
    rm /opt/samtools-${SAMTOOLS_VERSION}.tar.bz2

    echo 'export PATH=${PATH}:/opt/samtools-${SAMTOOLS_VERSION}:/opt/samtools-${SAMTOOLS_VERSION}/bin' >> $SINGULARITY_ENVIRONMENT
	export PATH=${PATH}:/opt/samtools-${SAMTOOLS_VERSION}:/opt/samtools-${SAMTOOLS_VERSION}/bin

	# Install PicardTools
	echo "Install PicardTools"
	PICARD_VERSION="2.0.1"
	curl -fsSL https://github.com/broadinstitute/picard/releases/download/${PICARD_VERSION}/picard-tools-${PICARD_VERSION}.zip -o /opt/picard-tools-${PICARD_VERSION}.zip && \
	unzip /opt/picard-tools-${PICARD_VERSION}.zip -d /opt/ && \
	rm /opt/picard-tools-${PICARD_VERSION}.zip

	echo 'export PICARD_HOME=/opt/picard-tools-${PICARD_VERSION}' >> $SINGULARITY_ENVIRONMENT
	export PICARD_HOME=/opt/picard-tools-${PICARD_VERSION}

	# Install BEDTools
	echo "Install Bedtools"
	BEDTOOLS_VERSION="2.26.0"
	curl -fsSL https://github.com/arq5x/bedtools2/releases/download/v${BEDTOOLS_VERSION}/bedtools-${BEDTOOLS_VERSION}.tar.gz -o /opt/bedtools-${BEDTOOLS_VERSION}.tar.gz && \
	tar xvzf /opt/bedtools-${BEDTOOLS_VERSION}.tar.gz -C /opt/ && \
	cd /opt/bedtools2; make; cd - && \
	rm /opt/bedtools-${BEDTOOLS_VERSION}.tar.gz

	echo 'export PATH=${PATH}:/opt/bedtools2/bin' >> $SINGULARITY_ENVIRONMENT
	export PATH=${PATH}:/opt/bedtools2/bin

	# Install R
	echo "Install R and R packages"
	R_VERSION="R-3.4.2"
	curl -fsSL https://cran.r-project.org/src/base/R-3/${R_VERSION}.tar.gz -o /opt/${R_VERSION}.tar.gz && \
	tar xvzf /opt/${R_VERSION}.tar.gz -C /opt/ && \
	cd /opt/${R_VERSION};./configure;make;make install;cd - && \
	rm /opt/${R_VERSION}.tar.gz

	# Install core R dependencies
	echo "r <- getOption('repos'); r['CRAN'] <- 'https://ftp.acc.umu.se/mirror/CRAN/'; options(repos = r);" > ~/.Rprofile && \
	Rscript -e "install.packages('caTools',dependencies=TRUE)" && \
	Rscript -e "install.packages('snow',dependencies=TRUE)" && \
	Rscript -e "install.packages('doMC',dependencies=TRUE)" && \
	Rscript -e "install.packages('utils',dependencies=TRUE)" && \
	Rscript -e "install.packages('stringr',dependencies=TRUE)" && \
	Rscript -e "install.packages('markdown',dependencies=TRUE)" && \
	Rscript -e "install.packages('evaluate',dependencies=TRUE)" && \
	Rscript -e "install.packages('ggplot2',dependencies=TRUE)" && \
	Rscript -e "install.packages('knitr',dependencies=TRUE)" && \
	Rscript -e "install.packages('RMySQL',dependencies=TRUE)"

	# Install R Bioconductor packages
	echo 'source("https://bioconductor.org/biocLite.R")' > /opt/packages.r && \
	echo 'biocLite()' >> /opt/packages.r && \
	echo 'biocLite(c("BSgenome", "Rsamtools", "ShortRead", "GenomicRanges", "GenomicFeatures", "ensembldb", "ChIPpeakAnno", "biomaRt", "rtracklayer", "BSgenome.Hsapiens.UCSC.hg19", "org.Hs.eg.db", "BSgenome.Mmusculus.UCSC.mm10", "org.Mm.eg.db"))' >> /opt/packages.r && \
	Rscript /opt/packages.r

	# Install phantompeakqualtools
	echo "Install PHANTOMPEAKQUALTOOLS"
	SPP_VERSION="1.15"
	PHANTOMPEAKQUALTOOLS_VERSION="v.1.1"
	curl -fsSL https://github.com/hms-dbmi/spp/archive/${SPP_VERSION}.tar.gz -o /opt/SPP_${SPP_VERSION}.tar.gz && \
	Rscript -e "install.packages('/opt/SPP_${SPP_VERSION}.tar.gz',dependencies=TRUE)" && \
	rm /opt/SPP_${SPP_VERSION}.tar.gz && \
	curl -fsSL https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/phantompeakqualtools/ccQualityControl.${PHANTOMPEAKQUALTOOLS_VERSION}.tar.gz -o /opt/phantompeakqualtools.${PHANTOMPEAKQUALTOOLS_VERSION}.tar.gz && \
	tar xvzf /opt/phantompeakqualtools.${PHANTOMPEAKQUALTOOLS_VERSION}.tar.gz -C /opt/ && \
	rm /opt/phantompeakqualtools.${PHANTOMPEAKQUALTOOLS_VERSION}.tar.gz && \
	mkdir /opt/phantompeakqualtools/bin && \
	echo 'Rscript /opt/phantompeakqualtools/run_spp.R' > /opt/phantompeakqualtools/bin/run_spp.R && \
	chmod 755 /opt/phantompeakqualtools/bin/run_spp.R

	export PATH=${PATH}:/opt/phantompeakqualtools/bin
	echo 'export PATH=${PATH}:/opt/phantompeakqualtools/bin' >> $SINGULARITY_ENVIRONMENT

	# Install DeepTools
	echo "Install DeepTools"
	DEEPTOOLS_VERSION="2.5.4"
	pip3 install matplotlib numpydoc py2bit pyBigWig pysam scipy
	cd /opt && \
	git clone -b "${DEEPTOOLS_VERSION}" --single-branch --depth 1 https://github.com/deeptools/deepTools && \
	cd deepTools; python3 setup.py install; cd /

	# Install ngsplot
	echo "Install ngsplot"
	NGSPLOT_VERSION="2.63"
	curl -fsSL https://github.com/shenlab-sinai/ngsplot/archive/${NGSPLOT_VERSION}.tar.gz -o /opt/ngsplot_${NGSPLOT_VERSION}.tar.gz && \
	tar xvzf /opt/ngsplot_${NGSPLOT_VERSION}.tar.gz -C /opt/ && \
	rm /opt/ngsplot_${NGSPLOT_VERSION}.tar.gz

	export NGSPLOT=/opt/ngsplot-${NGSPLOT_VERSION}
	echo 'export NGSPLOT=/opt/ngsplot-${NGSPLOT_VERSION}' >> $SINGULARITY_ENVIRONMENT
	export PATH=${PATH}:/opt/ngsplot-${NGSPLOT_VERSION}/bin
	echo 'export PATH=${PATH}:/opt/ngsplot-${NGSPLOT_VERSION}/bin' >> $SINGULARITY_ENVIRONMENT

	echo "Install NGSPLOT databases"
	echo y | python /opt/ngsplot-${NGSPLOT_VERSION}/bin/ngsplotdb.py install /opt/ngsplotdb_mm10_75_3.00.tar.gz && \
	echo y | python /opt/ngsplot-${NGSPLOT_VERSION}/bin/ngsplotdb.py install /opt/ngsplotdb_hg19_75_3.00.tar.gz && \
	echo y | python /opt/ngsplot-${NGSPLOT_VERSION}/bin/ngsplotdb.py install /opt/ngsplotdb_StrepPneumo1_40_3.00.tar.gz && \
	rm /opt/ngsplotdb_hg19_75_3.00.tar.gz && \
	rm /opt/ngsplotdb_mm10_75_3.00.tar.gz && \
	rm /opt/ngsplotdb_StrepPneumo1_40_3.00.tar.gz

	# Install MACS
	echo "Install MACS peak caller"
	MACS_VERSION="2.1.1.20160309"
	pip install Numpy
	pip install MACS2==${MACS_VERSION}

	# Install MUSIC
	echo "Install MUSIC peak caller"
	curl -fsSL https://github.com/gersteinlab/MUSIC/archive/master.zip -o /opt/MUSIC.zip && \
	unzip /opt/MUSIC.zip -d /opt/; rm /opt/MUSIC.zip; cd /opt/MUSIC-master && \
	make clean;make;cd -

	echo 'export PATH=${PATH}:/opt/MUSIC-master/bin' >> $SINGULARITY_ENVIRONMENT
	export PATH=${PATH}:/opt/MUSIC-master/bin

	# Install epic
	echo "Install epic peak caller"
	EPIC_VERSION="0.2.9"
	pip3 install bioepic==${EPIC_VERSION}

	# Install MultiQC
	echo "Install MultiQC"
	MULTIQC_VERSION="1.4"
	pip3 install multiqc==${MULTIQC_VERSION}
