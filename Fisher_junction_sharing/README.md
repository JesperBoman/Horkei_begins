In this directory there are scripts to do a pairwise Fisher junction sharing analysis.

As input you use phased vcf-files generated with SHAPEIT4. 
If you use some other software to determine identical-by-descent blocks and then produce a phased vcf-file accordingly, it should work just as well or possibly better.

Steps:

1. Run 01_defineFisherJunctions.sh employing make_FJ_bed.awk to produce bed-files of Fisher junctions per sample.
2. Run 02_FisherJunction_pairwise_sharing.sh to calculate pairwise sharing patterns.
3. Visualize and use hierarchical clustering of results using 03_Fisher_junction_sharing_plot_and_stats.R.

Auxiliary tools:
1. Visualize phased genotypes using haplotype_plot.R
2. Visualize Fisher Junctions in a specific region using FJvis_prep.sh followed by FJ_plot.R


Nota bene: In the figure below, the Fisher junction sharing patterns in panel C are based on all autosomes and not only the region shown in panel A and B.

<image src="https://github.com/JesperBoman/Horkei_begins/blob/main/Fisher_junction_sharing/fisher_junction_collage.png" width="800">
