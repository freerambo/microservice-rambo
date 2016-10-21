(function () {
    var as = angular.module('exampleApp.controllers', ['ui.bootstrap']);
    //Test
    //  var baseUrl = "http://172.21.76.225:8080/MicrogridApiTest/devices";
//  var staticUrl = "http://172.21.76.225:8080/MicrogridApiTest/static";
//  var url = "http://172.21.76.225:8080/MicrogridApiTest";
  
  //Dev
  var baseUrl = "http://172.21.76.225:8080/MicrogridApiDev/devices";
  var staticUrl = "http://172.21.76.225:8080/MicrogridApiDev/static";
  var url = "http://172.21.76.225:8080/MicrogridApiDev";
   
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
    	   
//    	   if (confirm("Are you SURE to delete the device " + id + " ?")) {
//    		   $location.path('/devices/update/'+id);
//    	    }
    	   $location.path('/devices/'+id);
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
            	 
//             	 console.log("Console devices " + data.id);
                 $scope.device = data;	                        
                 
             });
        	
        	$http.get(actionUrl+"/variables")
            .success(function (data) {
           	 
//            	 console.log("Console variable " + data.id);
                 $scope.variables = data;	                        
                
            });
        	
        	$http.get(actionUrl+"/commands")
            .success(function (data) {
           	 
//            	 console.log("Console commands " + data.id);
                 $scope.commands = data;	                        
                
            });
        	
        	$http.get(staticUrl+"/units")
            .success(function (data) {
           	 
                 $scope.units = data;	                        
                
            });
        	
        	$http.get(staticUrl+"/commandProtocols")
            .success(function (data) {
           	 
                 $scope.protocols = data;	                        
                
            });
        	
        	$http.get(staticUrl+"/commandTypes")
            .success(function (data) {
           	 
                 $scope.types = data;	                        
                
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
        
        $scope.saveCommand = function (id) {
        	$scope.newCommand.deviceID = id;
        	 $http.post(actionUrl + "/commands", $scope.newCommand).success(function (data) {
        		 // push the new command to the list
                 $scope.commands.push(data);
                
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
        
        $scope.goUpdateCommand = function (id) {
        	 $http.get(actionUrl + "/commands/"+id).success(function (data) {
        		
        		 $scope.updateCommand = data;
        		 $('#commandModal1').toggle();
        		 
             });
        	 
        };
        
        $scope.updatedCommand = function (deviceId,id) {
        	$scope.updateCommand.deviceID = deviceId;
        	$scope.updateCommand.ID = id;
//        	alert("update command " + id);
        	 $http.put(actionUrl + "/commands/"+id, $scope.updateCommand).success(function (data) {
                 $('#commandModal1').toggle();
//                 alert("update command " + data.commandTypeName);
                 load();
             });
        	 
        };
        
        $scope.cancelCommand = function (id) {
       	 $('#commandModal1').toggle();	
       	
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
    
    
    
    as.controller('devicedetailCtrl', function($scope, $http, $routeParams,$filter) {
    	
    	 var actionUrl = baseUrl + '/' + $routeParams.id;
    	
    	 //start
    	 $scope.itemsPerPage = 50;
    		$scope.currentPage = 0;
    		$scope.entities = [];
    		$scope.isVisible = false;
    		$scope.showWeeks = true;
    		$scope.formats = [ 'dd-MMMM-yyyy', 'yyyy/MM/dd', 'shortDate' ];
    		$scope.format = $scope.formats[0];

    		$scope.range = function() {
    			var rangeSize = 4;
    			var ps = [];
    			var start;

    			start = $scope.currentPage;
    			
    			if (start > $scope.pageCount() - rangeSize) {
    				start = $scope.pageCount() - rangeSize ;
    				if (start < 0) {
    			        start = 0;
    			    }
    			} 

    			for (var i = start; i < start + rangeSize && i <= $scope.pageCount(); i++) {
    				ps.push(i);
    			}
    			console.log(ps);
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
    			console.log($scope.entities.length / $scope.itemsPerPage);
    			return Math.ceil($scope.entities.length / $scope.itemsPerPage) - 1 ;
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
    			if (n > 0 && n < $scope.pageCount()) {
    			      $scope.currentPage = n;
    			    }
    		};

    		$scope.today = function() {
    			$scope.fromDate = new Date();
    			$scope.toDate = new Date();
    		};
    		$scope.today();
    		$scope.toggleWeeks = function() {
    			$scope.showWeeks = !$scope.showWeeks;
    		};
    		$scope.clear = function() {
    			$scope.fromDate = null;
    			$scope.toDate = null;
    		};
    		// Disable weekend selection
    		//$scope.disabled = function(date, mode) {
    		//  return ( mode === 'day' && ( date.getDay() === 0 || date.getDay() === 6 ) );
    		// };
    		$scope.toggleMin = function() {
    			$scope.minDate = ($scope.minDate) ? new Date() : null;
    		};
    		$scope.toggleMin();
    		$scope.open = function($event) {
    			$scope.fromDate = new Date();
    			$event.preventDefault();
    			$event.stopPropagation();
    			$scope.opened = true;
    		};
    		$scope.dateOptions = {
    			'year-format' : "'yy'",
    			'starting-day' : 1
    		};
    		$scope.open1 = function($event) {
    			$scope.toDate = new Date();
    			$event.preventDefault();
    			$event.stopPropagation();
    			$scope.opened1 = true;
    		};
    		
    		$scope.find = function () {
    			$scope.fromDate = $filter('date')($scope.fromDate, "yyyy-MM-dd HH:mm:ss");
    			$scope.toDate = $filter('date')($scope.toDate, "yyyy-MM-dd HH:mm:ss");
    			console.log($scope.fromDate);
    			console.log($scope.toDate);
    			
    			$http({
    				method : "GET",
    				url: actionUrl + "/data"+"?startDate='"+$scope.fromDate+"'&endDate='"+$scope.toDate+"'"
    				
    			}).then(function mySucces(response) {
    				console.log(response.data);
    				$scope.entities = response.data;
    				if ($scope.entities.length > 0) {
    					$scope.entity = response.data[0];
    					$scope.isVisible = true;
    				} else {
    					$scope.response = "No records to display"
    				}
    				

    			}, function myError(response) {
    				console.log("error");
    				console.log(response.data);
    				//$scope.entities = response.statusText;
    			});
    			
    		};	
    		



    		$http({
    			method : "GET",
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
    	 //end
  
       
    });   
       
    as.controller("sldCtrl", function($scope, $location, $http) {
    	
    	$http({
			method : "GET",
			 url: "http://localhost:8999/MicrogridApi/"
		}).then(function mySucces(response) {
			console.log(response);
			$scope.devices = response.data;
			
			angular.forEach($scope.devices, function (value, key) {
				//console.log( document.querySelector( "#dv_"+(key+1) ))
				var element = angular.element( document.querySelector( "#dv_"+(key+1) ) );
				element.append('<a ng-click="monitor('+value.deviceID+')" href="">'+value.deviceName+'</a><br><br>');     
				angular.forEach(value.varList, function (value2, key2) {
					//console.log(value2);
					if (value2.isLink == 1) {
						element.append('<a href="'+value2.url_ON+'" >'+value2.variableName +'</a><br>');
					} else if (value2.isSwitcher == 1) {
						
						onofftag = angular.element( document.querySelector( "#onoffbutton" ) );
						//onofftag.append(value2.variableName +' : ');
						onofftag.append('<input type="checkbox" name="onoffswitch" class="onoffswitch-checkbox" id="myonoffswitch" onchange="change()"><label class="onoffswitch-label" for="myonoffswitch"> <span class="onoffswitch-inner"></span> <span class="onoffswitch-switch"></span></label>');
						element.append(onofftag);
					}  else  {
						element.append(value2.variableName+':'+value2.value);
						element.append('<br>');
						
					}
					
				});
				
				
	            
	        }); 

		}, function myError(response) {
			console.log("error");
			console.log(response.data);
			//$scope.entities = response.statusText;
		});
        
             
        $scope.monitor= function(deviceId) {
        	$location.path('/monitor/'+deviceId); 
        	
        }
        
        $scope.change = function() {
        	alert("event");
        }
        
        
        
    });
   

}());





