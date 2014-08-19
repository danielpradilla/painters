library(MASS)
library(shiny)
require(rCharts)
getPainters <- function(input) {
  schools<-data.frame(School=c("A","B","C","D","E","F","G","H"), SchoolName=c("Renaissance", "Mannerist", "Seicento", "Venetian","Lombard","Sixteenth Century","Seventeenth Century", "French") )
  
  data<-painters[painters$Composition >= input$Composition 
                 & painters$Drawing >= input$Drawing
                 & painters$Colour >= input$Colour
                 & painters$Expression >= input$Expression, ]
  data<-cbind(Painter = rownames(data),data)
  data<-merge(data[,], schools, by="School")
  data[order(data$Painter),c("Painter","SchoolName","Composition","Drawing","Colour","Expression")]

}

shinyServer(
  function(input, output) {
  
    output$painterstable = renderDataTable({
      getPainters(input)
      }, options = list(bSortClasses = TRUE), 
                callback='function(oTable) { 
                            oTable.on("draw.dt", function() {
                              initPainters(); 
                            });
                          }'
                
      )
    
      output$painterschart <- renderChart({
        mypainters <- getPainters(input)
        paintersdf <- as.data.frame(table(mypainters[, "SchoolName"]))
        colnames(paintersdf) <- c("SchoolName","Freq") 
        p1 <- nPlot(Freq ~ SchoolName, type="discreteBarChart", data = paintersdf)
        p1$set(dom = "painterschart",width=500)
        p1$xAxis(
          rotateLabels=-45, height=200
        )
        p1$yAxis(tickFormat="#!function(d) {return d}!#")
        p1$chart(showValues='true'
                 ,valueFormat="#!function(d) {return d}!#"
        )
        return(p1)
      })
    
  }
)