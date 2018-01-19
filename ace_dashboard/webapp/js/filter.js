(function() {
    var app = angular.module('microgridApp.filters', []);

    app.filter('range', function() {
        return function(input, total) {
            total = parseInt(total);
            for (var i = 0; i < total; i++)
                input.push(i);
            return input;
        };
    });
    app.filter('pagination', function()
    		{
    		  return function(input, start) {
    		    start = parseInt(start, 10);
    		    return input.slice(start);
    		  };
    		});

}());


