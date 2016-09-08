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
            {'label': $.i18n.prop('ON'), 'value': 'ON'},
            {'label': $.i18n.prop('OFF'), 'value': 'OFF'}
        ];   
        var actionUrl = 'api/devices/',
        load = function () {
            $http.get(actionUrl + '?q=' + $scope.q
                    + '&status=' + ($scope.statusOpt.value == 'ALL' ? '' : $scope.statusOpt.value)
                    + '&page=' + ($scope.p - 1))
                    .success(function (data) {
                        $scope.devices = data.content;
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

        $scope.save = function () {
            $http.post(actionUrl, $scope.newDevice).success(function () {
                $location.path('/devices');
            });
        };


        $scope.cancel = function () {
            $location.path('/devices');
        };

    });

    
   

}());