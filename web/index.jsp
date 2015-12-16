<%-- 
    Document   : index
    Created on : 6-dic-2015, 17.08.00
    Author     : nicola
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>Google+ JavaScript Quickstart</title>
  <script src="https://apis.google.com/js/client:platform.js?onload=startApp" async defer></script>
  <!-- JavaScript specific to this application that is not related to API
     calls -->
  <script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js" ></script>
  <meta name="google-signin-client_id" content="495487496441-r9l7mppbotcf6i3rt3cl7fag77hl0v62.apps.googleusercontent.com"></meta>
</head>
<body>
  <div id="gConnect">
    <div id="signin-button"></div>
  </div> 
  <div id="authOps" style="display:none">
    <h2>User is now signed in to the app using Google+</h2>
    <button id="signOut" onclick="auth2.signOut()">Sign Out</button>
    <!--
    <p>If the user chooses to disconnect, the app must delete all stored
    information retrieved from Google for the given user.</p>
    <button id="disconnect">Disconnect your Google account from this app</button>
    -->
    <h2>User's profile information</h2>
    <div id="profile"></div>
    
    <div id="userInfo">
        <form id="userParameters" action="ServletLogin" method="post">
            <input type="hidden" name="action" value="loginGooglePlus">
            
            <input id="id_name" type="text" name="name">
            <input id="id_surname" type="text" name="surname">
        <!--    <input id="id_email" type="email" name="email"> -->
            <input id="id_token" type="text" name="idToken">
            <input id="id_access_token" type="text" name="access_token">
            
            <input type="submit" value="submit">
        </form>
    </div>
    
<!--
    <h2>Authentication Logs</h2>
    <pre id="authResult"></pre> -->
  </div>
  <div id="loaderror">
    This section will be hidden by JQuery. If you can see this message, you
    may be viewing the file rather than running a web server.<br />
    The sample must be run from http or https. See instructions at
    <a href="https://developers.google.com/+/quickstart/javascript">
    https://developers.google.com/+/quickstart/javascript</a>.
  </div>
<script type="text/javascript">
var auth2 = {};

/**  * Hides the sign in button and starts the post-authorization operations.
     * @param {Object} authResult An Object which contains the access token and
     * other authentication information. */
function onSignInCallback(authResult) {
    if (authResult.isSignedIn.get()) {
        $('#authOps').show('slow');
        $('#gConnect').hide();

        var authResponse = authResult.currentUser.get().getAuthResponse();
        $('#id_token').val(authResponse.id_token);
        $('#id_access_token').val(authResponse.access_token);
        
        getProfileData();        
      } 
      else if (authResult['error'] || authResult.currentUser.get().getAuthResponse() === null) {
        // There was an error, which means the user is not signed in.
        // As an example, you can handle by writing to the console:
        console.log('There was an error: ' + authResult['error']);
        $('#authResult').append('Logged out');
        $('#authOps').hide('slow');
        $('#gConnect').show();
      }

      console.log('authResult', authResult);
}

/*  Calls the OAuth2 endpoint to disconnect the app for the user. */
function disconnect() {
    auth2.disconnect();
}

function getProfileData() {    
    gapi.client.plus.people.get({'userId': 'me'}).then(function(res) { 
        var profile = res.result; 
        
        var name = profile.name.givenName; 
        var surname = profile.name.familyName;
        
        $('#id_name').val(name);        
        $('#id_surname').val(surname); 
     //   $('#userParameters').submit();     
      }, function(err) {
        var error = err.result;
        $('#profile').empty();
        $('#profile').append(error.message);
      }
    ); 
}

/* jQuery initialization */
$(document).ready(function() {
  $('#disconnect').click(disconnect);
  $('#loaderror').hide();
  if ($('meta')[0].content === 'YOUR_CLIENT_ID') {
    alert('This sample requires your OAuth credentials (client ID) ' +
        'from the Google APIs console:\n' +
        '    https://code.google.com/apis/console/#:access\n\n' +
        'Find and replace YOUR_CLIENT_ID with your client ID.'
    );
  }
});

/* Handler for when the sign-in state changes.
 * @param {boolean} isSignedIn The new signed in state. */
function updateSignIn() {
  console.log('update sign in state');
  if (auth2.isSignedIn.get()) {
    console.log('signed in');
    onSignInCallback(gapi.auth2.getAuthInstance());
  }else{
    console.log('signed out');
    onSignInCallback(gapi.auth2.getAuthInstance());
  }
}

/**
 * This method sets up the sign-in listener after the client library loads.
 */
function startApp() {
    //gapi.load carica dinamicamente librerie js
  gapi.load('auth2', function() {
    gapi.client.load('plus','v1').then(function() {
      gapi.signin2.render('signin-button', {
          scope: 'https://www.googleapis.com/auth/plus.login',
          fetch_basic_profile: false });
      gapi.auth2.init({fetch_basic_profile: false,
          scope:'https://www.googleapis.com/auth/plus.login'}).then(
            function (){
              console.log('init');
              auth2 = gapi.auth2.getAuthInstance();
              auth2.isSignedIn.listen(updateSignIn);
              auth2.then(updateSignIn());
            });
    });
  });
}
</script>
</body>
</html>



