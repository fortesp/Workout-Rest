'use strict';

angular.module('mytestappApp')
    .factory('Register', function ($resource) {
        return $resource('api/register', {}, {
        });
    });


