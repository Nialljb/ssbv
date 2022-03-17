# Clear workspace
rm(list= ls()) # clear screen
options(scipen=999) # gets rid of scientific notation

# Recently came across packmann - makes it cleaner to add packeges, rather than load them one at a time
require(pacman)
pacman::p_load(RColorBrewer, ggsci, tidyverse, readxl, psych, lme4, lmerTest, MASS, car, emmeans, ggpubr, standardize, Cairo)

## Formating options ##
myPalette <- c("#3399FF","#FF0000")
fillPalette <- (scale_fill_npg()) 
colPalette <- (scale_color_npg()) 
npgGroupPalette <- c("#4DBBD5FF","#E64B35FF")
npgAgentPalette <- c("#00A087FF","#3C5488FF")

# The errorbars overlapped, so use position_dodge to move them horizontally
pd <- position_dodge(0.1) # move them .05 to the left and right 
ebSize <- 1
fpSize <- 2
pointSize <- 3

# Font type & size (size 20 does not display well in r, but good for output figures)
textOption <- element_text(family="Times", size = 22)
facetText  <- element_text( size = 20) #family="Times",