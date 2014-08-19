---
title       : Styles of Famous Painters
subtitle    : a subjetive assessment
author      : Daniel Pradilla
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
--- 
## What's this?

- A subjective assesment of 54 classic painters, done by [Roger de Piles](http://en.wikipedia.org/wiki/Roger_de_Piles)
- The painters were assessed on a 0 to 20 scale on four characteristics: composition, drawing, colour and expression.
![width](assets/img/painters.png)

---
## How do I use it?

- Go to [http://danielpradilla.shinyapps.io/painters/](http://danielpradilla.shinyapps.io/painters/)
- Use the sliders to filter the list of painters. Check out the frequency chart by clicking on the "Chart" tab
- Also, you can click over a painter's name to see a sample of his work

---
## How did you make it?
- [Shiny](http://shiny.rstudio.com/) + [rCharts](http://rcharts.io/)

---
## How did you filter the list?

- Like so:
```R
schools<-data.frame(School=c("A","B","C","D","E","F","G","H"), 
    SchoolName=c("Renaissance", "Mannerist", "Seicento",
    "Venetian","Lombard","Sixteenth Century","Seventeenth Century", "French") )
  
  data<-painters[painters$Composition >= input$Composition 
                 & painters$Drawing >= input$Drawing
                 & painters$Colour >= input$Colour
                 & painters$Expression >= input$Expression, ]
  data<-cbind(Painter = rownames(data),data)
  data<-merge(data[,], schools, by="School")
  data[order(data$Painter),
      c("Painter","SchoolName","Composition","Drawing","Colour","Expression")
      ]
```

---
## I see that you made a lookup table

- Oh, this?

```r
data.frame(School=c("A","B","C","D","E","F","G","H"), 
    SchoolName=c("Renaissance", "Mannerist", "Seicento",
    "Venetian","Lombard","Sixteenth Century","Seventeenth Century", "French") )
```

```
##   School          SchoolName
## 1      A         Renaissance
## 2      B           Mannerist
## 3      C            Seicento
## 4      D            Venetian
## 5      E             Lombard
## 6      F   Sixteenth Century
## 7      G Seventeenth Century
## 8      H              French
```

---
## How did you create the chart?
```R
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
```

---
## And what about the painting preview?

- That was some JavaScript:

```js
searchPainter = function(name) {
  var baseUrl ='https://ajax.googleapis.com/ajax/services/search/images?v=1.0&q=';
  var url = baseUrl + name + ' painting commons.wikimedia' + '&callback=?';
  console.log('getting painting for ' + name);
  $.getJSON(url, function(json){
    var results=json.responseData.results;
    if (results[0]){
      setImage(results[0].url,results[0].originalContextUrl);    
    } else {
      setDefaultImage();
    }
  })
}
```

--- .dark
## Thanks!

- [danielpradilla.info](http://danielpradilla.info)

- [twitter](http://twitter.com/danielpradilla)


