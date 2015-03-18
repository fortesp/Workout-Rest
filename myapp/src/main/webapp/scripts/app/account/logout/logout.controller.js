'use strict';

angular.module('mytestappApp')
    .controller('LogoutController', function (Auth) {
        Auth.logout();
    });
