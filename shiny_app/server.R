
function(input, output, session) {

  output$category_count <- renderDT({
    out <- demographics %>%
      group_by(homebuyers) %>%
      summarise(n = n()) %>%
      select("Num Homebuyers" = homebuyers, Count = n)

    datatable(
      out,
      rownames = FALSE
    )
  })

  parameters_chart_prep <- reactive({
    aggregate_fun <- function(x) mean(x)

    out <- dat9 %>%
      select(input$parameters) %>%
      mutate(homebuyers = demographics$homebuyers) %>%
      group_by(homebuyers) %>%
      summarise_at(input$parameters, aggregate_fun)

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
      hc_chart(type = "line") %>%
      hc_xAxis(categories = cats) %>%
      hc_add_series_list(series)
  })
}
