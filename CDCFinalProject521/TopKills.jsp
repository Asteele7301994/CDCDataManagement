<!DOCTYPE html>
<!--
//********************************************************************************
//         File: TopKills.JSP
//       Author: Andrew Steele
//         Date: 12/13/2018
//      Purpose: This is a form that shows users last search result as well as enabling them to search new results.
//
//********************************************************************************
-->
<html>
<head>
<meta  name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="TopKills.css" >

    <script>


function showPage() {
  document.getElementById("loader").style.display = "block";
  document.getElementById("page").style.display = "none";
}
    </script>
</head>
<body>
<div id="loader" style="display:none"></div>
<div id="page" style="display:block" >
<form id="regForm" action="http://astee461.kutztown.edu:8080/CDCFinalProject521/CDCFinalProject521" method=GET>



<!-- One "tab" for each step in the form: -->
<div class="tab">
	<!-- Tiny implementation of the javabean that calls the date utility to post the time/date of when the user last accessed the website-->
	<jsp:useBean id = "date" class = "java.util.Date" /> 
	<p style="float:right">Time of Access <%= date %></p>

		   <br> 
		   <br>
		   <br>
		   <br>
	<center><font size="3">This is a java web development project for CSC521<br>When prompted please select a region you'd like to focus on.<br>Then Select the States,Causes,and Years you're interested in.<br>Once submitted you'll be taken to a page that displays your search results<br><b>|ScientificCauseName|Average Age Death Rate|Standard Cause Name|Deaths|State|Year|</b></font></center>

	<h1>Select a Region</h1>
	<h2><label>
	<select name="region" id="region" onchange="formShift(this.id,'State','State2')">


		<option value="0" selected = "selected"></option>
		<option value="NE">NorthEast</option>
		<option value="MW">MidWest</option>
		<option value="STH">South</option>
		<option value="WST">West</option>
	</select>	

	</label></h2>

</div>
<div class="tab">
<h1>More Info:</h1>
<br>
<b>Last search</b>
<!-- Cookie maker, calls the cookies from the jsp page and populates them into a little table -->
<br><%

	Cookie k[]=request.getCookies();

	if (k==null){
		out.print("No Last Search");
	}
	
	if(k!=null){
		if (k[0].getName().contentEquals("ST")){
			out.print("<b>Query 1</b><br><b>State</b>|"+k[0].getValue()+"<br><b>Year</b>|"+k[1].getValue()+"<br><b>Cause</b>|"+k[2].getValue());
			out.print("<br>");
			out.print("_____________");
			out.print("<br><b>Query 2</b><br><b>State</b>|"+k[3].getValue()+"<br><b>Year</b>|"+k[4].getValue()+"<br><b>Cause</b>|"+k[5].getValue());

		}

		}

		
	
	
%>

<br>
<br>

<br>
<h2>Query1</h2>
<label>
<span><h3>State :</h3></span>
	<select name="State" id="State"></select>
</label>
<label>
	<span><h3>Year :</h3></span>
		<select name="Year" id="Year">
		<option value="1999" selected>1999</option>
			<script>
				for(var i=2000; i<2017;i++){
				document.write('<option value="'+i+'">'+i+'</option>')
				}
			</script>
		</select>
</label>
<label>
	<span><h3>Cause Name :</h3></span>
		<select name="Cause_Name" id="Cause_Name" >
		<option value="All causes" selected>All causes</option>
		<option value="Alzheimers disease">Alzheimer's disease</option>
		<option value="Cancer">Cancer</option>
		<option value="CLRD">CLRD</option>
		<option value="Diabetes">Diabetes</option>
		<option value="Heart disease">Heart disease</option>
		<option value="Influenza and pneumonia">Influenza and pneumonia</option>
		<option value="Kidney disease">Kidney disease</option>
		<option value="Stroke">Stroke</option>
		<option value="Suicide">Suicide</option>
		<option value="Unintentional injuries">Unintentional injuries</option>
		</select>	
</label>
<br>
<br>
<h2>Query2</h2>
<label>
<span><h3>State :</h3></span>
	<select name="State2" id="State2">
		<option value="United States">United States</option>
		<option value="Alabama">Alabama</option>
		<option value="Alaska">Alaska</option>
		<option value="Arizona">Arizona</option>
		<option value="Arkansas">Arkansas</option>
		<option value="California">California</option>
		<option value="Colorado">Colorado</option>
		<option value="Connecticut">Connecticut</option>
		<option value="Delaware">Delaware</option>
		<option value="District of Columbia">District of Columbia</option>
		<option value="Florida">Florida</option>
		<option value="Georgia">Georgia</option>
		<option value="Hawaii">Hawaii</option>
		<option value="Idaho">Idaho</option>
		<option value="Illinois">Illinois</option>
		<option value="Indiana">Indiana</option>
		<option value="Iowa">Iowa</option>
		<option value="Kansas">Kansas</option>
		<option value="Kentucky">Kentucky</option>
		<option value="Louisiana">Louisiana</option>
		<option value="Maine">Maine</option>
		<option value="Maryland">Maryland</option>
		<option value="Massachusetts">Massachusetts</option>
		<option value="Michigan">Michigan</option>
		<option value="Minnesota">Minnesota</option>
		<option value="Mississippi">Mississippi</option>
		<option value="Missouri">Missouri</option>
		<option value="Montana">Montana</option>
		<option value="Nebraska">Nebraska</option>
		<option value="Nevada">Nevada</option>
		<option value="New Hampshire">New Hampshire</option>
		<option value="New Jersey">New Jersey</option>
		<option value="New Mexico">New Mexico</option>
		<option value="New York">New York</option>
		<option value="North Carolina">North Carolina</option>
		<option value="North Dakota">North Dakota</option>
		<option value="Ohio">Ohio</option>
		<option value="Oklahoma">Oklahoma</option>
		<option value="Oregon">Oregon</option>
		<option value="Pennsylvania">Pennsylvania</option>
		<option value="Rhode Island">Rhode Island</option>
		<option value="South Carolina">South Carolina</option>
		<option value="South Dakota">South Dakota</option>
		<option value="Tennessee">Tennessee</option>
		<option value="Texas">Texas</option>
		<option value="Utah">Utah</option>
		<option value="Vermont">Vermont</option>
		<option value="Virginia">Virginia</option>
		<option value="Washington">Washington</option>
		<option value="West Virgina">West Virgina</option>
		<option value="Wisconsin">Wisconsin</option>
		<option value="Wyoming">Wyoming</option>

	</select>
</label>
<label>
	<span><h3>Year :</h3></span>
		<select name="Year2" id="Year2">
		<option value="1999" selected>1999</option>
			<script>
				for(var i=2000; i<2017;i++){
				document.write('<option value="'+i+'">'+i+'</option>')
				}
			</script>
		</select>
</label>
<label>
	<span><h3>Cause Name :</h3></span>
		<select name="Cause_Name2" id="Cause_Name2" >
		<option value="All causes" selected>All causes</option>
		<option value="Alzheimers disease">Alzheimer's disease</option>
		<option value="Cancer">Cancer</option>
		<option value="CLRD">CLRD</option>
		<option value="Diabetes">Diabetes</option>
		<option value="Heart disease">Heart disease</option>
		<option value="Influenza and pneumonia">Influenza and pneumonia</option>
		<option value="Kidney disease">Kidney disease</option>
		<option value="Stroke">Stroke</option>
		<option value="Suicide">Suicide</option>
		<option value="Unintentional injuries">Unintentional injuries</option>
		</select>	
		
</label>
<br>
<hr>
<br>
<span><h3>Optional Information:</h3></span>
<label>
	<select name="Options" id="Options" >
		<option value="0" selected = "selected"></option>
		<option value="Combo">Combine</option>
		<option value="Differ">Differential</option>
	</select>	

</label>
		


</div>
	<div style="overflow:auto;">
		<div style="float:right;">
			<br>
			<button type="button" id="prevBtn" onclick="nextPrev(-1)">Previous</button>
			<button type="button" id="nextBtn" onclick="nextPrev(1)" disabled>Next</button>
		</div>
	</div>
	<div style="text-align:center;margin-top:40px;">
		<span class="step"></span>
		<span class="step"></span>
	</div>

</form>
</div>

<script type="text/javascript">
	var currentTab = 0; // Current tab is set to be the first tab (0)
	showTab(currentTab); // Display the crurrent tab


		function showTab(n) {
		// This function will display the specified tab of the form...
		var x = document.getElementsByClassName("tab");
		x[n].style.display = "block";
		//... and fix the Previous/Next buttons:
		if (n == 0) {
			document.getElementById("prevBtn").style.display = "none";
		} 
		else {
			document.getElementById("prevBtn").style.display = "inline";
		}
		if (n == (x.length - 1)) {
			document.getElementById("nextBtn").innerHTML = "Submit";
		} else {
			document.getElementById("nextBtn").innerHTML = "Next";
		}
		//... and run a function that will display the correct step indicator:
		fixStepIndicator(n)
	}

	function nextPrev(n) {
		// This function will figure out which tab to display
		var x = document.getElementsByClassName("tab");
		// Exit the function if any field in the current tab is invalid:
		if (n == 1 && !validateForm()) return false;
		// Hide the current tab:
		x[currentTab].style.display = "none";
		// Increase or decrease the current tab by 1:
		currentTab = currentTab + n;
		// if you have reached the end of the form...
		if (currentTab >= x.length) {
		// ... the form gets submitted:
			document.getElementById("regForm").submit();
			document.display(showPage());
			return false;
	}
	// Otherwise, display the correct tab:
	showTab(currentTab);
	}

	function validateForm() {
	// This function deals with validation of the form fields
	var x, y, i, valid = true;
	x = document.getElementsByClassName("tab");
	y = x[currentTab].getElementsByTagName("input");
	// A loop that checks every input field in the current tab:
	for (i = 0; i < y.length; i++) {
		// If a field is empty...
		if (y[i].value == "") {
			// add an "invalid" class to the field:
			y[i].className += " invalid";
			// and set the current valid status to false
			valid = false;
		}
	}
	// If the valid status is true, mark the step as finished and valid:
	if (valid) {
		document.getElementsByClassName("step")[currentTab].className += " finish";
	}
	return valid; // return the valid status
	}

	function fixStepIndicator(n) {
		// This function removes the "active" class of all steps...
		var i, x = document.getElementsByClassName("step");
		for (i = 0; i < x.length; i++) {
			x[i].className = x[i].className.replace("active", "");
		}
		//... and adds the "active" class on the current step:
		x[n].className += " active";
	}
	function formShift(r1,r2){
	var r1 = document.getElementById(r1);
	var r2 = document.getElementById(r2);
	r2.innerHTML ="";


	if (r1.value == "NE"){

		var optionArray = ["Connecticut|Connecticut","Maine|Maine","Massachusetts|Massachusetts","New Hampshire|New Hampshire","New Jersey|New Jersey","New York|New York","Pennsylvania|Pennsylvania","Rhode Island|Rhode Island","Vermont|Vermont"];
	}
	else if (r1.value == "MW"){

		var optionArray = ["Illinois|Illinois","Indiana|Indiana","Iowa|Iowa","Kansas|Kansas","Michigan|Michigan","Minnesota|Minnesota","Missouri|Missouri","Nebraska|Nebraska","North Dakota|North Dakota","Ohio|Ohio","South Dakota|South Dakota","Wisconsin|Wisconsin"];
	}
	else if (r1.value == "STH"){

		var optionArray = ["Alabama|Alabama","Arkansas|Arkansas","Delaware|Delaware","District of Columbia|District of Columbia","Florida|Florida","Georgia|Georgia","Kentucky|Kentucky","Louisiana|Louisiana","Maryland|Maryland","Mississippi|Mississippi","North Carolina|North Carolina","Oklahoma|Oklahoma","South Carolina|South Carolina",
	"Tennessee|Tennessee","Texas|Texas","Virginia|Virginia","West Virgina|West Virgina"];
	}
	else if (r1.value == "WST"){

		var optionArray = ["Alaska|Alaska","Arizona|Arizona","California|California","Colorodo|Colorodo","Hawaii|Hawaii","Idaho|Idaho","Montana|Montana","Nevada|Nevada","New Mexico|New Mexico","Oregon|Oregon","Utah|Utah","Washington|Washington","Wyoming|Wyoming"];
	}
	//"|",
	for(var option in optionArray){
		var pair = optionArray[option].split("|");
		var newOption = document.createElement("option");
		newOption.value = pair[0];
		newOption.innerHTML = pair[1];
		r2.options.add(newOption);
		}
	if(r1.value.length>1){
		document.getElementById('nextBtn').disabled = false;

		}
	else{
		document.getElementById('nextBtn').disabled = true;
		}
	}

</script>


</body>
</html>
