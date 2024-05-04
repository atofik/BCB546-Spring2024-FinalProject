library(tidyr)
library(ggplot2)
library(readr)
df <- read_csv("AntibioticResistanceVirulence​HeatMap.csv")
View(df)
gene_df <- df
library(pheatmap)
rownames(gene_df) <- gene_df$Gene
unique_categories <- unique(gene_df$Category)
category_colors <- c("Beta-lactam" = "#f19066", "Aminoglycoside" = "#f5cd79", "Fluoroquinolone" = "#546de5", "Macrolide" = "#e15f41", "Chloramphenicol" = "#c44569", "Sulphonamide" = "#786fa6", "Tetracycline" = "#f8a5c2","Trimethoprim" = "#63cdda", "Erythromycin" = "#ea8685","Quinolone"= "#596275")
names(category_colors) <- unique_categories
annotation_row_df <- data.frame(Category = gene_df$Category)
rownames(annotation_row_df) <- gene_df$Gene
pheatmap(as.matrix(gene_df[, -which(names(gene_df) %in% c("Gene", "Category"))]),
         annotation_row = annotation_row_df,
         annotation_colors = list(Category = category_colors),
         cluster_rows = FALSE,
         cluster_cols = FALSE,
         show_rownames = TRUE,
         show_colnames = TRUE,
         legend = FALSE,
         color = colorRampPalette(c("white", "grey25"))(2)) 
