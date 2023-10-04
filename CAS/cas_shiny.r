library(shiny)
library(ggplot2)
library(fredr)

ui <- fluidPage(

  titlePanel("Hello Shiny!"),
  mainPanel(
        for (i in plotOutput(outputId = "plot")) {
            i
        }
    )
)

server <- function(input, output) {

    output$plot <- renderPlot({
    dataset <- c()
    for (state in state.abb) {
    dataset <- rbind(dataset, fredr(paste0(state, "URN"))[, 1:3])
    }
    dataset$series_id <- gsub("urn", "", dataset$series_id, ignore.case = TRUE)
    df <- dataset |> filter(dataset["series_id"] == "AL")
    })
    output$plot <- c()
    output$plot[1] <- renderPlot({
        ggplot(data = df, aes(x = date, y = value)) + geom_line(linewidth = 1)
    })
}

shinyApp(ui = ui, server = server)