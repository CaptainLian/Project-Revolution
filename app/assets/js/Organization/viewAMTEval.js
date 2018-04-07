
(function() {
    [].slice.call(document.querySelectorAll('.sttabs')).forEach(function(el) {
        new CBPFWTabs(el);

    });
    $("#amtTable").DataTable();

    new Chart(document.getElementById("chartamt1"), {
        type: 'bar',
        data: {
            labels: ["venue", "equipment"],
            datasets: [{
                label: "Average Grade",
                backgroundColor: ["#3e95cd", "#8e5ea2"],
                data: [venue, equipment]
            }]
        },
        options: {
            legend: {
                display: false
            },
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                }]
            }
        }
    });
})();
