# ---- Clear the environment and imports libraries ----
rm(list=ls(all=TRUE))

library(haven); library(plm); library(tidyverse); library(summarytools); library(dplyr)
library(pder) # Import dataset
library(tidyr); library(kableExtra)

# ---- Import dataset and data processing ----

data("Mafia")
head(Mafia)
str(Mafia)
summary(Mafia)

# Filter for 1990 - 1999
Mafia <- Mafia %>% 
  filter(year >= 1990 & year <= 1999) 
dfSummary(Mafia, valid.col = FALSE, graph.col = F, silent = FALSE)

# Panel data frame for Mafia
Mafia <- pdata.frame(Mafia, c("province","year"))

# Determine if the panel is balanced or not
pdim(Mafia)$balanced
is.pbalanced(Mafia)

# Creating the lags and renaming the variables
Mafia <- Mafia %>%
  group_by(province) %>%
  arrange(year, .by_group = TRUE) %>%
  mutate(
    
    # Lags for council dismissal
    L1cds2 = dplyr::lag(cds2, 1),
    L2cd  = dplyr::lag(cd, 2),
    L3cd  = dplyr::lag(cd, 3),
    
    # Lags for economic variables
    Y = y,
    G = g,
    L1G = dplyr::lag(g, 1),
    L2G = dplyr::lag(g, 2),
    L1Y = dplyr::lag(y, 1),
    L2Y = dplyr::lag(y, 2),
    
    # Controls in t
    Mafiosi      = mafiosi,
    Extortion    = extortion,
    Corruption1  = corruption1,
    Corruption2  = corruption2,
    Murder       = murder,
    Population   = pop,
    
    # Lags of controls
    L1U1 = dplyr::lag(u1, 1),
    L1U2 = dplyr::lag(u2, 1),
    L2U1 = dplyr::lag(u1, 2),
    L2U2 = dplyr::lag(u2, 2),
    
    L2CD = dplyr::lag(cd, 2),
    L3CD = dplyr::lag(cd, 3),
    
    L1Mafiosi     = dplyr::lag(mafiosi, 1),
    L1Extortion   = dplyr::lag(extortion, 1),
    L1Corruption1 = dplyr::lag(corruption1, 1),
    L1Corruption2 = dplyr::lag(corruption2, 1),
    L1Murder      = dplyr::lag(murder, 1),
    
    L2Mafiosi     = dplyr::lag(mafiosi, 2),
    L2Extortion   = dplyr::lag(extortion, 2),
    L2Corruption1 = dplyr::lag(corruption1, 2),
    L2Corruption2 = dplyr::lag(corruption2, 2),
    L2Murder      = dplyr::lag(murder, 2),
    
    CD_S1 = cds1,
    L1CD_S2 = dplyr::lag(cds2, 1)
    
  ) %>%
  ungroup()

# ---- Econometric estimations ----

# Static models without IV
{
  # Pooled without IV
  pool_s <- plm(formula = Y ~ G + L1G + L2G + L1U1 + L1U2 + L2U1 + L2U2 + L2CD + L3CD + Mafiosi +
                Extortion + Corruption1 + Corruption2 + Murder + L1Mafiosi +
                L1Extortion + L1Corruption1 + L1Corruption2 + L1Murder + 
                L2Mafiosi + L2Extortion + L2Corruption1 + L2Corruption2 + 
                L2Murder, data = Mafia, cluster = "Group", model = "pooling", weights = Population)
  summary(pool_s) # 9.6822e-05
  
  # Random effects without IV
  re_s <- plm(Y ~ 0 + G + Extortion + Mafiosi + Murder + Corruption1 + Corruption2 +
              L1Extortion + L1Mafiosi + L1Murder + L1Corruption1 + L1Corruption2 + 
              L2Extortion + L2Mafiosi + L2Murder + L2Corruption1 + L2Corruption2 + 
              L1U1 + L2U1 + L1U2 + L2U2 + L2CD + L3CD + L1G + L2G, 
            data = Mafia, cluster = "Group", model = "random", weights = Population)
  
  summary(re_s) # 1.9763e-05
  
  # Fixed Effects without IV
  fe_s <- plm(Y ~ 0 + G + L1G + L2G + L1U1 + L1U2 + L2U1 + L2U2 + L2CD + L3CD + Mafiosi +
              Extortion + Corruption1 + Corruption2 + Murder + L1Mafiosi +
              L1Extortion + L1Corruption1 + L1Corruption2 + L1Murder + 
              L2Mafiosi + L2Extortion + L2Corruption1 + L2Corruption2 + 
              L2Murder, data = Mafia, model = "within", effect = "twoways", cluster = "Group", 
            weights = Population)
  
  summary(fe_s) # 1.9261e-05
  
  # Defining the best model: test
  {
    pwtest(pool_s, data = Mafia) # 0.05277 
    
    plmtest(re_s, type = "bp") # 0.06291
    
    bptest(pool_s) #2.2e-16
    
    bgtest(pool_s, order = 1) # 0.03825
    
    pooltest(pool_s, fe_s) # 0.999
    
    pFtest(fe_s, pool_s) # 0.999
    
    phtest(fe_s, re_s) # 0.8276
  }
}
# Static models with IV
{
  # Pooled model with IV
  pool_iv_s <- plm(formula = Y ~ G + L1G + L2G + L1U1 + L1U2 + L2U1 + L2U2 + L2CD + L3CD + Mafiosi +
                   Extortion + Corruption1 + Corruption2 + Murder + L1Mafiosi +
                   L1Extortion + L1Corruption1 + L1Corruption2 + L1Murder + 
                   L2Mafiosi + L2Extortion + L2Corruption1 + L2Corruption2 + 
                   L2Murder | CD_S1 + L1CD_S2 + L1G + L2G + L1U1 + L1U2 + L2U1 + L2U2 + L2CD + L3CD + Mafiosi +
                   Extortion + Corruption1 + Corruption2 + Murder + L1Mafiosi +
                   L1Extortion + L1Corruption1 + L1Corruption2 + L1Murder + 
                   L2Mafiosi + L2Extortion + L2Corruption1 + L2Corruption2 + 
                   L2Murder, data = Mafia, model = "pooling")
  
  summary(pool_iv_s) # 0.42209
  
  # Fixed effects IV
  fe_iv_s <- plm(Y ~ G + L1G + L2G + L1U1 + L1U2 + L2U1 + L2U2 + L2CD + L3CD + Mafiosi +
                  Extortion + Corruption1 + Corruption2 + Murder + L1Mafiosi +
                  L1Extortion + L1Corruption1 + L1Corruption2 + L1Murder + 
                  L2Mafiosi + L2Extortion + L2Corruption1 + L2Corruption2 + 
                  L2Murder | CD_S1 + L1CD_S2 + L1U1 + L1U2 + L2U1 + L2U2 + L2CD + L3CD + Mafiosi +
                  Extortion + Corruption1 + Corruption2 + Murder + L1Mafiosi +
                  L1Extortion + L1Corruption1 + L1Corruption2 + L1Murder + 
                  L2Mafiosi + L2Extortion + L2Corruption1 + L2Corruption2 + 
                  L2Murder + L1G + L2G, data = Mafia, model = "within",
                effect = "twoways")
  summary(fe_iv_s) # 0.0035717
  
  # Random effects IV
  re_iv_s <- plm(Y ~ G + L1G + L2G + L1U1 + L1U2 + L2U1 + L2U2 + L2CD + L3CD + Mafiosi +
                   Extortion + Corruption1 + Corruption2 + Murder + L1Mafiosi +
                   L1Extortion + L1Corruption1 + L1Corruption2 + L1Murder + 
                   L2Mafiosi + L2Extortion + L2Corruption1 + L2Corruption2 + 
                   L2Murder | CD_S1 + L1CD_S2 + L1U1 + L1U2 + L2U1 + L2U2 + L2CD + L3CD + Mafiosi +
                   Extortion + Corruption1 + Corruption2 + Murder + L1Mafiosi +
                   L1Extortion + L1Corruption1 + L1Corruption2 + L1Murder + 
                   L2Mafiosi + L2Extortion + L2Corruption1 + L2Corruption2 + 
                   L2Murder + L1G + L2G, data = Mafia, model = "random")
  summary(re_iv_s) # 0.12316
}
# Dynamic models (FE with/without IV)
{
  fe_d <- plm(Y ~ G + L1G + L2G + L1Y + L2Y + L1U1 + L1U2 + L2U1 + L2U2 + L2CD + L3CD + Mafiosi +
               Extortion + Corruption1 + Corruption2 + Murder + L1Mafiosi +
               L1Extortion + L1Corruption1 + L1Corruption2 + L1Murder + 
               L2Mafiosi + L2Extortion + L2Corruption1 + L2Corruption2 + 
               L2Murder, data = Mafia, model = "within", effect = "twoways", cluster = "Group", 
             weights = Population)
  summary(fe_d) # 1.8639e-05
  
  fe_iv_d <- plm(Y ~ G + L1G + L2G + L1Y + L2Y + L1U1 + L1U2 + L2U1 + L2U2 + L2CD + L3CD + Mafiosi +
                  Extortion + Corruption1 + Corruption2 + Murder + L1Mafiosi +
                  L1Extortion + L1Corruption1 + L1Corruption2 + L1Murder + 
                  L2Mafiosi + L2Extortion + L2Corruption1 + L2Corruption2 + 
                  L2Murder | CD_S1 + L1CD_S2 + L1Y + L2Y + L1U1 + L1U2 + L2U1 + L2U2 + L2CD + L3CD + Mafiosi +
                  Extortion + Corruption1 + Corruption2 + Murder + L1Mafiosi +
                  L1Extortion + L1Corruption1 + L1Corruption2 + L1Murder + 
                  L2Mafiosi + L2Extortion + L2Corruption1 + L2Corruption2 + 
                  L2Murder + L1G + L2G, data = Mafia, model = "within",
                effect = "twoways", cluster = "Group")
  summary(fe_iv_d) # 0.6.073e-07
}
# Spatial models
{
# Data processing for spatial models
  {
    Mafia <- Mafia |> group_by(province) |> 
      summarise(media_Y = mean(Y), 
                mediana_Y = median(Y), 
                sd_Y = sd(Y), 
                media_G = mean(na.omit(G)), 
                mediana_G = median(na.omit(G)), 
                sd_G = sd(na.omit(G)), 
                media_Mafiosi = mean(na.omit(Mafiosi)), 
                mediana_Mafiosi = median(na.omit(Mafiosi)), 
                sd_Mafiosi = sd(na.omit(Mafiosi)))
    
    Mafia <- Mafia |> filter(year>= 1990 & year <= 1999) %>% pdata.frame(c("province","year"))
    
    data_mafia_geo1 <- left_join(x = Mafia, y = data_map1, by = c("region", "province")) %>%
      relocate(c(province,geometry), .before = province)
    
    data_mafia_geo1$Year <- as.numeric(as.character(data_mafia_geo1$year))
    
    knn4 <- knearneigh(coords, k = 4)
    nb_knn4 <- knn2nb(knn4)
    We_knn4 <- nb2listw(nb_knn4, style = "W")
    
    data_mafia_geo1$wG<-splm::slag(data_mafia_geo1$G, We_knn4, 1)
    data_mafia_geo1$wL1G<-splm::slag(data_mafia_geo1$L1G, We_knn4, 1)
    data_mafia_geo1$wL2G<-splm::slag(data_mafia_geo1$L2G, We_knn4, 1)
    data_mafia_geo1$wL1U1<-splm::slag(data_mafia_geo1$L1U1, We_knn4, 1)
    data_mafia_geo1$wL1U2<-splm::slag(data_mafia_geo1$L1U2, We_knn4, 1)
    data_mafia_geo1$wL2U1<-splm::slag(data_mafia_geo1$L2U1, We_knn4, 1)
    data_mafia_geo1$wL2U2<-splm::slag(data_mafia_geo1$L2U2, We_knn4, 1)
    data_mafia_geo1$wL2CD<-splm::slag(data_mafia_geo1$L2CD, We_knn4, 1)
    data_mafia_geo1$wL3CD<-splm::slag(data_mafia_geo1$L3CD, We_knn4, 1)
    data_mafia_geo1$wMafiosi<-splm::slag(data_mafia_geo1$Mafiosi, We_knn4, 1)
    data_mafia_geo1$wExtortion<-splm::slag(data_mafia_geo1$Extortion, We_knn4, 1)
    data_mafia_geo1$wCorruption1<-splm::slag(data_mafia_geo1$Corruption1, We_knn4, 1)
    data_mafia_geo1$wCorruption2<-splm::slag(data_mafia_geo1$Corruption2, We_knn4, 1)
    data_mafia_geo1$wMurder<-splm::slag(data_mafia_geo1$Murder, We_knn4, 1)
    data_mafia_geo1$wL1Mafiosi<-splm::slag(data_mafia_geo1$L1Mafiosi, We_knn4, 1)
    data_mafia_geo1$wL1Extortion<-splm::slag(data_mafia_geo1$L1Extortion, We_knn4, 1)
    data_mafia_geo1$wL1Corruption1<-splm::slag(data_mafia_geo1$L1Corruption1, We_knn4, 1)
    data_mafia_geo1$wL1Corruption2<-splm::slag(data_mafia_geo1$L1Corruption2, We_knn4, 1)
    data_mafia_geo1$wL1Murder<-splm::slag(data_mafia_geo1$L1Murder, We_knn4, 1)
    data_mafia_geo1$wL2Mafiosi<-splm::slag(data_mafia_geo1$L2Mafiosi, We_knn4, 1)
    data_mafia_geo1$wL2Extortion<-splm::slag(data_mafia_geo1$L2Extortion, We_knn4, 1)
    data_mafia_geo1$wL2Corruption1<-splm::slag(data_mafia_geo1$L2Corruption1, We_knn4, 1)
    data_mafia_geo1$wL2Corruption2<-splm::slag(data_mafia_geo1$L2Corruption2, We_knn4, 1)
    data_mafia_geo1$wL2Murder<-splm::slag(data_mafia_geo1$L2Murder, We_knn4, 1)
    
    data_mafia_geo1$wCD_S1<-splm::slag(data_mafia_geo1$CD_S1, We_knn4, 1)
    data_mafia_geo1$wL1CD_S2<-splm::slag(data_mafia_geo1$L1CD_S2, We_knn4, 1)
    data_mafia_geo1$wL1Y<-splm::slag(data_mafia_geo1$L1Y, We_knn4, 1)
    data_mafia_geo1$wL2Y<-splm::slag(data_mafia_geo1$L2Y, We_knn4, 1)
  }
  
}

# Efectos espaciales
{
  #Fixed effects spatial models estáticos-----
{
{

}
  
  
  # Modelo SAR
  sarfe <- spml(Y ~ G + L1G + L2G + L1U1 + L1U2 + L2U1 + L2U2 + L2CD + L3CD + Mafiosi +
                  Extortion + Corruption1 + Corruption2 + Murder + L1Mafiosi +
                  L1Extortion + L1Corruption1 + L1Corruption2 + L1Murder + 
                  L2Mafiosi + L2Extortion + L2Corruption1 + L2Corruption2 + 
                  L2Murder | CD_S1 + L1CD_S2 + L1G + L2G + L1U1 + L1U2 + L2U1 + L2U2 + L2CD + L3CD + Mafiosi +
                  Extortion + Corruption1 + Corruption2 + Murder + L1Mafiosi +
                  L1Extortion + L1Corruption1 + L1Corruption2 + L1Murder + 
                  L2Mafiosi + L2Extortion + L2Corruption1 + L2Corruption2 + 
                  L2Murder, data = data_mafia_geo1, listw = We_knn4, spatial.error="none", lag=TRUE, 
                model = "within", effect = "twoways", method = "eigen")
  summary(sarfe) #0.1995982, significant 
  
  # Modelo SEM
  semfe <- spml(Y ~ G + L1G + L2G + L1U1 + L1U2 + L2U1 + L2U2 + L2CD + L3CD + Mafiosi +
                  Extortion + Corruption1 + Corruption2 + Murder + L1Mafiosi +
                  L1Extortion + L1Corruption1 + L1Corruption2 + L1Murder + 
                  L2Mafiosi + L2Extortion + L2Corruption1 + L2Corruption2 + 
                  L2Murder | CD_S1 + L1CD_S2 + L1G + L2G + L1U1 + L1U2 + L2U1 + L2U2 + L2CD + L3CD + Mafiosi +
                  Extortion + Corruption1 + Corruption2 + Murder + L1Mafiosi +
                  L1Extortion + L1Corruption1 + L1Corruption2 + L1Murder + 
                  L2Mafiosi + L2Extortion + L2Corruption1 + L2Corruption2 + 
                  L2Murder, data = data_mafia_geo1, listw = We_knn4, lag = FALSE, 
                spatial.error = "b",  model = "within", effect = "twoways", method = "eigen")
  summary(semfe) #0.196581, significant 
  
  # Modelo SAC-SARAR-SARMA
  sararfe <- spml(Y ~ G + L1G + L2G + L1U1 + L1U2 + L2U1 + L2U2 + L2CD + L3CD + Mafiosi +
                    Extortion + Corruption1 + Corruption2 + Murder + L1Mafiosi +
                    L1Extortion + L1Corruption1 + L1Corruption2 + L1Murder + 
                    L2Mafiosi + L2Extortion + L2Corruption1 + L2Corruption2 + 
                    L2Murder | CD_S1 + L1CD_S2 + L1G + L2G + L1U1 + L1U2 + L2U1 + L2U2 + L2CD + L3CD + Mafiosi +
                    Extortion + Corruption1 + Corruption2 + Murder + L1Mafiosi +
                    L1Extortion + L1Corruption1 + L1Corruption2 + L1Murder + 
                    L2Mafiosi + L2Extortion + L2Corruption1 + L2Corruption2 + 
                    L2Murder, data = data_mafia_geo1, listw = We_knn4, lag = TRUE, 
                  spatial.error = "b", model = "within", effect = "twoways", method = "eigen")
  summary(sararfe) #0.1996363  significant 
  
  # Modelo Spatial Durbin model
  sdmfe <- spml(Y ~ G + L1G + L2G + L1U1 + L1U2 + L2U1 + L2U2 + L2CD + L3CD + Mafiosi +
                  Extortion + Corruption1 + Corruption2 + Murder + L1Mafiosi +
                  L1Extortion + L1Corruption1 + L1Corruption2 + L1Murder + 
                  L2Mafiosi + L2Extortion + L2Corruption1 + L2Corruption2 + 
                  L2Murder + wG + wL1G + wL2G + wL1U1 + wL1U2 + wL2U1 + wL2U2 + wL2CD + wL3CD + wMafiosi +
                  wExtortion + wCorruption1 + wCorruption2 + wMurder + wL1Mafiosi +
                  wL1Extortion + wL1Corruption1 + wL1Corruption2 + wL1Murder + 
                  wL2Mafiosi + wL2Extortion + wL2Corruption1 + wL2Corruption2 + 
                  wL2Murder| CD_S1 + L1CD_S2 + L1G + L2G + L1U1 + L1U2 + L2U1 + L2U2 + L2CD + L3CD + Mafiosi +
                  Extortion + Corruption1 + Corruption2 + Murder + L1Mafiosi +
                  L1Extortion + L1Corruption1 + L1Corruption2 + L1Murder + 
                  L2Mafiosi + L2Extortion + L2Corruption1 + L2Corruption2 + 
                  L2Murder + wG + wL1G + wL2G + wL1U1 + wL1U2 + wL2U1 + wL2U2 + wL2CD + wL3CD + wMafiosi +
                  wExtortion + wCorruption1 + wCorruption2 + wMurder + wL1Mafiosi +
                  wL1Extortion + wL1Corruption1 + wL1Corruption2 + wL1Murder + 
                  wL2Mafiosi + wL2Extortion + wL2Corruption1 + wL2Corruption2 + 
                  wL2Murder + wCD_S1 + wL1CD_S2, data = data_mafia_geo1, listw = We_knn4, lag = TRUE, 
                spatial.error = "none", model = "within", effect = "twoways", method = "eigen")
  summary(sdmfe) #0.193292, significant
  
  # Modelo Spatial Durbin error model
  sdemfe <- spml(Y ~ G + L1G + L2G + L1U1 + L1U2 + L2U1 + L2U2 + L2CD + L3CD + Mafiosi +
                   Extortion + Corruption1 + Corruption2 + Murder + L1Mafiosi +
                   L1Extortion + L1Corruption1 + L1Corruption2 + L1Murder + 
                   L2Mafiosi + L2Extortion + L2Corruption1 + L2Corruption2 + 
                   L2Murder + wG + wL1G + wL2G + wL1U1 + wL1U2 + wL2U1 + wL2U2 + wL2CD + wL3CD + wMafiosi +
                   wExtortion + wCorruption1 + wCorruption2 + wMurder + wL1Mafiosi +
                   wL1Extortion + wL1Corruption1 + wL1Corruption2 + wL1Murder + 
                   wL2Mafiosi + wL2Extortion + wL2Corruption1 + wL2Corruption2 + 
                   wL2Murder| CD_S1 + L1CD_S2 + L1G + L2G + L1U1 + L1U2 + L2U1 + L2U2 + L2CD + L3CD + Mafiosi +
                   Extortion + Corruption1 + Corruption2 + Murder + L1Mafiosi +
                   L1Extortion + L1Corruption1 + L1Corruption2 + L1Murder + 
                   L2Mafiosi + L2Extortion + L2Corruption1 + L2Corruption2 + 
                   L2Murder + wG + wL1G + wL2G + wL1U1 + wL1U2 + wL2U1 + wL2U2 + wL2CD + wL3CD + wMafiosi +
                   wExtortion + wCorruption1 + wCorruption2 + wMurder + wL1Mafiosi +
                   wL1Extortion + wL1Corruption1 + wL1Corruption2 + wL1Murder + 
                   wL2Mafiosi + wL2Extortion + wL2Corruption1 + wL2Corruption2 + 
                   wL2Murder + wCD_S1 + wL1CD_S2, data = data_mafia_geo1, listw = We_knn4, lag = FALSE, 
                 spatial.error = "b", model = "within", effect = "twoways", method = "eigen")
  summary(sdemfe) #0.195267, significant
  
  # Modelo SLX
  slxfe <- plm(Y ~ G + L1G + L2G + L1U1 + L1U2 + L2U1 + L2U2 + L2CD + L3CD + Mafiosi +
                 Extortion + Corruption1 + Corruption2 + Murder + L1Mafiosi +
                 L1Extortion + L1Corruption1 + L1Corruption2 + L1Murder + 
                 L2Mafiosi + L2Extortion + L2Corruption1 + L2Corruption2 + 
                 L2Murder + wG + wL1G + wL2G + wL1U1 + wL1U2 + wL2U1 + wL2U2 + wL2CD + wL3CD + wMafiosi +
                 wExtortion + wCorruption1 + wCorruption2 + wMurder + wL1Mafiosi +
                 wL1Extortion + wL1Corruption1 + wL1Corruption2 + wL1Murder + 
                 wL2Mafiosi + wL2Extortion + wL2Corruption1 + wL2Corruption2 + 
                 wL2Murder| + CD_S1 + L1CD_S2 + L1G + L2G + L1U1 + L1U2 + L2U1 + L2U2 + L2CD + L3CD + Mafiosi +
                 Extortion + Corruption1 + Corruption2 + Murder + L1Mafiosi +
                 L1Extortion + L1Corruption1 + L1Corruption2 + L1Murder + 
                 L2Mafiosi + L2Extortion + L2Corruption1 + L2Corruption2 + 
                 L2Murder + wG + wL1G + wL2G + wL1U1 + wL1U2 + wL2U1 + wL2U2 + wL2CD + wL3CD + wMafiosi +
                 wExtortion + wCorruption1 + wCorruption2 + wMurder + wL1Mafiosi +
                 wL1Extortion + wL1Corruption1 + wL1Corruption2 + wL1Murder + 
                 wL2Mafiosi + wL2Extortion + wL2Corruption1 + wL2Corruption2 + 
                 wL2Murder + wCD_S1 + wL1CD_S2, data = data_mafia_geo1, model = "within", effect = "twoways", method = "eigen")
  summary(slxfe) #0.9936156, significant 

}
  
  #Fixed effects spatial models dinámicos-----
  {
    {
      knn4 <- knearneigh(coords, k = 4)
      nb_knn4 <- knn2nb(knn4)
      We_knn4 <- nb2listw(nb_knn4, style = "W")
      
      data_mafia_geo1$wG<-splm::slag(data_mafia_geo1$G, We_knn4, 1)
      data_mafia_geo1$wL1G<-splm::slag(data_mafia_geo1$L1G, We_knn4, 1)
      data_mafia_geo1$wL2G<-splm::slag(data_mafia_geo1$L2G, We_knn4, 1)
      data_mafia_geo1$wL1U1<-splm::slag(data_mafia_geo1$L1U1, We_knn4, 1)
      data_mafia_geo1$wL1U2<-splm::slag(data_mafia_geo1$L1U2, We_knn4, 1)
      data_mafia_geo1$wL2U1<-splm::slag(data_mafia_geo1$L2U1, We_knn4, 1)
      data_mafia_geo1$wL2U2<-splm::slag(data_mafia_geo1$L2U2, We_knn4, 1)
      data_mafia_geo1$wL2CD<-splm::slag(data_mafia_geo1$L2CD, We_knn4, 1)
      data_mafia_geo1$wL3CD<-splm::slag(data_mafia_geo1$L3CD, We_knn4, 1)
      data_mafia_geo1$wMafiosi<-splm::slag(data_mafia_geo1$Mafiosi, We_knn4, 1)
      data_mafia_geo1$wExtortion<-splm::slag(data_mafia_geo1$Extortion, We_knn4, 1)
      data_mafia_geo1$wCorruption1<-splm::slag(data_mafia_geo1$Corruption1, We_knn4, 1)
      data_mafia_geo1$wCorruption2<-splm::slag(data_mafia_geo1$Corruption2, We_knn4, 1)
      data_mafia_geo1$wMurder<-splm::slag(data_mafia_geo1$Murder, We_knn4, 1)
      data_mafia_geo1$wL1Mafiosi<-splm::slag(data_mafia_geo1$L1Mafiosi, We_knn4, 1)
      data_mafia_geo1$wL1Extortion<-splm::slag(data_mafia_geo1$L1Extortion, We_knn4, 1)
      data_mafia_geo1$wL1Corruption1<-splm::slag(data_mafia_geo1$L1Corruption1, We_knn4, 1)
      data_mafia_geo1$wL1Corruption2<-splm::slag(data_mafia_geo1$L1Corruption2, We_knn4, 1)
      data_mafia_geo1$wL1Murder<-splm::slag(data_mafia_geo1$L1Murder, We_knn4, 1)
      data_mafia_geo1$wL2Mafiosi<-splm::slag(data_mafia_geo1$L2Mafiosi, We_knn4, 1)
      data_mafia_geo1$wL2Extortion<-splm::slag(data_mafia_geo1$L2Extortion, We_knn4, 1)
      data_mafia_geo1$wL2Corruption1<-splm::slag(data_mafia_geo1$L2Corruption1, We_knn4, 1)
      data_mafia_geo1$wL2Corruption2<-splm::slag(data_mafia_geo1$L2Corruption2, We_knn4, 1)
      data_mafia_geo1$wL2Murder<-splm::slag(data_mafia_geo1$L2Murder, We_knn4, 1)
      
      data_mafia_geo1$wCD_S1<-splm::slag(data_mafia_geo1$CD_S1, We_knn4, 1)
      data_mafia_geo1$wL1CD_S2<-splm::slag(data_mafia_geo1$L1CD_S2, We_knn4, 1)
      data_mafia_geo1$wL1Y<-splm::slag(data_mafia_geo1$L1Y, We_knn4, 1)
      data_mafia_geo1$wL2Y<-splm::slag(data_mafia_geo1$L2Y, We_knn4, 1)
    }
    
    
    # Modelo SAR
    sarfe <- spml(Y ~ G + L1G + L2G + L1U1 + L1U2 + L2U1 + L2U2 + L2CD + L3CD + Mafiosi +
                    Extortion + Corruption1 + Corruption2 + Murder + L1Mafiosi +
                    L1Extortion + L1Corruption1 + L1Corruption2 + L1Murder + 
                    L2Mafiosi + L2Extortion + L2Corruption1 + L2Corruption2 + 
                    L2Murder | CD_S1 + L1CD_S2 + L1G + L2G + L1U1 + L1U2 + L2U1 + L2U2 + L2CD + L3CD + Mafiosi +
                    Extortion + Corruption1 + Corruption2 + Murder + L1Mafiosi +
                    L1Extortion + L1Corruption1 + L1Corruption2 + L1Murder + 
                    L2Mafiosi + L2Extortion + L2Corruption1 + L2Corruption2 + 
                    L2Murder, data = data_mafia_geo1, listw = We_knn4, spatial.error="none", lag=TRUE, 
                  model = "within", effect = "twoways", method = "eigen")
    summary(sarfe) #0.1995982, significant 
    
    # Modelo SEM
    semfe <- spml(Y ~ G + L1G + L2G + L1U1 + L1U2 + L2U1 + L2U2 + L2CD + L3CD + Mafiosi +
                    Extortion + Corruption1 + Corruption2 + Murder + L1Mafiosi +
                    L1Extortion + L1Corruption1 + L1Corruption2 + L1Murder + 
                    L2Mafiosi + L2Extortion + L2Corruption1 + L2Corruption2 + 
                    L2Murder | CD_S1 + L1CD_S2 + L1G + L2G + L1U1 + L1U2 + L2U1 + L2U2 + L2CD + L3CD + Mafiosi +
                    Extortion + Corruption1 + Corruption2 + Murder + L1Mafiosi +
                    L1Extortion + L1Corruption1 + L1Corruption2 + L1Murder + 
                    L2Mafiosi + L2Extortion + L2Corruption1 + L2Corruption2 + 
                    L2Murder, data = data_mafia_geo1, listw = We_knn4, lag = FALSE, 
                  spatial.error = "b",  model = "within", effect = "twoways", method = "eigen")
    summary(semfe) #0.196581, significant 
    
    # Modelo SAC-SARAR-SARMA
    sararfe <- spml(Y ~ G + L1G + L2G + L1U1 + L1U2 + L2U1 + L2U2 + L2CD + L3CD + Mafiosi +
                      Extortion + Corruption1 + Corruption2 + Murder + L1Mafiosi +
                      L1Extortion + L1Corruption1 + L1Corruption2 + L1Murder + 
                      L2Mafiosi + L2Extortion + L2Corruption1 + L2Corruption2 + 
                      L2Murder | CD_S1 + L1CD_S2 + L1G + L2G + L1U1 + L1U2 + L2U1 + L2U2 + L2CD + L3CD + Mafiosi +
                      Extortion + Corruption1 + Corruption2 + Murder + L1Mafiosi +
                      L1Extortion + L1Corruption1 + L1Corruption2 + L1Murder + 
                      L2Mafiosi + L2Extortion + L2Corruption1 + L2Corruption2 + 
                      L2Murder, data = data_mafia_geo1, listw = We_knn4, lag = TRUE, 
                    spatial.error = "b", model = "within", effect = "twoways", method = "eigen")
    summary(sararfe) #0.1996363  significant 
    
    # Modelo Spatial Durbin model
    sdmfe <- spml(Y ~ G + L1G + L2G + L1U1 + L1U2 + L2U1 + L2U2 + L2CD + L3CD + Mafiosi +
                    Extortion + Corruption1 + Corruption2 + Murder + L1Mafiosi +
                    L1Extortion + L1Corruption1 + L1Corruption2 + L1Murder + 
                    L2Mafiosi + L2Extortion + L2Corruption1 + L2Corruption2 + 
                    L2Murder + wG + wL1G + wL2G + wL1U1 + wL1U2 + wL2U1 + wL2U2 + wL2CD + wL3CD + wMafiosi +
                    wExtortion + wCorruption1 + wCorruption2 + wMurder + wL1Mafiosi +
                    wL1Extortion + wL1Corruption1 + wL1Corruption2 + wL1Murder + 
                    wL2Mafiosi + wL2Extortion + wL2Corruption1 + wL2Corruption2 + 
                    wL2Murder| CD_S1 + L1CD_S2 + L1G + L2G + L1U1 + L1U2 + L2U1 + L2U2 + L2CD + L3CD + Mafiosi +
                    Extortion + Corruption1 + Corruption2 + Murder + L1Mafiosi +
                    L1Extortion + L1Corruption1 + L1Corruption2 + L1Murder + 
                    L2Mafiosi + L2Extortion + L2Corruption1 + L2Corruption2 + 
                    L2Murder + wG + wL1G + wL2G + wL1U1 + wL1U2 + wL2U1 + wL2U2 + wL2CD + wL3CD + wMafiosi +
                    wExtortion + wCorruption1 + wCorruption2 + wMurder + wL1Mafiosi +
                    wL1Extortion + wL1Corruption1 + wL1Corruption2 + wL1Murder + 
                    wL2Mafiosi + wL2Extortion + wL2Corruption1 + wL2Corruption2 + 
                    wL2Murder + wCD_S1 + wL1CD_S2, data = data_mafia_geo1, listw = We_knn4, lag = TRUE, 
                  spatial.error = "none", model = "within", effect = "twoways", method = "eigen")
    summary(sdmfe) #0.193292, significant
    
    # Modelo Spatial Durbin error model
    sdemfe <- spml(Y ~ G + L1G + L2G + L1U1 + L1U2 + L2U1 + L2U2 + L2CD + L3CD + Mafiosi +
                     Extortion + Corruption1 + Corruption2 + Murder + L1Mafiosi +
                     L1Extortion + L1Corruption1 + L1Corruption2 + L1Murder + 
                     L2Mafiosi + L2Extortion + L2Corruption1 + L2Corruption2 + 
                     L2Murder + wG + wL1G + wL2G + wL1U1 + wL1U2 + wL2U1 + wL2U2 + wL2CD + wL3CD + wMafiosi +
                     wExtortion + wCorruption1 + wCorruption2 + wMurder + wL1Mafiosi +
                     wL1Extortion + wL1Corruption1 + wL1Corruption2 + wL1Murder + 
                     wL2Mafiosi + wL2Extortion + wL2Corruption1 + wL2Corruption2 + 
                     wL2Murder| CD_S1 + L1CD_S2 + L1G + L2G + L1U1 + L1U2 + L2U1 + L2U2 + L2CD + L3CD + Mafiosi +
                     Extortion + Corruption1 + Corruption2 + Murder + L1Mafiosi +
                     L1Extortion + L1Corruption1 + L1Corruption2 + L1Murder + 
                     L2Mafiosi + L2Extortion + L2Corruption1 + L2Corruption2 + 
                     L2Murder + wG + wL1G + wL2G + wL1U1 + wL1U2 + wL2U1 + wL2U2 + wL2CD + wL3CD + wMafiosi +
                     wExtortion + wCorruption1 + wCorruption2 + wMurder + wL1Mafiosi +
                     wL1Extortion + wL1Corruption1 + wL1Corruption2 + wL1Murder + 
                     wL2Mafiosi + wL2Extortion + wL2Corruption1 + wL2Corruption2 + 
                     wL2Murder + wCD_S1 + wL1CD_S2, data = data_mafia_geo1, listw = We_knn4, lag = FALSE, 
                   spatial.error = "b", model = "within", effect = "twoways", method = "eigen")
    summary(sdemfe) #0.195267, significant
    
    # Modelo SLX
    slxfe <- plm(Y ~ G + L1G + L2G + L1U1 + L1U2 + L2U1 + L2U2 + L2CD + L3CD + Mafiosi +
                   Extortion + Corruption1 + Corruption2 + Murder + L1Mafiosi +
                   L1Extortion + L1Corruption1 + L1Corruption2 + L1Murder + 
                   L2Mafiosi + L2Extortion + L2Corruption1 + L2Corruption2 + 
                   L2Murder + wG + wL1G + wL2G + wL1U1 + wL1U2 + wL2U1 + wL2U2 + wL2CD + wL3CD + wMafiosi +
                   wExtortion + wCorruption1 + wCorruption2 + wMurder + wL1Mafiosi +
                   wL1Extortion + wL1Corruption1 + wL1Corruption2 + wL1Murder + 
                   wL2Mafiosi + wL2Extortion + wL2Corruption1 + wL2Corruption2 + 
                   wL2Murder| + CD_S1 + L1CD_S2 + L1G + L2G + L1U1 + L1U2 + L2U1 + L2U2 + L2CD + L3CD + Mafiosi +
                   Extortion + Corruption1 + Corruption2 + Murder + L1Mafiosi +
                   L1Extortion + L1Corruption1 + L1Corruption2 + L1Murder + 
                   L2Mafiosi + L2Extortion + L2Corruption1 + L2Corruption2 + 
                   L2Murder + wG + wL1G + wL2G + wL1U1 + wL1U2 + wL2U1 + wL2U2 + wL2CD + wL3CD + wMafiosi +
                   wExtortion + wCorruption1 + wCorruption2 + wMurder + wL1Mafiosi +
                   wL1Extortion + wL1Corruption1 + wL1Corruption2 + wL1Murder + 
                   wL2Mafiosi + wL2Extortion + wL2Corruption1 + wL2Corruption2 + 
                   wL2Murder + wCD_S1 + wL1CD_S2, data = data_mafia_geo1, model = "within", effect = "twoways", method = "eigen")
    summary(slxfe) #0.9936156, significant 
    
  }
  
  sdmfe1 <- spml(Y ~ G + L1G + L2G + L1Y + L2Y + L1U1 + L1U2 + L2U1 + L2U2 + L2CD + L3CD + Mafiosi +
                   Extortion + Corruption1 + Corruption2 + Murder + L1Mafiosi +
                   L1Extortion + L1Corruption1 + L1Corruption2 + L1Murder + 
                   L2Mafiosi + L2Extortion + L2Corruption1 + L2Corruption2 + 
                   L2Murder + wG + wL1G + wL2G + wL1U1 + wL1U2 + wL2U1 + wL2U2 + wL2CD + wL3CD + wMafiosi +
                   wExtortion + wCorruption1 + wCorruption2 + wMurder + wL1Mafiosi +
                   wL1Extortion + wL1Corruption1 + wL1Corruption2 + wL1Murder + 
                   wL2Mafiosi + wL2Extortion + wL2Corruption1 + wL2Corruption2 + 
                   wL2Murder + L1Y + L2Y | + CD_S1 + L1CD_S2 + L1G + L2G + L1U1 + L1U2 + L2U1 + L2U2 + L2CD + L3CD + Mafiosi +
                   Extortion + Corruption1 + Corruption2 + Murder + L1Mafiosi +
                   L1Extortion + L1Corruption1 + L1Corruption2 + L1Murder + 
                   L2Mafiosi + L2Extortion + L2Corruption1 + L2Corruption2 + 
                   L2Murder + L1Y + L2Y + wG + wL1G + wL2G + wL1U1 + wL1U2 + wL2U1 + wL2U2 + wL2CD + wL3CD + wMafiosi +
                   wExtortion + wCorruption1 + wCorruption2 + wMurder + wL1Mafiosi +
                   wL1Extortion + wL1Corruption1 + wL1Corruption2 + wL1Murder + 
                   wL2Mafiosi + wL2Extortion + wL2Corruption1 + wL2Corruption2 + 
                   wL2Murder + wCD_S1 + wL1CD_S2 + wL1Y + wL2Y, data = data_mafia_geo1, listw = We_knn4, lag = TRUE, 
                 spatial.error = "none", model = "within", index = c("province", "year"), effect = "twoways", cluster = "Group", 
                 weights = Population)
  
  summary(sdmfe1) #1.9326e-01, significant
  
  
}



