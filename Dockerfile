FROM rocker/rstudio:4.4.1

# System dependencies
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libhdf5-dev \
    libgit2-dev \
    libfontconfig1-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    libglpk-dev \
    zlib1g-dev \
    cmake \
    git \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Use Posit Package Manager for fast pre-built Linux binaries
ENV CRAN=https://packagemanager.posit.co/cran/__linux__/noble/latest

# Core CRAN packages
RUN R -e " \
  options(repos = c(CRAN = Sys.getenv('CRAN'))); \
  install.packages(c( \
    'BiocManager', \
    'remotes', \
    'dplyr', \
    'ggplot2', \
    'ggpubr', \
    'tibble', \
    'rmarkdown', \
    'knitr', \
    'htmltools', \
    'viridis' \
  ))"

# Seurat v5
RUN R -e " \
  options(repos = c(CRAN = Sys.getenv('CRAN'))); \
  install.packages('Seurat')"

# Bioconductor: zellkonverter + dependencies (reads .h5ad files)
RUN R -e " \
  BiocManager::install(c('zellkonverter', 'SingleCellExperiment', 'BiocParallel'), ask = FALSE)"

# Immcantation suite: alakazam, shazam, airr
RUN R -e " \
  options(repos = c(CRAN = Sys.getenv('CRAN'))); \
  install.packages(c('alakazam', 'shazam', 'airr'))"

# Copy tutorial files
COPY airrc_tutorial.Rmd /home/rstudio/tutorial/airrc_tutorial.Rmd
COPY data/concat.h5ad /home/rstudio/tutorial/concat.h5ad
COPY data/airrc_shaw_singleCell.tsv /home/rstudio/tutorial/airrc_shaw_singleCell.tsv

# Fix ownership
RUN chown -R rstudio:rstudio /home/rstudio/tutorial

EXPOSE 8787
ENV PASSWORD=tutorial
