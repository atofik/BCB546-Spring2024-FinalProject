# Load necessary libraries
library(ggplot2)
library(reshape2)
library(readr)
# Read the CSV file
data <- read.csv("genotype_phenotypeHeatmap.csv", header = TRUE, stringsAsFactors = FALSE)

# Subset the data to include only the columns for the heatmap (columns 3 to 13)
heatmap_data <- data[, c(1, 3:13)]

# Melt the data for use with ggplot
# Now 'Gene' is explicitly part of the data and used as an identifier in melting
melted_data <- melt(heatmap_data, id.vars = "Gene")

# Rename the melted data columns for clarity if needed
names(melted_data) <- c("Gene", "Strain", "Value")

# Mapping the values of the table to colors
melted_data$Value <- factor(melted_data$Value, levels = c("Not_present", "Resistant", "Susceptible", "Present"))
colors <- c("Not_present" = "white", "Resistant" = "red", "Susceptible" = "blue", "Present" = "gray")

# Creating the heatmap
heatmap_plot_genotype_phenotype <- ggplot(melted_data, aes(Strain, Gene, fill = Value)) +
  geom_tile(color = "white") +
  scale_fill_manual(values = colors) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1), 
        axis.title = element_blank()) +
  labs(fill = "Gene Presence")

# Display the heatmap
print(heatmap_plot_genotype_phenotype)

# Save the plot as a tiff file
ggsave("heatmap_plot.tiff", plot = heatmap_plot_genotype_phenotype, width = 10, height = 8, dpi = 300)
