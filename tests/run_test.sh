#!/usr/bin/env bash

script_path="../main.nf"
if [ -z $1]
then
    echo "No argument given, going to try to run ../main.nf"
else
    script_path=$1
fi

data_path="/tmp"
if [ -d "./test_data" ]
then
    data_path="./test_data"
    echo "Found data directory in current working directory, using ./test_data/"
fi

curl --version >/dev/null 2>&1 || { echo >&2 "I require curl, but it's not installed. Aborting."; exit 1; }
tar --version >/dev/null 2>&1 || { echo >&2 "I require tar, but it's not installed. Aborting."; exit 1; }
docker -v >/dev/null 2>&1 || { echo >&2 "I require docker, but it's not installed. Visit https://www.docker.com/products/overview#/install_the_platform  ."; exit 1; }
nextflow -v >/dev/null 2>&1 || { echo >&2 "I require nextflow, but it's not installed. If you hava Java, run 'curl -fsSL get.nextflow.io | bash'. If not, install Java."; exit 1; }

data_dir=${data_path}/test_set
if [ -d $data_dir ]
then
    echo "Found existing test set, using $data_dir"
else
	mkdir $data_dir
    echo "Downloading test set..."
	curl http://starklab.org/data/bardet_natprotoc_2011/input_dmel.fastq.gz -o ${data_dir}
	curl http://starklab.org/data/bardet_natprotoc_2011/chip_dmel.fastq.gz -o ${data_dir}
    echo "Downloading reference..."
    curl ftp://igenome:G3nom3s4u@ussd-ftp.illumina.com/Drosophila_melanogaster/UCSC/dm6/Drosophila_melanogaster_UCSC_dm6.tar.gz -o ${data_dir}
    echo "Unpacking reference..."
    tar xvjf ${data_path}/Drosophila_melanogaster_UCSC_dm6.tar.gz -C ${data_dir}
    echo "Done"

fi

run_name="Test Docker ChIP-Seq Run: "$(date +%s)

nf_cmd="nextflow run $script_path -resume -name \"$run_name\" -profile testing --fasta ${data_dir}/Drosophila_melanogaster/UCSC/dm6/Sequence/WholeGenomeFasta/genome.fa --gtf ${data_dir}/Drosophila_melanogaster/UCSC/dm6/Annotation/Genes/genes.gtf --bwa_index ${data_dir}/Drosophila_melanogaster/UCSC/dm6/Sequence/BWAIndex --geffective 0.99 --macsconfig ${data_dir}/macs.config.csv --reads \"${data_dir}/*.fastq.gz\" --singleEnd"
echo "Starting nextflow... Command:"
echo $nf_cmd
echo "--------------------------------------------------"
eval $nf_cmd

