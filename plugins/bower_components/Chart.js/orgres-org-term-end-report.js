$( document ).ready(function() {
    
    
    var ctx3 = document.getElementById("chart3").getContext("2d");
    var data3 = [
        { // peach
            value: 300,
            color:"#FF9D79",
            highlight: "#FF9D79",
            label: "5%",

        },
        {
            value: 50,
            color: "#E85F83",
            highlight: "#E85F83",
            label: "Non-Academic"
            
        },
        {
            value: 50,
            color: "#DD76FF",
            highlight: "#DD76FF",
            label: "Non-Academic"
        },
        {
            value: 50,
            color: "#6E5FE8",
            highlight: "#6E5FE8",
            label: "Non-Academic"
        },
        {
            value: 50,
            color: "#69B7FF",
            highlight: "#69B7FF",
            label: "Non-Academic"
        }
    ];
    
    var myPieChart = new Chart(ctx3).Pie(data3,{
        segmentShowStroke : true,
        segmentStrokeColor : "#fff",
        segmentStrokeWidth : 0,
        animationSteps : 100,
		tooltipCornerRadius: 0,
        animationEasing : "easeOutBounce",
        animateRotate : true,
        animateScale : false,
        legendTemplate : "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<segments.length; i++){%><li><span style=\"background-color:<%=segments[i].fillColor%>\"></span><%if(segments[i].label){%><%=segments[i].label%><%}%></li><%}%></ul>",
        responsive: true
    });


    var ctx4 = document.getElementById("chart4").getContext("2d");
    var data4 = [
        { // peach
            value: 300,
            color:"#FF9D79",
            highlight: "#FF9D79",
            label: "5%",

        },
        {
            value: 50,
            color: "#E85F83",
            highlight: "#E85F83",
            label: "Non-Academic"
            
        },
        {
            value: 50,
            color: "#DD76FF",
            highlight: "#DD76FF",
            label: "Non-Academic"
        },
        {
            value: 50,
            color: "#6E5FE8",
            highlight: "#6E5FE8",
            label: "Non-Academic"
        },
        {
            value: 50,
            color: "#69B7FF",
            highlight: "#69B7FF",
            label: "Non-Academic"
        }
    ];
    
    var myPieChart = new Chart(ctx4).Pie(data4,{
        segmentShowStroke : true,
        segmentStrokeColor : "#fff",
        segmentStrokeWidth : 0,
        animationSteps : 100,
        tooltipCornerRadius: 0,
        animationEasing : "easeOutBounce",
        animateRotate : true,
        options:{
            title:{
                display:true,
                text:'custom chart'
            }
        },
        animateScale : false,        responsive: true
    });

    var ctx5 = document.getElementById("chart5").getContext("2d");
    var data5 = [
        { // peach
            value: 300,
            color:"#FF9D79",
            highlight: "#FF9D79",
            label: "5%",

        },
        {
            value: 50,
            color: "#E85F83",
            highlight: "#E85F83",
            label: "Non-Academic"
            
        },
        {
            value: 50,
            color: "#DD76FF",
            highlight: "#DD76FF",
            label: "Non-Academic"
        },
        {
            value: 50,
            color: "#6E5FE8",
            highlight: "#6E5FE8",
            label: "Non-Academic"
        },
        {
            value: 50,
            color: "#69B7FF",
            highlight: "#69B7FF",
            label: "Non-Academic"
        }
    ];
    
    var myPieChart = new Chart(ctx5).Pie(data5,{
        segmentShowStroke : true,
        segmentStrokeColor : "#fff",
        segmentStrokeWidth : 0,
        animationSteps : 100,
        tooltipCornerRadius: 0,
        animationEasing : "easeOutBounce",
        animateRotate : true,
        animateScale : false,
        legendTemplate : "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<segments.length; i++){%><li><span style=\"background-color:<%=segments[i].fillColor%>\"></span><%if(segments[i].label){%><%=segments[i].label%><%}%></li><%}%></ul>",
        responsive: true
    });

    var ctx6 = document.getElementById("chart6").getContext("2d");
    var data6 = [
        { // peach
            value: 300,
            color:"#FF9D79",
            highlight: "#FF9D79",
            label: "5%",

        },
        {
            value: 50,
            color: "#E85F83",
            highlight: "#E85F83",
            label: "Non-Academic"
            
        },
        {
            value: 50,
            color: "#DD76FF",
            highlight: "#DD76FF",
            label: "Non-Academic"
        },
        {
            value: 50,
            color: "#6E5FE8",
            highlight: "#6E5FE8",
            label: "Non-Academic"
        },
        {
            value: 50,
            color: "#69B7FF",
            highlight: "#69B7FF",
            label: "Non-Academic"
        }
    ];
    
    var myPieChart = new Chart(ctx6).Pie(data6,{
        segmentShowStroke : true,
        segmentStrokeColor : "#fff",
        segmentStrokeWidth : 0,
        animationSteps : 100,
        tooltipCornerRadius: 0,
        animationEasing : "easeOutBounce",
        animateRotate : true,
        animateScale : false,
        legendTemplate : "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<segments.length; i++){%><li><span style=\"background-color:<%=segments[i].fillColor%>\"></span><%if(segments[i].label){%><%=segments[i].label%><%}%></li><%}%></ul>",
        responsive: true
    });

    //chart 7
    var ctx7 = document.getElementById("chart7").getContext("2d");
    var data7 = [
        { // peach
            value: 300,
            color:"#FF9D79",
            highlight: "#FF9D79",
            label: "5%",

        },
        {
            value: 50,
            color: "#E85F83",
            highlight: "#E85F83",
            label: "Non-Academic"
            
        },
        {
            value: 50,
            color: "#DD76FF",
            highlight: "#DD76FF",
            label: "Non-Academic"
        },
        {
            value: 50,
            color: "#6E5FE8",
            highlight: "#6E5FE8",
            label: "Non-Academic"
        },
        {
            value: 50,
            color: "#69B7FF",
            highlight: "#69B7FF",
            label: "Non-Academic"
        }
    ];
    
    var myPieChart = new Chart(ctx7).Pie(data7,{
        segmentShowStroke : true,
        segmentStrokeColor : "#fff",
        segmentStrokeWidth : 0,
        animationSteps : 100,
        tooltipCornerRadius: 0,
        animationEasing : "easeOutBounce",
        animateRotate : true,
        animateScale : false,
        legendTemplate : "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<segments.length; i++){%><li><span style=\"background-color:<%=segments[i].fillColor%>\"></span><%if(segments[i].label){%><%=segments[i].label%><%}%></li><%}%></ul>",
        responsive: true
    });
    //chart 8
    var ctx8 = document.getElementById("chart8").getContext("2d");
    var data8 = [
        { // peach
            value: 300,
            color:"#FF9D79",
            highlight: "#FF9D79",
            label: "5%",

        },
        {
            value: 50,
            color: "#E85F83",
            highlight: "#E85F83",
            label: "Non-Academic"
            
        },
        {
            value: 50,
            color: "#DD76FF",
            highlight: "#DD76FF",
            label: "Non-Academic"
        },
        {
            value: 50,
            color: "#6E5FE8",
            highlight: "#6E5FE8",
            label: "Non-Academic"
        },
        {
            value: 50,
            color: "#69B7FF",
            highlight: "#69B7FF",
            label: "Non-Academic"
        }
    ];
    
    var myPieChart = new Chart(ctx8).Pie(data8,{
        segmentShowStroke : true,
        segmentStrokeColor : "#fff",
        segmentStrokeWidth : 0,
        animationSteps : 100,
        tooltipCornerRadius: 0,
        animationEasing : "easeOutBounce",
        animateRotate : true,
        animateScale : false,
        legendTemplate : "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<segments.length; i++){%><li><span style=\"background-color:<%=segments[i].fillColor%>\"></span><%if(segments[i].label){%><%=segments[i].label%><%}%></li><%}%></ul>",
        responsive: true
    });

    //chart 9
    var ctx9 = document.getElementById("chart9").getContext("2d");
    var data9 = [
        { // peach
            value: 300,
            color:"#FF9D79",
            highlight: "#FF9D79",
            label: "5% of the respondents",

        },
        {
            value: 50,
            color: "#E85F83",
            highlight: "#E85F83",
            label: "Non-Academic"
            
        },
        {
            value: 50,
            color: "#DD76FF",
            highlight: "#DD76FF",
            label: "Non-Academic"
        },
        {
            value: 50,
            color: "#6E5FE8",
            highlight: "#6E5FE8",
            label: "Non-Academic"
        },
        {
            value: 50,
            color: "#69B7FF",
            highlight: "#69B7FF",
            label: "Non-Academic"
        }
    ];
    
    var myPieChart = new Chart(ctx9).Pie(data9,{
        segmentShowStroke : true,
        segmentStrokeColor : "#fff",
        segmentStrokeWidth : 0,
        animationSteps : 100,
        tooltipCornerRadius: 0,
        animationEasing : "easeOutBounce",
        animateRotate : true,
        animateScale : false,
        legendTemplate : "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<segments.length; i++){%><li><span style=\"background-color:<%=segments[i].fillColor%>\"></span><%if(segments[i].label){%><%=segments[i].label%><%}%></li><%}%></ul>",
        responsive: true
    });
});