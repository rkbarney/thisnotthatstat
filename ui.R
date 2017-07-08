library(shiny)
library(shinythemes)

shinyUI(fluidPage(theme = shinytheme("yeti"),
  titlePanel("Convert Data Types"),
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
      p("Send an email to ", 
      HTML("<a href='mailto:thisnotthatstat@gmail.com' target='_top'>thisnotthatstat@gmail.com</a>"),
      " to report issues, request features, or additonal data services.")
      ),
    mainPanel(
      tableOutput('contents')
    )
  )
)
)