(function () {
    var as = angular.module('exampleApp.controllers', []);
    //Test
//    var baseUrl = "http://172.21.76.125:8080/MicrogridApiTest/devices";
//    var staticUrl = "http://172.21.76.125:8080/MicrogridApiTest/static";
//    var url = "http://172.21.76.125:8080/MicrogridApiTest";
    
    //Dev
    var baseUrl = "http://172.21.76.125:8080/MicrogridApiDev/devices";
    var staticUrl = "http://172.21.76.125:8080/MicrogridApiDev/static";
    var url = "http://172.21.76.125:8080/MicrogridApiDev";
   
    as.controller('MainController', function ($q, $scope, $rootScope, $http, i18n, $location) {
        var load = function () {
        	$http.get(url+'/version')
	        .success(function (data) {
	            $scope.version = data;	                        
	        }); 
        	
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
//                $scope.totalItems = response.length;
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
    as.controller('NewDeviceController', function ($scope, $http, i18n, $location, $q) {

//        $scope.entityId = $routeParams.entityId;
//        $scope.ID = $routeParams.entityId;
	  $scope.action = "Add ";

//      $scope.selectedOption = $scope.options[0];
        
	
      load = function () {           
        	
    	  $http.get(staticUrl+'/deviceTypes')
	        .success(function (data) {
	            $scope.deviceTypes = data;	                        
	        }); 
			$http.get(staticUrl+'/buses')
	        .success(function (data) {
	            $scope.buses = data;	                        
	        }); 
        	
         };
        load();
	      
	      
	      
        $scope.save = function () {
            $http.post(baseUrl, $scope.newDevice).success(function (data) {
            	
                $location.path('/devices/'+ data.ID);
            });
        };


        $scope.cancel = function () {
            $location.path('/devices');
        };

    });
    
    
    as.controller('DeviceDetailsController', function ($scope, $http, $routeParams,$location) {
        var actionUrl = baseUrl + '/' + + $routeParams.id;
       
        		
		 load = function () {           
        	$http.get(actionUrl)
             .success(function (data) {
            	 
             	 console.log("Console devices " + data.id);
                 $scope.device = data;	                        
                 
             });
        	
        	$http.get(actionUrl+"/variables")
            .success(function (data) {
           	 
            	 console.log("Console variable " + data.id);
                 $scope.variables = data;	                        
                
            });
/*        	$http.get(actionUrl+"/commands")
            .success(function (data) {
           	 
            	 console.log("Console commands " + data.id);
                 $scope.commands = data;	                        
                
            });*/
        	
        	$http.get(staticUrl+"/units")
            .success(function (data) {
           	 
                 $scope.units = data;	                        
                
            });
        	
         };
        load();
        $scope.update = function (id) {
            $location.path('/devices/update/'+id);
        };
        $scope.cancel = function () {
            $location.path('/devices');
        };
// save the variable
        
        
        $scope.cancelVariable = function (id) {
        	 $('#myModal1').toggle();	
        	
        };
        
        
        $scope.saveVariable = function (id) {
        	$scope.newVariable.deviceID = id;
        	 $http.post(actionUrl + "/variables", $scope.newVariable).success(function (data) {
        		 // push the new variables to the list
                 $scope.variables.push(data);
                
             });
        	 
        };
        
        $scope.updatedVariable = function (deviceId,id) {
        	$scope.updateVariable.deviceID = deviceId;
        	$scope.updateVariable.ID = id;
//        	alert(deviceId + " : " + id);
        	 $http.put(actionUrl + "/variables/"+id, $scope.updateVariable).success(function (data) {
        		 // push the new variables to the list
                 $('#myModal1').toggle();
//                 $location.path('/devices/'+ deviceId);
                 load();
             });
        	 
        };
        
        $scope.goUpdateVariable = function (id) {
//        	$scope.newVariable.deviceID = id;
//        	alert(id);
        	 $http.get(actionUrl + "/variables/"+id).success(function (data) {
        		 // push the new variables to the list
//                 $scope.variables.push(data);
        		
        		 $scope.updateVariable = data;
        		 $('#myModal1').toggle();	
             });
        	 
        };
        
        
    });


    as.controller('UpdateDeviceController', function ($scope, $http, $routeParams,$location, $q) {
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
             	 console.log("Console devices " + data.id);
                 $scope.newDevice = data;	
             });
      	
         };
        load();
        



        $scope.cancel = function () {
            $location.path('/devices');
        };
        
        $scope.save = function () {
            $http.put(baseUrl, $scope.newDevice).success(function (data) {
                $location.path('/devices/'+data.ID);
            });
        };
        
    });
    
    
    
    as.controller('devicedetailCtrl', function($scope, $http, $routeParams) {
    	
    	 var actionUrl = baseUrl + '/' + $routeParams.id;
    	
    	 $scope.itemsPerPage = 50;
    	 $scope.currentPage = 0;
    	 $scope.entities = [];
    	 
    	 $scope.range = function() {
    		    var rangeSize = 4;
    		    var ps = [];
    		    var start;

    		    start = $scope.currentPage;
    		    if ( start > $scope.pageCount()-rangeSize ) {
    		      start = $scope.pageCount()-rangeSize+1;
    		    }

    		    for (var i=start; i<start+rangeSize; i++) {
    		      ps.push(i);
    		    }
    		    return ps;
    		  };

    		  $scope.prevPage = function() {
    		    if ($scope.currentPage > 0) {
    		      $scope.currentPage--;
    		    }
    		  };

    		  $scope.DisablePrevPage = function() {
    		    return $scope.currentPage === 0 ? "disabled" : "";
    		  };

    		  $scope.pageCount = function() {
    		    return Math.ceil($scope.entities.length/$scope.itemsPerPage)-1;
    		  };

    		  $scope.nextPage = function() {
    		    if ($scope.currentPage < $scope.pageCount()) {
    		      $scope.currentPage++;
    		    }
    		  };

    		  $scope.DisableNextPage = function() {
    		    return $scope.currentPage === $scope.pageCount() ? "disabled" : "";
    		  };

    		  $scope.setPage = function(n) {
    		    $scope.currentPage = n;
    		  };
    	 
    	 
    	 
    	 
        $http({
            method : "GET",
            //url : "http://172.21.76.189/MicrogridApi/devices"
            url: actionUrl + "/data"
        }).then(function mySucces(response) {
        	console.log(response.data);
            $scope.entities = response.data;
            $scope.entity = response.data[0];

        }, function myError(response) {
        	console.log("error");
        	console.log(response.data);
            //$scope.entities = response.statusText;
        });
        
        $http({
            method : "GET",
            //url : "http://172.21.76.189/MicrogridApi/devices"
            url: actionUrl
        }).then(function mySucces(response) {
        	console.log(response.data);
            $scope.device = response.data;
            //$scope.entity = response.data[0];

        }, function myError(response) {
        	console.log("error");
        	console.log(response.data);
            //$scope.entities = response.statusText;
        });
    });
   

}());

