//Define a function scope, variables used inside it will NOT be globally visible.
(function () {

    var
            //the HTTP headers to be used by all requests
            httpHeaders,
            //the message to be shown to the user
            message,
            //Define the main module.
            //The module is accessible everywhere using "angular.module('angularspring')", therefore global variables can be avoided totally.
            as = angular.module('exampleApp', ['ngRoute', 'ngResource', 'ngCookies', 'ui.bootstrap', 'ngMessages', 'exampleApp.i18n', 'exampleApp.services', 'exampleApp.controllers', 'exampleApp.filters', 'charts']);

    as.config(function ($routeProvider, $httpProvider) {
        //configure the rounting of ng-view
        $routeProvider
                .when('/',
                        {templateUrl: 'partials/home.html',
                            publicAccess: true})
                .when('/home',
                        {templateUrl: 'partials/home.html',
                            publicAccess: true})
                .when('/login',
                        {templateUrl: 'partials/login.html',
                            publicAccess: true})
             .when('/chart',
                    {
                	controller: 'Ctrl',
                	templateUrl: 'partials/devices/chart.html',
                            publicAccess: true})
                .when('/monitor/:id',
                    {
                	controller: 'devicedetailCtrl',
                	templateUrl: 'partials/devices/monitor.html',
                            publicAccess: true})
                .when('/devices',
                        {controller: 'DevicesController',
                            templateUrl: 'partials/devices/list.html',
                            publicAccess: true})
                 .when('/devices/new',
                        {controller: 'NewDeviceController',
                            templateUrl: 'partials/devices/new.html',
                            publicAccess: true}) 
                 .when('/devices/update/:id',
                        {controller: 'UpdateDeviceController',
                        templateUrl: 'partials/devices/edit.html',
                        publicAccess: true})            
                 .when('/devices/:id',
                        {controller: 'DeviceDetailsController',
                            templateUrl: 'partials/devices/details.html',
                            publicAccess: true
                            })           
                            ;


        //configure $http to catch message responses and show them

//        httpHeaders = $httpProvider.defaults.headers;
//        $httpProvider.defaults.headers.common['Access-Control-Allow-Origin'] = '*';

    });
}());