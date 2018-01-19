	var scheduleApp = angular.module('microgridApp.schedule', ['ui.bootstrap']);

	var jobUrl = "http://172.21.76.225:8888/schedule/";
	// Schedule list controller
	scheduleApp.controller('ScheduleController', function ($scope, $http, $location) {
		$scope.p = 1;
		$scope.q = '';
		$scope.statusOpt = {'label': 'ID', 'value': 'id'};
		$scope.statusOpts = [
			{'label': 'ID', 'value': 'id'}
		];

		load = function (url) {
			$http.get(url)
				.success(function (response) {
					$scope.jobs = response;
					$scope.totalItems = response.length;
					console.log("retieve schedule list successfully!! " + $scope.totalItems);
				}).error(function(response, status, headers, config) {
				$scope.error = true;
				console.log("retieve schedule list error" + response + status + headers + config);
			});

		};

		load(jobUrl+'get');

		$scope.search = function () {
			load(jobUrl+'get');
		};

		$scope.toggleStatus = function (r) {
			$scope.statusOpt = r;
		};

		$scope.add = function () {
			$location.path('/schedules/new');
		};

		$scope.del = function (data) {
			console.log("delete schedule " + data);
			$http.post(jobUrl+'stop', data)
				.success(function (response) {
					console.log("delete schedule  successfully!! " + id);
				}).error(function(response, status, headers, config) {
				console.log("delete schedule error" + id);
			});
			$location.path('/schedules/');
		};

		$scope.detail = function (id) {
			$location.path('/schedules/'+id);
		};

		$scope.viewby = 10;
		$scope.currentPage = 1;
		$scope.itemsPerPage = $scope.viewby ;
		$scope.maxSize = 5; //Number of pager buttons to show
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

		$scope.del = function(job) {

			if (confirm("Are you SURE to delete the schedules " + job.job + " ?")) {
				$http.post(jobUrl + 'stop', job).success(function (data) {
					console.log(data);
					load(jobUrl+'get');
				});
			}
		}
	});

	// new Schedule
	scheduleApp.controller('NewScheduleController', function ($scope, $http, i18n, $location, $q) {
		$scope.action = "Add ";

		$scope.save = function () {
			$http.post(jobUrl+'start', $scope.newScheduler).success(function (data) {
				console.log(data);
				$location.path('/schedules');
			});

		};

		$scope.cancel = function () {
			$location.path('/schedules');
		};

	});




