## Using R to randomize items across and within groups

Sometimes we need to take a list of items and randomly assign them to different groups. When doing this, we might want to makes sure that the items are assigned in a way that specfic attributes describing them are also uniformly spread our across the groups. This script does that. If needed it also randmizes the order of the items within groups in either 1 or 2 dimensions. The script shows how to ouput the result of this in a 2D map of the items.


#### Example Data

One case where this type of script is useful is assigning samples to a PCR plate for genetics labwork. A PCR plate has 8 rows and 12 columns of wells (96 wells total), and we often want to makes sure samples are randomly distributed with space for blank and replicate controls. The data folder has 3 example data files with sample information that show how one might go from a sample list to including replicates/blanks to filling out entire plates. The dummy-data.R script was used to generate these files. The data files have four columns: 1) an individual id; 2) the sex of the individual; 3) the location the individual was collected; 4) the weight of the individual. We want to make sure individuals from each location are spread out across all plates. Likewise, we also want to make sure that male and female samples are spread out across the plates. For this example, we don't care about the weight, but it is included to illustrate that extra columns do not interfere with the script.


#### Code

See r-group-randomize.R

I will try to update this README later to include more direct code explanation.


#### Output

Output files related to each of the input files.
