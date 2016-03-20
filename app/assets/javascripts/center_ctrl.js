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
      var chicago = {lat: 41.8405, lng: -87.6750};
      map = new google.maps.Map(document.getElementById('map'), {
        zoom: 11,
        center: chicago
      });

      var styles = [
          {
            stylers: [
              { hue: "#00ffe6" },
              { saturation: -20 }
            ]
          }
        ];


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
              '<h4 id="firstHeading" class="firstHeading"><a href="centers/'+center.id+'">'+center.business_name+'</h4>'+
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
        $scope.centers = response.data;
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