##################################################
#                                                #
#    SCRIPT FOR EXTRACTING MODULE MEMBERSHIP     #
#                                                #       
##################################################

##### Ecological Synthesis Lab (SintECO): https://marcomellolab.wordpress.com
##### Author: Gabriel Felix & Marco Mello
##### E-mail: gabriel.felixf@hotmail.com.  
##### How to cite: Felix GM & Mello MAR. 2018. Extracting module membership from the computeModules function of the package bipartite. Ecological Synthesis Lab of the University of São Paulo, Brazil.
##### This script was first used in the following preprint: Felix et al. 2017, bioRvix: https://doi.org/10.1101/236687.
##### Published on October 23rd, 2018 (English version).
##### Run in R 3.5.1 (2017-07-02) -- "Feather Spray"

##### Disclaimer: You may use this script freely for non-comercial purposes at your own risk. We assume no responsibility or liability for the use of this software, convey no license or title under any patent, copyright, or mask work right to the product. We reserve the right to make changes in the software without notification. We also make no representation or warranty that such application will be suitable for the specified use without further testing or modification. If this script helps you produce any academic work (paper, book, chapter, dissertation etc.), please acknowledge the authors and cite the source.


#############################################


#### Step 1: Clear all objects and load the required packages
rm(list=ls())

library(bipartite)
library(reshape2)
library(ggplot2)


#### Step 2: Set the working directory to the source file location 
current_path <- getActiveDocumentContext()$path 
setwd(dirname(current_path ))
print( getwd() )


#### Step 3: Create an adjancency matrix from a text file formatted for the package bipartite
# In this example we used the data from: Bezerra et al 2009, JANE (see "Suggested readings")
net1<-read.table("net1.txt", head=TRUE)
net1 #check it


#### Step 4: Run the modularity algorithm
# Run you favorite algorithm in the package bipartite. We prefer Beckett 2016, RSOS (see "Suggested readings")
modules = computeModules(net1, method="Beckett") #set the method for Beckett or DormannStrauss

# Create an object with the module list
modules.list = listModuleInformation(modules)


#### Step 5: Source the extraction function
source("Extracting_modules_from_bipartite.R")


##### Step 6: Create a data frame with module membership information
modules.dataframe = modules_from_bipartite(modules.list)


#### Step 7: Export module membership data frames
# Rows
write.table(modules.dataframe$Rows_modules, "modulemembership.rows.txt", sep="\t", quote=F)

# Columns
write.table(modules.dataframe$Cols_modules, "modulemembership.cols.txt", sep="\t", quote=F)


#### Suggested readings
# 1. Felix, G.M., Pinheiro, R.B.P., Poulin, R., Krasnov, B.R. & Mello, M.A.R. (2017) The compound topology of a continent-wide interaction network explained by an integrative hypothesis of specialization. bioRxiv, preprint. URL: https://doi.org/10.1101/236687 

# 2. Bezerra, E.L.S., Machado, I.C. & Mello, M.A.R. (2009) Pollination networks of oil-flowers: a tiny world within the smallest of all worlds. Journal of Animal Ecology, 78, 1096–1101. DOI: http://dx.doi.org/10.1111/j.1365-2656.2009.01567.x

# 3. Beckett, S.J. (2016) Improved community detection in weighted bipartite networks. Royal Society Open Science, 3, 140536. DOI: http://dx.doi.org/10.1098/rsos.140536 
