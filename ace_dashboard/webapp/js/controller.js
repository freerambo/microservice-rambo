(function () {
    var as = angular.module('microgridApp.controllers', ['ui.bootstrap']);

    //Dev
	var baseUrl = "http://172.21.76.225:8080/MicrogridApiDev/devices";

	var staticUrl = "http://172.21.76.225:8080/MicrogridApiDev/static";
	var url = "http://172.21.76.225:8080/MicrogridApiDev";
   
	as.controller('MainController', function ($q, $scope, $rootScope, $http, i18n, $location) {


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
    
    as.controller("sldCtrl", function($scope, $location, $http) {
    	
    	$http({
			method : "GET",
			 url: url
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
        	console.log("teting monitor ： " + deviceId);
        	$location.path('/monitor/'+deviceId); 
        	
        }
        
        $scope.change = function() {
        	alert("event");
        }
    });
	as.controller('LoginController', function ($scope, $rootScope, $http, base64, $location) {

		$scope.login = function () {
			console.log('username:password @' + $scope.username + ',' + $scope.password);
			$scope.$emit('event:loginRequest', $scope.username, $scope.password);
			// $('#login').modal('hide');
		};
	});


}());





