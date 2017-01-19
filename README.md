# Retinal blood vessel segmentation in fundus images

![Results obtained on DRIVE using MICCAI 2014 method. From left to right: original color image, ground truth annotations provided by two different human graders, and results.](http://homes.esat.kuleuven.be/~mblaschk/projects/retina/qualitativeResults.png)


This code corresponds to our paper on *IEEE Transactions on Biomedical Engineering* with Matthew B. Blaschko and Elena Prokofyeva, entitled **"A discriminatively trained fully connected conditional random field model for blood vessel segmentation in fundus images"**, which extends our *MICCAI 2014* paper **"Learning fully-connected CRFs for blood vessel segmentation in retinal images"**. We also include code in this repository to perform vessel segmentation as we did in our *SIPAIM 2016* paper, entitled **Convolutional neural network transfer for automated glaucoma identification**.

If you use our TBME 2017 code in any publication, please include the following citations:

```latex
@article{orlando2016discriminatively,
  author={Orlando, Jos\'{e} Ignacio and Prokofyeva, Elena and Blaschko, Matthew B.},
  journal={IEEE Transactions on Biomedical Engineering},
  title={A Discriminatively Trained Fully Connected Conditional Random Field Model for Blood Vessel Segmentation in Fundus Images},
  year={2017},
  volume={64},
  number={1},
  pages={16-27}
}
```

```latex
@inproceedings{orlando2014learning,
  title={Learning fully-connected CRFs for blood vessel segmentation in retinal images},
  author={Orlando, Jos{\'e} Ignacio and Blaschko, Matthew},
  booktitle={International Conference on Medical Image Computing and Computer-Assisted Intervention},
  pages={634--641},
  year={2014},
  organization={Springer}
}
```

If you apply the same configuration we used for SIPAIM 2016, please cite:

```latex
@incollection{Orlando2016bconvolutional,
title={Convolutional neural network transfer for automated glaucoma identification},
author={Orlando, Jos\'{e} Ignacio and Prokofyeva, Elena and del Fresno, Mariana and Blaschko, Matthew B.},
booktitle={12th International Symposium on Medical Information Processing and Analysis (SIPAIM)},
year={2016},
}
```


###Abstract

**Goal:** In this work, we present an extensive description and evaluation of our method for blood vessel segmentation in fundus images based on a discriminatively trained fully connected conditional random field model. **Methods:** Standard segmentation priors such as a Potts model or total variation usually fail when dealing with thin and elongated structures. We overcome this difficulty by using a conditional random field model with more expressive potentials, taking advantage of recent results enabling inference of fully connected models almost in real time. Parameters of the method are learned automatically using a structured output support vector machine, a supervised technique widely used for structured prediction in a number of machine learning applications. **Results:** Our method, trained with state of the art features, is evaluated both quantitatively and qualitatively on four publicly available datasets: DRIVE, STARE, CHASEDB1, and HRF. Additionally, a quantitative comparison with respect to other strategies is included. Conclusion: The experimental results show that this approach outperforms other techniques when evaluated in terms of sensitivity, F1-score, G-mean, and Matthews correlation coefficient. Additionally, it was observed that the fully connected model is able to better distinguish the desired structures than the local neighborhood-based approach. **Significance:** Results suggest that this method is suitable for the task of segmenting elongated structures, a feature that can be exploited to contribute with other medical and biological applications.

###Project webpage and papers

If you want to download our segmentations, code or even the PDF files of our papers, please [follow this link to our project webpage](http://homes.esat.kuleuven.be/~mblaschk/projects/retina/).

 - IEEE TBME 2017 paper. [[pdf]](https://lirias.kuleuven.be/bitstream/123456789/531621/3/OrlandoTBME2016.pdf) [[bibtex]](http://homes.esat.kuleuven.be/~mblaschk/bib/Orlando2016a.bib)
 - SIPAIM 2016 paper.  [[pdf]](https://lirias.kuleuven.be/bitstream/123456789/554709/1/4126_postprint.pdf) [[bibtex]](http://homes.esat.kuleuven.be/~mblaschk/bib/Orlando2016b.bib)
 - MICCAI 2014 paper.  [[pdf]](http://hal.inria.fr/docs/01/02/42/26/PDF/OrlandoMICCAI2014.pdf) [[bibtex]](http://homes.esat.kuleuven.be/~mblaschk/bib/Orlando2014a.bib)


## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

We make use of some external libraries in our code, namely:

 - VLFeat: for efficient ROC curve computation. [[link]](https://github.com/vlfeat/vlfeat)
 - Soares *et al.* code for Gabor filters.
 - Nguyen *et al.* code for line detectors.
 - Azzopardi *et al.* code for B-COSFIRE filters (only for reproducing segmentation results used in SIPAIM 2016). [[link]](https://www.mathworks.com/matlabcentral/fileexchange/49172-trainable-cosfire-filters-for-vessel-delineation-with-application-to-retinal-images). If you use this code, please cite the following papers:
    - [1] George Azzopardi, Nicola Strisciuglio, Mario Vento, Nicolai Petkov, Trainable COSFIRE filters for vessel delineation with application to retinal images, Medical Image Analysis, Available online 3 September 2014, ISSN 1361-8415, http://dx.doi.org/10.1016/j.media.2014.08.002.
    - [2] “N. Strisciuglio, G. Azzopardi, M. Vento, and N. Petkov” - Supervised vessel delineation in retinal fundus images with the automatic selection of B-cosfire filters. Machine Vision and Applications, http://doi:10.1007/s00138-016-0781-7

These two libraries are included by default in `fundus-vessel-segmentation-tbme/external` and `fundus-vessel-segmentation-tbme/core/Features/Features`, respectively.

It will also require to download some data sets like. This is a list of some data sets that you can use:

 - [DRIVE](www.isi.uu.nl/Research/Databases/DRIVE/). It is necessary for training the model we used for SIPAIM 2016.
 - [STARE](http://cecas.clemson.edu/~ahoover/stare/probing/index.html).
 - [CHASEDB1](https://blogs.kingston.ac.uk/retinal/chasedb1/).
 - [HRF](https://www5.cs.fau.de/research/data/fundus-images/).

We include code for preparing DRIVE data for training and evaluating both the SIPAIM 2016 and TBME 2017 versions of our segmentation method. A similar file organization has to be followed for computation.

### Installing

 1. Create a fork of this repository, or clone it by doing:

```git
$ git clone https://github.com/ignaciorlando/fundus-vessel-segmentation-tbme
```

 2. Update submodules doing:

 ```git
 $ git submodule update --init --recursive
 ```

 3. Open MATLAB (I used MATLAB R2015a) and move to `fundus-vessel-segmentation-tbme` folder.
 4. Run `setup_segmentation_code` to compile all MEX files and to add necessary folders to the MATLAB path. This will also create a copy of the configuration files in ```./default_configuration```, putting them into a new folder, namely ```./configuration```.
 5. Everything is ready to run!

> **Note:** We include binaries for Windows and Mac architectures, that were tested on Windows 7 and 10, and on a Macbook PRO Retina 2015 with macOS Sierra. In principle there would be no problem on using this system within other architectures or operating systems as far as you run ```setup_segmentation_code``` first.

###Code organization

The repository is organized in the following folders:

  - ```./api```: contains scripts that you can use for training the model or running experiments.
  - ```./configuration```: contains a series of configuration scripts that are called by the scripts in ```./api``` before doing anything. You can modify the variables in these scripts at your will, but take into account that no modification on the files will be committed to your repository as it is ignored.
  - ```./core```: contains the essential functions of this code, including features, SOSVM learning and FC-CRF and LNB-CRF wrappers.
  - ```./data_preparation```: contains scripts to prepare some data sets for further processing.
  - ```./default_configuration```: contains all the default configuration files, that will be copied to ```./configuration``` when running ```setup_segmentation_code```. Any modification here will be committed if you push to your repository, so take that into account.
  - ```./evaluation```: contains functions to evaluate segmentation results compared to gold standard segmentations.
  - ```./external```: contains external libraries.
  - ```./fundus-util```: is a git submodule from a different repository. Please, remember to do ```git submodule update --init --recursive``` after cloning.

By default, our code might create 3 additional folders that are ignored by git:

  - ```./data```: will contain the data sets.
  - ```./data/results```: will contain the results obtained in the experiments.
  - ```./data/segmentation_model```: will contain the model learned from DRIVE when reproducing SIPAIM 2016 method.

## Running experiments

Scripts for running experiments are in the `./api` folder. All filenames are quite self-explanatory, but if you have any questions do not hesitate in opening issues in my github repository.

In general, all experiments will require to edit a configuration script. They are all in the `./configuration` folder.


## Contributing

If you want to contribute to this project, please contact me by e-mail to [jiorlando -at- conicet.gov.ar](mailto:jiorlando@conicet.gov.ar).

## Authors

**José Ignacio Orlando** - *All coding* - [Github](https://github.com/ignaciorlando) - [Twitter](https://twitter.com/ignaciorlando)

See also the list of [contributors](https://github.com/ignaciorlando/fundus-vessel-segmentation-tbme/graphs/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](https://github.com/ignaciorlando/fundus-vessel-segmentation-tbmeLICENSE.md) file for details

## Acknowledgments

* This work is partially funded by Internal Funds KU Leuven, ERC Gran 259112, FP7-MC-CIG 334380 and ANPCyT PICTs 2010-1287 and 2014-1730.
* J.I.O. is funded by doctoral scholarships granted by CONICET. Part of this work was done during an internship at the Center for Learning and Visual Computing (CVC, École Centrale Paris).
* J.I.O. would also like to thank NK and CFK. They know why :-)
