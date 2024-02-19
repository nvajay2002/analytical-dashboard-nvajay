# Server
server = function(input, output, session) {
  
  #Structure
  output$structure = renderPrint(
    #structure
    data %>% 
      str()
  )
  #Summary
  output$summary = renderPrint(
    #Summary
    data %>% 
      summary()
    
  )
  #Data Table
  output$dataT = renderDataTable({
    datatable(data, options = list(scrollX = TRUE))
  })
  #stacked Histogram
  output$histplot = renderPlotly({# Histogram
    histogram <- data %>% 
      plot_ly() %>% 
      add_histogram(~get(input$var1)) %>% 
      layout(xaxis = list(title = input$var1))
    
    # Boxplot
    boxplot <- data %>% 
      plot_ly() %>% 
      add_boxplot(~get(input$var1)) %>% 
      layout(yaxis = list(showticklables = F))
    
    # Stacking plots using subplot
    subplot_list <- list(boxplot, histogram)  # Make sure to use a list
    
    # Create subplot
    subplot <- subplot(subplot_list, nrows = 2, shareX = TRUE) %>% 
      hide_legend() %>% 
      layout("Distribution Chart - Histogram and Boxplot",
             yaxis = list(title = "Frequency"))
    
  })
  output$bar <- renderPlotly({
    data %>% 
      plot_ly() %>% 
      add_bars(x=~State, y=~get(input$var1)) %>% 
      layout(title = paste("Statewise Number for", input$var1),
             xaxis = list(title = "State"),
             yaxis = list(title = paste(input$var1, "Number") ))
  })
  output$FA = renderPrint( summary(model_FA))
  output$A = renderPrint( summary(model_A))
  output$K = renderPrint( summary(model_K))
  output$I = renderPrint( summary(model_I))
 
}
