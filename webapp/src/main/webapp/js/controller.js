(function () {
    var as = angular.module('exampleApp.controllers', []);
    var baseUrl = "http://172.21.76.189/webapp/";
   
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
//       get 	XMLHttpRequest cannot load http://172.21.76.189/webapp/api/devices/?q=&bus=&page=0. No 'Access-Control-Allow-Origin' header is present on the requested resource. Origin 'http://localhost:8080' is therefore not allowed access.
        /*$http.jsonp({
        	
        	url: 'http://172.21.76.189/MicrogridApi/devices?callback=JSON_CALLBACK&q=' + $scope.q
            + '&bus=' + ($scope.statusOpt.value == 'ALL' ? '' : $scope.statusOpt.value)
            + '&page=' + ($scope.p - 1)
        })
                .success(function(data, status, headers, config) {
                    data = JSON.stringify(data);
                    $scope.devices = data;
                    console.log("devices list" + data);
                    $scope.totalItems = 18;
                    
                })                  
                  .error(function(data, status, headers, config) {
                	data = JSON.stringify(data);
			        $scope.error = true;
			        console.log(data);
			        console.log("devices list error" + data + status);
			    });*/
            
            
       /*     $http({
                method: 'JSONP',
                url: 'http://172.21.76.189/MicrogridApi/devices/?callback=JSON_CALLBACK'
            }).success(function(data, status, headers, config) {
                data = JSON.stringify(data);
                $scope.devices = data;
                console.log("devices list" + data);
                $scope.totalItems = 18;
                
            })                  
              .error(function(data, status, headers, config) {
            	data = JSON.stringify(data);
		        $scope.error = true;
		        console.log(data);
		        console.log("devices list error" + data + status + headers + config);
		    });
            */
//        	Ref. https://docs.angularjs.org/api/ng/service/$http
//        	http://172.21.76.189/MicrogridApi/devices/?callback=JSON_CALLBACK
//        	https://angularjs.org/greet.php?callback=JSON_CALLBACK&name=Super%20Hero
            $http.jsonp('http://172.21.76.189/MicrogridApi/devices/test?callback=JSON_CALLBACK').success(function (response) {
                $scope.devices = response;
                console.log("devices list success "  + response);
            }).error(function(response) {
		        $scope.error = true;
		        console.log("devices list error" + response);
		    });;
       
            
//            $scope.devices = [{"ID":1,"IPAdress":"127.34.1111","busID":1,"classID":2,"className":"Source","description":"test Update Load 1 top Load 1device","isConnected":0,"isProgrammable":1,"location":"somewhere 1","microgridID":1,"microgridName":"Lab Level 5 Microgrid","model":"Model 1","name":"Load 11","portNumber":"3011","typeID":2,"typeName":"DC source","vendor":"Vendor 1"},{"ID":2,"IPAdress":"127.34.5646.12","busID":2,"classID":2,"className":"Source","description":"test Update Load 2 top Load 2device","isConnected":1,"isProgrammable":1,"location":"somewhere 2","microgridID":1,"microgridName":"Lab Level 5 Microgrid","model":"Model S2","name":"Load 2","portNumber":"3030upd2","typeID":2,"typeName":"DC source","vendor":"Sasha's"},{"ID":3,"IPAdress":"some IP 3","busID":1,"classID":2,"className":"Source","isConnected":0,"isProgrammable":1,"location":"location3","microgridID":1,"microgridName":"Lab Level 5 Microgrid","model":"Model3","name":"API call add 3","portNumber":"2002","typeID":1,"typeName":"AC Source","vendor":"vendor3"},{"ID":4,"IPAdress":"127.34.1111","busID":1,"classID":2,"className":"Source","description":"test Update Load 1 top Load 1device","isConnected":0,"isProgrammable":1,"location":"somewhere 1","microgridID":1,"microgridName":"Lab Level 5 Microgrid","model":"Model 1","name":"Load 11","portNumber":"3011","typeID":2,"typeName":"DC source","vendor":"Vendor 1"},{"ID":5,"IPAdress":"127.34.1111","busID":1,"classID":2,"className":"Source","description":"test Update Load 1 top Load 1device","isConnected":0,"isProgrammable":1,"location":"somewhere 1","microgridID":1,"microgridName":"Lab Level 5 Microgrid","model":"Model 1","name":"Load 11","portNumber":"3011","typeID":2,"typeName":"DC source","vendor":"Vendor 1"},{"ID":6,"IPAdress":"127.34.1111","busID":1,"classID":2,"className":"Source","description":"test Update Load 1 top Load 1device","isConnected":0,"isProgrammable":1,"location":"somewhere 1","microgridID":1,"microgridName":"Lab Level 5 Microgrid","model":"Model 1","name":"Load 11","portNumber":"3011","typeID":2,"typeName":"DC source","vendor":"Vendor 1"},{"ID":7,"IPAdress":"127.34.1111","busID":1,"classID":2,"className":"Source","description":"test Update Load 1 top Load 1device","isConnected":0,"isProgrammable":1,"location":"somewhere 1","microgridID":1,"microgridName":"Lab Level 5 Microgrid","model":"Model 1","name":"Load 11","portNumber":"3011","typeID":2,"typeName":"DC source","vendor":"Vendor 1"},{"ID":8,"IPAdress":"127.34.1111","busID":1,"classID":2,"className":"Source","description":"test Update Load 1 top Load 1device","isConnected":0,"isProgrammable":1,"location":"somewhere 1","microgridID":1,"microgridName":"Lab Level 5 Microgrid","model":"Model 1","name":"Load 11","portNumber":"3011","typeID":2,"typeName":"DC source","vendor":"Vendor 1"},{"ID":9,"IPAdress":"127.34.1111","busID":1,"classID":2,"className":"Source","description":"test UPDATE Load ","isConnected":0,"isProgrammable":1,"location":"somewhere 1","microgridID":1,"microgridName":"Lab Level 5 Microgrid","model":"Model 1","name":"Load UPD1","portNumber":"3011","typeID":2,"typeName":"DC source","vendor":"Vendor upd"},{"ID":10,"IPAdress":"127.34.1111","busID":1,"classID":2,"className":"Source","description":"test Update Load 1 top Load 1device","isConnected":0,"isProgrammable":1,"location":"somewhere 1","microgridID":1,"microgridName":"Lab Level 5 Microgrid","model":"Model 1","name":"Load 11","portNumber":"3011","typeID":2,"typeName":"DC source","vendor":"Vendor 1"},{"ID":11,"IPAdress":"127.34.1111","busID":1,"classID":2,"className":"Source","description":"test Update Load 1 top Load 1device","isConnected":0,"isProgrammable":1,"location":"somewhere 1","microgridID":1,"microgridName":"Lab Level 5 Microgrid","model":"Model 1","name":"Load 11","portNumber":"3011","typeID":2,"typeName":"DC source","vendor":"Vendor 1"},{"ID":12,"IPAdress":"127.34.1111","busID":1,"classID":2,"className":"Source","description":"test Update Load 1 top Load 1device","isConnected":0,"isProgrammable":1,"location":"somewhere 1","microgridID":1,"microgridName":"Lab Level 5 Microgrid","model":"Model 1","name":"Load 11","portNumber":"3011","typeID":2,"typeName":"DC source","vendor":"Vendor 1"},{"ID":13,"IPAdress":"127.34.1111","busID":1,"classID":2,"className":"Source","description":"test INSERT Load ","isConnected":0,"isProgrammable":1,"location":"somewhere 1","microgridID":1,"microgridName":"Lab Level 5 Microgrid","model":"Model 1","name":"Load 12","portNumber":"3011","typeID":2,"typeName":"DC source","vendor":"Vendor"},{"ID":14,"IPAdress":"127.34.1111","busID":1,"classID":2,"className":"Source","description":"test INSERT Load ","isConnected":0,"isProgrammable":1,"location":"somewhere 1","microgridID":1,"microgridName":"Lab Level 5 Microgrid","model":"Model 1","name":"Load 12","portNumber":"3011","typeID":2,"typeName":"DC source","vendor":"Vendor"},{"ID":15,"IPAdress":"127.34.1111","busID":1,"classID":2,"className":"Source","description":"test Update Load 1 top Load 1device","isConnected":0,"isProgrammable":1,"location":"somewhere 1","microgridID":1,"microgridName":"Lab Level 5 Microgrid","model":"Model 1","name":"Load 11","portNumber":"3011","typeID":2,"typeName":"DC source","vendor":"Vendor 1"},{"ID":16,"IPAdress":"127.34.1111","busID":1,"classID":2,"className":"Source","description":"test Update Load 1 top Load 1device","isConnected":0,"isProgrammable":1,"location":"somewhere 1","microgridID":1,"microgridName":"Lab Level 5 Microgrid","model":"Model 1","name":"Load 11","portNumber":"3011","typeID":2,"typeName":"DC source","vendor":"Vendor 1"},{"ID":17,"IPAdress":"127.34.1111","busID":1,"classID":2,"className":"Source","description":"test Update Load 1 top Load 1device","isConnected":0,"isProgrammable":1,"location":"somewhere 1","microgridID":1,"microgridName":"Lab Level 5 Microgrid","model":"Model 1","name":"Load 11","portNumber":"3011","typeID":2,"typeName":"DC source","vendor":"Vendor 1"},{"ID":18,"IPAdress":"127.34.1111","busID":1,"classID":2,"className":"Source","description":"test Update Load 1 top Load 1device","isConnected":0,"isProgrammable":1,"location":"somewhere 1","microgridID":1,"microgridName":"Lab Level 5 Microgrid","model":"Model 1","name":"Load 11","portNumber":"3011","typeID":2,"typeName":"DC source","vendor":"Vendor 1"},{"ID":19,"IPAdress":"127.34.5646.12","busID":2,"classID":2,"className":"Source","description":"test Update Load 2 top Load 2device","isConnected":1,"isProgrammable":1,"location":"somewhere 2","microgridID":1,"microgridName":"Lab Level 5 Microgrid","model":"Model S2","name":"Load 2","portNumber":"3030upd2","typeID":2,"typeName":"DC source","vendor":"UPD3"}];
            
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

        
        $.ajax({
			url : 'http://172.21.76.189/MicrogridApi/devices',
			type : 'GET',
			dataType : 'jsonp',
			error : function(data) {
				console.log("devices list error ajax " + JSON.stringify(data));
			},
			success : function(data) {
				 $scope.devices = data;
				 console.log("devices list sucessfully" + JSON.stringify(data));
			}
		});
        
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