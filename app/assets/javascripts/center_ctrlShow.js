(function() {
  "use strict";

  angular.module("app").controller("centerCtrlShow", function($scope, $http){
    
    var map;
    var image = "https://bfb89515afffff903eb7a381cf5e58e24a620c1b-www.googledrive.com/host/0B09DNIgcGom_b1hxS2JnYXBiWFk/daycare.png";
    var markers = []

    function addMarkerShow(center){
      if(!center.latitude || !center.longitude){
        return;
      }
      return new google.maps.Marker({
        position: {lat: center.latitude, lng: center.longitude },
        map: map,
        icon: image,
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