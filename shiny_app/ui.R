
head <- dashboardHeader(
  title = "Brown Datathon 2020"
)

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem(
      text = "Column Comparison",
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
        width = 6,
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
          )
        ),
        fluidRow(
          highchartOutput("parameters_chart")
        )
      ),
      box(
        width = 6,
        DTOutput("category_count")
      )
    ),
    tabItem(
      tabName = "zip_code"
    )
  )
)

dashboardPage(
  head,
  sidebar,
  body,
  skin = "black"
)
