#Data exploration with the urchin data from the Marna mesocosm community experiment
  #Carolyn Prentice - April 2020

library(ggplot2)
library(dplyr)

#First I will read in the 3 csv files

rates<-read.csv("urchin_assimilation_rates.csv", header=TRUE)
bio<-read.csv("urchin_biometrics.csv", header=TRUE)
bio2<-read.csv("urchin_initial_biosampling.csv", header=TRUE)

#'rates' is the assimilation rate estimates from faecal pellet sampling
#'bio' is the urchin biometrics from the experiment urchins at the start and end of experiment
#'bio2' is the urchin biometrics from the 30 urchins initally sampled and sacrificed


#Plotting urchin wet mass from the initial and final sampling

wet_mass<-ggplot(bio, aes(x=Treatment, y=Wet_Mass_g, fill=Treatment)) + 
  geom_boxplot() 

wet_mass + labs(y="Wet Mass (g)") +
  theme_bw() +
  facet_wrap(~Date, ncol=2)  +
  scale_color_brewer(palette="Dark2")

#Plotting urchin test diameter from the initial and final sampling

test_d<-ggplot(bio, aes(x=Date, y=Test_Diameter_mm, fill=Date)) + 
  geom_boxplot()

test_d + labs(y="Test Diameter (mm)") +
  theme_bw() +
  facet_wrap(~Treatment, ncol=2)  +
  scale_color_brewer(palette="Dark2")


#Filter data to look only at the end time point

dplyr::tbl_df(bio)

dplyr::glimpse(bio)

bio %>%
  group_by(Treatment) %>%
  summarise(avg = mean(Test_Height_mm)) %>%
  arrange(avg)

bio_end<-dplyr::filter(bio, Date == "2020-03-17")

#Exploring assimilation rates data

#Urchin Faeces Dry Mass by Date and Treatment
rate_plot<-ggplot(rates, aes(x=Treatment, y=Total_faeces_dry_mass_g, fill=Treatment)) + 
  geom_boxplot(notch=FALSE)

rate_plot + labs(y="Faeces Dry Mass (g)") +
  theme_bw() +
  facet_wrap(~Date, ncol=2)  +
  scale_color_brewer(palette="Dark2")


#Ash-Free Dry Weight by Date and Treatment

afdw_plot<-ggplot(rates, aes(x=Date, y=AFDW_mass_g, fill=Date)) + 
  geom_boxplot(notch=FALSE)

afdw_plot + labs(y="Faeces Dry Mass (g)") +
  theme_bw() +
  facet_wrap(~Treatment, ncol=2)  +
  scale_color_brewer(palette="Dark2")

