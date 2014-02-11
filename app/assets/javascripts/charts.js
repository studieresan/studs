if (typeof google !== 'undefined') {
	google.load('visualization', '1', {'packages':['corechart']});
	google.setOnLoadCallback(drawCharts);
}

/**
Draws all charts specified in the charts array
Assumes the charts array exists and the elements in it has the form
{
url: 'url',
column: 'X',
options: {<google charts options>}
}
only url and column are required
*/
function drawCharts() {
	if (typeof(charts) == 'undefined') {
		$('#stats').html('<div class="col-xs-12">Efter eventet kommer statistik från medlemsenkäten att presenteras här.</div>');
		return;
	}
	for (var i = 0; i < charts.length; i++) {
		var chart = charts[i];
		var chartDiv = $('<div></div>').prop('id','chart-'+i).addClass('chart col-md-6');
		$('#charts').append(chartDiv);
		var queryString = null;
		if (chart.column != undefined)
			queryString = "SELECT " + chart.column + ", COUNT(A) GROUP BY " + chart.column;
		drawPieChart(chart.url, queryString, "chart-" + i, chart.options);
	}
}

/**
Draws a pie chart with data from a spreadsheet at the specified url
The queryString is used to filter the data of the spreadsheet, see
https://developers.google.com/chart/interactive/docs/querylanguage
The id is the id of the div that will contain the chart
*/
function drawPieChart(url, queryString, id, options) {
	var query = new google.visualization.Query(url);
	// Apply query language if specified
	if (queryString != null)
		query.setQuery(queryString);

	// Send the query with a callback function.
	query.send(function(response){
		handleQueryResponse(response, id, options);
	});
}

function handleQueryResponse(response, id, options) {
	if (response.isError()) {
		console.log('Error in query: ' + response.getMessage() + ' ' + response.getDetailedMessage());
		$('#'+id).html('There was an error loading the data');
		return;
	}

	var data = response.getDataTable();
	var opts = $.extend(true, //deep extension
		{
			title: data.yf[0].label,
			titleTextStyle: {fontSize: 15, fontName: 'Avenir', color: '#333333'},
			pieHole: 0.6, 
			height: 300, 
			pieSliceText: 'none', 
			legend: {position: 'right', alignment: 'center', textStyle: 
						{fontSize: 14, fontName: 'Avenir', color: '#333333'}},
			chartArea: {width: '100%', height: '55%'}
		}, options);//Add user supplied options
	visualization = new google.visualization.PieChart(document.getElementById(id));
	visualization.draw(data, opts);
}