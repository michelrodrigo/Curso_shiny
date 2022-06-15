library(shiny)
library(shinydashboard)
library(readxl)
library(tidyverse)
library(shinyalert)


dados <- read_excel("dados_curso1.xlsx") 
dados <- dados |> select(-1)

ui <-  dashboardPage(
  dashboardHeader(title = "IMRS Demografia"),
  
  dashboardSidebar(),
  
  dashboardBody(numericInput(inputId = 'num_municipios', label = "Digite o número de municípios (1-10)", value = 1),
                actionButton(inputId = 'sorteia_municipios', label = "Sortear"),
                textOutput(outputId = 'municipios_sorteados', inline = FALSE),
                actionButton(inputId = 'atualiza', label = "Atualizar"),
                checkboxGroupInput(inputId = 'selecao_municipios', label = "Selecione os municípios:" )
                )
)

server <- function(input, output) {
  
  minhas_variaveis <- reactiveValues()
  
  output$municipios_sorteados <- renderText({
    

    input$sorteia_municipios
    
  
    minhas_variaveis$municipios <- isolate(sample(unique(dados$MUNICIPIO), input$num_municipios))
    paste(minhas_variaveis$municipios, collapse = ", ")
    
     
    
    
  })
  
  observeEvent(input$atualiza, {
      updateCheckboxGroupInput(inputId = 'selecao_municipios', choices = minhas_variaveis$municipios)
  })
  
  
  
  
  
}

shinyApp(ui = ui, server = server)
