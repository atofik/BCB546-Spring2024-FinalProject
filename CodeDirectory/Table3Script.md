# BCB546 Assignment 
## Project Title:  Genotype–phenotype correlation of β‑lactamase‑producing  uropathogenic Escherichia coli (UPEC) strains from Bangladesh

### This script is intended to illustrate the replication of Table 3 from the paper.

### 1.)  Creat a conda envrionment and install the necessary tools

```

srun --nodes 1 --time 2:00:00 -p biocrunch --pty bash

module load miniconda3

conda create -p /work/LAS/wmoss-lab/programs/envs/test

conda activate /work/LAS/wmoss-lab/programs/envs/test

conda config --add channels bioconda

conda install serotypefinder

conda install mlst

conda install bioconda::ezclermont
```

### 2.) Updating the Database of Serotypefinder

``` 
cd /work/LAS/wmoss-lab/programs/envs/test
# Clone and enter the serotypefinder directory
git clone https://bitbucket.org/genomicepidemiology/serotypefinder.git
cd serotypefinder
git clone https://bitbucket.org/genomicepidemiology/serotypefinder_db.git
cd serotypefinder_db
STFinder_DB=$(pwd)
# Install SerotypeFinder database with executable kma_index program
python3 INSTALL.py kma_index
```

### 3.) Downloading the fasta file from NCBI and prepare for Analysis 
```
#The fasta files were downloaded from NCBI using their assession number.
#The files were further concatenated into a single fasta file.

cat *.fna > All_fasta

```
### 4.) MLST (Multilocus Sequence typing)
```
#This carries out mlst on all the fasta files and save the result in a mlst.csv 
mlst *.fna > mlst.csv

```
### 5.) Serotypefinder 

```
#This code should be executed in the folder for the database.

python serotypefinder.py  -i /work/LAS/wmoss-lab/ddabiri/All_Fasta/ -p serotypefinder_db/ -x
 ```

 ### 6.) Phylogrouping 

 ```
 # EzClermont tool was used for this analysis

 conda install bioconda::ezclermont
 ls *.fna | parallel ezclermont {} 1>> Typing_results.txt  2>> typing_results.log
 
 ```
