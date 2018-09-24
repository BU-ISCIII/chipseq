Bootstrap: docker
From: centos:latest

%files
	./scif_app_recipes/* /opt/
%post
	echo "Install basic development tools"
	yum -y groupinstall "Development Tools"
	yum -y update && yum -y install wget curl

	echo "Install python2.7 setuptools and pip"
	yum -y install python-setuptools
	easy_install pip

	echo "Installing SCI-F"
    pip install scif

    echo "Installing plasmidID app"
	echo "Install basic development tools" && \
    yum -y groupinstall "Development Tools" && \
    yum -y update && yum -y install wget curl && \
    echo "Install python2.7 setuptools and pip" && \
    yum -y install python-setuptools && \
    easy_install pip && \
    echo "Installing SCI-F" && \
    pip install scif ipython && \
    echo "Installing fastQC app" && \
    scif install /opt/fastqc_v0.11.7_centos7.scif && \
    echo "Installing Trimgalore app" && \
    scif install /opt/trimgalore_v0.4.5_centos7.scif && \
    echo "Installing bwa app" && \
    scif install /opt/bwa_v0.7.17_centos7.scif && \
    echo "Installing cutadapt app" && \
    scif install /opt/cutadapt_v1.16_centos7.scif && \
    echo "Installing samtools app" && \
    scif install /opt/samtools_v1.9_centos7.scif && \
    echo "Installing picard app" && \
    scif install /opt/picard_v2.0.1_centos7.scif && \
    echo "Installing bedtools app" && \
    scif install /opt/bedtools_v2.27_centos7.scif && \
    echo "Installing R app" && \
    scif install /opt/R_v3.5.1_centos7.scif && \
    echo "Installing SPP app"
    scif install /opt/spp_v1.15_centos7.scif && \
    echo "Installing phantompeakqualtools app" && \
    scif install /opt/phantompeakqualtools_v1.1_centos7.scif && \
    echo "Installing deeptools app" && \
    scif install /opt/deeptools_v2.5.4_centos7.scif && \
    echo "Installing ngsplot app" && \
    scif install /opt/ngsplot_v2.63_centos7.scif && \
    echo "Installing macs app"
    scif install /opt/macs_v2.1.1.20160309_centos7.scif
    echo "Installing epic app"
    scif install /opt/epic_v0.2.9_centos7.scif
    echo "Installing multiqc app"
    scif install /opt/multiqc_v1.4_centos7.scif

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

    # Executables must be exported for nextflow, if you use their singularity native integration.
    # It would be cool to use $SCIF_APPBIN_bwa variable, but it must be set after PATH variable, because I tried to use it here and in %environment without success.
    find /scif/apps -maxdepth 2 -name "bin" | while read in; do echo "export PATH=\${PATH}:$in" >> $SINGULARITY_ENVIRONMENT;done

%runscript
    exec scif "$@"
