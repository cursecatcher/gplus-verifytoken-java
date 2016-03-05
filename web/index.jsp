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
    
  <%@include file="/googleplus.jsp" %> 
  
</body>
</html>



