# title: 'Developing Data Products: Course Project'
# author: "VALAT Didier"
# date: "13/03/2016"
# description: Shiny User Interface file

# Loading required libraries
library(shiny)
library(rCharts)

# Create the Shiny User Interface
shinyUI(
	navbarPage("Motor Trend Car Road Tests Dataset Interactive Analysis"
		,tabPanel(
			p(icon("automobile"), "Analysis")
			,sidebarPanel(
				# Cars list checkbox list and graphs panel
				p("Please select a car.")
				,actionButton(inputId="clear", label="Clear", icon=icon("eraser"))
				,actionButton(inputId="selectAll", label="Select all", icon=icon("check-square"))
				,p("")
				,uiOutput("carBrandsControls")
			),
			mainPanel(
				tabsetPanel(
					# Graph panel
					tabPanel(
						p(icon("bar-chart-o"), "Graphs")
						,h4('Weight vs. MPG by number of cylinders', align = "center")
						,showOutput("gearByMpg", "nvd3")
						,h4('Gross horsepower vs. MPG by transmission', align = "center")
						,showOutput("new", "nvd3")
						,h4('Number of cars by transmission', align = "center")
						,showOutput("am", "nvd3")
					),
					
					# Dataset panel
					tabPanel(
						p(icon("table"), "Data")
						,dataTableOutput(outputId="table")
					)
				)
			)
		),
		
		# Info panel
		tabPanel(
			p(icon("info"), "Info")
			,mainPanel(
				includeMarkdown("include.md")
			)
		)
	)
)