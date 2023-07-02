(function ($)
{
	var problems = [],
		haveGraph = false,
		graphType = "fa",
		testCaseNumbers = {1: 1}, //problem -> number of test cases
		problemCount = 1,
		resultCount = 1,
		editGraphButtons = [],
		uploadGraphButtons = [],
		exercise_type="TM",
		exerciseName="";

	function generatejson()
	{
		var exerciseNameElement = document.getElementById('exerciseName');
        
		problems = [];
		$("fieldset").each(problemInfo);
		var json = JSON.stringify(problems);
		var downloadData = 'data:text/json;charset=utf8,' + encodeURIComponent(json);
		var fileName;
		if (haveGraph) {
			fileName = "fixerTests.json";	
		} else {
			fileName = "tests.json";
		}

		let my_data = {
			type: exercise_type,
			
			problems: problems

		  };

		  $.ajax({
			url: '/exercises',
			type: 'POST',
			dataType: 'json',
			data: JSON.stringify(my_data),
			beforeSend: function(xhr) {
			  xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
			},
			success: function(response) {
			  // Redirect to the newly created exercise page
			  window.location.href = response.url;
			},
			error: function(xhr, status, error) {
			  // Handle errors
			  var errorMessage = xhr.responseJSON.error;
			  errorMessage = errorMessage.replace("Title", "Description"); // replace "Title" with "Description" in the error message
			  $('#error-message').text(errorMessage); // assuming there's a <div id="error-message"></div> in your 'new' view
			}
		  });

		$("#btn-save");
		$('#download').html('<a href="data:' + downloadData + '" target="_blank" download="' + fileName + '">Download Exercises JSON File</a>');
		$('#download').click();
	}
	
	function problemInfo() {
		var problem = {
			expression: "",
			description: "",
			type: "",
			testCases: [],
			graph: ""
		};
		var index = $(this).index();

		var typeButtons = $(this).find("input[type='radio']");
		var showType = typeButtons[0].checked ? "expression" : "description";
		problem.type = showType;
		problem.expression = $(this).find("input[name='expression']")[0].value;
		problem.description = $(this).find("input[name='description']")[0].value;

		if (document.getElementById('transducer').checked)
		{
			$(this).find(".testCase").each(function()
			{
				var _case = {},
						testString = $(this).find("input[name='testStringa']")[0].value,
						result = $(this).find("input[name='testStringb']")[0].value;
						resultButtons = $(this).find("input[type='radio']");
				
				_case[testString] = result;
				_case['ShowTestCase'] = resultButtons[0].checked ? true : false;
				problem.testCases.push(_case);
			});
			problem.graph = jQuery.parseJSON(localStorage['problem' + index]);
			problems.push(problem);
		} else {
			$(this).find(".testCase").each(function()
			{
				var _case = {},
						testString = $(this).find("input[name='testString']")[0].value,
						resultButtons = $(this).find("input[type='radio']");
				var result = resultButtons[0].checked ? true : false;
			
				_case[testString] = result;
				_case['ShowTestCase'] = resultButtons[2].checked ? true : false;
				problem.testCases.push(_case);
			});
			problem.graph = jQuery.parseJSON(localStorage['problem' + index]);
			problems.push(problem);
		}
	}

	function addProblem()
	{
		isFA = false;
		problemCount++;
		resultCount++;
		if (document.getElementById('transducer').checked)
		{
			$("#problems").append(""+
			"<fieldset id='" + problemCount + "'>" + 
				"<legend>Problem " + problemCount + "</legend>" +
					"<div><input type='radio' name='mode' value='noGraph' checked>Expression Only" +
					"<input type='radio' name='mode' value='yesGraph'>With Wrong Graph</div>" +
					"<input type='radio' name='show" + problemCount + "' value='true' checked>" + 
					"<span>Expression: </span>" + 
					"<input type='text' name='expression'>" + 
					"<br>" + 
					"<input type='radio' name='show" + problemCount + "' value='false'>" + 
					"<span>Description: </span>" + 
					"<input type='text' name='description'" + 
					"<br>"+
					"<div class='testCases'>" + 
					"<div class='testCase'>"+
					"<span>Test Case 1: </span>"+
					"<div id='transducerTwo' style='display: block;'>" +
					"<div id='box1'><p>Input</p> <input type='text' name='testStringa'> </div>  " +
					"<div id='box2'><p>Output</p> <input type='text' name='testStringb'> </div>  " +
					// <p>Input</p> <input type='text' name='testStringa" + resultCount + "'> " +
					// <p>Output</p> <input type='text' name='testStringb" + resultCount + "'/>" +
					"<br>"+
					"<br>"+
					"<br>"+
					"<br>"+
					"<br>"+
					"<br>"+
					"<br>"+
					"</div>" +
					"</div>" +
					"</div>"+
			"</fieldset>");
		}
			else{
		$("#problems").append(""+
			"<fieldset id='" + problemCount + "'>" + 
				"<legend>Problem " + problemCount + "</legend>" +
					"<div><input type='radio' name='mode' value='noGraph' checked>Expression Only" +
					"<input type='radio' name='mode' value='yesGraph'>With Wrong Graph</div>" +
					"<input type='radio' name='show" + problemCount + "' value='true' checked>" + 
					"<span>Expression: </span>" + 
					"<input type='text' name='expression'>" + 
					"<br>" + 
					"<input type='radio' name='show" + problemCount + "' value='false'>" + 
					"<span>Description: </span>" + 
					"<input type='text' name='description'" + 
					"<br>"+
					"<div class='testCases'>" + 
					"<div class='testCase'>"+
						"<span>Test Case 1: </span>"+
						"<input type='radio' name='result" + resultCount + "' value='true' checked> <span>Accept</span>"+
						" <input type='radio' name='result" + resultCount + "' value='false'> <span>Reject</span>"+
						"<input type='text' name='testString'>"+
						"<br>" + 
					"</div>"+
					"</div>"+
			"</fieldset>");
		}

		var addCaseButton = $("<button type='button' id='addTestCase'>Add another test case</button>");
		addCaseButton.click(addCase);
		$("fieldset[id='" + problemCount + "']").append(addCaseButton);

		var editGraphButton = $("<button type='button' id='editGraph'>Edit Graph</button>");
		editGraphButton.click(editGraph);
		$("fieldset[id='" + problemCount + "']").append(editGraphButton);

		var uploadGraphButton = $("<button type='button' id='uploadGraph'>Upload Graph</button>");
		uploadGraphButton.click(uploadGraph);
		$("fieldset[id='" + problemCount + "']").append(uploadGraphButton);

		testCaseNumbers[problemCount] = 1;
		localStorage['problem' + (problemCount - 1)] = '{"nodes":[], "edges": []}';

		if (haveGraph) {
			editGraphButton.show();
			uploadGraphButton.show();
		}
		else {
			editGraphButton.hide();
			uploadGraphButton.hide();
		}

		editGraphButtons.push(editGraphButton);
		uploadGraphButtons.push(uploadGraphButton);
	}

	function addCase()
	{
		var button = $(this);
		var thisProblem = button.parent();
		var testCases = button.parent().find(".testCases");
		var index = thisProblem.index() + 1;
		testCaseNumbers[index]++;
		caseCount = testCaseNumbers[index];
		resultCount++;

		if (document.getElementById('transducer').checked)
		{
			testCases.append("" +
			"<div class='testCase'>"+
				"<br>"+
				"<br>"+
				"<br>"+
				
				
				"<br>"+
				//"<br>"+
				//"<br>"+
				"<span>Test Case " + testCaseNumbers[index] + ": </span>"+
				
				
				"<div id='transducerTwo' style='display: block;'>" +
				"<input type='radio' name='showTest" + resultCount + "' value='true' checked> Show Test Case" +
                "<input type='radio' name='showTest" + resultCount + "' value='false'> Hide Test Case" +
				"<div id='box1'><p>Input</p> <input class='form-control' type='text' name='testStringa'> </div>  " +
				"<div id='box2'><p>Output</p> <input class='form-control'  type='text' name='testStringb'> </div>  " +
				
				// <p>Input</p> <input type='text' name='testStringa" + resultCount + "'> " +
		        // <p>Output</p> <input type='text' name='testStringb" + resultCount + "'/>" +
				"<br>"+
				//"<br>"+
				//"<br>"+
				"</div>" +
			"</div>");
		}
		else{
			testCases.append("" +
			"<div class='testCase'>"+
			"<br>"+
				"<span style='display: block;'>Test Case " + testCaseNumbers[index] + ": </span>"+
				"<input type='radio' name='result" + resultCount + "' value='true' checked> <span>Accept</span>"+
				"<input type='radio' name='result" + resultCount + "' value='false'  style='margin-left: 5px;'> <span>Reject</span>"+
				"<br>"+
				"<input type='radio' name='showTest" + resultCount + "' value='true' checked> Show Test Case" +
                "<input type='radio' name='showTest" + resultCount + "' value='false'> Hide Test Case" +
				"<input  class='form-control'  type='text' name='testString'>"+
				"<br>"+
			"</div>");
		}
	}

	function editGraph() {
		var editButton = $(this);
		var problemIndex = editButton.parent().index();
		//let FAEditor know we are editing graphs for exercises so we don't need certain functions.
		localStorage['createExercise'] = true;
		localStorage['exerciseIndex'] = problemIndex;
		localStorage['fromEditor'] = true;
		if (graphType == "fa")
		{
			
			window.open("/OpenDSA-master/AV/OpenFLAP/FA.html");
		}
		else if (graphType == "pad")
		{
			window.open("../../PDAEditor.html");
		}
		else if (graphType == "tm"){
			//OpenDSA/AV/Development/formal_language/TMEditor.html
			window.open("../../../Development/formal_language/TMEditor.html");
		}

	}

	//Open the FAFix page
	function fixerButton() {
		problems = [];
		$("fieldset").each(problemInfo);
		var json = JSON.stringify(problems);
		localStorage['json'] = json;
		window.buttonid = document.getElementById('fixerButton');
		window.open("../../FAFixer.html");
	}

	//Open the FATester page
	function testerButton() {
		problems = [];
		$("fieldset").each(problemInfo);
		var json = JSON.stringify(problems);
		localStorage['json'] = json;
		window.buttonid = document.getElementById('testerButton');
		window.open("../../FATester.html");
	}

	function uploadGraph() {
		var uploadButton = $(this);
		var problemIndex = uploadButton.parent().index();
		//let FAEditor know we are editing graphs for exercises so we don't need certain functions.
		localStorage['createExercise'] = true;
		localStorage['exerciseIndex'] = problemIndex;
		// console.log('PROBLEM INDEX: ' + problemIndex);

		document.getElementById('upload').click();
	}
	//parse function copy from FAEditor
	function parseFile(text) {
		var parser,
			jsav = new JSAV("av"),
			g,
			xmlDoc;
		if (window.DOMParser) {
			parser = new DOMParser();
			xmlDoc = parser.parseFromString(text,"text/xml");
		}
		else {
			xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
			xmlDoc.async = false;
			xmlDoc.loadXML(txt);
		}
		if (!xmlDoc.getElementsByTagName("type")[0]) {
			// This file is not a file that can be parsed.
			window.alert('File does not contain an automaton.');
			return;
		}
		if (xmlDoc.getElementsByTagName("type")[0].childNodes[0].nodeValue !== graphType){//check that the machine matches the graph type
			// This file was created by a different automaton editor.
			window.alert('File does not contain a finite automaton.');
			return;
		}
		else {
			g = new jsav.ds.FA({width: '730px', height: 440, layout: "automatic", editable: true});
			var nodeMap = {};			// map node IDs to nodes
			var xmlStates = xmlDoc.getElementsByTagName("state");
			xmlStates = _.sortBy(xmlStates, function(x) { return x.id; })
			var xmlTrans = xmlDoc.getElementsByTagName("transition");
			// Iterate over the nodes and initialize them.
			for (var i = 0; i < xmlStates.length; i++) {
				var x = Number(xmlStates[i].getElementsByTagName("x")[0].childNodes[0].nodeValue);
				var y = Number(xmlStates[i].getElementsByTagName("y")[0].childNodes[0].nodeValue);
				// console.log('x = ' + x);
				// console.log('y = ' + y);
				var newNode = g.addNode({left: x, top: y});
				// console.log(newNode.position().left);
				// console.log(newNode.position().top);
				// Add the various details, including initial/final states and state labels.
				var isInitial = xmlStates[i].getElementsByTagName("initial")[0];
				var isFinal = xmlStates[i].getElementsByTagName("final")[0];
				var isLabel = xmlStates[i].getElementsByTagName("label")[0];
				if (isInitial) {
					g.makeInitial(newNode);
				}
				if (isFinal) {
					newNode.addClass('final');
				}
				if (isLabel) {
					newNode.stateLabel(isLabel.childNodes[0].nodeValue);
				}
				nodeMap[xmlStates[i].id] = newNode;
				newNode.stateLabelPositionUpdate();
			}
			// Iterate over the edges and initialize them.
			for (var i = 0; i < xmlTrans.length; i++) {
				var from = xmlTrans[i].getElementsByTagName("from")[0].childNodes[0].nodeValue;
				var to = xmlTrans[i].getElementsByTagName("to")[0].childNodes[0].nodeValue;
				var read = xmlTrans[i].getElementsByTagName("read")[0].childNodes[0];
				// Empty string always needs to be checked for.
				if (!read) {
					read = emptystring;
				}
				else {
					read = read.nodeValue;
				}
				var edge = g.addEdge(nodeMap[from], nodeMap[to], {weight: read});
				edge.layout();
			}
		}
		return serialize(g);
    }
    
    function onTMChange() {
		
		if (document.getElementById('transducer').checked)
		exercise_type="TM";
		console.log(exercise_type);
		
        document.getElementById("transducerOne").style.display = "none";
        document.getElementById("transducerTwo").style.display = "block";
        document.getElementById("acceptReject").style.display = "none";
    }

    
    function onTMReset() {
	    
		if (document.getElementById('resetTransducer').checked)
		exercise_type="TM";
		else if (document.getElementById('CFL').checked)
		exercise_type="CFL";
		else if (document.getElementById('FA').checked)
		exercise_type="FA";

		else if (document.getElementById('grammar').checked)
		exercise_type="grammar";
		else if (document.getElementById('PDA').checked)
		exercise_type="PDA";

		else if (document.getElementById('Regular').checked)
		exercise_type="Regular";
		else if (document.getElementById('NFAtoDFA').checked)
		{exercise_type="NFAtoDFA";

		$("#editGraph").show();
		$("#uploadGraph").show();

}


		




		console.log(exercise_type);


        document.getElementById("transducerOne").style.display = "block";
        document.getElementById("transducerTwo").style.display = "none";
        document.getElementById("acceptReject").style.display = "block";
    }

	function loadGraph() {
		var loaded = document.getElementById('upload');
		var file = loaded.files[0],
			reader = new FileReader();
		reader.onload = function (ev) {
			var text = reader.result;
			console.log('The input JFLAP file: ');
			console.log(text);
			console.log('The output JSON file: ');
			var resultJson = parseFile(text);
			console.log(resultJson);

			var uploadButton = $(this);
			var problemIndex = uploadButton.parent().index();
			// console.log('problem index: ' + localStorage['exerciseIndex']);
			localStorage['problem' + localStorage['exerciseIndex']] = resultJson;
		};
		reader.readAsText(file);
		alert('Graph loaded!');
	}
		
	$('input:radio[name="mode"]').change(function()
	{
		if ($(this).val() == 'noGraph')
		{
			$("#editGraph").hide();
			editGraphButtons.forEach(function(button) {
				button.hide();
			});

			$("#uploadGraph").hide();
			uploadGraphButtons.forEach(function(button) {
				button.hide();
			});

			$("#fixerButton").hide();
			$("#testerButton").show();
			haveGraph = false;
		}
		else {
			$("#editGraph").show();
			editGraphButtons.forEach(function(button) {
				button.show();
			});

			$("#uploadGraph").show();
			uploadGraphButtons.forEach(function(button) {
				button.show();
			});

			$("#fixerButton").show();
			$("#testerButton").hide();
			haveGraph = true;
		}
	});

	$('input:radio[name="mode2"]').change(function()
	{
		if ($(this).val() == 'pda')
		{
			graphType = "pad";
		}
		else if ($(this).val() == 'fa'){
			graphType = "fa";
		}
		else if ($(this).val() == 'tm'){
			graphType = "tm"
		}
		else if ($(this).val() == 'regulargrammar'){
			//FIXME hides the graph radio button
			;
		}
	});


    $("#transducer").click(onTMChange);
    $("#resetTransducer").click(onTMReset);
	$("#CFL").click(onTMReset);
	$("#FA").click(onTMReset);
	$("#grammar").click(onTMReset);
	$("#PDA").click(onTMReset);
	$("#Regular").click(onTMReset);
	$("#NFAtoDFA").click(onTMReset);
	
	


	$("#getjson").click(generatejson);
	$("#addExercise").click(addProblem).hide();
	$("#addTestCase").click(addCase);
	$("#editGraph").click(editGraph);

	//Test button for FAFixer and FATester
	$("#fixerButton").hide();
	$("#fixerButton").click(fixerButton);
	$("#testerButton").click(testerButton);

	$("#editGraph").hide();

	$("#uploadGraph").click(uploadGraph);
	$("#uploadGraph").hide();
	$("#upload").change(loadGraph);
	localStorage.clear();
	localStorage['problem0'] = '{"nodes":[],"edges":[]}';
}(jQuery));
