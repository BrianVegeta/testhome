var templateUrl = '/ng_view/test_style';

var styleApp = angular.module('style', ['angularFileUpload']);

styleApp.controller('newController', ['$scope', '$http', function($scope, $http) {
	$scope.test = 0;
}]);

styleApp.controller('controlPanelController', ['$scope', function($scope) {
		this.showForm = function() {
			$('#save_dialog').modal({
			  keyboard: false
			})
		};
}]);

styleApp.controller('styleFormController', ['$scope', '$http', function($scope, $http) {
		this.save = function() {
			$textarea = $('<textarea name="style[html]" hidden></textarea>').append($('.style-editor-content').html());
			// console.log($('#new_style').append($textarea).html());
			// return;
			$('#new_style').append($textarea).submit();
			// console.log($scope);
			// $http.post('', {
			// 	test: {
			// 		test: 'asd'
			// 	}
			// }).success(function(data, status, headers, config) {
			// 	console.log(data, status, headers, config);
			// }).error(function(data, status, headers, config) {
			// 	console.log(data, status, headers, config);
			// });
			// console.log($scope.name);
			// console.log($scope.description);
			// console.log($('.style-editor-content').html());
		};
}]);

styleApp.directive('styleEditor', function($http) {
	return {
		restrict: 'A',
		link: function(scope, element, attrs) {
			
		},
		templateUrl: function(e, a, s) {
			return templateUrl;
		}
	};
});


styleApp.directive('controlMenu', function() {
	return {
		restrict: 'A',
		link: function(scope, element, attrs) {
			element.contextmenu({
			  target:'#context-menu', 
			  before: function(e,context) {
			  	e.preventDefault();
			  	return true;
			    // execute code before context menu if shown
			  },
			  onItem: function(context,e) {
			  	var action = $(e.target).attr('action');
			  	switch(action) {
				    case 'resizeable-nav-header':
				    	if (typeof element.resizable('instance') === 'undefined') {
								var limit = element.attr('resizeable-nav-header').split(' ');
				        element.resizable({
									minWidth: limit[0],
									maxWidth: limit[1],
									minHeight: limit[2],
									maxHeight: limit[3],
									resize: function(event, ui) {
										var $navbarFix = $('#navbar-fix'),
												$navbarLinks = $('#navbar').find('a'),
												navbarLinkHeight = $navbarLinks.height(),
												navbarHeight = ui.size.height,
												paddingTop = Math.round((navbarHeight - navbarLinkHeight) / 2),
												paddingBot = navbarHeight - navbarLinkHeight - paddingTop;
										$navbarFix.css({
											'padding-top': navbarHeight + 'px',
										});
										$navbarLinks.css({
											'padding-top': paddingTop + 'px',
											'padding-bottom': paddingBot + 'px'
										});
									}
								});
							} else {
								element.resizable('enable');
							}

							break;
						case 'cancel':
							element.resizable( "disable" );
							break;
						case 'test':
							console.log(element.resizable( "instance" ));
							break;
					} 
			  	console.log($(e.target).attr('action'));
			  }
			})
		}
	};
});

styleApp.directive('navbarBrandUpload', function($upload) {
	return {
		restrict: 'A',
		controller: function($scope, $upload) {
			this.upload = function($files) {
				$upload.upload({
          url: '/admin/images',
          method: 'post',
          file: $files[0],
          fileFormDataName: 'image[avatar]'
        }).progress(function(event) {

        }).success(function(response) {
        	var imageUrl = response.imageUrl.small; 
        	$('a.navbar-brand').css({
        		'background-image': 'url(' + response.imageUrl.small + ')'
        	});
        });
			};

		},
		link: function(scope, element, attrs) {
			element.parent().css({
				'position': 'relative'
			});
			element.css({
				'position': 'absolute',
				'top': '0',
				'right': '0'
			});
		},
		controllerAs: 'imageUpload',
		template: '<button ng-file-select ng-file-change="imageUpload.upload($files)">upload</button>'
	};
});
