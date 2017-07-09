library(shiny)
library(shinythemes)

shinyUI(fluidPage(theme = shinytheme("yeti"),
  tags$head(includeScript("google-analytics.js")),
  titlePanel("ThisNotThatStat"),
  h4("Converts file formats between SPSS, STATA, and .csv"),
  sidebarLayout(
    sidebarPanel(
      fileInput('file1', label = p(h3('Upload a file'),'(types: .csv,.sav,.dta)'),
                accept=c('text/csv', 
                         'text/comma-separated-values,text/plain', 
                         '.csv',
                         '.sav',
                         '.dta')),
      selectInput("write_type", label = h3("File output type"), 
                  choices = list(".csv" = ".csv", "SPSS" = ".sav", "STATA" = ".dta"), 
                  selected = 1),
      downloadButton('downloadData', 'Download'), 
      conditionalPanel(condition = "input.write_type == '.csv'",
                       checkboxInput("write_labels", label = "Write factor labels instead of values", value = TRUE)),
      p(),
      p(),
      p(),
      p(),
      p(),
      p(),
      p(),
      p(),
      p(),
      HTML("<hr>"),
      p("ThisNotThatStat is built on the", 
        a(link = 'https://shiny.rstudio.com/', 'shiny development framework for R'), 
        ' and uses', 
        a(link='https://github.com/tidyverse/haven', 'haven'), 'to perform file conversions.'),
      HTML("<hr>"),
      p("Please log issues or feature requests to", 
        a(link = 'https://github.com/rkbarney/thisnotthatstat', 'github.')), 
      HTML("<hr>"),
      p("Contact ", 
      HTML("<a href='mailto:rkbarney@gmail.com' target='_top'>rkbarney@gmail.com</a>"),
      " for other inquiries.")
      ),
    mainPanel(
      tableOutput('contents')
    )
  )
)
)