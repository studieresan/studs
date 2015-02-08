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
	var sentenceChart;
	for (var i = 0; i < charts.length; i++) {
		var chart = charts[i];
		if (i === 3) {
			sentenceChart = $('<div></div>').prop('id','chart-'+i).addClass('chart col-md-12');
		} else {
			var chartDiv = $('<div></div>').prop('id','chart-'+i).addClass('chart col-md-6');
			$('#charts').append(chartDiv);
		}
		var queryString = null;
		if (chart.column != undefined)
			queryString = "SELECT " + chart.column + ", COUNT(A) GROUP BY " + chart.column;
		drawChart(chart.url, queryString, "chart-" + i, chart.options);
	}
	$('#sentence-chart').append(sentenceChart);
}

/**
Draws a pie chart with data from a spreadsheet at the specified url
The queryString is used to filter the data of the spreadsheet, see
https://developers.google.com/chart/interactive/docs/querylanguage
The id is the id of the div that will contain the chart
*/
function drawChart(url, queryString, id, options) {
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
	console.log(data);
	var threeWordsQuestion = "Describe your interpretation";
	if (startsWith(data.Pf[0].label, threeWordsQuestion)) {
		data = buildCustomDatatable(data);
		drawBubbleChart(data, id, options);
	} else {
		data = sortData(data);
		drawPieChart(data, id, options);
	}
}

function drawPieChart (data, id, options) {
	var opts = $.extend(true, //deep extension
	{
		title: data.Pf[0].label,
		titleTextStyle: {fontSize: 15, fontName: 'Avenir', color: '#333333'},
	      colors: ['#FF35BB', '#FFF43E', '#D8D8D8', '#3A91F6', '#3EBFBF'],
	      pieHole: 0.6,
		height: 300, 
		pieSliceText: 'none', 
		legend: {position: 'right', alignment: 'center', textStyle: 
		{fontSize: 14, fontName: 'Avenir', color: '#333333'}},
		chartArea: {width: '100%', height: '55%'}
		}, options);//Add user supplied options
	var visualization = new google.visualization.PieChart(document.getElementById(id));
	visualization.draw(data, opts);
}

function drawBubbleChart (data, id, options) {
	var opts = $.extend(true, //deep extension
	{
		title: data.Pf[0].label,
		titleTextStyle: {fontSize: 15, fontName: 'Avenir', color: '#333333'},
        colors: ['#FF35BB', '#FFF43E', '#D8D8D8', '#3A91F6', '#3EBFBF'],
		height: 300,
		vAxis: {
			baselineColor: '#FFFFFF',
		  gridlines: {
		  	color: 'transparent'
	    },
	    viewWindow: {
	    	min: 0,
	    	max: 100
	    }
		},
		hAxis: {
			baselineColor: '#FFFFFF',
			textPosition: 'none',
	    gridlines: {
	      color: 'transparent'
	    },
	    viewWindow: {
	    	min: 0,
	    	max: 100
	    }
		},
		sizeAxis: {minValue: 0,  maxSize: 50},
		legend: {position: 'right', alignment: 'center', textStyle: 
		{fontSize: 14, fontName: 'Avenir', color: '#333333'}},
		chartArea: {width: '100%', height: '55%'},
		bubble: {textStyle: {auraColor: 'none', fontSize: 14, fontName: 'Avenir', color: '#333333'}},
		}, options);//Add user supplied options
  var number = data.getValue(1, 4);
  var percentage = Math.round(number / 28 * 100);
  data.setFormattedValue(1, 4, percentage + '% (' + number + '/' + 28 + ')');
	var visualization = new google.visualization.BubbleChart(document.getElementById(id));
	visualization.draw(data, opts);
}

/**
Insanely ugly custom hack to counter a specific question in the surveys of studs 2015, where the combination
["Attractive benefits", "Felt that I will fit in at the company", "Right development platform for me"] counted
as a unique answser, instead of increasing the count for each sentence by one.
*/
function buildCustomDatatable(originalData) {
	var memberNo = 28;
	var answerValues = {
		'Interesting scope of practice' : 0,
		'Interesting methodology' : 0,
		'Optimal geographic location' : 0,
		'Attractive benefits' : 0,
		'High demands' : 0,
		'Felt that I will fit in at the company' : 0,
		'Right development platform for me' : 0,
		'Great possibilities for career development' : 0,
		'Attractive office' : 0,
		'Flexibility' : 0,
		'International possibilities' : 0
	};

	for (var i = 0; i < originalData.getNumberOfRows(); i++) {
		var sentences = originalData.getValue(i, 0).split(', ');
		var number = originalData.getValue(i, 1);
		$.each(sentences, function (idx, sentence) {
			answerValues[sentence] += number;
		})
	};

	var data = new google.visualization.DataTable(
    {
      cols: [{id: 'sentence', label: originalData.Pf[0].label, type: 'string'},
      			 {id: 'x', type: 'number'},
      			 {id: 'y', type: 'number'},
      			 {id: 'colorIndex', type: 'string'},
      			 {id: 'number', label: 'Partition', type: 'number'}]
    });
	var i = 1;
	var mapKeys = Object.keys(answerValues);
	mapKeys.sort(function(a,b){return answerValues[b] - answerValues[a]}); // Get the keys sorted by their values
	// Extract the three most popular answers, set the formatted value for the tooltip
	for (var i = 0; i < 3; i++) {
		var key = mapKeys[i];
		var value = answerValues[key];
		var colorIndex = i == 0 ? '0' : '1';
		var pos = getPosition(i);
		data.addRow([key, pos.x, pos.y, colorIndex, value]);
	  var percentage = Math.round(value / memberNo * 100);
	  data.setFormattedValue(i, 4, percentage + '% (' + value + '/' + memberNo + ')');
	};
	data.sort({column: 4});
	return data;
}

function getPosition (index) {
	switch(index) {
		case 0: return {x: 45, y: 69};
		case 1: return {x: 34, y: 34};
		case 2: return {x: 55, y: 23};
	}
}

function sortData(data) {
	var sortedData = data.clone();
	var columnIndex = sortedData.addColumn('number', 'Priority');
	for (var i = 0; i < sortedData.getNumberOfRows(); i++) {
		var word = sortedData.getValue(i,0);
		if (isPositiveWord(word)) {
			sortedData.setValue(i, columnIndex, 1);
		}
		if (isNegativeWord(word)) {
			sortedData.setValue(i, columnIndex, 2);
		}
		if (isNeutralWord(word)) {
			sortedData.setValue(i, columnIndex, 3);
		}
	};
	sortedData.sort({column: columnIndex});
	sortedData.removeColumn(columnIndex);
	return sortedData;
}

function startsWith (text, prefix) {
	return text.substring(0, prefix.length) === prefix;
}

function isPositiveWord (word) {
	return word === "Yes" || word === "Positively" || word === "Positive";
}

function isNegativeWord (word) {
	return word === "No" || word === "Negatively" || word === "Negative";
}

function isNeutralWord (word) {
	return word === "No opinion" || word === "Unchanged" || word === "Neutral";
}