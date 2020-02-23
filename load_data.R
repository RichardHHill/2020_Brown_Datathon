
library(dplyr)
library(highcharter)
library(fst)

demographics_path <- "citizens-home-financing-challenge/zip9_demographics_coded_pv.csv"

hold <- read.csv(demographics_path)
write_fst(hold, "data/demographics")

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

  write_fst(hold, paste0("data/fst", i + 3))
}

