
library(highcharter)
library(dplyr)
library(fst)

# dat4 <- read_fst("data/fst4")
# dat5 <- read_fst("data/fst5")
# dat6 <- read_fst("data/fst6")
# dat7 <- read_fst("data/fst7")
# dat8 <- read_fst("data/fst8")
dat9 <- read_fst("data/fst9")
demographics <- read_fst("data/demographics")

column_names <- c("mortgage_open", "bankcard_limit", "total_revolving_limit")
aggregate_fun <- function(x) mean(x)

out <- dat9 %>%
  select(column_names) %>%
  mutate(homebuyers = demographics$homebuyers) %>%
  group_by(homebuyers) %>%
  summarise_at(column_names, aggregate_fun)


series <- vector("list", ncol(out) - 1)

for (i in seq_len(ncol(out) - 1)) {
  series[[i]] <- list(
    data = out[[i+1]],
    name = names(out)[[i+1]]
  )
}

highchart() %>%
  hc_chart(type = "line") %>%
  hc_xAxis(categories = out[[1]]) %>%
  hc_add_series_list(series)
