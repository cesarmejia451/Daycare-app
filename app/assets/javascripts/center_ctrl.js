(function() {
  "use strict";

  angular.module("app").controller("centerCtrl", function($scope, $http){
    
    var map;
    var markers = [];


    function addMarker(center){
      if(!center.latitude || !center.longitude){
        return;
      } 

      var image = "https://bfb89515afffff903eb7a381cf5e58e24a620c1b-www.googledrive.com/host/0B09DNIgcGom_b1hxS2JnYXBiWFk/daycare.png"
      var marker = new google.maps.Marker({
        position: {lat: center.latitude, lng: center.longitude},
        map: map,
        icon: image,
        title: "Daycare Playground"
      });

      markers.push(marker);
      return marker;
      
    };

    function initMap(){
      var chicago = {lat: 41.8905, lng: -87.6750};
      map = new google.maps.Map(document.getElementById('map'), {
        zoom: 12,
        center: chicago
      });

      var styles = [

          {
                  "featureType": "all",
                  "elementType": "geometry",
                  "stylers": [
                      {
                          "color": "#63b5e5"
                      }
                  ]
              },
              {
                  "featureType": "all",
                  "elementType": "geometry.fill",
                  "stylers": [
                      {
                          "visibility": "on"
                      },
                      {
                          "hue": "#6ca0dc"
                      },
                      {
                          "saturation": "0"
                      },
                      {
                          "gamma": "1.36"
                      },
                      {
                          "weight": "0.01"
                      }
                  ]
              },
              {
                  "featureType": "all",
                  "elementType": "geometry.stroke",
                  "stylers": [
                      {
                          "color": "#cccccc"
                      }
                  ]
              },
              {
                  "featureType": "all",
                  "elementType": "labels.text.fill",
                  "stylers": [
                      {
                          "gamma": 0.01
                      },
                      {
                          "lightness": 20
                      }
                  ]
              },
              {
                  "featureType": "all",
                  "elementType": "labels.text.stroke",
                  "stylers": [
                      {
                          "saturation": -31
                      },
                      {
                          "lightness": -33
                      },
                      {
                          "weight": 2
                      },
                      {
                          "gamma": 0.8
                      }
                  ]
              },
              {
                  "featureType": "all",
                  "elementType": "labels.icon",
                  "stylers": [
                      {
                          "visibility": "off"
                      }
                  ]
              },
              {
                  "featureType": "landscape",
                  "elementType": "geometry",
                  "stylers": [
                      {
                          "lightness": 30
                      },
                      {
                          "saturation": 30
                      }
                  ]
              },
              {
                  "featureType": "poi",
                  "elementType": "geometry",
                  "stylers": [
                      {
                          "saturation": 20
                      }
                  ]
              },
              {
                  "featureType": "poi.park",
                  "elementType": "geometry",
                  "stylers": [
                      {
                          "lightness": 20
                      },
                      {
                          "saturation": -20
                      }
                  ]
              },
              {
                  "featureType": "road",
                  "elementType": "geometry",
                  "stylers": [
                      {
                          "lightness": 10
                      },
                      {
                          "saturation": -30
                      }
                  ]
              },
              {
                  "featureType": "road",
                  "elementType": "geometry.stroke",
                  "stylers": [
                      {
                          "saturation": 25
                      },
                      {
                          "lightness": 25
                      }
                  ]
              },
              {
                  "featureType": "water",
                  "elementType": "all",
                  "stylers": [
                      {
                          "lightness": -15
                      }
                  ]
              }
      ];

      map.setOptions({styles: styles});


      var bounds = new google.maps.LatLngBounds();
        
      for (var i = 0; i < $scope.centers.length; i++) {
        var center = $scope.centers[i];
        var marker = addMarker(center);
        if(marker){
          bounds.extend(marker.getPosition())
        }
        (function(m) {
          if(m){
            var name = center.business_name || center.name;
             var contentString = '<div id="content">'+
              '<div id="siteNotice">'+
              '</div>'+
              '<h4 id="firstHeading" class="firstHeading"><a href="centers/'+center.id+'">'+ name +'</h4>'+
              '<div id="bodyContent">'+
              '<p><a href="'+center.website+'"">Company Website</a>' +
              '</p>'+
              '<img src="https://bfb89515afffff903eb7a381cf5e58e24a620c1b-www.googledrive.com/host/0B09DNIgcGom_b1hxS2JnYXBiWFk/Drawing.png" alt="Logo" height="50" width="75"">'+
              '</div>'+
              '</div>';

            var infowindow = new google.maps.InfoWindow({
              content: contentString,
              maxWidth: 300
            });

            m.addListener('click', function() {
              infowindow.open(map, m);
            });
            
          }
        }(marker))
      };
      map.getBounds(bounds);
    }

    $scope.setup = function(){
      $http.get('/centers.json').then(function(response){
        if(window.centers){
          $scope.centers = window.centers
        }else {
          $scope.centers = response.data;
        }
        initMap()
      });
    };

    $scope.search = function() {
      $http.get('/api_search.json?search=' + $scope.searchValue).then(function(response){
          clearMarkers()
          $scope.centers = response.data;
          initMapSearch()
      });
    }

    // Sets the map on all markers in the array.
      function setMapOnAll(map) {
        for (var i = 0; i < markers.length; i++) {
          markers[i].setMap(map);
        }
      }

      // Removes the markers from the map, but keeps them in the array.
      function clearMarkers() {
        setMapOnAll(null);
        markers = []
      }


     function initMapSearch(){


      var bounds = new google.maps.LatLngBounds();
      
      for (var i = 0; i < $scope.centers.length; i++) {
        var center = $scope.centers[i];
        var marker = addMarker(center); 
  
        if(marker){
          bounds.extend(marker.getPosition())
        }
        (function(m) {
          if(m){
             var contentString = '<div id="content">'+
              '<div id="siteNotice">'+
              '</div>'+
              '<h4 id="firstHeading" class="firstHeading"><a href="/centers/'+center.id+'">'+center.name+'</h4>'+
              '<div id="bodyContent">'+
              '<p>'+center.phone+'</p>'+
              '<p><a href="'+center.website+'"">Company Website</a>' +
              '</p>'+
              '</div>'+
              '</div>';

            var infowindow = new google.maps.InfoWindow({
              content: contentString,
              maxWidth: 200
            });

            m.addListener('click', function() {
              infowindow.open(map, m);
            });
            // m.addListener('mousedown', function() {
            //   infowindow.close(map, m);
            // });
            
          }
        }(marker))
      };
      map.getBounds(bounds);
    }


    var map2;

    function addMarkerShow(center){
      if(!center.latitude || !center.longitude){
        return;
      }
      return new google.maps.Marker({
        position: {lat: center.latitude, lng: center.longitude },
        map: map,
        title: "Daycare Playground"
      });

    };

    function initMapShow(){
      var latitude = document.getElementById('lat').innerHTML;
      var longitude = document.getElementById('lng').innerHTML;
      var chicago = {lat: Number(latitude), lng: Number(longitude) };
    
     
      map = new google.maps.Map(document.getElementById('map'), {
        zoom: 15,
        center: chicago
      });
      var bounds = new google.maps.LatLngBounds();
        
      for (var i = 0; i < $scope.centers.length; i++) {
        var center = $scope.centers[i];
        var marker = addMarkerShow(center);
        if(marker){
          bounds.extend(marker.getPosition())
        }
        (function(m) {
          if(m){
             var contentString = '<div id="content">'+
              '<div id="siteNotice">'+
              '</div>'+
              '<h4 id="firstHeading" class="firstHeading"><a href="/centers/'+center.id+'">'+center.business_name+'</h4>'+
              '<div id="bodyContent">'+
              '<p>'+center.phone+'</p>'+
              '<p><a href="'+center.website+'"">Company Website</a>' +
              '</p>'+
              '</div>'+
              '</div>';

            var infowindow = new google.maps.InfoWindow({
              content: contentString,
              maxWidth: 200
            });


            m.addListener('mouseover', function() {
              infowindow.open(map, m);
            });
            m.addListener('click', function() {
              infowindow.close(map, m);
            });
            
          }
        }(marker))
      };
      map.getBounds(bounds);
    }

    $scope.setupShow = function(){
      $http.get('/centers.json').then(function(response){
        $scope.centers = response.data;
        initMapShow()
      });
    };

    window.scope = $scope;
  })

}());