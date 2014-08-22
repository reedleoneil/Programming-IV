<cfif IsDefined("URL.MM_logout") AND URL.MM_logout EQ "1">
  <cflock scope="Session" type="Exclusive" timeout="30" throwontimeout="no">
    <cfset Session.MM_Username="">
    <cfset Session.MM_UserAuthorization="">
  </cflock>
  <cfset MM_logoutRedirectPage="/FreeBoard/index.cfm">
  <cfif MM_logoutRedirectPage EQ "">
    <cfset MM_logoutRedirectPage=CGI.SCRIPT_NAME>
  </cfif>
  <cfset MM_logoutQuery=ListDeleteAt(CGI.QUERY_STRING,ListContainsNoCase(CGI.QUERY_STRING,"MM_logout=","&"),"&")>
  <cfif MM_logoutQuery NEQ "">
    <cfif Find("?",MM_logoutRedirectPage) EQ 0>
      <cfset MM_logoutRedirectPage=MM_logoutRedirectPage & "?" & MM_logoutQuery>
      <cfelse>
      <cfset MM_logoutRedirectPage=MM_logoutRedirectPage & "&" & MM_logoutQuery>
    </cfif>
  </cfif>
  <cflocation url="#MM_logoutRedirectPage#" addtoken="no">
</cfif>
<cfset CurrentPage=GetFileFromPath(GetBaseTemplatePath())>
<cfparam name="PageNum_rsListUsers" default="1">
<cfif IsDefined("FORM.MM_UpdateRecord") AND FORM.MM_UpdateRecord EQ "form2">
  <cfquery datasource="FreeBoard">   
    UPDATE users
SET username=<cfif IsDefined("FORM.username") AND #FORM.username# NEQ "">
<cfqueryparam value="#FORM.username#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, password=<cfif IsDefined("FORM.password") AND #FORM.password# NEQ "">
<cfqueryparam value="#FORM.password#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, fname=<cfif IsDefined("FORM.fname") AND #FORM.fname# NEQ "">
<cfqueryparam value="#FORM.fname#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, lname=<cfif IsDefined("FORM.lname") AND #FORM.lname# NEQ "">
<cfqueryparam value="#FORM.lname#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, address=<cfif IsDefined("FORM.address") AND #FORM.address# NEQ "">
<cfqueryparam value="#FORM.address#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, contact=<cfif IsDefined("FORM.contact") AND #FORM.contact# NEQ "">
<cfqueryparam value="#FORM.contact#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, pictures=<cfif IsDefined("FORM.pictures") AND #FORM.pictures# NEQ "">
<cfqueryparam value="#FORM.pictures#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
WHERE userid=<cfqueryparam value="#FORM.userid#" cfsqltype="cf_sql_numeric">
  </cfquery>
  <cflocation url="/FreeBoard/member/index.cfm">
</cfif>
<cfif IsDefined("FORM.MM_InsertRecord") AND FORM.MM_InsertRecord EQ "form1">
  <cfquery datasource="FreeBoard">   
    INSERT INTO users (username, password, fname, lname, address, contact, pictures)
VALUES (<cfif IsDefined("FORM.username") AND #FORM.username# NEQ "">
<cfqueryparam value="#FORM.username#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.password") AND #FORM.password# NEQ "">
<cfqueryparam value="#FORM.password#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.fname") AND #FORM.fname# NEQ "">
<cfqueryparam value="#FORM.fname#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.lname") AND #FORM.lname# NEQ "">
<cfqueryparam value="#FORM.lname#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.address") AND #FORM.address# NEQ "">
<cfqueryparam value="#FORM.address#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.contact") AND #FORM.contact# NEQ "">
<cfqueryparam value="#FORM.contact#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.pictures") AND #FORM.pictures# NEQ "">
<cfqueryparam value="#FORM.pictures#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
)
  </cfquery>
  <cflocation url="/FreeBoard/member/index.cfm">
</cfif>
<cfquery name="rsUser" datasource="FreeBoard">
SELECT *
FROM users where username = <cfqueryparam value="#SESSION.MM_Username#" cfsqltype="cf_sql_clob" maxlength="50"> and password  = <cfqueryparam value="#SESSION.MM_Password#" cfsqltype="cf_sql_clob" maxlength="50">
 
</cfquery>
<cfquery name="rsListUsers" datasource="FreeBoard">
SELECT *
FROM users
ORDER BY userid ASC 
</cfquery>
<cfset MaxRows_rsListUsers=10>
<cfset StartRow_rsListUsers=Min((PageNum_rsListUsers-1)*MaxRows_rsListUsers+1,Max(rsListUsers.RecordCount,1))>
<cfset EndRow_rsListUsers=Min(StartRow_rsListUsers+MaxRows_rsListUsers-1,rsListUsers.RecordCount)>
<cfset TotalPages_rsListUsers=Ceiling(rsListUsers.RecordCount/MaxRows_rsListUsers)>
<cfset QueryString_rsListUsers=Iif(CGI.QUERY_STRING NEQ "",DE("&"&XMLFormat(CGI.QUERY_STRING)),DE(""))>
<cfset tempPos=ListContainsNoCase(QueryString_rsListUsers,"PageNum_rsListUsers=","&")>
<cfif tempPos NEQ 0>
  <cfset QueryString_rsListUsers=ListDeleteAt(QueryString_rsListUsers,tempPos,"&")>
</cfif>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<body>
<p>Welcome <cfoutput>#rsUser.fname#</cfoutput> <cfoutput>#rsUser.lname#</cfoutput> !</p>
<p><img src="<cfoutput>#rsUser.pictures#</cfoutput>" width="110" height="104" longdesc="<cfoutput>#rsUser.fname#</cfoutput>" /></p>
<p><a href="<cfoutput>#CurrentPage#?MM_logout=1</cfoutput>">Log out</a></p>
<p>Show list of Users</p>
<table border="1">
  <tr>
    <td><div align="center"><strong>USERID</strong></div></td>
    <td><div align="center"><strong>USERNAME</strong></div></td>
    <td><div align="center"><strong>PASSWORD</strong></div></td>
    <td><div align="center"><strong>FIRST NAME</strong></div></td>
    <td><div align="center"><strong>LAST NAME</strong></div></td>
    <td><div align="center"><strong>ADDRESS</strong></div></td>
    <td><div align="center"><strong>CONTACT NO.</strong></div></td>
    <td><div align="center"><strong>PICTURE</strong></div></td>
  </tr>
  <cfoutput query="rsListUsers" startRow="#StartRow_rsListUsers#" maxRows="#MaxRows_rsListUsers#">
    <tr>
      <td>#rsListUsers.userid#</td>
      <td>#rsListUsers.username#</td>
      <td>#rsListUsers.password#</td>
      <td>#rsListUsers.fname#</td>
      <td>#rsListUsers.lname#</td>
      <td>#rsListUsers.address#</td>
      <td>#rsListUsers.contact#</td>
      <td><img src="#rsListUsers.pictures#" width="70" height="40" longdesc="#rsListUsers.fname#" /></td>
    </tr>
  </cfoutput>
</table>
<p>&nbsp;
<table border="0">
  <cfoutput>
    <tr>
      <td><cfif PageNum_rsListUsers GT 1>
        <a href="#CurrentPage#?PageNum_rsListUsers=1#QueryString_rsListUsers#"><img src="/FreeBoard/member/First.gif" border="0" /></a>
      </cfif>
      </td>
      <td><cfif PageNum_rsListUsers GT 1>
        <a href="#CurrentPage#?PageNum_rsListUsers=#Max(DecrementValue(PageNum_rsListUsers),1)##QueryString_rsListUsers#"><img src="/FreeBoard/member/Previous.gif" border="0" /></a>
      </cfif>
      </td>
      <td><cfif PageNum_rsListUsers LT TotalPages_rsListUsers>
        <a href="#CurrentPage#?PageNum_rsListUsers=#Min(IncrementValue(PageNum_rsListUsers),TotalPages_rsListUsers)##QueryString_rsListUsers#"><img src="/FreeBoard/member/Next.gif" border="0" /></a>
      </cfif>
      </td>
      <td><cfif PageNum_rsListUsers LT TotalPages_rsListUsers>
        <a href="#CurrentPage#?PageNum_rsListUsers=#TotalPages_rsListUsers##QueryString_rsListUsers#"><img src="/FreeBoard/member/Last.gif" border="0" /></a>
      </cfif>
      </td>
    </tr>
  </cfoutput>
</table>
</p>
<p>&nbsp;</p>
<p>Update my profile</p>
<p>&nbsp;</p>

<form action="<cfoutput>#CurrentPage#</cfoutput>" method="post" name="form2" id="form2">
  <table align="center">
    <tr valign="baseline">
      <td nowrap="nowrap" align="right">Username:</td>
      <td><input type="text" name="username" value="<cfoutput>#rsListUsers.username#</cfoutput>" size="32" /></td>
    </tr>
    <tr valign="baseline">
      <td nowrap="nowrap" align="right">Password:</td>
      <td><input type="password" name="password" value="<cfoutput>#rsListUsers.password#</cfoutput>" size="32" /></td>
    </tr>
    <tr valign="baseline">
      <td nowrap="nowrap" align="right">Fname:</td>
      <td><input type="text" name="fname" value="<cfoutput>#rsListUsers.fname#</cfoutput>" size="32" /></td>
    </tr>
    <tr valign="baseline">
      <td nowrap="nowrap" align="right">Lname:</td>
      <td><input type="text" name="lname" value="<cfoutput>#rsListUsers.lname#</cfoutput>" size="32" /></td>
    </tr>
    <tr valign="baseline">
      <td nowrap="nowrap" align="right">Address:</td>
      <td><input type="text" name="address" value="<cfoutput>#rsListUsers.address#</cfoutput>" size="32" /></td>
    </tr>
    <tr valign="baseline">
      <td nowrap="nowrap" align="right">Contact:</td>
      <td><input type="text" name="contact" value="<cfoutput>#rsListUsers.contact#</cfoutput>" size="32" /></td>
    </tr>
    <tr valign="baseline">
      <td nowrap="nowrap" align="right">Pictures:</td>
      <td><input type="text" name="pictures" value="<cfoutput>#rsListUsers.pictures#</cfoutput>" size="32" /></td>
    </tr>
    <tr valign="baseline">
      <td nowrap="nowrap" align="right">&nbsp;</td>
      <td><input type="submit" value="Update record" /></td>
    </tr>
  </table>
  <input type="hidden" name="MM_UpdateRecord" value="form2" />
  <input type="hidden" name="userid" value="<cfoutput>#rsListUsers.userid#</cfoutput>" />
</form>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
</body>
</html>
