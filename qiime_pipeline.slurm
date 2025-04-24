#!/bin/sh -l

#SBATCH --nodes=1                    ##number of requested nodes (a node is a group of CPUs)
#SBATCH -n 80		             ##number of requested CPUs
#SBATCH --time=20:00:00              ##time requested
#SBATCH --job-name MP-pipeline       ##name of job
#SBATCH -A microbiome                ##name of the queue you are using. Could be scholar or microbiome if you are on snyder

#########################################################################

echo "Start time"
date +"%d %B %Y %H:%M:%S"

cd /scratch/bell/dsarnaik/project2/seq

ml biocontainers qiime2

#qiime tools import \
#--type 'SampleData[PairedEndSequencesWithQuality]' \
#--input-path projectmanifest.tsv \
#--input-format PairedEndFastqManifestPhred33V2 \
#--output-path demux.qza

#qiime dada2 denoise-paired \
#  --i-demultiplexed-seqs demux.qza \
#  --p-trim-left-f 12 \
#  --p-trim-left-r 8 \
#  --p-trunc-len-f 230 \
#  --p-trunc-len-r 217 \
#  --o-table table.qza \
#  --o-representative-sequences rep-seqs.qza \
#  --o-denoising-stats denoising-stats.qza


#qiime metadata tabulate \
#  --m-input-file denoising-stats.qza \
#  --o-visualization denoising-stats.qzv


#qiime phylogeny align-to-tree-mafft-fasttree \
#  --i-sequences rep-seqs.qza \
#  --o-alignment aligned-rep-seqs.qza \
#  --o-masked-alignment masked-aligned-rep-seqs.qza \
#  --o-tree unrooted-tree.qza \
#  --o-rooted-tree rooted-tree.qza


#qiime diversity core-metrics-phylogenetic \
#  --i-phylogeny rooted-tree.qza \
#  --i-table table.qza \
#  --p-sampling-depth 26656\
#  --m-metadata-file pig-metadata.tsv \
#  --output-dir core-metrics-results

#qiime diversity alpha-group-significance \
#  --i-alpha-diversity core-metrics-results/faith_pd_vector.qza \
#  --m-metadata-file pig-metadata.tsv \
#  --o-visualization core-metrics-results/faith-pd-group-significance.qzv

#qiime diversity alpha-group-significance \
#  --i-alpha-diversity core-metrics-results/evenness_vector.qza \
#  --m-metadata-file pig-metadata.tsv \
#  --o-visualization core-metrics-results/evenness-group-significance.qzv


#qiime diversity beta-group-significance \
#  --i-distance-matrix core-metrics-results/unweighted_unifrac_distance_matrix.qza \
#  --m-metadata-file pig-metadata.tsv \
#  --m-metadata-column Day \
#  --o-visualization core-metrics-results/unweighted-unifrac-Day-significance.qzv \
#  --p-pairwise

#qiime diversity beta-group-significance \
#  --i-distance-matrix core-metrics-results/weighted_unifrac_distance_matrix.qza \
#  --m-metadata-file pig-metadata.tsv \
#  --m-metadata-column Day \
#  --o-visualization core-metrics-results/weighted-unifrac-Day-significance.qzv \
 # --p-pairwise


wget \
  -O "gg-13-8-99-515-806-nb-classifier.qza" \
  "https://data.qiime2.org/2023.9/common/gg-13-8-99-515-806-nb-classifier.qza"






Echo "End time"
date +"%d %B %Y %H:%M:%S"

#to run: sbatch qiime_pipeline.slurm
