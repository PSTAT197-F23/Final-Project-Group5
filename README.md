# Final-Project-Group5

> Vignette on implementing clustering methods (k-means and hierarchical) using the well known iris data; created as a class project for PSTAT197A in Fall 2023.

**Contributors:** Kaitlyn Lee, Sanaz Ebrahimi, Yoobin Won, Aron Ma, Dylan Fu

**Vignette abstract:** The clustering vignette guides the reader through the application of two key clustering algorithms, K-Means and Hierarchical clustering, using the Iris dataset. The reader will gain hands-on experience with using built in methods to cluster the data in R and visualizing the results. We also included an additional section covering support vector machine for those interested in another method for clustering that is well suited for smaller datasets. This notebook will equip the reader with practical skills to analyze and group data based on their inherent similarities.

**Repository contents:** In the root repository we have the `vignette.qmd` our primary vignette document that teaches the different clustering methods with step-by-step explanations.  

-   `data`: contains `iris.csv` and corresponding `codebook.txt`

-   `scripts`: contains a `drafts` folder and a `vignette-script.R` file

    -   `drafts`: contains draft scripts for the different clustering methods
    -   `vignette-script.R`: script compiling the code from the primary vignette document with line-by-line annotations
    -   `svm.rmd`: script containing code from vignette-svm-clustering with line annotations
    -   `pca_kmeans.rmd`: script containing pca code and annotations from primary vignette
-   `images` contains .png files of plots and output used in primary vignette document

**Reference list:** The following are references pertaining to clustering.

1.  [Clustering(K-Mean and Hierarchical) with Practical Implementation](https://medium.com/machine-learning-researcher/clustering-k-mean-and-hierarchical-cluster-fa2de08b4a4b)

2.  [The Math Behind K-Means Clustering](https://medium.com/@draj0718/the-math-behind-k-means-clustering-4aa85532085e)

3.  [Another article on the math for k-means](https://heartbeat.comet.ml/understanding-the-mathematics-behind-k-means-clustering-40e1d55e2f4c)


4.  [Article for hierarchical clustering](https://www.learndatasci.com/glossary/hierarchical-clustering/)


5. [SVM kernel distinguishing](https://www.kdnuggets.com/2016/06/select-support-vector-machine-kernels.html)

6. [SVM explanation](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC2099486/)

7. [kernel functions](https://www.analyticsvidhya.com/blog/2021/07/svm-support-vector-machine-algorithm/)
