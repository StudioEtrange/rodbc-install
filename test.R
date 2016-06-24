localRepo <- Sys.getenv("LOCAL_R_REPO")

library(RODBC,lib.loc=localRepo)

library("RODBC")
odbcDataSources()
