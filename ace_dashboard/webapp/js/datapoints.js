	var dpApp = angular.module('microgridApp.dpApp', ['ui.bootstrap']);

	// Schedule list controller
	dpApp.controller('DataPointValueController', function ($scope, $routeParams, $http, $location) {
		$scope.p = 1;
		$scope.q = '';
		$scope.statusOpt = {'label': 'ID', 'value': 'id'};
		$scope.statusOpts = [
			{'label': 'ID', 'value': 'id'}
		];

		dpId = $routeParams.id;
		actionUrl = baseUrl + 'dpvs/';
		if(dpId != null)
			actionUrl += dpId;

		load = function (url) {
			$http.get(url)
				.success(function (response) {
					$scope.dpvs = response;
					$scope.totalItems = response.length;
					console.log("retieve datapoints list successfully!! " + $scope.totalItems);
				}).error(function(response, status, headers, config) {
				$scope.error = true;
				console.log("retieve datapoints list error" + response + status + headers + config);
			});
		};

		$scope.viewby = 20;
		$scope.currentPage = 1;
		$scope.itemsPerPage = $scope.viewby ;
		$scope.maxSize = 10; //Number of pager buttons to show
		$scope.setPage = function (pageNo) {
			$scope.currentPage = pageNo;
		};

		$scope.pageChanged = function() {
			console.log('Page changed to: ' + $scope.currentPage);
		};

		$scope.setItemsPerPage = function(num) {
			$scope.itemsPerPage = num;
			$scope.currentPage = 1; //reset to first page
		}

		load(actionUrl);
		$scope.search = function () {
			load(baseUrl+'dpvs/' + $scope.q);

		};
		$scope.toggleStatus = function (r) {
			$scope.statusOpt = r;
		};
	});


	dpApp.controller('DataPointController', function ($scope, $routeParams, $http, $location) {
		$scope.p = 1;
		$scope.q = '';
		$scope.statusOpt = {'label': 'ID', 'value': 'id'};
		$scope.statusOpts = [
			{'label': 'ID', 'value': 'id'}
		];
		$scope.projectId = $routeParams.id || 1001;

		actionUrl = baseUrl + 'project/' + $scope.projectId + '/dataPoints';

		load = function (url) {
			$http.get(url)
				.success(function (response) {
					$scope.dps = response;
					$scope.totalItems = response.length;
					console.log("retieve datapoints list successfully!! " + $scope.totalItems);
				}).error(function(response, status, headers, config) {
				$scope.error = true;
				console.log("retieve datapoints list error" + response + status + headers + config);
			});
		};

		$scope.viewby = 20;
		$scope.currentPage = 1;
		$scope.itemsPerPage = $scope.viewby ;
		$scope.maxSize = 10; //Number of pager buttons to show
		$scope.setPage = function (pageNo) {
			$scope.currentPage = pageNo;
		};

		$scope.pageChanged = function() {
			console.log('Page changed to: ' + $scope.currentPage);
		};

		$scope.setItemsPerPage = function(num) {
			$scope.itemsPerPage = num;
			$scope.currentPage = 1; //reset to first page
		}

		load(actionUrl);
		$scope.search = function () {
			$location.path('/dpvs/'+$scope.q);
		};
		$scope.toggleStatus = function (r) {
			$scope.statusOpt = r;
		};
	});



