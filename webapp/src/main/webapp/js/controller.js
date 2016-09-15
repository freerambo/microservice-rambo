(function () {
    var as = angular.module('exampleApp.controllers', []);

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
        var actionUrl = 'api/devices/',
        load = function () {
            $http.get(actionUrl + '?q=' + $scope.q
                    + '&bus=' + ($scope.statusOpt.value == 'ALL' ? '' : $scope.statusOpt.value)
                    + '&page=' + ($scope.p - 1))
                    .success(function (data) {
                        $scope.devices = data.content;
//                        console.log("devices list" + data.content);
                        $scope.totalItems = data.totalElements;
                        
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
	          ,
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
            $http.post(actionUrl, $scope.newDevice).success(function () {
                $location.path('/devices');
            });
        };


        $scope.cancel = function () {
            $location.path('/devices');
        };

    });
    
    
    as.controller('DeviceDetailsController', function ($scope, $http, $routeParams,$q) {
        var actionUrl = 'api/devices/' + + $routeParams.id,

        		
		 load = function () {           
        	$http.get(actionUrl)
             .success(function (data) {
            	 
             	 console.log("Console devices " + data.id);
                 $scope.device = data;	                        
                 
             });
         };
        load();

    });


    as.controller('UpdateDeviceController', function ($scope, $http, $routeParams,$q) {
        var actionUrl = 'api/devices/update/' + + $routeParams.id,

        		
		 load = function () {           
        	$http.get(actionUrl)
             .success(function (data) {
            	 
             	 console.log("Console devices " + data.id);
                 $scope.device = data;	                        
                 
             });
         };
        load();

    });
   

}());