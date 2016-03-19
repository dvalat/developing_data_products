# title: 'Developing Data Products: Course Project'
# author: "VALAT Didier"
# date: "13/03/2016"
# description: Shiny Server file

# Loading required libraries
library(shiny)
library(rCharts)
library(data.table)
library(reshape2)
library(dplyr)
library(markdown)

# Load specification R functions
source("functions.R")

# Data preparation

# Add "brands" column to the data set
ds<-data.table(brands=rownames(mtcars),mtcars)
# Recode transmission variable
ds$am<-ifelse(ds$am==0,"Automatic","Manual")
# Sort car list in order to use them in the checkbox
carBrands<-sort(unique(ds[["brands"]]))

# Shiny server
shinyServer(function(input, output, session) {
	
	# Define and initialize reactive values
	values <- reactiveValues()
	values$carBrands <- carBrands
	
	# Create an event of type "checkbox"
	output$carBrandsControls <- renderUI({
		checkboxGroupInput('carBrands', '', carBrands, selected=values$carBrands)
	})
		
	# Add observers on "clear" button
	observe({
		if(input$clear==0) return()
		values$carBrands<-c()
	})

	# Add observers on "Select All" button	
	observe({
		if(input$selectAll==0) return()
		values$carBrands<-carBrands
	})

	# Filter the data set on only cars selected by the user
	dsFil <- reactive({
		filterByBrands(ds, input$carBrands)
	})

	# Scatter Chart - MPG vs. Wt by cyl
	output$gearByMpg <- renderChart({
		scatChart(ds=dsFil(), dom="gearByMpg")
	})

	# Line chart - HP vs. MPG by transmission
	output$new <- renderChart({
		hpChart(ds=dsFil(), dom="new")
	})
	
	# Pie chart - Number of cars by transmission
	output$am <- renderChart({
		pieChart(ds=dsFil(), dom="am")
	})
	
	# Display data set in table form
	output$table <- renderDataTable({dsFil()}, options = list(bFilter = FALSE, iDisplayLength = 10))
})
