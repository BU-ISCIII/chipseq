#!/usr/bin/env bash

script_path="../main.nf"

if [ -z $1 ]
then
    echo "No argument given, going to try to run $script_path"
else
    script_path=$1
fi

data_path="./test_data"

curl --version >/dev/null 2>&1 || { echo >&2 "I require curl, but it's not installed. Aborting."; exit 1; }
tar --version >/dev/null 2>&1 || { echo >&2 "I require tar, but it's not installed. Aborting."; exit 1; }
docker -v >/dev/null 2>&1 || { echo >&2 "I require docker, but it's not installed. Visit https://www.docker.com/products/overview#/install_the_platform  ."; exit 1; }
nextflow -v >/dev/null 2>&1 || { echo >&2 "I require nextflow, but it's not installed. If you hava Java, run 'curl -fsSL get.nextflow.io | bash'. If not, install Java."; exit 1; }

data_dir=${data_path}/test_set
if [ -d $data_dir ]
then
    echo "Found existing test set, using $data_dir"
else
	echo "Creating $data_dir"
	mkdir -p $data_dir
    echo "Downloading test set..."
	curl http://starklab.org/data/bardet_natprotoc_2011/input_dmel.fastq.gz -o ${data_dir}/input_dmel.fastq.gz
	curl http://starklab.org/data/bardet_natprotoc_2011/chip_dmel.fastq.gz -o ${data_dir}/chip_dmel.fastq.gz
    echo "Downloading reference..."
    curl ftp://igenome:G3nom3s4u@ussd-ftp.illumina.com/Drosophila_melanogaster/UCSC/dm6/Drosophila_melanogaster_UCSC_dm6.tar.gz -o ${data_dir}/Drosophila_melanogaster_UCSC_dm6.tar.gz
    echo "Downloading macsconfig test file..."
    wget https://github.com/BU-ISCIII/nextflow-scif/releases/download/v.v1.0/macs.config.csv -O ${data_dir}/macs.config.csv
    echo "Unpacking reference..."
    tar -xvf ${data_dir}/Drosophila_melanogaster_UCSC_dm6.tar.gz -C ${data_dir}
    echo "Done"
fi

run_name="Test Docker ChIP-Seq Run: "$(date +%s)

nf_cmd="nextflow -C /home/smonzon/.nextflow/assets/BU-ISCIII/chipseq/conf/testing.config run $script_path -resume -name \"$run_name\" --fasta ${data_dir}/Drosophila_melanogaster/UCSC/dm6/Sequence/WholeGenomeFasta/genome.fa --gtf ${data_dir}/Drosophila_melanogaster/UCSC/dm6/Annotation/Genes/genes.gtf --geffective dm --macsconfig ${data_dir}/macs.config.csv --reads \"${data_dir}/*.fastq.gz\" --singleEnd --outdir ./${data_path}/results --keepduplicates --mfold '1 100'"
echo "Starting nextflow... Command:"
echo $nf_cmd
echo "--------------------------------------------------"
eval $nf_cmd

