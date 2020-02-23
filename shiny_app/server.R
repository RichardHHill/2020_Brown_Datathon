
function(input, output, session) {

  output$category_count <- renderDT({
    out <- demographics %>%
      group_by(homebuyers) %>%
      summarise(n = n()) %>%
      select("Number of Homebuyers" = homebuyers, Count = n)

    datatable(
      out,
      rownames = FALSE,
      options = list(
        pageLength = nrow(out),
        dom = "t"
      )
    )
  })

  parameters_chart_prep <- reactive({
    funs <- list(
      Mean = mean,
      Median = median
    )

    out <- dat9 %>%
      select(input$parameters) %>%
      mutate(homebuyers = demographics$homebuyers) %>%
      group_by(homebuyers) %>%
      summarise_at(input$parameters, funs[[input$aggregate_fun]])

    series <- vector("list", ncol(out) - 1)

    for (i in seq_len(ncol(out) - 1)) {
      series[[i]] <- list(
        data = out[[i+1]],
        name = names(out)[[i+1]]
      )
    }

    list(
      series,
      out$homebuyers
    )
  })

  output$parameters_chart <- renderHighchart({
    series <- parameters_chart_prep()[1][[1]]
    cats <- parameters_chart_prep()[2][[1]]

    highchart() %>%
      hc_title(text = "Aggregate by Number of Homes Bought") %>%
      hc_chart(type = "line") %>%
      hc_xAxis(categories = cats) %>%
      hc_add_series_list(series)
  })

  map_prep <- reactive({
    demographics %>%
      group_by(zip5) %>%
      summarise(total_buyers = n()) %>%
      mutate(zip5 = as.character(zip5)) %>%
      inner_join(zipcode, by = c("zip5" = "zip")) %>%
      arrange(desc(total_buyers)) %>%
      select(name = zip5, lat = latitude, lon = longitude, z = total_buyers) %>%
      head(if (is.na(input$num_zipcodes)) 0 else input$num_zipcodes)
  })

  output$map <- renderHighchart({
    out <- map_prep()

    hcmap(map = "countries/us/us-all", showInLegend = FALSE) %>%
      hc_title(text = "Zipcodes With the Greatest Number of Homebuyers") %>%
      hc_add_series(
        type = "mapbubble",
        name = "Zip Code",
        data = out,
        maxSize = "5%",
        showInLegend = FALSE
      ) %>%
      hc_mapNavigation(enabled = TRUE)
  })
}
