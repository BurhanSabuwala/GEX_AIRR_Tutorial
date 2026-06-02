# AIRRC 2026 Tutorial: Joint Analysis of AIRR and scRNA-seq Data in R

**Authors:** Burhan Sabuwala, Jian Xing

This repository contains everything needed to run the tutorial hands-on:  
the `.Rmd` notebook, the Seurat object (`.h5ad`), and the AIRR rearrangement file (`.tsv`) are all included. No downloads required.

---

## Option 1 — GitHub Codespaces (recommended, no local install)

### Step 1 — Launch a Codespace

Click the green **Code** button at the top of this page → **Codespaces** tab → **Create codespace on main**.

> ⚠️ When asked to choose a machine type, select **Standard (4-core, 16 GB RAM)** or larger.  
> The default 2-core machine will struggle with Seurat.

Or use this direct link (replace with your actual repo path):
```
https://codespaces.new/YOUR_USERNAME/YOUR_REPO
```

### Step 2 — Wait for the build (~10–15 min on first launch)

The container installs R 4.4, RStudio Server, Seurat, zellkonverter, shazam, alakazam, airr, and ggpubr. You'll see streaming build logs. When complete, the terminal will print:

```
Container ready! Click the Ports tab and open port 8787. Login: rstudio / tutorial
```

Subsequent starts are instant (the image is cached).

### Step 3 — Open RStudio

1. Click the **Ports** tab in the bottom panel of VS Code.
2. Find **port 8787** and click the 🌐 globe icon to open RStudio in your browser.
3. Log in:
   - **Username:** `rstudio`
   - **Password:** `tutorial`

### Step 4 — Open and run the tutorial

In the RStudio file browser, navigate to:
```
tutorial/ → airrc_tutorial.Rmd
```

Click the file to open it. You can:
- **Run interactively:** execute chunks one at a time with Ctrl+Enter (Cmd+Enter on Mac)
- **Knit to HTML:** click the **Knit** button to render the full notebook

All data files (`concat.h5ad` and `airrc_shaw_singleCell.tsv`) are already in the same `tutorial/` folder — no paths to change.

---

## Option 2 — Run locally with Docker

### Prerequisites
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) installed and running
- At least **16 GB RAM** allocated to Docker (Preferences → Resources)
- At least **5 GB free disk space**

### Steps

```bash
# 1. Clone the repo
git clone https://github.com/YOUR_USERNAME/YOUR_REPO.git
cd YOUR_REPO

# 2. Build the Docker image (10–15 min first time)
docker build -t airrc-tutorial .

# 3. Start RStudio Server
docker run -d \
  -p 8787:8787 \
  -e PASSWORD=tutorial \
  --name airrc-rstudio \
  airrc-tutorial

# 4. Open RStudio in your browser
open http://localhost:8787
# Username: rstudio  |  Password: tutorial

# 5. When done, stop and remove the container
docker stop airrc-rstudio && docker rm airrc-rstudio
```

Navigate to `tutorial/airrc_tutorial.Rmd` in the RStudio file browser to get started.

---

## R Packages

| Package | Purpose |
|---|---|
| `Seurat` | Single-cell RNA-seq analysis |
| `zellkonverter` | Read `.h5ad` (AnnData) files into R |
| `airr` | Read AIRR-format rearrangement TSV files |
| `shazam` | Somatic hypermutation frequency (Immcantation) |
| `alakazam` | CDR3 amino acid properties, BCR lineage (Immcantation) |
| `dplyr` | Data manipulation |
| `ggplot2` | Visualization |
| `ggpubr` | Statistical annotations for ggplot2 |

---

## Repository Layout

```
.
├── Dockerfile                        ← builds the RStudio environment
├── .devcontainer/
│   └── devcontainer.json             ← Codespaces configuration
├── airrc_tutorial.Rmd                ← tutorial notebook
├── data/
│   ├── concat.h5ad                   ← Seurat object (Y3, Day 0 + Day 7)
│   └── airrc_shaw_singleCell.tsv     ← AIRR rearrangement data
└── README.md
```

---

## Tutorial Overview

**Subject:** Y3 — young donor, seasonal influenza vaccination  
**Samples:** Day 0 (pre-vaccination) and Day 7 (post-vaccination)

**What you'll do:**

1. Load a `.h5ad` single-cell object with `zellkonverter` and convert it to Seurat
2. Load AIRR-format BCR sequences and compute SHM frequency with `shazam`
3. Calculate CDR3 amino acid properties with `alakazam`
4. Merge BCR metadata into the Seurat object
5. Visualize isotype, SHM, and CDR3 features on UMAP embeddings
6. Compare B cell subsets (Naïve, Memory, Age-associated, Plasma cells) between Day 0 and Day 7

---

## Troubleshooting

| Problem | Fix |
|---|---|
| Port 8787 not appearing | In the Codespaces terminal, run any command (e.g. `echo hi`) to wake up port detection. Or add port 8787 manually via Ports → Add Port. |
| RStudio is slow / crashes | Increase machine size to 8-core / 32 GB in Codespaces settings. |
| Build fails on a package | Check the build log for which package errored. Open a GitHub issue with the log. |
| `readH5AD` error | Make sure `zellkonverter` installed correctly. Re-run: `BiocManager::install("zellkonverter")` in the RStudio console. |

---

## Contact

For questions, open a GitHub issue or contact the authors directly.
