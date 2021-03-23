# Alle vorher gespeicherten Variablen entfernen
rm(list=ls())

install.packages("Hmisc")
library(Hmisc)

covid_data <- read.csv("C:\\R\\Covid_Analysis\\Covid.csv", header = TRUE)

# Info über unsere Datei
describe(covid_data)

# Als Tabelle darstellen
View(covid_data)

# Datei aufräumen, da zB Tode manchmal mit 1, aber manchmal mit
# dem Datum des Todes bezeichnet werden.
# Wenn ungleich 0, dann bedeutet es "verstorben"
covid_data$death_clean <- as.integer(covid_data$death != 0)

# Bleibt nur mehr 1 und 0 übrig
unique(covid_data$death_clean)

# Todesrate berechnen (etwa 5%)
sum(covid_data$death_clean) / nrow(covid_data)

# Behauptung: Es sterben eher ältere Menschen
dead = subset(covid_data, death_clean == 1)
alive = subset(covid_data, death_clean == 0)

# NA entfernen und Durchschnittsalter berechnen
mean(dead$age, na.rm=T) # 68,6 Jahre
mean(alive$age, na.rm=T) # 48,1 Jahre

# Frage: Ist dieses Ergebnis statistisch signifikant?
t.test(alive$age, dead$age, alternative = "two.sided", conf.level = 0.95)
# Wir haben einen p-Wert von ~ 0, daher ist die Nullhypothese widerlegt.
# Das bedeutet, dass ein signifikanter Zusammenhang zwischen Alter und Todesrate
# besteht

# Frage: Frauen oder Männer öfter gestorben?
men = subset(covid_data, gender == "male")
women = subset(covid_data, gender == "female")

# durchschnittliche Todesrate zwischen 0 und 1 berechnen
mean(men$death_clean, na.rm=T) # 0.085
mean(women$death_clean, na.rm=T) # 0.037

# Statistische Signifikanz berechnen
t.test(men$death_clean, women$death_clean, alternative = "two.sided", conf.level = 0.95)
# 95% Sicherheit: Männer sind 1,7% bis zu 7,8% wahrscheinlicher
# an Covid zu sterben, als Frauen
# p-Wert ist 0.002 < 0.05, daher ist es wieder statistisch signifikant