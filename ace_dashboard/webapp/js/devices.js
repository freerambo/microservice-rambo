	var deviceApp = angular.module('microgridApp.devices', ['ui.bootstrap']);
	//Test
    //  var bdeviceAppeUrl = "http://172.21.76.225:8080/MicrogridApiTest/devices";
	//  var staticUrl = "http://172.21.76.225:8080/MicrogridApiTest/static";
	//  var url = "http://172.21.76.225:8080/MicrogridApiTest";

	// device list controller
	deviceApp.controller('DevicesController', function ($scope,$rootScope,  $http,$routeParams, $location, i18n) {
		$scope.p = 1;
		$scope.q = '';
		$scope.statusOpt = {'label': 'ALL', 'value': 'ALL'};
		$scope.statusOpts = [
			{'label': 'ALL', 'value': 'ALL'},
			{'label': 'Name', 'value': 'name'}
		];
		$rootScope.projectId = 1001;
		projectId = $routeParams.id;
		var actionUrl = null;
		if(projectId != null){
			$rootScope.projectId = projectId;
		}
		actionUrl = baseUrl + $rootScope.projectId  + '/devices';

		// test = $location.search().test; // get params in URL


		console.log(actionUrl);

		load = function () {
			$http.get(actionUrl)
				.success(function (response) {
					$scope.devices = response;
              		$scope.totalItems = response.length;
					console.log("retrieve devices list successfully!!! " +  $scope.totalItems );
				}).error(function(response, status, headers, config) {
				$scope.error = true;
				console.log("retrieve devices list error" + response + status + headers + config);
			});

		};

		load();

		$scope.search = function () {
			load();
		};

		$scope.toggleStatus = function (r) {
			$scope.statusOpt = r;
		};

		$scope.add = function (projectId) {
			console.log(projectId);
			$location.path('/devices/new/'+projectId);
		};

		$scope.details = function (id) {
			$location.path('/devices/'+id);
		};
		$scope.del = function (id) {
			   if (confirm("Are you SURE to delete the device " + id + " ?")) {
				   $http.delete(baseUrl + 'devices/'+id).success(function (data) {
					   load();
					});
			   }

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

	deviceApp.controller('LoginController', function ($scope, $rootScope, $http, base64, $location) {

		$scope.login = function () {
			console.log('username:password @' + $scope.username + ',' + $scope.password);
			$scope.$emit('event:loginRequest', $scope.username, $scope.password);
			// $('#login').modal('hide');
		};
	});

	// new Device
	deviceApp.controller('NewDeviceController', function ($scope, $routeParams,$http, i18n, $location, $q) {

		$scope.action = "Add ";
		// $scope.selectedOption = $scope.options['UnKnown'];
		$scope.newDevice = {};
		$scope.newDevice.projectId = $routeParams.id;

		$scope.save = function () {
			$http.post(baseUrl + 'devices/', $scope.newDevice).success(function (data) {
				$location.path('/devices/'+ data.id);
			});
	};

		$scope.cancel = function () {
			$location.path('/devices');
		};

	});


	deviceApp.controller('DeviceDetailsController', function ($scope, $http, $routeParams,$location) {
		var actionUrl = baseUrl + 'devices/' + $routeParams.id;
		load = function () {
			$http.get(actionUrl)
				.success(function (data) {
					$scope.device = data;
				});

			$http.get(baseUrl + $routeParams.id+"/dataPoints")
				.success(function (data) {
					$scope.dataPoints = data;
				});

			$http.get(actionUrl+"/protocol")
				.success(function (data) {
					$scope.protocol = data;
				});
		};

		load();

		$scope.update = function (id) {
			$location.path('/devices/update/'+id);
		};
		$scope.cancel = function () {
			// $location.path('/devices');
			history.back();
		};

		$scope.cancelDataPoint = function (id) {
			$('#myModal1').toggle();
		};


		$scope.saveDataPoint = function (id) {
			// $scope.newDataPoint["device"] = {"id":id};
			// $scope.newDataPoint.device.id = id;
			$scope.newDataPoint.device = {"id":id};
			$http.post(baseUrl + "dataPoints", $scope.newDataPoint).success(function (data) {
				// push the new dataPoints to the list
				$scope.dataPoints.push(data);
			});
		};



		$scope.gotoDp = function (id) {
			$location.path('/dpvs/');
		};

		$scope.delDp = function (id) {
			if (confirm("Are you SURE to delete the DataPoint " + id + " ?")) {
				$http.delete(baseUrl + "dataPoints/" + id).success(function (data) {
					console.log(id + " DP is deleted!!");
					load();
				});
				// $location.path('devices/'+$scope.device.id);
   		    }
		};
		$scope.saveProtocol = function (id) {
			$scope.newProtocol.deviceId = id;
			$scope.newProtocol.name = $scope.device.protocol;
			protocolUrl = getProtocolUrl($scope.newProtocol.name);
			if(protocolUrl != "unknown"){
				$http.post(baseUrl + protocolUrl, $scope.newProtocol).success(function (data) {
					$scope.protocol = data;
				});
			}
		};
		getProtocolUrl = function (protocolName){
			protocolUrl = "unknown";
			switch (protocolName) {
				case "EthernetIP":
					protocolUrl = "ips";
					break;
				case "ModbusTCP":
					protocolUrl = "tcps";
					break;
				case "ModbusRTU":
					protocolUrl = "rtus";
					break;
				default:
					protocolUrl = "unknown";
			}
			return protocolUrl;
		};
		$scope.delProtocol = function (id, name) {
			if (confirm("Are you SURE to delete the Protocol " + name + id + " ?")) {
				protocolUrl = getProtocolUrl(name);
				$http.delete(baseUrl + protocolUrl + "/" + id).success(function (data) {
					console.log(id + " DP is deleted!!");
					load();
				});
			}
		};

		$scope.cancelProtocol = function (id) {
			$('#protocolModal').toggle();

		};


	});


	deviceApp.controller('UpdateDeviceController', function ($scope, $http, $routeParams,$location, $q) {
		var actionUrl = baseUrl + '/' + $routeParams.id;
		$scope.action = "Update ";

		$scope.ID = $routeParams.id;
		load = function () {

			$http.get(staticUrl+'/deviceTypes')
				.success(function (data) {
					$scope.deviceTypes = data;
				});
			$http.get(staticUrl+'/buses')
				.success(function (data) {
					$scope.buses = data;
				});
			$http.get(actionUrl)
				.success(function (data) {
					$scope.newDevice = data;
				});

		};
		load();

		$scope.cancel = function () {
			$location.path('/devices');
			// history.back();
		};

		$scope.save = function () {
			$http.put(baseUrl, $scope.newDevice).success(function (data) {
				$location.path('/devices/'+data.id);
			});
		};

	});



