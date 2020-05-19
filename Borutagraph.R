path="/Users/michaelallwright/Dropbox (Sydney Uni)/michael_PhD/Projects/MISC/Paul CRPS DPN CYTOKINE ASSAYS/Data/"

path2="/Users/michaelallwright/Dropbox (Sydney Uni)/michael_PhD/Projects/MISC/RaqibMRI/Data/"

library(Boruta)
library(ggplot2)
library(tidyverse)

#Raquib MRI
write_csv(Bor_raq_df,paste0(path,"Boruta_imp.csv"))
raq<-read.csv(file=paste0(path2,"mod_data.csv"))
raq=raq[(names(raq)!="X")]
Bor_raq<-Boruta(frs_score_grp~.,data=raq,doTrace=2)
getSelectedAttributes(Bor_raq, withTentative = T)
Bor_raq_df <- attStats(Bor_raq)
Bor_raq_df$Feature=rownames(Bor_raq_df)

plot(Bor_raq,las = 1)
write_csv(Bor_raq_df,paste0(path2,"Boruta_imp_raq.csv"))

#Paul Cytokines
allvars=read.csv(file=paste0(path,"mod_data_cy.csv"))
allvars=allvars[(names(allvars)!="X")]
Boruta(Type~.,data=allvars,doTrace=2)->Bor.hvo
print(Bor.hvo)
plot(Bor.hvo,las = 2,axis.text=element_text(size=12),
     axis.title=element_text(size=14,face="bold"))
plot(Bor.hvo,las = 1)
getSelectedAttributes(Bor.hvo, withTentative = T)
cyt_bor_df <- attStats(Bor.hvo)
cyt_bor_df$Feature=rownames(cyt_bor_df)
#Export data
write_csv(cyt_bor_df,paste0(path,"Boruta_imp.csv"))

