(function () {
    var as = angular.module('exampleApp.controllers', []);
    var baseUrl = "http://172.21.76.189/MicrogridApi/devices";
   
    as.controller('MainController', function ($q, $scope, $rootScope, $http, i18n, $location) {
        var load = function () {
        };

        load();

        $scope.language = function () {
            return i18n.language;
        };
        $scope.setLanguage = function (lang) {
            i18n.setLanguage(lang);
        };
        $scope.activeWhen = function (value) {
            return value ? 'active' : '';
        };

        $scope.path = function () {
            return $location.url();
        };

        $scope.logout = function () {
            $rootScope.user = null;
            $scope.username = $scope.password = null;
            $scope.$emit('event:logoutRequest');
            $location.url('/login');
        };

    });
    
    
    // device list controller
    as.controller('DevicesController', function ($scope, $http, $location, i18n) {
        $scope.p = 1;
        $scope.q = '';
        $scope.statusOpt = {'label': $.i18n.prop('ALL'), 'value': 'ALL'};
        $scope.statusOpts = [
            {'label': $.i18n.prop('ALL'), 'value': 'ALL'},
            {'label': $.i18n.prop('AC'), 'value': 'AC'},
            {'label': $.i18n.prop('DC'), 'value': 'DC'}
        ];   
        var actionUrl = baseUrl + 'api/devices/',
        load = function () {

//        	Ref. https://docs.angularjs.org/api/ng/service/$http
//        	http://172.21.76.189/MicrogridApi/devices/?callback=JSON_CALLBACK
//        	https://angularjs.org/greet.php?callback=JSON_CALLBACK&name=Super%20Hero
//        	without callback, there's MINE Type error as application/json is not executable
        	$http.get(baseUrl)
            .success(function (response) {
                $scope.devices = response;
                console.log("devices list success ");
            }).error(function(response, status, headers, config) {
		        $scope.error = true;
		        console.log("devices list error" + response + status + headers + config);
		    });
          
        };

       load();
       
       $scope.search = function () {
           load();
       };

       $scope.toggleStatus = function (r) {
           $scope.statusOpt = r;
       };
       
       $scope.add = function () {
           $location.path('/devices/new');
       };
       
       $scope.update = function (id) {
           $location.path('/devices/update/'+id);
       };
       $scope.del = function (id) {
    	   
    	   if (confirm("Are you SURE to delete the device " + id + " ?")) {
    		   $location.path('/devices/update/'+id);
    	    }
           
       };
       
    });
    as.controller('LoginController', function ($scope, $rootScope, $http, base64, $location) {

        $scope.login = function () {
            console.log('username:password @' + $scope.username + ',' + $scope.password);
            $scope.$emit('event:loginRequest', $scope.username, $scope.password);
            // $('#login').modal('hide');
        };
    });

    // new Device
    as.controller('NewDeviceController', function ($scope, $http, i18n, $location) {
        var actionUrl = 'api/devices/';

//        $scope.entityId = $routeParams.entityId;
//        $scope.ID = $routeParams.entityId;
        $scope.action = "Add ";

        $scope.options = [
	      
	          {
	            name: 'Source',
	            value: '1'
	          },
	          {
	            name: 'Load',
	            value: '2'
	          },
	          {
	            name: 'Battery',
	            value: '3'
	          }
	          ,
	          {
	            name: 'Conveters',
	            value: '4'
	          },
	          {
	            name: 'Others',
	            value: '5'
	          },

			    {
			      name: 'Please select device type',
			      value: '0'
			    }
		    
	          
	      ];
	      $scope.selectedOption = $scope.options[0];
        
        $scope.save = function () {
            $http.post(baseUrl, $scope.newDevice).success(function () {
                $location.path('/devices');
            });
        };


        $scope.cancel = function () {
            $location.path('/devices');
        };

    });
    
    
    as.controller('DeviceDetailsController', function ($scope, $http, $routeParams,$location) {
        var actionUrl = baseUrl + '/' + + $routeParams.id,
       
        		
		 load = function () {           
        	$http.get(actionUrl)
             .success(function (data) {
            	 
             	 console.log("Console devices " + data.id);
                 $scope.device = data;	                        
                 
             });
         };
        load();
        $scope.update = function (id) {
            $location.path('/devices/update/'+id);
        };
        $scope.cancel = function () {
            $location.path('/devices');
        };

    });


    as.controller('UpdateDeviceController', function ($scope, $http, $routeParams,$location) {
    	 var actionUrl = baseUrl + '/' + + $routeParams.id;
    	 $scope.action = "Update ";

    	 $scope.ID = $routeParams.id;
		 load = function () {           
        	$http.get(actionUrl)
             .success(function (data) {
            	 
             	 console.log("Console devices " + data.id);
                 $scope.newDevice = data;	                        
                 
             });
         };
        load();

        $scope.cancel = function () {
            $location.path('/devices');
        };
        
    });
   

}());