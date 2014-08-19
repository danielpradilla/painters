library(shiny)
require(rCharts)

shinyUI(
  fluidPage(
    includeCSS('www/painters.css'),
    includeScript('www/painters.js'),
    headerPanel('Styles of Famous Painters'),
    div(id="intro", class="span12 well",
      p('Hello and welcome :) this app presents a list of a subjective assessment, 
        on a 0 to 20 integer scale, of 54 classical painters. 
        The painters were assessed on four characteristics: composition, drawing, colour and expression. 
        The data is due to the Eighteenth century art critic, de Piles.'),
      p('You can use the sliders to filter the table. 
        Check out the frequency chart by clicking on the "Chart" tab'),
      p("Also, you can click over a painter's name to see a sample of his work")
    ),
    sidebarPanel(id="filters",
      div(id='painting'),
      helpText('Move the sliders to filter the data on the table'),
      div(id="sliders",
        sliderInput("Composition", "Composition:", 
                    min=0, max=20, value=5),
        sliderInput("Drawing", "Drawing:", 
                    min=0, max=20, value=5),
        sliderInput("Colour", "Colour:", 
                    min=0, max=20, value=5),
        sliderInput("Expression", "Expression:", 
                    min=0, max=20, value=5)
      ),
      div(id="author",a(href="https://github.com/danielpradilla","Daniel Pradilla"))
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Table",dataTableOutput("painterstable")),
        tabPanel("Chart",
                div(class="chartcontainer",
                  h3('# Artists per School'),
                  showOutput("painterschart", "nvd3"))
                )
      )
    )
  )
)