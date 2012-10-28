(function() {
	var _lat = 53.641186;
	var _lng = -2.099836;

	var _infoWindow;

	var _getInfoWindow = function(options) {
		if (!_infoWindow) {
			_infoWindow = new google.maps.InfoWindow();
		}

		var latLng = new google.maps.LatLng(options.lat, options.lng);

		_infoWindow.setPosition(latLng);
		_infoWindow.setContent(options.title);

		return _infoWindow;
	};

	function _addMarker(options) {
		var marker = new google.maps.Marker({
			map: Gmaps.map.serviceObject,
			position: new google.maps.LatLng(options.lat, options.lng),
			animation: google.maps.Animation.DROP,
			clickable: true,
			title: options.title
		});

		google.maps.event.addListener(marker, "click", function() {
			var infoWindow = _getInfoWindow(options);

			infoWindow.open(Gmaps.map.serviceObject, marker);
		});

		return marker;
	}

	function _enablePusherLogging() {
		Pusher.log = function(message) {
			if (window.console && window.console.log) {
				window.console.log(message);
			}
		};
	}

	function _subscribeToPusher() {
		var pusher = new Pusher("6c823debc0954f77934f");
		var channel = pusher.subscribe("flend");

		channel.bind("pusher:subscription_succeeded", function() {
			$("#divColor").text("subscribed");
		});

		channel.bind("newItem", function(message) {
			var date = new Date();
			var messageString = JSON.stringify(message);

			$("#divColor").text(messageString);

			var marker = _addMarker({
				lat: message.lat,
				lng: message.lng,
				title: message.title
			});
		});		
	}

	$(document).ready(function() {
		_enablePusherLogging();
		_subscribeToPusher();
		_initMap();
	});
}());
