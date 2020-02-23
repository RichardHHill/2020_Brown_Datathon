
library(shiny)
library(shinydashboard)
library(fst)
library(shinyWidgets)
library(DT)
library(zipcode)
library(fiftystater)
library(highcharter)
library(dplyr)

data(zipcode)
data(fifty_states)

dat9 <- read_fst("data/fst9")
demographics <- read_fst("data/demographics")
