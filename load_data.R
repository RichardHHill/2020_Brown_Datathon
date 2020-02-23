
library(feather)
library(dplyr)
library(highcharter)

demographics_path <- "citizens-home-financing-challenge/zip9_demographics_coded_pv.csv"

hold <- read.csv(demographics_path)
write_feather(hold, "data/demographics")

paths <- c(
  "citizens-home-financing-challenge/zip9_coded_201904_pv.csv",
  "citizens-home-financing-challenge/zip9_coded_201905_pv.csv",
  "citizens-home-financing-challenge/zip9_coded_201906_pv.csv",
  "citizens-home-financing-challenge/zip9_coded_201907_pv.csv",
  "citizens-home-financing-challenge/zip9_coded_201908_pv.csv",
  "citizens-home-financing-challenge/zip9_coded_201909_pv.csv"
)

for (i in 1:6) {
  hold <- read.csv(paths[i])

  write_feather(hold, paste0("data/dat", i + 3))
}
