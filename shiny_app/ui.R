
head <- dashboardHeader(
  title = "Brown Datathon 2020"
)

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem(
      text = "Parameter Comparison",
      tabName = "parameter_chart"
    ),
    menuItem(
      text = "Zip Code Map",
      tabName = "zip_code"
    )
  )
)

body <- dashboardBody(
  tabItems(
    tabItem(
      tabName = "parameter_chart",
      box(
        width = 9,
        fluidRow(
          column(
            3,
            pickerInput(
              "parameters",
              "Parameters",
              choices = names(dat9)[3:ncol(dat9)],
              selected = names(dat9)[3:7],
              multiple = TRUE,
              options = list(
                actionsBox = TRUE
              )
            )
          ),
          column(
            2,
            pickerInput(
              "aggregate_fun",
              "Aggregate Statistic",
              choices = list("Mean", "Median")
            )
          )
        ),
        fluidRow(
          highchartOutput("parameters_chart")
        )
      ),
      box(
        width = 3,
        DTOutput("category_count")
      )
    ),
    tabItem(
      tabName = "zip_code",
      box(
        width = 12,
        fluidRow(
          column(
            2,
            numericInput(
              "num_zipcodes",
              "# Zipcodes to Display",
              150,
              min = 0
            )
          )
        ),
        fluidRow(
          highchartOutput("map", height = "800px")
        )
      )
    )
  )
)

dashboardPage(
  head,
  sidebar,
  body,
  skin = "black"
)
