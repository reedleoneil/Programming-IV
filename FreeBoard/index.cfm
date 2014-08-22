<cfif IsDefined("FORM.username")>
  <cfset MM_redirectLoginSuccess="/FreeBoard/member/Index.main.html">
  <cfset MM_redirectLoginFailed="/FreeBoard/loginfailed.cfm">
  <cfquery  name="MM_rsUser" datasource="FreeBoard">
  SELECT userid,username,password FROM users WHERE username=<cfqueryparam value="#FORM.username#" cfsqltype="cf_sql_clob" maxlength="50"> AND password=<cfqueryparam value="#FORM.password#" cfsqltype="cf_sql_clob" maxlength="50">
  </cfquery>
  <cfif MM_rsUser.RecordCount NEQ 0>
  		<cfset SESSION.MM_Username = MM_rsUser.username>
        <cfset SESSION.MM_Password = MM_rsUser.password>
  
    <cftry>
      <cflock scope="Session" timeout="30" type="Exclusive">
        <cfset Session.MM_Username=FORM.username>
        <cfset Session.MM_UserAuthorization="">
      </cflock>
      <cfif IsDefined("URL.accessdenied") AND false>
        <cfset MM_redirectLoginSuccess=URL.accessdenied>
      </cfif>
      <cflocation url="#MM_redirectLoginSuccess#" addtoken="no">
      <cfcatch type="Lock">
        <!--- code for handling timeout of cflock --->
      </cfcatch>
    </cftry>
  </cfif>
  <cflocation url="#MM_redirectLoginFailed#" addtoken="no">
  <cfelse>
  <cfset MM_LoginAction=CGI.SCRIPT_NAME>
  <cfif CGI.QUERY_STRING NEQ "">
    <cfset MM_LoginAction=MM_LoginAction & "?" & XMLFormat(CGI.QUERY_STRING)>
  </cfif>
</cfif>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>YouBoard.com</title>
</head>

<body background="/FreeBoard/member/images/wallpaper.jpg">
<p align=center>Welcome to University of the Assumption</p>
<p align=center>&quot;<em>You-Board</em>&quot;</p>
<form id="form1" name="form1" method="POST" action="<cfoutput>#MM_loginAction#</cfoutput>">
  <table width="200" border="0" align=center>
    <tr>
      <td>Username:</td>
      <td><label>
      <input type="text" name="username" id="username" />
      </label></td>
    </tr>
    <tr>
      <td>Password: </td>
      <td><label>
        <input type="password" name="password" id="password" />
      </label></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td><input type="submit" name="button" id="button" value="Login" />
      <input type="submit" name="button2" id="button2" value="Register" /></td>
    </tr>
  </table>
</form>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp; </p>
</body>
</html>
