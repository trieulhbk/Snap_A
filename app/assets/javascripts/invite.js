<script src="http://connect.facebook.net/en_US/all.js"></script>
      // assume we are already logged in
  FB.init({appId: <%= GRAPH_APP_ID %>, xfbml: true, cookie: true});

  $('#app_request').click(function () {
    FB.ui({
      method: 'apprequests',
      message: 'try out this app http://0.0.0.0:3000/',
    });
  return false;
});