library(tools)
library(shiny)
library(readr)
library(haven)

function(input, output) {
  
  data <- reactive({{
    
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    # Read in  csv file
    if (inFile$type == "text/csv"){
      dat <-read_csv(inFile$datapath)      
    }
    
    # Read in SPSS files
    if (inFile$type == "application/x-spss-sav"){
      dat <- read_sav(inFile$datapath)   
    }
    
    # Read in Stata files
    if (inFile$type == "" & file_ext(inFile$name)=='.dta'){
      dat <- read_dta(inFile$datapath) 
      inFile$type <- 'stata'
    }
    
    # Stata doesnt support colnames with '.'. Fix.
    if(input$write_type == '.dta'){
      colnames(dat) <- gsub('\\.',colnames(dat), replacement = '_')
    }
    
    if (input$write_labels){
      labelled_cols <- unlist(lapply(dat, is.labelled), use.names = F)
      dat[labelled_cols] <- data.frame(lapply(dat[labelled_cols], as_factor))
    }
    
    inFile$extension <- file_path_sans_ext(inFile$name)
    
    list(file_info = inFile,data = dat)
  }})
  
  output$contents <- renderTable({data()$data})
  
  output$downloadData <- downloadHandler(
    filename = function(){
      paste(file_path_sans_ext(data()$file_info$name),input$write_type)
    } ,
    content = function(file) {
      
      dat <- data()
      
      if (input$write_type == '.csv'){
        write_csv(dat$data, file)
      } else if (input$write_type == '.sav'){
        write_sav(dat$data, file)
      }else if (input$write_type == '.dta'){
        write_dta(dat$data, file)
      }
    }
  )
}