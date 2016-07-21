<%@language="VBScript"%>
<%
'* --> 
'*	script name:			propertyinvestmentprofile.asp
'*
'*	part of application:	internet
'*
'*	description:			custom form for prudential nw properties			
'*
'*	notes:
'*
'*	revision history:		1.0 - Joy Waranyuwat - 07.14.06 - initial development	
'* ----------------------------------------------------------------------------------------------------------------- *'

if request.Form("submitted") = 1 then

	dim intReturn, txt, strCheckHomeValue
	
	intReturn = 0
	
	set Message = server.CreateObject("apps" & application("appsdllversion") & ".clsemail")
	message.connectionstring = application("activity_connectionstring")
	message.sourceID = 67
	message.companyid =  application("companyid")
	message.mailTo = chr(34) & "customerservice@prunw.com" & chr(34)
	message.mailFrom = chr(34) & "website@reliancenetwork.com" & chr(34)
	message.mailSubject = "Property Investment Profile" & " " & Request.Form("FirstName") & " " & Request.Form("LastName")
	
	txt = Request.Form("FirstName") & " " & Request.Form("LastName") & " <" & Request.Form("emailAddress") & "> submitted the following information via the 'Property Investment Profile' tool on " & Date() & "." & "<br>" & "<br>"
	txt = txt & "Name: " & Request.Form("FirstName") & " " & Request.Form("LastName") & "<br>"
	txt = txt & "Email: " & Request.Form("emailAddress") & "<br>"
	txt = txt & "Phone: " & Request.Form("phoneNumberAreaCode") & Request.Form("phoneNumberPrefix") & Request.Form("phoneNumberBase") & Request.Form("phoneNumberExtension") & "<br>"
	txt = txt & "Where You Heard About Us: " & Request.Form("resource") & "<br>"
	txt = txt & "Address: " & Request.Form("Address") & "<br>"
	txt = txt & "City: " & Request.Form("City") & "<br>"
	txt = txt & "State: " & Request.Form("State") & "<br>"
	txt = txt & "Zip Code: " & Request.Form("Zip") & "<br>"
	
	strCheckHomeValue = request.form("checkhomevalue")
	if len(strCheckHomeValue ) = 0 then
		strCheckHomeValue = "No"
	end if

	txt = txt & "How Much is My Home Worth Right Now: " & strCheckHomeValue & "<br>"
	txt = txt & "Property Feature Size: " & Request.Form("propertyfeaturesize") & "<br>"
	txt = txt & "Property Feature Lot Size: " & Request.Form("propertyfeaturelotsize") & "<br>"
	txt = txt & "Year Built: " & Request.Form("propertyfeatureyearbuilt") & "<br>"
	txt = txt & "Bedrooms: " & Request.Form("propertyfeaturebedrooms") & "<br>"
	txt = txt & "Bathrooms: " & Request.Form("propertyfeaturebathrooms") & "<br>"
	txt = txt & "Comments: " & Request.Form("Feedback") & "<br>"
	txt = txt & "Agent Name: " & Request.Form("agentname") & "<br>"
	
	message.mailBody = txt
	message.Sendemail

	response.Redirect("default.asp")
else%>

<script language="JavaScript">

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}


function YY_checkform() { //v4.65
//copyright (c)1998,2002 Yaromat.com
  var args = YY_checkform.arguments; var myDot=true; var myV=''; var myErr='';var addErr=false;var myReq;
  for (var i=1; i<args.length;i=i+4){
    if (args[i+1].charAt(0)=='#'){myReq=true; args[i+1]=args[i+1].substring(1);}else{myReq=false}
    var myObj = MM_findObj(args[i].replace(/\[\d+\]/ig,""));
    myV=myObj.value;
    if (myObj.type=='text'||myObj.type=='password'||myObj.type=='hidden'){
      if (myReq&&myObj.value.length==0){addErr=true}
      if ((myV.length>0)&&(args[i+2]==1)){ //fromto
        var myMa=args[i+1].split('_');if(isNaN(parseInt(myV))||myV<myMa[0]/1||myV > myMa[1]/1){addErr=true}
      } else if ((myV.length>0)&&(args[i+2]==2)){
          var rx=new RegExp("^[\\w\.=-]+@[\\w\\.-]+\\.[a-z]{2,4}$");if(!rx.test(myV))addErr=true;
      } else if ((myV.length>0)&&(args[i+2]==3)){ // date
        var myMa=args[i+1].split("#"); var myAt=myV.match(myMa[0]);
        if(myAt){
          var myD=(myAt[myMa[1]])?myAt[myMa[1]]:1; var myM=myAt[myMa[2]]-1; var myY=myAt[myMa[3]];
          var myDate=new Date(myY,myM,myD);
          if(myDate.getFullYear()!=myY||myDate.getDate()!=myD||myDate.getMonth()!=myM){addErr=true};
        }else{addErr=true}
      } else if ((myV.length>0)&&(args[i+2]==4)){ // time
        var myMa=args[i+1].split("#"); var myAt=myV.match(myMa[0]);if(!myAt){addErr=true}
      } else if (myV.length>0&&args[i+2]==5){ // check this 2
            var myObj1 = MM_findObj(args[i+1].replace(/\[\d+\]/ig,""));
            if(myObj1.length)myObj1=myObj1[args[i+1].replace(/(.*\[)|(\].*)/ig,"")];
            if(!myObj1.checked){addErr=true}
      } else if (myV.length>0&&args[i+2]==6){ // the same
            var myObj1 = MM_findObj(args[i+1]);
            if(myV!=myObj1.value){addErr=true}
      }
    } else
    if (!myObj.type&&myObj.length>0&&myObj[0].type=='radio'){
          var myTest = args[i].match(/(.*)\[(\d+)\].*/i);
          var myObj1=(myObj.length>1)?myObj[myTest[2]]:myObj;
      if (args[i+2]==1&&myObj1&&myObj1.checked&&MM_findObj(args[i+1]).value.length/1==0){addErr=true}
      if (args[i+2]==2){
        var myDot=false;
        for(var j=0;j<myObj.length;j++){myDot=myDot||myObj[j].checked}
        if(!myDot){myErr+='* ' +args[i+3]+'\n'}
      }
    } else if (myObj.type=='checkbox'){
      if(args[i+2]==1&&myObj.checked==false){addErr=true}
      if(args[i+2]==2&&myObj.checked&&MM_findObj(args[i+1]).value.length/1==0){addErr=true}
    } else if (myObj.type=='select-one'||myObj.type=='select-multiple'){
      if(args[i+2]==1&&myObj.selectedIndex/1==0){addErr=true}
    }else if (myObj.type=='textarea'){
      if(myV.length<args[i+1]){addErr=true}
    }
    if (addErr){myErr+='* '+args[i+3]+'\n'; addErr=false}
  }
  if (myErr!=''){alert(myErr)}
  document.MM_returnValue = (myErr=='');
}
</script>
<style>
form#PIP input.txtField {
font-size: 9px; 
width: 200px;
background: top left repeat-y url(<%=application("mediapath")%>/companyset/Prudential_NW/bg_inputText.gif);
border:solid 1px #dddddd;
}
input.txtField{
margin-top:3px;
}
input#checkhomevalue{
margin-left:150px;
}
form#PIP input.citytxt{
width:104px;
}
* html form#PIP input.citytxt{
width:100px;
}
form#PIP input.ph1{
margin-top:3px;
WIDTH: 33px;
}
* html form#PIP input.ph1{
margin-top:2px;
WIDTH: 30px;
}
form#PIP select {font-size: 9px; width: 200px; float:left;}
form#PIP label{
display:block;
width:150px;
float:left;
}
form#PIP label.box{
float:none;
padding-bottom:10px;
}
div#threebox{
margin-left:150px;
margin-top:-15px;
}
* html div#threebox{
margin-top:-20px;
}
div.largeBox{
float:left;
padding:10px 0px 20px 0px;
}
form#PIP legend{
font-size:14px;
color:#333333;
}
form#PIP label.bedbath{
display:block;
width:150px;
}
* html form#PIP label.bedbath{
display:block;
width:153px;
}
form#PIP label.contactInfo{
display:block;
width:157px;
}
p#info{
font-size:11px;
}
</style>

<form action="default.asp?p=propertyinvestmentprofile.asp" method="post" name="PIP" id="PIP" onsubmit="javascript: alert('Your form has been sent');">
<h1 id="pip"><span>Property Investment Profile Request</span></h1>

<p id="info">Prudential Northwest Properties can tell you how much your home is worth with a 
customized Property Investment Profile™.<br><br>It’s an automatic e-mail update 
that contains the most current estimated value of your home.<br><br>Just like 
your bank statement, all information is confidential and is sent to you monthly 
with no obligation.<br><br>It’s totally free with no strings 
attached. </p>

	<fieldset style="padding:5px; margin-bottom:25px;">
	<legend><b>Please Enter Property Information:</b></legend>
	<input type="hidden" name="submitted" value="1" ID="Hidden5">
	<p><b>Enter the address for the property below:</b></p>

	<label>Address:</label>
	<input class=txtField name="Address" type="text" id="Address" size="35" maxlength="50"><br>
	
	<label>City, State, Zip:</label>
	<input class="txtField citytxt" name="City" type="text" id="City" size="10" maxlength="35"> ,
	<input class="txtField" name="State" type="text" id="State" size="2" maxlength="2" style="width:30px;">
	<input class="txtField" name="Zip" type="text" id="Zip" size="5" maxlength="5" style="width:50px;">
	<br>
	
	<p><b>Property Features:</b></p>

	<div id="threebox">
		<div class="largeBox">
		<label class="box">Approx Sq Ft:</label>

		<select name="propertyfeaturesize" size="17" style="width:128px;font-size:9pt;" multiple ID="propertyfeaturesize">
		<option value="0">No Preference</option>
		<option value="1000">1,000+</option>
		<option value="1250">1,250+</option>
		<option value="1500">1,500+</option>
		<option value="1750">1,750+</option>
		<option value="2000">2,000+</option>
		<option value="2250">2,250+</option>
		<option value="2500">2,500+</option>
		<option value="2750">2,750+</option>
		<option value="3000">3,000+</option>
		<option value="3500">3,500+</option>
		<option value="4000">4,000+</option>
		<option value="4500">4,500+</option>
		<option value="5000">5,000+</option>
		<option value="6000">6,000+</option>
		<option value="7000">7,000+</option>
		<option value="10000">10,000+</option>
		</select>
		</div>

	
		<div class="largeBox boxleft">
		<label class="box">Approx Lot Size:</label>

		<select name="propertyfeaturelotsize" size="17" style="width:128px;font-size:9pt;" multiple ID="propertyfeaturelotsize">
		<option value="0 to 2,999 SqFt">0 to 2,999 SqFt</option>
		<option value="3,000 to 4,999 SqFt">3,000 to 4,999 SqFt</option>
		<option value="5,000 to 6,999 SqFt">5,000 to 6,999 SqFt</option>
		<option value="7,000 to 9,999 SqFt">7,000 to 9,999 SqFt</option>
		<option value="10,000 to 14,999 SqFt">10,000 to 14,999 SqFt</option>
		<option value="15,000 to 19,999 SqFt">15,000 to 19,999 SqFt</option>
		<option value="20,000 SqFt to .99 Acres">20,000 SqFt to .99 Acres</option>
		<option value="1 to 2.99 Acres">1 to 2.99 Acres</option>
		<option value="3 to 4.99 Acres">3 to 4.99 Acres</option>
		<option value="5 to 9.99 Acres">5 to 9.99 Acres</option>
		<option value="10 to 19.99 Acres">10 to 19.99 Acres</option>
		<option value="20 to 49.99 Acres">20 to 49.99 Acres</option>
		<option value="50 to 99.99 Acres">50 to 99.99 Acres</option>
		<option value="100 to 199.99 Acres">100 to 199.99 Acres</option>
		<option value="200+ Acres">200+ Acres</option>
		</select>
		</div>

		<div class="largeBox">
		<label class="box">Year Built:</label>

		<select name="propertyfeatureyearbuilt" size="17" style="width:128px;font-size:9pt;" multiple ID="propertyfeatureyearbuilt">
		<option value="1900">1900+</option>
		<option value="1920">1920+</option>
		<option value="1940">1940+</option>
		<option value="1960">1960+</option>
		<option value="1970">1970+</option>
		<option value="1975">1975+</option>
		<option value="1980">1980+</option>
		<option value="1985">1985+</option>
		<option value="1990">1990+</option>
		<option value="1991">1991+</option>
		<option value="1992">1992+</option>
		<option value="1993">1993+</option>
		<option value="1994">1994+</option>
		<option value="1995">1995+</option>
		<option value="1996">1996+</option>
		<option value="1997">1997+</option>
		<option value="1998">1998+</option>
		<option value="1999">1999+</option>
		<option value="2000">2000+</option>
		<option value="2001">2001+</option>
		<option value="2002">2002+</option>
		<option value="2003">2003+</option>
		<option value="2004">2004+</option>
		<option value="2005">2005+</option>
		</select>
		</div>
	
		<div class="largeBox">
		<label class="box bedbath">Bedrooms:</label>
		<select name="propertyfeaturebedrooms" size="1" ID="propertyfeaturebedrooms" style="width:130px;">
		<option value="">Any</option>
		<option value="1">1+</option>
		<option value="2">2+</option>
		<option value="3">3+</option>
		<option value="4">4+</option>
		<option value="5">5+</option>
		</select></div>

		<div class="largeBox">
		<label class="box bedbath">Bathrooms:</label>
		<select name="propertyfeaturebathrooms" size="1" ID="propertyfeaturebathrooms" style="width:130px;">
		<option value="">Any</option>
		<option value="1">1+</option>
		<option value="2">2+</option>
		<option value="3">3+</option>
		<option value="4">4+</option>
		<option value="5">5+</option>
		</select>
		</div>
		<div style="clear:both;"></div>
		
		<div>
		<label class="box">Additional Comments:</label>
		<textarea class=txtField name=Feedback rows=7 cols=50 ID="Feedback"></textarea>
		</div>
	</div>
	<div style="clear:both;"></div>
	
	<%if len(session("accountid")) = 0 then%>

	<p>If you are currently working with a Prudential NW agent or there is an agent from whom you would like to receive this report, please enter their name here.</p>


	<label>Agent Name:</label>
	<input type="text" class="txtField" name="agentname" ID="agentname">

	<%end if%>
	</fieldset>	
		
	<%'these variables tell inc_contact_preferences.asp to not build these fields
	bSkipZipcode = true
	bIncludeSource = true%>            
             
	<input name="toEmail" type="hidden" value="<%=vEmail%>" ID="Hidden1">
	<input name="toName" type="hidden" value="<%=vName%>" ID="Hidden2">
	<input name="toAccountID" type="hidden" value="<%=vAccountID%>" ID="Hidden3">
	<input name="cc" type="hidden" value="<%=vEmail2%>" ID="Hidden4">

	<%if request.QueryString("formid") > 0 then%>
		Thank you, <b><%=request.Form("firstname")%></b>! Your <b><%=vFormName%></b> form has been received and you will receive a response as soon as possible.
		<%else%>
		
		
		<p><b>Your Name & Contact Information:</b></p>
	   
		<label class="contactInfo">First Name: </label>
		<input class=txtField size=25 name="FirstName" ID="FirstName"> <img src="<%=application("mediapath")%>/companyset/<%=application("sitedirectory")%>/requiredstar.gif">
		<br>
	    
		<label class="contactInfo">Last Name: </label>
		<input class=txtField size=25 name="LastName" ID="LastName"> <img src="<%=application("mediapath")%>/companyset/<%=application("sitedirectory")%>/requiredstar.gif">
		<br>
	    
		<label class="contactInfo">Email: </label>
		<input class=txtField size=25 name="emailAddress" ID="emailAddress"> <img src="<%=application("mediapath")%>/companyset/<%=application("sitedirectory")%>/requiredstar.gif">
		<br>
	    
		<%if not bSkipZipcode then %>	
		 
		<label class="contactInfo">Zip Code: </label>
		<input class=txtField size=25 maxlength=5 name=zip id="zip">
		<br>
	    
		<%end if%> 
		<label class="contactInfo">1st Phone: </label>
		<input class="input ph1" style="border:solid 1px #dddddd;background: top left repeat-y url(<%=application("mediapath")%>/companyset/Prudential_NW/bg_inputText.gif);" maxlength=3 size=3 name=phoneNumberAreaCode ID="phoneNumberAreaCode">
			- <input class="input ph1" style="border:solid 1px #dddddd;background: top left repeat-y url(<%=application("mediapath")%>/companyset/Prudential_NW/bg_inputText.gif);" maxlength=3 size=3 name=phoneNumberPrefix ID="phoneNumberPrefix">
			- <input class=input style="WIDTH: 50px;border:solid 1px #dddddd;background: top left repeat-y url(<%=application("mediapath")%>/companyset/Prudential_NW/bg_inputText.gif);" maxlength=4 size=4 name=phoneNumberBase ID="phoneNumberBase">
			X <input class=input style="WIDTH: 46px;border:solid 1px #dddddd;background: top left repeat-y url(<%=application("mediapath")%>/companyset/Prudential_NW/bg_inputText.gif);" maxlength=5 size=3 name=phoneNumberExtension ID="phoneNumberExtension"> <%=vPhoneRequiredIndicator%>
		<br>
	    
		<%if bIncludeSource then%>
		<label style="height:110px;">How you heard<br> about us: </label>
	   
			<input type=radio value="Word of Mouth" name=resource ID="resource">Word of Mouth<br>
			<input type=radio value="Print" name=resource ID="resource">Print<br>
			<input type=radio value="Radio" name=resource ID="resource">Radio<br>
			<input type=radio value="TV" name=resource ID="resource">TV<br>
			<input type=radio value="Internet" name=resource ID="resource">Internet<br>
			<input type=radio value="Direct Mail" name=resource ID="resource">Direct Mail
		<br><br>
		<%end if%>
	   
	    
		<i><font color="#FF0000">* = Required Fields</font></i>
	   
	    
	   
		<%if not bSkipSubmitButton then%>
	    <br><br>
		<input type="submit" name="Submit" value="Submit Form" class="input" ID="Submit1" onClick="YY_checkform('PIP','FirstName','#q','0','First Name is required','LastName','#q','0','Last Name is required','emailAddress','#S','2','Email is required');return document.MM_returnValue;">
		<br><br>
		<%end if%>
	  
		<%server.execute "/" & application("sitedirectory") & "/custompages/privacy.inc"%>
	  
	<%end if %>

</form>
                

<%'This TR contains a legal disclaimer for a contest Pru NW is running from 6.05 to 9.30 06. This section should 
'be removed after this period ref ticket 15353--Grant G%>

<!--<br>***********************************************************************<br>
Legal owners of residential property in the greater Portland Metro/Southwest 
Washington area completing this form in full and registering between June 5, 
2006 and September 30, 2006 will be entered to win a Dell Inspiron notebook. 
Winner must be 21 years of age, provide proof of residential property ownership 
and grant permission to use your name and photo for advertising/promotional 
purposes. Drawing will take place October 6, 2006. Winner will be notified by 
telephone and/or mail, and will be required to sign and return an Affidavit of 
Eligibility, a Liability Release and, a Publicity Release within seven (7) 
business days or prize will be forfeited and awarded to an alternate winner. An 
alternate winner will be selected if the person initially selected as a winner 
cannot be reached by Prudential NW Properties within fourteen (14) business days 
after the drawing (as determined by Prudential NW Properties), if such person's 
name and address cannot be identified for any reason, if such person is not a 
legal owner of residential property or if prize/notification is returned 
undeliverable. Odds of winning will be determined by the number of eligible 
entries received.-->

<%' -- end of temprorary disclaimer%>


<%end if%>	
  
				
				
