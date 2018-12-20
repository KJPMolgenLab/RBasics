## Code Merger für femNAT DAten 



## Arbeitsplatz festlegen
### setwd("S:/KJP_Biolabor/Projekte/FemNAT-CD/EpiGenetik/Phenotypes/export_4_ac_20181206/Tomerge/") AGC opt
#setwd("~/Downloads/99_femnat") # Mimis PC

options(stringsAsFactors = F) ### verhindert dass Wörter als Faktor gespeichert werden 

library(readr)

CDCURRSYMPT <-  read.csv("CDCURRSYMPT.csv", fileEncoding = "WINDOWS-1252")
KCIG_TRANSP <-  read.csv("KCIG_TRANSP.csv", fileEncoding = "WINDOWS-1252")
KPTSD1_TRANSP <- read.csv("KPTSD1_TRANSP.csv", fileEncoding = "WINDOWS-1252")
KPTSDAD_TRANSP <- read.csv("KPTSDAD_TRANSP.csv", fileEncoding = "WINDOWS-1252")
MHCS <- read.csv("MHCS.csv", fileEncoding = "WINDOWS-1252")

############ data selection 

### alle möglichen IDS: 
alltwuid=unique(c(CDCURRSYMPT$twuid,KCIG_TRANSP$twuid,KPTSD1_TRANSP$twuid,KPTSDAD_TRANSP$twuid, MHCS$twuid))

CDCURRSYMPT=CDCURRSYMPT[CDCURRSYMPT$tt==1,]
alltwuid[which(! alltwuid %in% CDCURRSYMPT$twuid)] # alle IDS sind in der CDCURRSYMPT drin

KCIG_TRANSP=KCIG_TRANSP[KCIG_TRANSP$tt==1,]
alltwuid[which(! alltwuid %in% KCIG_TRANSP$twuid)] # 5 IDS sind nicht in der KCIG_TRANSP drin

KPTSD1_TRANSP=KPTSD1_TRANSP[KPTSD1_TRANSP$tt==1,]
alltwuid[which(! alltwuid %in% KPTSD1_TRANSP$twuid)] # 5 IDS sind nicht in der KPTSD1_TRANSP drin

KPTSDAD_TRANSP=KPTSDAD_TRANSP[KPTSDAD_TRANSP$tt==1,]
alltwuid[which(! alltwuid %in% KPTSDAD_TRANSP$twuid)] # 658 IDS sind nicht in der KPTSDAD_TRANSP drin

MHCS=MHCS[MHCS$tt==1,]
alltwuid[which(! alltwuid %in% MHCS$twuid)] # 27 IDS sind nicht in der MHCS drin



######### data check 

ncol(MHCS)
ncol(KPTSDAD_TRANSP)
ncol(KPTSD1_TRANSP)
ncol(CDCURRSYMPT)
ncol(KCIG_TRANSP)

allNames=c(colnames(MHCS),
colnames(KPTSDAD_TRANSP),
colnames(KPTSD1_TRANSP),
colnames(CDCURRSYMPT),
colnames(KCIG_TRANSP))


length(unique(allNames))

Overlappings=intersect(colnames(MHCS), colnames(CDCURRSYMPT))
CDCURRSYMPT[duplicated(CDCURRSYMPT$twuid), ]

merge1 <- merge (CDCURRSYMPT, KCIG_TRANSP, all.x= T,all.y = T, no.dups = T)
### check if no duplicated entries
sum(duplicated(merge1$twuid)) # no duplicated 
sum(!alltwuid %in% merge1$twuid) ## all are in the merge1 file 

#############




merge2 <- merge (merge1, KPTSD1_TRANSP, by ="twuid", all.x= T)
merge3 <- merge (merge2, KCIG_TRANSP, by = c("twuid", "centre", "partno", "tt"), all.x= T)
merge4 <- merge (merge2, KPTSDAD_TRANSP, by = c("twuid", "centre", "partno", "tt"), all.x= T)
write.csv(merge4, file = "MyData.csv")
          
          
          