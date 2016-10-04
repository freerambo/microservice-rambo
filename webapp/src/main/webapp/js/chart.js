var app = angular.module('charts', []);

app.directive('highchart', function () {
return {
    restrict: 'E',
    template: '<div></div>',
    replace: true,

    link: function (scope, element, attrs) {

        scope.$watch(function () { return attrs.chart; }, function () {

            if (!attrs.chart) return;

            var charts = JSON.parse(attrs.chart);
            
            console.log(charts);

            $(element[0]).highcharts(charts);

        });
    }
};
});

//
app.controller('Ctrl', function ($scope, $http, $timeout) {
$http.get("http://172.21.76.125:8080/MicrogridApiDev/devices/22/data?startDate='2016-06-20 10:11:38'&endDate='2016-06-20 17:23:38'").success(function (data, status) {

	console.log(data[0].timestamp);
	$scope.entities =data;
    var current = [];
/*    for (var i = 0; i < data.length; i++) {
        current.push(data[i].Current);   
    }*/
    var timestamp = [];
    for (var i = 0; i < data.length; i++) {
//    	current.push(data[i].Current);
        timestamp.push(data[i].timestamp);
        
        current[i] = {
        		type: 'area',
        	       
                turboThreshold:0,
                data: data[i].Current

            };
    }

    $scope.renderChart = {
        chart: {
        	zoomType: 'x'
        },
        yAxis: {
                title: {
                    text: 'y-axis label'
                }
            }
        ,
        xAxis: {
        	type: 'datetime',
            categories: timestamp
        },
        
/*        series: [{
        	type: 'area',
       
            turboThreshold:0,
            data: current
        }],*/
        series: current,


        
        legend: {
            enabled: false
        }
    };
}).error("error message");

});