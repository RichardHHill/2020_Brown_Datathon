
# zipcode is archived. Download the most recent version from https://cran.r-project.org/src/contrib/Archive/zipcode/
# In RStudio, go to packages, click install, set install from to package archive, and use the file path of your download
# Same with fiftystater: https://cran.r-project.org/src/contrib/Archive/fiftystater/
library(zipcode)
library(feather)
library(dplyr)
library(ggplot2)
library(fiftystater)

data(zipcode)
data("fifty_states")

demographics <- read_feather("data/demographics")

out <- demographics %>%
  group_by(zip5) %>%
  summarise(total_buyers = n()) %>%
  mutate(zip5 = as.character(zip5)) %>%
  inner_join(zipcode, by = c("zip5" = "zip"))

ggplot() +
  geom_polygon(data=fifty_states, aes(x=long, y=lat, group = group),color="white", fill="grey92" ) +
  geom_point(data=out, aes(x=longitude, y=latitude, size = total_buyers / 100), alpha = 0.1)
