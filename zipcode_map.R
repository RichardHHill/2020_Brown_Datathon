
# zipcode is archived. Download the most recent version from https://cran.r-project.org/src/contrib/Archive/zipcode/
# In RStudio, go to packages, click install, set install from to package archive, and use the file path of your download
# Same with fiftystater: https://cran.r-project.org/src/contrib/Archive/fiftystater/
library(zipcode)
library(feather)
library(dplyr)
library(ggplot2)
library(fiftystater)
library(highcharter)

data(zipcode)
data("fifty_states")

demographics <- read_feather("data/demographics")

out <- demographics %>%
  group_by(zip5) %>%
  summarise(total_buyers = n()) %>%
  mutate(zip5 = as.character(zip5)) %>%
  inner_join(zipcode, by = c("zip5" = "zip")) %>%
  arrange(desc(total_buyers)) %>%
  select(name = zip5, lat = latitude, lon = longitude, z = total_buyers) %>%
  head(150)

hcmap(map = "countries/us/us-all", showInLegend = FALSE) %>%
  hc_add_series(
    type = "mapbubble",
    name = "Zip Code",
    data = out,
    maxSize = "5%",
    showInLegend = FALSE
  ) %>%
  hc_mapNavigation(enabled = TRUE)
