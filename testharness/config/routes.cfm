<!--- -------------------------------------------
	Configure your setup here...
	This file is executed directly in the ses interceptor spawned from Adam Fortuna's ColdCourse.
	Therefore, ALL methods related to a plugin/interceptor/handler are available, you 
	can use getSetting(), getController(), etc....
	
	I actually ENCOURAGE you to use the getSetting() for tier detection.
	
	All credits to Adam Fortuna, Rob Cameron & Per Djurner of Coldfusion On Wheels 
	(http://www.cfwheels.com/) for innovating this routing method in Coldfusion.

	- http://coldcourse.riaforge.com
	
NOTE: The interceptor will create a new setting called: sesBaseURL with this value
	so it can be used by your application for any HTML base tags or relocations.
	The interceptor will also create the setting: htmlBaseURL so you can use in your
	<base> html tags, this is the same as the baseURL without the index.cfm if used.
	Else, htmlBaseURL and sesBaseURL should be the same.
	
-------------------------------------------- --->

<!---
	Do you want ColdCourse to be on or off? If it's off it'll just short circuit
	any page requests that come in, in effect it'll do nothing. Only framework 
	specific actions will work if this is set to off.
--->
<cfset setEnabled(true)>

<!--- 
	This determines if non-coldcourse urls should be routed back to coldcourse.
	In other words, if someone goes to http://localhost/index.cfm?event=home.main
	should we redirect (301, permanantly moved) to the coldcourse url: 
	http://localhost/home/main ?

	This will also make sure that any trailing index pages get redirected as well, so 
	if you go to http://localhost/home/index it would redirect to http://localhost/home 
	if index is your framework action default.

	For SEO purposes it's always best to have one URL for everything, not 3!
--->
<cfset setUniqueURLs(false)>

<!--- 
	The Base URL for your site. This will only be used for forwarding requests if 
	UniqueURLs is enabled.
   
    If you want your URLs to look like http://localhost/handler/action then you should
    put "http://localhost" here. For this option you'll need .htaccess or isapi rewrite support.
   
    If you want your URLs to look more like http://localhost/index.cfm/handler/action, then
    put "http://localhost/index.cfm" here. No additional setup is required to use this setting.

	You can place any tier detection within this section if needed. 
	
	NOTE: The interceptor will create a new setting called: sesBaseURL with this value
	so it can be used by your application for any HTML base tags or relocations.
	The interceptor will also create the setting: htmlBaseURL so you can use in your
	<base> html tags, this is the same as the baseURL without the index.cfm if used.
	Else, htmlBaseURL and sesBaseURL should be the same.
--->
<cfset setBaseURL("http://#getSetting('MyBaseURL')#/coldbox/testharness/index.cfm")>


<!--- -------------------------------------------
	Add your Courses here...
	The syntax of these is the same as that of Coldfusion on Wheels, and similar to Ruby 
	on Rails.  The idea is that the number of variables in a URL will be the first indicator
	of which course to use.
	
	Here's the general setup:
	<cfset addCourse(	pattern="handler/action/:id",	# Set the pattern
						handler="handler_name",		# Set the handler
						action="action_name" )>				# Set the action
						
	Notice how the "pattern" argument has three parts. In this case if a request comes in that starts with
	"/handler/action", such as "http://localhost/handler/action/oneOtherItem", this course will match.
	The "oneOtherItem" variable will be set to a URL variable with the name ID 
	<cfset url["ID"] = "oneOtherItem"> before then routing to the "handler_name" handler and the 
	"action_name" action. This would be the same as the URL
	http://localhost/index.cfm?event=handler_name.action_name&id=oneOtherItem
	
	It's important to remember that courses are evaulauted in order and go with the first one that matches.
	For instance if you have a course for /:handler/:action/:username, and another course later for 
	/:handler/:action/:id, then the second course will NEVER be run. If instead you change your first 
	course to something more generic such as /user/:action/:username, and specify (handler="user") as
	a second paramter, then only URLs that start with /user will qualify for having the thrid argument of
	username, while everywhere else will use a third argument of ID.
	
	THe Coldfusion on Wheels help files say it best:
	By the way, what's with the : syntax?  In the Ruby programming language, any variable 
	starting with a : is a symbol. Symbols are just like strings but they always point to 
	the same place in memory and are therefore more efficient.  They don't work that way 
	here in ColdFusion, but they make a good variable marker without worrying about where 
	to put quotes and stuff
	
	Examples:
	<cfset addCourse(	pattern="blog/entry/:year/:month/:day",
						handler="blog",
						action="entry" )>
	<cfset addCourse(	pattern="profile/view/:username",
						handler="profile",
						action="view" )>	
	<cfset addCourse(":handler/:action/:id")>
	<cfset addCourse(":handler/:action")>
	<cfset addCourse(":handler")>			
-------------------------------------------- --->

<!--- CUSTOM COURSES GO HERE (they will be checked in order) --->
<cfset addCourse(pattern="test/:id-numeric/:name?",handler="ehGeneral",action="dspHello")>
<cfset addCourse(pattern="test/:id/:name?",handler="ehGeneral",action="dspHello")>

<!--- STANDARD COLDBOX COURSES, DO NOT MODIFY UNLESS YOU DON'T LIKE THEM --->
<cfset addCourse(":handler/:action?/:id?")>

