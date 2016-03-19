# title: 'Developing Data Products: Course Project'
# author: "VALAT Didier"
# date: "13/03/2016"
# description: Shiny functions file

#' Filter the dataset by selected car brands
#'
#' @param ds the source data set
#' @param carBrands the list of car brands to filter
#' @return the data set filtered
filterByBrands <- function(ds, carBrands) {
	ds %>% filter(brands %in% carBrands)
}

#' Create Scatter Chart
#'
#' @param ds the source data set
#' @param dom the DOM source event
#' @return the chart
scatChart<-function(ds, dom) {
	evt<-nPlot(mpg~wt, group='cyl', data=ds %>% arrange(cyl, desc(mpg))
		, dom=dom, type = "scatterChart")
	# Modify the Toop Tip content
	evt$chart(tooltipContent = "#! function(key, x, y, e){
		return '<h3>' + e.point.brands + '</h3>'} !#")
	evt$xAxis(axisLabel='Weight (in lb)')
	evt$yAxis(axisLabel='Miles/(US) gallon')
	evt
}

#' Create Line Chart
#'
#' @param ds the source data set
#' @param dom the DOM source event
#' @return the chart
hpChart<-function(ds, dom) {
	ds<-ds %>% arrange(mpg, hp)
	evt<-nPlot(hp~mpg, group='am'
		, data=ds %>% arrange(mpg, hp), dom=dom, type="lineChart")
	evt$chart(tooltipContent = "#! function(key, x, y, e){
		return '<h3>' + e.point.brands + '</h3>'
		+ 'Gross horsepower: ' +'<b>' + e.point.hp + '</b>' + '<br>'
		+ 'Miles/(US) gallon: ' + '<b>' + e.point.mpg + '</b>'} !#")
	evt$xAxis(axisLabel='Gross horsepower')
	# This does not work unfortunately so I can not put a label on the Y axis :(
	evt$yAxis(axisLabel='Miles/(US) gallon')
	evt
}

#' Create Pie Chart
#'
#' @param ds the source data set
#' @param dom the DOM source event
#' @return the chart
pieChart<-function(ds, dom) {
	evt<-nPlot(~am, data=ds, dom=dom, type="pieChart", y="Freq")
	evt$chart(tooltipContent = "#! function(key, y, e, graph){
		return '<h3>' + 'Category: ' + key 
		+ '</h3>' + '<p>'+ 'Number of cars: ' + '<b>' + y + '</b>'} !#")
	evt$set(width = 800, height = 500)
	evt
}
