angular.module('AceApp',['rzModule']).controller('SldCtrl', function($scope,$rootScope,$stateParams, $location, $timeout,$http, $uibModal,$interval,$filter, $localStorage) {

	var isDevice = $stateParams.isDevice;
	var simulator = false;
	// $rootScope.isDevice = 'device'== isDevice? true: false ;
	$rootScope.isDevice = true ;
	console.log("isDevice : "+$rootScope.isDevice);
	meterUrl = "data/pages/devices/meters.json";
	dcsource1Url = "data/pages/devicedetails/dcsource1.json";
	dcload1Url = "data/pages/devicedetails/dcload1.json";
	acsource1Url = "data/pages/devicedetails/acsource1.json";
	convertersUrl = "data/pages/devicedetails/converters.json";
	gridsimulatorUrl= "data/pages/devicedetails/gridsimulator.json";

	dcloadDataUrl = "data/pages/devicedetails/dcload1Data.json";


	// $scope.acsource1["status"] = "icons/off-16x16.png";
	// $scope.dcsource1["status"] = "icons/off-16x16.png";
	$scope.offStatus = "icons/off-16x16.png";

	totalDCsource = 0.0;
	totalACsource = 0.0;
	totalDCload = 0.0;
	totalACLoad = 0.0;
	totalBic = 0.0;

	totalPv1= 0.0;
	totalBattery= 0.0;


	// demo from device when demo eaquals to 'device'
	if($rootScope.isDevice){
		meterUrl = $rootScope.wsServerUrl;
		dcsource1Url = $rootScope.serverUrl + "get/dcsource1";
		dcload1Url = $rootScope.serverUrl + "get/dcload1";
		acsource1Url = $rootScope.serverUrl + "get/acsource1";
		convertersUrl = $rootScope.convWsServerUrl;
		gridsimulatorUrl = $rootScope.gridsimulatorUrl + "readValues";


	}else{ // dummy data for demo
		$http.get(meterUrl).success(function(data) {
			// console.log(data);
			listener(data);
		});

		$http.get(convertersUrl).success(function(data) {
			converterListener(data);
		});


		$interval(
			function(){
				$http.get(dcsource1Url,  { timeout: 2000 }).success(function(data) {
					// $http.get("http://172.21.76.189/angular/data/pages/devicedetails/devicedetails.json").success(function(data) {
					$scope.dcsource1 = data.data;
					// console.log($scope.dcsource1);
					$scope.dcsource1["power"] = $scope.dcsource1.variables.loadVoltage * $scope.dcsource1.variables.loadCurrent;
					// $scope.dcsource1["power"] = 450;
					if ($scope.dcsource1.variables.deviceStatus != 0){
						$scope.dcsource1["status"] = "icons/on-16x16.png";
						if($scope.dcsource1["power"] >= 20){
							$scope.dcsource1["arrow"] = "icons/arrow-down-blu-3-30x60.png";
							$scope.dcsource1["animation"] ="blink-animation-blu-down 4s steps(4, start) infinite";
						}else if ($scope.dcsource1["power"] <= -20){
							$scope.dcsource1["arrow"] = "icons/arrow-up-blu-3-30x60.png";
							$scope.dcsource1["animation"] ="blink-animation-blu-up 4s steps(4, start) infinite";
						}else{
							$scope.dcsource1["arrow"] = null;
							$scope.dcsource1["animation"]=null;
						}
					}else{
						$scope.dcsource1["status"] = "icons/off-16x16.png";
					}
				});
			},
			3000,20000
		);


		$interval(
			function(){
				//acsource1Url
				$http.get(acsource1Url,  { timeout: 2000 }).success(function(data) {
					// $http.get("http://172.21.76.189/angular/data/pages/devicedetails/devicedetails.json").success(function(data) {
					$scope.acsource1 = data.data;
					// console.log($scope.acsource1);
					$scope.acsource1.variables.realPower *= 1000;
					$scope.acsource1["animation"] =null;
					$scope.acsource1["arrow"] = null;
					if ($scope.acsource1.variables.deviceStatus != 0){
						$scope.acsource1["status"] = "icons/on-16x16.png";
						if($scope.acsource1.variables.realPower >= 20){
							$scope.acsource1["arrow"] = "icons/arrow-up-gry-3-30x60.png";
							$scope.acsource1["animation"] ="blink-animation-gry-up 4s steps(4, start) infinite";

						}else if ($scope.acsource1.variables.realPower  <= -20){
							$scope.acsource1["arrow"] = "icons/arrow-down-gry-3-30x60.png";
							$scope.acsource1["animation"] ="blink-animation-gry-down 4s steps(4, start) infinite";

						}
					}else{
						$scope.acsource1["status"] = "icons/off-16x16.png";
					}
				});
			},
			3000,20000
		);
	}


	$scope.open = function (titlename) {
		var modalInstance = $uibModal.open({
			templateUrl: 'views/popup/'+titlename+'.html',
			controller: 'PopupCont',
			resolve: {
				deviceId : function () {
					return titlename;
				}
			}
		});
	}




	function startWS(){
		if($rootScope.isDevice) {
			ws = new WebSocket(meterUrl);
			ws.onopen = function () {
				console.log("Power Meter WebSocket has been opened!");
			};
			ws.onmessage = function (message) {

				$scope.$apply(function () {
					listener(JSON.parse(message.data));
				});

			};

			ws.onclose = function () {
				//try to reconnect in 3 seconds
				setTimeout(function () {
					startWS()
				}, 3000);
			};
		}
	}

	function startConverterWS(){
		if($rootScope.isDevice) {
			wsConv = new WebSocket(convertersUrl);
			wsConv.onopen = function () {
				console.log("Converters WebSocket has been opened!");
			};
			wsConv.onmessage = function (message) {

				$scope.$apply(function () {
					converterListener(JSON.parse(message.data));
				});
			};
			wsConv.onclose = function () {
				//try to reconnect in 3 seconds
				setTimeout(function () {
					startConverterWS()
				}, 3000);
			};
		}
	}

	// $http.get("data/pages/devices/meters.json").success(function(data) {
	function listener(data) {
		// $scope.meters  = data;
		$scope.dcmeters = data.DC;
		$scope.acmeters = data.AC;

		totalDCsource = 0.0;
		totalACsource = 0.0;
		totalDCload = 0.0;
		totalACLoad  = 0.0;
		totalBic = 0.0;

		totalPv1= 0.0;
		totalBattery= 0.0;

		// console.log($scope.dcmeters);
		angular.forEach($scope.dcmeters, function(object, key) {
			// console.log(object);
			meterNo = object.meterNo;
			switch (meterNo) {
				case 1:
					$scope.powerbat1=object;
					if($scope.powerbat1.power){
						totalBattery += $scope.powerbat1.power;
						if($scope.powerbat1.power <= 0.0){
							totalDCsource += Math.abs($scope.powerbat1.power);
						}else{
							totalDCload += $scope.powerbat1.power;
						}
					}
					// console.log($scope.powerbat1.power );
					break;
				case 2:
					$scope.powerbat2=object;
					if($scope.powerbat2.power){
						totalBattery += $scope.powerbat2.power;
						if($scope.powerbat2.power <= 0.0){
							totalDCsource += Math.abs($scope.powerbat2.power);
						}else{
							totalDCload += $scope.powerbat2.power;
						}
					}
					break;
				case 3:
					$scope.powerpv1=object;
					if($scope.powerpv1.power){
						totalDCsource += Math.abs($scope.powerpv1.power);
						totalPv1 = Math.abs($scope.powerpv1.power);
					}
					break;
				case 4:
					$scope.powerbic1=object;
					if($scope.powerbic1.power){
						if($scope.powerbic1.power >= 0.0){
							totalDCload += $scope.powerbic1.power;
							totalACsource += $scope.powerbic1.power;
						}else{
							totalDCsource += Math.abs($scope.powerbic1.power);
							totalACLoad += Math.abs($scope.powerbic1.power);
						}
						totalBic += $scope.powerbic1.power;
					}
					break;
				case 5:
					$scope.powerpv2=object;
					if($scope.powerpv2.power){
							totalDCsource += Math.abs($scope.powerpv2.power);
					}
					break;
				case 6:
					$scope.powerbic2=object;

					if($scope.powerbic2.power){
						if($scope.powerbic2.power >= 0.0){
							totalDCload += $scope.powerbic2.power;
							totalACsource += $scope.powerbic2.power;
						}else{
							totalDCsource += Math.abs($scope.powerbic2.power);
							totalACLoad += Math.abs($scope.powerbic2.power);
						}
						totalBic += $scope.powerbic2.power;
					}
					break;
				case 7:
					$scope.powerdcsource1=object;
					if($scope.powerdcsource1.power){
							totalDCsource += Math.abs($scope.powerdcsource1.power);
					}
					break;
				case 8:
					$scope.powerdcload1=object;
					if($scope.powerdcload1.power){
						totalDCload += Math.abs($scope.powerdcload1.power);
					}
					break;
				default:
					alert("unknown dc meter id： " + meterNo);
			}
		});

		// ac meters
		angular.forEach($scope.acmeters, function(object, key) {

			meterNo = object.meterNo;
			switch (meterNo) {
				case 2:
					$scope.powersimulator=object;
					if($scope.powersimulator.totalActivePower>0){
						totalACLoad += Math.abs($scope.powersimulator.totalActivePower);
					}else{
						totalACsource += Math.abs($scope.powersimulator.totalActivePower);
					}
					// console.log(JSON.stringify(object));
					break;
				case 1:
					$scope.poweracsource1=object;
					if($scope.poweracsource1.totalApparentPower){
						totalACsource += Math.abs($scope.poweracsource1.totalApparentPower);
					}
					break;
				case 3:
					$scope.poweracload2=object;
					break;
				case 5:
					$scope.poweracbic1=object;
					break;
				case 6:
					$scope.poweracbic2=object;
					break;
				case 4:
					$scope.poweracload1=object;
					// console.log($scope.poweracload1.totalApparentPower);
					$scope.poweracload1["status"] = "icons/off-16x16.png";
					$scope.poweracload1["arrow"] = null;
					$scope.poweracload1["animation"] =null;
					if($scope.poweracload1.totalApparentPower >= 0.001){
						totalACLoad += Math.abs($scope.poweracload1.totalApparentPower);
						$scope.poweracload1["status"] = "icons/on-16x16.png";
						if($scope.poweracload1.totalApparentPower >= 0.02){
							$scope.poweracload1["arrow"] = "icons/arrow-down-gry-3-30x60.png";
							$scope.poweracload1["animation"] ="blink-animation-gry-down 4s steps(4, start) infinite";
						}
					};
					break;
				default:
					console.warn("unknown ac meter id： " + meterNo);
			}

		});
	}

	function converterListener(data) {
		// $scope.meters  = data;
		$scope.converters = data.converters;
		// console.log($scope.converters);
		angular.forEach($scope.converters, function(object) {
			// console.log(object);
			deviceId = object.deviceId;
			// console.log(object);
			// console.log("deviceId " + deviceId);

			// console.log("converter " + JSON.stringify(object));
			switch (deviceId) {
				case 'battery1':
					$scope.bat1 = object;
					$scope.bat1Slider.value = object.BAT_SOC;

					// on/off status
					if (object.CH1_ONOFF_STATUS || object.CH2_ONOFF_STATUS || object.CH3_ONOFF_STATUS || object.BAT_MODE != '4') {
						$scope.bat1["status"] = "icons/on-16x16.png";

						if (object.OPERATING_POW >= 20) {
							$scope.bat1["arrow"] = "icons/arrow-down-blu-3-30x60.png";
							$scope.bat1["animation"] ="blink-animation-blu-down 4s steps(4, start) infinite";

						} else if (object.OPERATING_POW <= -20) {
							$scope.bat1["arrow"] = "icons/arrow-up-blu-3-30x60.png";
							$scope.bat1["animation"] ="blink-animation-blu-up 4s steps(4, start) infinite";

						} else {
							$scope.bat1["arrow"] = null;
							$scope.bat1["animation"] = null;
						}
					} else
						$scope.bat1["status"] = "icons/off-16x16.png";
					break;
				case 'battery2':
					$scope.bat2 = object;
					$scope.bat2Slider.value = object.BAT_SOC;

					// on/off status
					if (object.CH1_ONOFF_STATUS || object.CH2_ONOFF_STATUS || object.CH3_ONOFF_STATUS || object.BAT_MODE != '4') {
						$scope.bat2["status"] = "icons/on-16x16.png";

						if (object.OPERATING_POW >= 20) {
							$scope.bat2["arrow"] = "icons/arrow-down-blu-3-30x60.png";
							$scope.bat2["animation"] ="blink-animation-blu-down 4s steps(4, start) infinite";

						} else if (object.OPERATING_POW <= -20) {
							$scope.bat2["arrow"] = "icons/arrow-up-blu-3-30x60.png";
							$scope.bat2["animation"] ="blink-animation-blu-up 4s steps(4, start) infinite";

						} else {
							$scope.bat2["arrow"] = null;
							$scope.bat2["animation"] = null;
						}
					} else
						$scope.bat2["status"] = "icons/off-16x16.png";
					break;
				case 'pv1':
					$scope.pv1 = object;
					if (object.CH1_MODE == 4) {
						//off
						$scope.pv1["status"] = "icons/off-16x16.png";

					} else {
						//on
						$scope.pv1["status"] = "icons/on-16x16.png";
						if (object.CH1_POWER >= 20) {
							//show arrows
							$scope.pv1["arrow"] = "icons/arrow-down-blu-3-30x60.png";
							$scope.pv1["animation"] ="blink-animation-blu-down 4s steps(4, start) infinite";
						}else{
							$scope.pv1["arrow"] = null;
							$scope.pv1["animation"] = null;
						}
					}
					break;
				case 'pv2':
					$scope.pv2 = object;
					if (object.CH1_MODE == 4) {
						//off
						$scope.pv2["status"] = "icons/off-16x16.png";

					} else {
						//on
						$scope.pv2["status"] = "icons/on-16x16.png";
						if (object.CH1_POWER >= 20) {
							//show arrows
							$scope.pv2["arrow"] = "icons/arrow-down-blu-3-30x60.png";
							$scope.pv2["animation"] ="blink-animation-blu-down 4s steps(4, start) infinite";
						}else{
							$scope.pv2["arrow"] = null;
							$scope.pv2["animation"] = null;
						}
					}
					break;
				case 'bic1':
					$scope.bic1 = object;
					if(!object.isolate_status ) {

						$scope.bic1["status"] = "icons/on-16x16.png";

						if (object.AC_output_active_power >= 20) {
							$scope.bic1["arrow"] = "icons/arrow-down-gry-3-30x60.png";
							$scope.bic1["animation"] ="blink-animation-gry-down 4s steps(4, start) infinite";
						} else if (object.AC_output_active_power <= -20) {
							$scope.bic1["arrow"] = "icons/arrow-up-blu-3-30x60.png";
							$scope.bic1["animation"] ="blink-animation-blu-up 4s steps(4, start) infinite";


						} else {
							$scope.bic1["arrow"] = null;
							$scope.bic1["animation"] = null;
						}
					} else{
						$scope.bic1["status"] = "icons/off-16x16.png";
					}
					break;
				case 'bic2':
					$scope.bic2=object;
					$scope.bic2["arrow"] = null;
					$scope.bic2["animation"] = null;
					if(!object.isolate_status ) {
						$scope.bic2["status"] = "icons/on-16x16.png";
						object.AC_output_active_power = -object.AC_output_active_power;
						if (object.AC_output_active_power >= 20) {
							$scope.bic2["arrow"] = "icons/arrow-down-gry-3-30x60.png";
							$scope.bic2["animation"] ="blink-animation-gry-down 4s steps(4, start) infinite";

						} else if (object.AC_output_active_power <= -20) {

							$scope.bic2["arrow"] = "icons/arrow-up-blu-3-30x60.png";
							$scope.bic2["animation"] ="blink-animation-blu-up 4s steps(4, start) infinite";

						}
					}else{
						$scope.bic2["status"] = "icons/off-16x16.png";
					}
					break;
				default:
					console.warn("unknown converter with id： " + deviceId);
			}
		});
	}


//start the websocket services
	startWS();
	startConverterWS();

	$scope.bat1Slider = {
		value: 0,
		options: {
			floor: 0,
			ceil: 100,
			// readOnly: true,
			vertical: true,
			showSelectionBar: true,
			translate: function(value) {
				return value + '%';
			},
			getSelectionBarColor: function(value) {
				if (value <= 20)
					return '#f0ad4e';
				if (value <= 85)
					return '#5cb85c';
				if (value <= 100)
					return '#d9534f';
				return '#2AE02A';
			},
			getPointerColor: function(value) {
				if (value <= 20)
					return '#f0ad4e';
				if (value <= 85)
					return '#5cb85c';
				if (value <= 100)
					return '#d9534f';
				return '#2AE02A';
			}
		}
	};

	$scope.bat2Slider = {
		value: 0,
		options: {
			floor: 0,
			ceil: 100,
			// readOnly: true,
			vertical: true,
			showSelectionBar: true,
			translate: function(value) {
				return value + '%';
			},
			getSelectionBarColor: function(value) {
				if (value <= 20)
					return '#f0ad4e';
				if (value <= 85)
					return '#5cb85c';
				if (value <= 100)
					return '#d9534f';
				return '#2AE02A';
			},
			getPointerColor: function(value) {
				if (value <= 20)
					return '#f0ad4e';
				if (value <= 85)
					return '#5cb85c';
				if (value <= 100)
					return '#d9534f';
				return '#2AE02A';
			}
		}
	};


	$scope.visible = false;
	$scope.verticalSlider5 = {
		value: 4,
		options: {
			floor: 0,
			ceil: 15,
			vertical: true,
			step: 0.01,
			precision: 2,
			translate: function(value) {
				return value + 'kW';
			},
			showSelectionBar: true,

			onEnd: function(newValue, highValue, pointerType) {
				console.info(newValue, pointerType);
				// $scope.otherData.end = newValue * 10;
			}
		}
	};
	$scope.toggle = function () {
		$scope.visible = !$scope.visible;
		console.log($scope.visible);

		$timeout(function () {
			$scope.$broadcast('rzSliderForceRender');
		});
	};


	$scope.visiblePv =  false;
	$scope.pvbStyle = "btn-primary";
	$scope.togglePv = function () {
		$scope.visiblePv = true;
		$scope.pvbStyle = "btn-success";
		if($rootScope.isDevice){
			$http.post($rootScope.autostart+ 'dynload').success(function(data) {
				response = data;
				console.log("Set pv1 successfully! " +  JSON.stringify(response.data));
				$scope.pvbStyle = "btn-primary";
				// $scope.visiblePv = !$scope.visiblePv;
				$timeout(function () {
					$scope.visiblePv = false;
				}, 20000);
			});
		}else{
			$timeout(function () {
				$scope.pvbStyle = "btn-primary";
                $scope.visiblePv = false;
			}, 60000);
		}

	};

    $scope.showPvPlot = function () {
        $scope.visiblePv = !$scope.visiblePv;
    };



	$scope.ok = function(){
		$scope.data =  {
			mode: "9",
			channel: 'channelA',
			inputValue:$scope.verticalSlider5.value * 1000
		}
		$http.post($rootScope.serverUrl+ 'set/dcload1', $scope.data).success(function(data) {
			response = data;
			if(response && response.code == 200){
				console.log("Set dc load successfully! " +  JSON.stringify(response.data));
			}
		});
	};

	$interval(
		function(){
			//dcload1
			$http.get(dcload1Url ,  { timeout: 2000 }).success(function(data) {
				// $http.get("http://172.21.76.189/angular/data/pages/devicedetails/devicedetails.json").success(function(data) {
				var response = data.data;
				if(response && response.variables){
					$scope.dcload1 = response;
					$scope.dcload1["arrow"] = null;
					$scope.dcload1["animation"] = null;

					if ($scope.dcload1.variables.deviceStatus && $scope.dcload1.variables.deviceStatus == 1){

						$scope.dcload1["status"] = "icons/on-16x16.png";
						if($scope.dcload1.variables.power >= 20){
							$scope.dcload1["arrow"] = "icons/arrow-up-blu-3-30x60.png";
							$scope.dcload1["animation"] ="blink-animation-blu-up 4s steps(4, start) infinite";
						}else if ($scope.dcload1.variables.power  <= -20){
							$scope.dcload1["arrow"] = "icons/arrow-down-blu-3-30x60.png";
							$scope.dcload1["animation"] ="blink-animation-blu-down 4s steps(4, start) infinite";
						}
					}else{
						$scope.dcload1["status"] = "icons/off-16x16.png";
					}
				}else{
					$scope.dcload1["status"] = "icons/off-16x16.png";
				}
			});
		},
		2000,20000
	);

	$interval(
		function(){
			//gridsimulator
			$http.get(gridsimulatorUrl, { timeout: 2000 }).success(function(data) {
				// $http.get("http://172.21.76.189/angular/data/pages/devicedetails/devicedetails.json").success(function(data) {
				$scope.gridsimulator = data.data;
				// console.log($scope.acsource1);
				// $scope.gridsimulator.realPower *= 1000;
				$scope.gridsimulator["arrow"] = null;
				$scope.gridsimulator["animation"] = null;
				if ($scope.gridsimulator.deviceStatus != 'OFF'){
					$scope.gridsimulator["status"] = "icons/on-16x16.png";
					if($scope.gridsimulator.realPower >= 100){
						$scope.gridsimulator["arrow"] = "icons/arrow-up-gry-3-30x60.png";
						$scope.gridsimulator["animation"] ="blink-animation-gry-up 4s steps(4, start) infinite";

					}else if ($scope.gridsimulator.realPower  <= -100){
						$scope.gridsimulator["arrow"] = "icons/arrow-down-gry-3-30x60.png";
						$scope.gridsimulator["animation"] ="blink-animation-gry-down 4s steps(4, start) infinite";
					}
				}else{
					$scope.gridsimulator["status"] = "icons/off-16x16.png";
				}

			})
		},
		3000,20000
	);


	$scope.bStyle = "btn-warning";
	$scope.init = "STDBY";


	$scope.isSim = simulator;
	if(!$scope.isSim){
		$scope.sStyle = "btn-primary";
	}else{
		$scope.sStyle = "btn-success";
	}

	$http.get(dcloadDataUrl).success(function(data) {
		// console.log(data);
		$rootScope.sdata = data;
	});



	function startS(){

		d = new Date();

		hour = d.getHours();
		minute = d.getMinutes();

		t = hour + ":" + (minute < 10? "0"+minute: minute);

		console.log(t + " - " + $rootScope.sdata[t] * 5);

		$scope.data =  {
				mode: "9",
				channel: 'channelA',
				inputValue:	$rootScope.sdata[t] * 5
			}
		$http.post($rootScope.serverUrl+ 'set/dcload1', $scope.data).success(function(data) {
			response = data;
			if(response && response.code == 200){
				console.log("Set dc load successfully! " +  JSON.stringify(response.data));
			}
		});
	};

	$scope.startSim = function () {

		$scope.sStyle = "btn-success";
		simulator = true;
		$scope.isSim = simulator;


		startS();

		$interval(
			startS,
			60000,360
		);



	};

	$scope.standby = function () {
		alertInfo = '';
		$http.post($rootScope.autostart + "start/on").success(function(data) {
			response = data;
			log = [];
			angular.forEach(response, function(msg, deviceId){
				if(msg != 'OK'){
					alertInfo += deviceId + " : "+msg +";\n";
					// alert(deviceId + " : "+msg);
					this.push(" <b class='red'>" +deviceId + ":"+msg+"</b>");
				}else{
					this.push(" " +deviceId + ":"+msg);
				}
			},log);

			$scope.message=log;
			if(alertInfo){
				alert(alertInfo);
			}else{
				$scope.bStyle = "btn-success";
				$scope.init = "ON";
			}
		});

	};

	$scope.start = function () {
		$http.post($rootScope.autostart + "auto/on").success(function(data) {
			response = data;
			if(response.alert){
				$scope.message=response.alert;
				alert(response.alert);
			}else{
				$scope.message="Autostart is completed";
				console.log($scope.message);
			}
		});

	};

	$scope.stop = function () {

		$http.post($rootScope.autostart + "shutdown").success(function(data) {
			response = data;
			if(response.alert){
				$scope.message=response.alert;
				alert(response.alert);
			}else{
				$scope.message="Autoshut is finished";
				console.log($scope.message);

			}
		});

	};

    Highcharts.setOptions({
        global: {
            useUTC: false
        }
    });

	dataLength = 30;
	bicChart  = new Highcharts.Chart({
		chart: {
			renderTo: 'container2',
			defaultSeriesType: 'spline',
			events: {
				load: function () {
					// set up the updating of the chart each second
					var series = this.series[0];
					setInterval(function () {
						x = (new Date()).getTime(), // current time
						y =  Math.round(Math.random() * 10);
						if($rootScope.isDevice){
							y =  Math.round((totalBic * 100))/100.0;
						}
						shift = series.data.length > dataLength; // shift if the series is longer than 20
						series.addPoint([x, y], true, shift);

					}, 2000);
				}
			}
		},
		title: {
			text: 'BIC Power Flow'
		},
		credits: {
			enabled: false
		},
		xAxis: {
			type: 'datetime',
			tickPixelInterval: 150,
			maxZoom: 20 * 1000
		},
		yAxis: {
			max: 5,
			min: -5,
			title: {
				text: 'Power (kW)',
			}
		},
		series: [{
			name: 'Total BIC (kW)',
			data: []
		}]
	});

	dcChart  = new Highcharts.Chart({
		chart: {
			renderTo: 'container',
			defaultSeriesType: 'spline',
			events: {
				load: function () {
					// set up the updating of the chart each second
					var series = this.series[0];
					var series1 = this.series[1];
					setInterval(function () {
						x = (new Date()).getTime(), // current time
						y =  Math.round(Math.random() * 10);
						y1 =  Math.round(Math.random() * 10);
						if($rootScope.isDevice){
							y =  Math.round( totalDCload * 100)/100.0;
							y1 = Math.round(totalDCsource * 100)/100.0;
						}
						shift = series.data.length > dataLength; // shift if the series is longer than 20
						shift1 = series1.data.length > dataLength; // shift if the series is longer than 20
						series.addPoint([x, y], true, shift);
						series1.addPoint([x, y1], true, shift1);
					}, 2000);
				}
			}
		},
		title: {
			text: 'DC Grid Power Balance'
		},
		credits: {
			enabled: false
		},
		xAxis: {
			type: 'datetime',
			tickPixelInterval: 150,
			maxZoom: 20 * 1000
		},
		yAxis: {
			minPadding: 0.1,
			maxPadding: 5,
			max: 15,
			min: 0,
			title: {
				text: 'Power (kW)',
			}
		},
		series: [{
			name: 'Total DC Load (kW)',
			data: []
		},{
			name: 'Total DC Source (kW)',
			data: []
		}]
	});

	acChart  = new Highcharts.Chart({
		chart: {
			renderTo: 'container1',
			defaultSeriesType: 'spline',
			events: {
				load: function () {
					// set up the updating of the chart each second
					var series = this.series[0];
					var series1 = this.series[1];
					setInterval(function () {
						x = (new Date()).getTime(), // current time
						y =  Math.round(Math.random() * 10);
						y1 =  Math.round(Math.random() * 10);
						if($rootScope.isDevice){
							y =  Math.round( totalACLoad * 100)/100.0;
							y1 = Math.round(totalACsource * 100)/100.0;
						}
						shift = series.data.length > dataLength; // shift if the series is longer than 20
						shift1 = series1.data.length > dataLength; // shift if the series is longer than 20
						series.addPoint([x, y], true, shift);
						series1.addPoint([x, y1], true, shift1);
					}, 2000);
				}
			}
		},
		title: {
			text: 'AC Grid Power Balance'
		},
		credits: {
			enabled: false
		},
		xAxis: {
			type: 'datetime',
			tickPixelInterval: 150,
			maxZoom: 20 * 1000
		},
		yAxis: {
			max: 10,
			min: 0,
			title: {
				text: 'Power (kW)',
			}
		},
		series: [{
			name: 'Total AC Load (kW)',
			data: []
		},{
			name: 'Total AC Source (kW)',
			data: []
		}]
	});


	pvChart  = new Highcharts.Chart({
		chart: {
			renderTo: 'pvplot',
			defaultSeriesType: 'spline',
			events: {
				load: function () {
					// set up the updating of the chart each second
					var series = this.series[0];
					var series1 = this.series[1];
					setInterval(function () {
						x = (new Date()).getTime(), // current time
							y =  Math.round(Math.random() * 10);
							y1 =  Math.round(Math.random() * 10);
						if($rootScope.isDevice){
							y =  Math.round(totalPv1 * 100)/100.0;
							y1 = Math.round(Math.abs(totalBattery + totalBic) * 100)/100.0;
						}
						shift = series.data.length > 40; // shift if the series is longer than 20
						shift1 = series1.data.length > 40; // shift if the series is longer than 20
						series.addPoint([x, y], true, shift);
						series1.addPoint([x, y1], true, shift1);
					}, 2000);
				}
			}
		},
		title: {
			text: 'PV Intermittency and Compensation'
		},
		credits: {
			enabled: false
		},
		xAxis: {
			type: 'datetime',
			tickPixelInterval: 50,
			maxZoom: 20 * 1000
		},
		yAxis: {
			minPadding: 0.1,
			maxPadding: 4,
			max: 8,
			min: 0,
			title: {
				text: 'Power (kW)',
			}
		},
		series: [{
			name: 'PV1 Power(kW)',
			data: []
		},{
			name: 'Compensation (kW)',
			data: []
		}]
	});

});







angular.module('AceApp').controller('PopupCont', function ($scope, $rootScope, $window, $uibModalInstance, $http, deviceId) {

	$scope.deviceId = deviceId;


	// console.log("popup : "+ $rootScope.isDevice );
	deviceUrl = "data/pages/devicedetails/"+deviceId+".json";
	// if reading from devices
	if($rootScope.isDevice){
		deviceUrl = $rootScope.serverUrl + "get/" + deviceId;
		if(deviceId == 'gridsimulator'){
			deviceUrl = $rootScope.gridsimulatorUrl + "readValues";
		}else{
			deviceUrl = $rootScope.serverUrl + "get/" + deviceId;
		}
	}
	$http.get(deviceUrl).success(function(data) {
		$scope.device = data.data;
		// console.log($scope.device);
	});
	$scope.close = function () {
		$uibModalInstance.dismiss('cancel');
	};

	$scope.changeStatus = function () {

		var changeStatus = $window.confirm('Are you absolutely sure to change device status?');

		if (changeStatus) {

			var url;
			var deviceStatus;

			if(deviceId == 'gridsimulator'){
				deviceStatus = $scope.device.deviceStatus;
				url = $rootScope.gridsimulatorUrl + "status/"+ deviceStatus;
			}else{
				deviceStatus = $scope.device.variables.deviceStatus;
				url = $rootScope.serverUrl+ 'set/' + deviceId + '/' +  deviceStatus + "/";
			}

			$window.alert('Going to submit to ' + url);
			if ($rootScope.isDevice) {
				$http.post(url).success(function(data) {
					response = data;
					if(response.code && response.code == 200){
						alert("Successfully Changed Device's status!");
					}
				});
			}
		}
	};
	$scope.save = function () {
		// $uibModalInstance.saved_result();
		// $scope.data["deviceStatus"] = $scope.device.deviceStatus;
		// console.log($scope.data);
		flag = true;
		if($scope.data == null){
			alert("Please input required values!");
			flag = false;
		}else{
			msg = "";
			angular.forEach($scope.data, function(object, key) {
				// console.log(key+" : "+object);
				if(!object){
					msg += key + " cannot be null! ";
					flag = false;
				}

			});
			if(msg != ""){
				alert(msg);
			}
		}

		if(flag){
			var url ;

			if(deviceId == 'gridsimulator'){
				url = $rootScope.gridsimulatorUrl + "setRead";
			}else{
				url = $rootScope.serverUrl+ 'set/' + deviceId;
			}

				var changeStatus = $window.confirm('confirm to request to ' + url + " with data " +JSON.stringify($scope.data));
				if (changeStatus) {
					$window.alert('Going to request to ' + url + " with data " +JSON.stringify($scope.data));
					// console.log(JSON.stringify($scope.data));
					if ($rootScope.isDevice) {
						$http.post(url, $scope.data).success(function(data) {

							response = data;
							console.log("set device: " + JSON.stringify(data));
							// alert("code :" + response.code + " message: " + response.message);

							if(response.code && response.code == 200){
								alert("Set Device successfully! " +  JSON.stringify(response.data));
							}
						});
					}
				}

		}
		// $uibModalInstance.dismiss('cancel');
	};
});
