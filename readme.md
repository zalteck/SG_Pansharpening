# Variational Bayesian Pansharpening with Super-Gaussian Sparse Image Priors.
This directory holds implementations for the method proposed in the paper

            Pérez-Bueno, F., Vega, M., Mateos, J., Molina, R., & Katsaggelos, A. K. (2020). 
            Variational Bayesian Pansharpening with Super-Gaussian Sparse Image Priors. Sensors, 20(18), 5308. 
            https://www.mdpi.com/1424-8220/20/18/5308

Directories:

    others
        This directory holds other's authors implementations for some methods.
        These implementations have been taken from https://rscl-grss.org/coderecord.php?id=541, used in

       Vivone, G.; Alparone, L.; Chanussot, J.; Dalla Mura, M.; Garzelli, A.; Licciardi, G.A.; Restaino, R.; Wald, L. 
        A critical comparison among pansharpening algorithms. IEEE Trans. Geosci. Remote Sens. 2015, 53, 2565â€“2586.

    source
        This directory holds implementations for the methods proposed in papers

            Pérez-Bueno, F., Vega, M., Mateos, J., Molina, R., & Katsaggelos, A. K. (2020). 
            Variational Bayesian Pansharpening with Super-Gaussian Sparse Image Priors. Sensors, 20(18), 5308. 

            M. Vega, J. Mateos, R. Molina, and A. K. Katsaggelos, â€œSuper resolution of multispectral images using TV image models, 
            in International Conference on Knowledge-Based and Intelligent Information and Engineering Systems, 2008, pp. 408â€“415.
   
    work
        This directory holds functions and scripts to perform all experiments in Pérez-Bueno, F. 2020 paper.

        Directories whithin work:

            Sensors
                Datasets   (MS image Dataset for Pérez-Bueno, F. 2020 paper). Please download from: 
                data       (Input data files for all experiments. dododoMain_Reduced_Resolution obtains those files from Dataset)
                results    (Folder to store output data files for all experiments)
                
            Quality_Indices  (Functions to obtain quality indexes coming from Vivone 2015 paper (See https://rscl-grss.org/coderecord.php?id=541))

            
        NOTE: Datasets folder must be filled and data has to be obtained before using the functions below:

        Recontructions of a Multi-spectral image using other authors methods and comparison with groundtruth following the Wald's protocol 
        can be obtained using doothersSens0 function.

        Recontructions of a Multi-spectral image using other authors methods and quantitative comparison using QNR measures 
        can be obtained using doothersSens0FR function.

        **Recontructions of a Multi-spectral image using TV, log and lp methods and comparison with groundtruth following the Wald's protocol 
        can be obtained using doTVMESens0, dologSGMESens0 and dolpSGMESens0 respectively.**

        **Recontructions of a Multi-spectral image using TV, log and lp methods 
        can be obtained using doTVMESens0FR, dologSGMESens0FR and dolpSGMESens0FR respectively.**
