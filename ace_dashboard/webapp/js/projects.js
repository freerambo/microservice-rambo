	var projectApp = angular.module('microgridApp.projects', ['ui.bootstrap']);
	//Test
    //  var baseUrl = "http://172.21.76.225:8080/MicrogridApiTest/Projects";
	//  var staticUrl = "http://172.21.76.225:8080/MicrogridApiTest/static";
	//  var url = "http://172.21.76.225:8080/MicrogridApiTest";

    //Dev
	var baseUrl = "http://172.21.76.225:8888/api/";

	// Project list controller
	projectApp.controller('ProjectsController', function ($scope,$rootScope, $http, $location) {
		$scope.p = 1;
		$scope.q = '';
		$scope.statusOpt = {'label': 'ID', 'value': 'id'};
		$scope.statusOpts = [
			{'label': 'ID', 'value': 'id'}
		];
		$rootScope.projectId = 1001;
		load = function (url) {
			$http.get(url)
				.success(function (response) {
					$scope.projects = response;
					$scope.totalItems = response.length;
					console.log("retieve project list successfully!! " + $scope.totalItems);
				}).error(function(response, status, headers, config) {
				$scope.error = true;
				console.log("retieve project list error" + response + status + headers + config);
			});

		};

		load(baseUrl+'projects');

		$scope.search = function () {
			load(baseUrl+'projects');
		};

		$scope.toggleStatus = function (r) {
			$scope.statusOpt = r;
		};

		$scope.add = function () {
			$location.path('/projects/new');

		};

		$scope.del = function (id) {
			console.log("delete project error" + id);
			$http.delete(baseUrl+'projects/'+id)
				.success(function (response) {
					console.log("delete project  successfully!! " + id);
					load(baseUrl+'projects');
				}).error(function(response, status, headers, config) {
				console.log("delete project error" + id);
			});

		};

		$scope.detail = function (id) {
			$location.path('/projects/'+id);
			$rootScope.projectId = id;
		};
		$scope.update = function (id) {
			$location.path('/projects/update/'+id);
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


	});

	// new Project
	projectApp.controller('NewProjectController', function ($scope, $http, i18n, $location, $q) {
		$scope.action = "Add ";

		$scope.save = function () {
			$http.post(baseUrl+'projects', $scope.newProject).success(function (data) {
				$location.path('/projects/'+ data.id);
			});
		};


		$scope.cancel = function () {
			$location.path('/projects');
		};

	});


	projectApp.controller('ProjectDetailsController', function ($scope, $http, $routeParams,$location) {
		var actionUrl = baseUrl + 'projects/' + + $routeParams.id;
		console.log("Console actionUrl " + actionUrl);
		load = function () {
			$http.get(actionUrl)
				.success(function (data) {
//             	 console.log("Console projects " + data.id);
					$scope.project = data;
				});
		};
		load();

		$scope.update = function (id) {
			$location.path('/projects/update/'+id);
		};
		$scope.cancel = function () {
			$location.path('/projects');
		};

	});


	projectApp.controller('UpdateProjectController', function ($scope, $http, $routeParams,$location, $q) {
		var actionUrl = baseUrl +'projects'+ '/' + $routeParams.id;
		$scope.action = "Update ";

		$scope.id = $routeParams.id;
		load = function () {
			$http.get(actionUrl)
				.success(function (data) {
					$scope.newProject = data;
				});
		};
		load();
		$scope.cancel = function () {
			$location.path('/projects');
		};

		$scope.save = function () {
			$http.put(baseUrl + 'projects', $scope.newProject).success(function (data) {
				$location.path('/projects/'+data.id);
			});
		};

	});







