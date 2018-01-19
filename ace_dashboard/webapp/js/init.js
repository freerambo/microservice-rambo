//Define a function scope, variables used inside it will NOT be globally visible.
(function () {

    var
            //the HTTP headers to be used by all requests
            httpHeaders,
            //the message to be shown to the user
            message,
            //Define the main module.
            //The module is accessible everywhere using "angular.module('angularspring')", therefore global variables can be avoided totally.
            as = angular.module('microgridApp', ['ngRoute', 'ngResource', 'ngCookies', 'ui.bootstrap', 'ngMessages', 'microgridApp.i18n',
                'microgridApp.services', 'microgridApp.controllers','microgridApp.projects', 'microgridApp.filters', 'microgridApp.devices',
                'microgridApp.schedule', 'microgridApp.dpApp','charts']);

    as.config(function ($routeProvider, $httpProvider) {
        //configure the rounting of ng-view
        $routeProvider
                .when('/',
                        {
                	// controller: 'MainController',
                	// templateUrl: 'partials/home.html',
                            controller: 'ProjectsController',
                            templateUrl: 'partials/projects/list.html',
                            publicAccess: true})
              /*  .when('/home',
                        {templateUrl: 'partials/home.html',
                            publicAccess: true})*/
                .when('/login',
                        {templateUrl: 'partials/login.html',
                            publicAccess: true})
        /*     .when('/chart',
                    {
                	controller: 'Ctrl',
                	templateUrl: 'partials/devices/chart.html',
                    publicAccess: true})*/
            .when('/projects/',
                {
                    controller: 'ProjectsController',
                    templateUrl: 'partials/projects/list.html',
                    publicAccess: true})
            .when('/projects/new',
                {controller: 'NewProjectController',
                    templateUrl: 'partials/projects/new.html',
                    publicAccess: true})
            .when('/projects/update/:id',
                {controller: 'UpdateProjectController',
                    templateUrl: 'partials/projects/edit.html',
                    publicAccess: true})
            .when('/projects/:id',
                {controller: 'ProjectDetailsController',
                    templateUrl: 'partials/projects/details.html',
                    publicAccess: true
                })
            .when('/projects/devices/:id',
                {controller: 'DevicesController',
                    templateUrl: 'partials/devices/list.html',
                    publicAccess: true})
            .when('/devices',
                    {controller: 'DevicesController',
                        templateUrl: 'partials/devices/list.html',
                        publicAccess: true})
             .when('/devices/new/:id',
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
            .when('/dps/',
                {controller: 'DataPointController',
                    templateUrl: 'partials/datapoints/list.html',
                    publicAccess: true
                })
            .when('/dps/:id',
                {controller: 'DataPointController',
                    templateUrl: 'partials/datapoints/list.html',
                    publicAccess: true
                })
            .when('/dpvs/',
                {controller: 'DataPointValueController',
                    templateUrl: 'partials/datapoints/listValues.html',
                    publicAccess: true
                })
            .when('/dpvs/:id',
                {controller: 'DataPointValueController',
                    templateUrl: 'partials/datapoints/listValues.html',
                    publicAccess: true
                })
            .when('/schedules',
                {controller: 'ScheduleController',
                    templateUrl: 'partials/schedule/list.html',
                    publicAccess: true
                })
            .when( '/schedules/new',
                {controller: 'NewScheduleController',
                    templateUrl: 'partials/schedule/new.html',
                    publicAccess: true
                })
             ;


        //configure $http to catch message responses and show them
       httpHeaders = $httpProvider.defaults.headers;
       $httpProvider.defaults.headers.common['Access-Control-Allow-Origin'] = '*';

    });
}());