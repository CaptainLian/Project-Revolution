(function() {
    [].slice.call(document.querySelectorAll('.sttabs')).forEach(function(el) {
        new CBPFWTabs(el);
    });

    $('#myBtn').click(function(event) {
        console.log('to the top you go')
        document.body.scrollTop = 0;
        document.documentElement.scrollTop = 0;
    });

    window.onscroll = () => {
        if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
            document.getElementById("myBtn").style.display = "block";
        } else {
            document.getElementById("myBtn").style.display = "none";
        }
    };

    $('#amtTable').dataTable();
    $('#finTable').dataTable();
    $('#memSurTable').dataTable();
    $('#docuTable').dataTable();
    $('#amtTable2').dataTable();
    //Start of Online officer survey form results
    //      new Chart(document.getElementById("bar-chart1"), {
    //         type: 'bar',
    //         data: {
    //           labels: ["Strongly Agree", "Agree", "Neutral", "Disagree", "Strongly Disagree"],
    //           datasets: [
    //             {
    //               label: "Respondents",
    //               backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
    //               data: [100,5267,734,784,433] //number of respondents here
    //             }
    //           ]
    //         },
    //         options: {
    //           legend: { display: false },

    //         }
    //     });


    //     new Chart(document.getElementById("bar-chart2"), {
    //         type: 'bar',
    //         data: {
    //           labels: ["Strongly Agree", "Agree", "Neutral", "Disagree", "Strongly Disagree"],
    //           datasets: [
    //             {
    //               label: "Respondents",
    //               backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
    //               data: [2478,5267,734,784,433]
    //             }
    //           ]
    //         },
    //         options: {
    //           legend: { display: false }
    //         }
    //     });
    //      new Chart(document.getElementById("bar-chart3"), {
    //         type: 'bar',
    //         data: {
    //           labels: ["Strongly Agree", "Agree", "Neutral", "Disagree", "Strongly Disagree"],
    //           datasets: [
    //             {
    //               label: "Respondents",
    //               backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
    //               data: [2478,5267,734,784,433]
    //             }
    //           ]
    //         },
    //         options: {
    //           legend: { display: false }
    //         }
    //     });
    //      new Chart(document.getElementById("bar-chart4"), {
    //         type: 'bar',
    //         data: {
    //           labels: ["Strongly Agree", "Agree", "Neutral", "Disagree", "Strongly Disagree"],
    //           datasets: [
    //             {
    //               label: "Respondents",
    //               backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
    //               data: [2478,5267,734,784,433]
    //             }
    //           ]
    //         },
    //         options: {
    //           legend: { display: false }
    //         }
    //     });
    //      new Chart(document.getElementById("bar-chart5"), {
    //         type: 'bar',
    //         data: {
    //           labels: ["Strongly Agree", "Agree", "Neutral", "Disagree", "Strongly Disagree"],
    //           datasets: [
    //             {
    //               label: "Respondents",
    //               backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
    //               data: [2478,5267,734,784,433]
    //             }
    //           ]
    //         },
    //         options: {
    //           legend: { display: false }
    //         }
    //     });
    //      new Chart(document.getElementById("bar-chart6"), {
    //         type: 'bar',
    //         data: {
    //           labels: ["Strongly Agree", "Agree", "Neutral", "Disagree", "Strongly Disagree"],
    //           datasets: [
    //             {
    //               label: "Respondents",
    //               backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
    //               data: [2478,5267,734,784,433]
    //             }
    //           ]
    //         },
    //         options: {
    //           legend: { display: false }
    //         }
    //     });
    //      new Chart(document.getElementById("bar-chart7"), {
    //         type: 'bar',
    //         data: {
    //           labels: ["Strongly Agree", "Agree", "Neutral", "Disagree", "Strongly Disagree"],
    //           datasets: [
    //             {
    //               label: "Respondents",
    //               backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
    //               data: [2478,5267,734,784,433]
    //             }
    //           ]
    //         },
    //         options: {
    //           legend: { display: false }
    //         }
    //     });
    //      new Chart(document.getElementById("bar-chart8"), {
    //         type: 'bar',
    //         data: {
    //           labels: ["Strongly Agree", "Agree", "Neutral", "Disagree", "Strongly Disagree"],
    //           datasets: [
    //             {
    //               label: "Respondents",
    //               backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
    //               data: [2478,5267,734,784,433]
    //             }
    //           ]
    //         },
    //         options: {
    //           legend: { display: false }
    //         }
    //     });
    //      new Chart(document.getElementById("bar-chart9"), {
    //         type: 'bar',
    //         data: {
    //           labels: ["Strongly Agree", "Agree", "Neutral", "Disagree", "Strongly Disagree"],
    //           datasets: [
    //             {
    //               label: "Respondents",
    //               backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
    //               data: [2478,5267,734,784,433]
    //             }
    //           ]
    //         },
    //         options: {
    //           legend: { display: false }
    //         }
    //     });

    //     var data = {
    //         datasets: [{
    //             data: [10, 20, 30]
    //         }],

    //         // These labels appear in the legend and in the tooltips when hovering different arcs
    //         labels: [
    //             'Red',
    //             'Yellow',
    //             'Blue'
    //         ]
    //     };
    // //End of Online officer survey form results
    //Start of Online member survey form results
    //  new Chart(document.getElementById("chartm1"), {
    //     type: 'bar',
    //     data: {
    //       labels: ["Strongly Agree", "Agree", "Neutral", "Disagree", "Strongly Disagree"],
    //       datasets: [
    //         {
    //           label: "Respondents",
    //           backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
    //           data: [100,5267,734,784,433] //number of respondents here
    //         }
    //       ]
    //     },
    //     options: {
    //       legend: { display: false },

    //     }
    // });

    // new Chart(document.getElementById("chartm2"), {
    //     type: 'bar',
    //     data: {
    //       labels: ["Strongly Agree", "Agree", "Neutral", "Disagree", "Strongly Disagree"],
    //       datasets: [
    //         {
    //           label: "Respondents",
    //           backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
    //           data: [2478,5267,734,784,433]
    //         }
    //       ]
    //     },
    //     options: {
    //       legend: { display: false }
    //     }
    // });
    //  new Chart(document.getElementById("chartm3"), {
    //     type: 'bar',
    //     data: {
    //       labels: ["Strongly Agree", "Agree", "Neutral", "Disagree", "Strongly Disagree"],
    //       datasets: [
    //         {
    //           label: "Respondents",
    //           backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
    //           data: [2478,5267,734,784,433]
    //         }
    //       ]
    //     },
    //     options: {
    //       legend: { display: false }
    //     }
    // });
    //  new Chart(document.getElementById("chartm4"), {
    //     type: 'bar',
    //     data: {
    //       labels: ["Strongly Agree", "Agree", "Neutral", "Disagree", "Strongly Disagree"],
    //       datasets: [
    //         {
    //           label: "Respondents",
    //           backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
    //           data: [2478,5267,734,784,433]
    //         }
    //       ]
    //     },
    //     options: {
    //       legend: { display: false }
    //     }
    // });
    //  new Chart(document.getElementById("chartm5"), {
    //     type: 'bar',
    //     data: {
    //       labels: ["Strongly Agree", "Agree", "Neutral", "Disagree", "Strongly Disagree"],
    //       datasets: [
    //         {
    //           label: "Respondents",
    //           backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
    //           data: [2478,5267,734,784,433]
    //         }
    //       ]
    //     },
    //     options: {
    //       legend: { display: false }
    //     }
    // });
    //  new Chart(document.getElementById("chartm6"), {
    //     type: 'bar',
    //     data: {
    //       labels: ["Strongly Agree", "Agree", "Neutral", "Disagree", "Strongly Disagree"],
    //       datasets: [
    //         {
    //           label: "Respondents",
    //           backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
    //           data: [2478,5267,734,784,433]
    //         }
    //       ]
    //     },
    //     options: {
    //       legend: { display: false }
    //     }
    // });
    //  new Chart(document.getElementById("chartm7"), {
    //     type: 'bar',
    //     data: {
    //       labels: ["Strongly Agree", "Agree", "Neutral", "Disagree", "Strongly Disagree"],
    //       datasets: [
    //         {
    //           label: "Respondents",
    //           backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
    //           data: [2478,5267,734,784,433]
    //         }
    //       ]
    //     },
    //     options: {
    //       legend: { display: false }
    //     }
    // });
    //  new Chart(document.getElementById("chartm8"), {
    //     type: 'bar',
    //     data: {
    //       labels: ["Strongly Agree", "Agree", "Neutral", "Disagree", "Strongly Disagree"],
    //       datasets: [
    //         {
    //           label: "Respondents",
    //           backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
    //           data: [2478,5267,734,784,433]
    //         }
    //       ]
    //     },
    //     options: {
    //       legend: { display: false }
    //     }
    // });
    //  new Chart(document.getElementById("chartm9"), {
    //     type: 'bar',
    //     data: {
    //       labels: ["Strongly Agree", "Agree", "Neutral", "Disagree", "Strongly Disagree"],
    //       datasets: [
    //         {
    //           label: "Respondents",
    //           backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
    //           data: [2478,5267,734,784,433]
    //         }
    //       ]
    //     },
    //     options: {
    //       legend: { display: false }
    //     }
    // });

    // var data = {
    //     datasets: [{
    //         data: [10, 20, 30]
    //     }],

    //     // These labels appear in the legend and in the tooltips when hovering different arcs
    //     labels: [
    //         'Red',
    //         'Yellow',
    //         'Blue'
    //     ]
    // };
    // new Chart(document.getElementById("chartm10"), {
    //     type: 'bar',
    //     data: {
    //       labels: ["Strongly Agree", "Agree", "Neutral", "Disagree", "Strongly Disagree"],
    //       datasets: [
    //         {
    //           label: "Respondents",
    //           backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
    //           data: [2478,5267,734,784,433]
    //         }
    //       ]
    //     },
    //     options: {
    //       legend: { display: false }
    //     }
    // });

    // var data = {
    //     datasets: [{
    //         data: [10, 20, 30]
    //     }],

    //     // These labels appear in the legend and in the tooltips when hovering different arcs
    //     labels: [
    //         'Red',
    //         'Yellow',
    //         'Blue'
    //     ]
    // };
    // new Chart(document.getElementById("chartm11"), {
    //     type: 'bar',
    //     data: {
    //       labels: ["Strongly Agree", "Agree", "Neutral", "Disagree", "Strongly Disagree"],
    //       datasets: [
    //         {
    //           label: "Respondents",
    //           backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
    //           data: [2478,5267,734,784,433]
    //         }
    //       ]
    //     },
    //     options: {
    //       legend: { display: false }
    //     }
    // });

    // var data = {
    //     datasets: [{
    //         data: [10, 20, 30]
    //     }],

    //     // These labels appear in the legend and in the tooltips when hovering different arcs
    //     labels: [
    //         'Red',
    //         'Yellow',
    //         'Blue'
    //     ]
    // };
    // new Chart(document.getElementById("chartm12"), {
    //     type: 'bar',
    //     data: {
    //       labels: ["Strongly Agree", "Agree", "Neutral", "Disagree", "Strongly Disagree"],
    //       datasets: [
    //         {
    //           label: "Respondents",
    //           backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
    //           data: [2478,5267,734,784,433]
    //         }
    //       ]
    //     },
    //     options: {
    //       legend: { display: false }
    //     }
    // });

    // var data = {
    //     datasets: [{
    //         data: [10, 20, 30]
    //     }],

    //     // These labels appear in the legend and in the tooltips when hovering different arcs
    //     labels: [
    //         'Red',
    //         'Yellow',
    //         'Blue'
    //     ]
    // };
    // new Chart(document.getElementById("chartm13"), {
    //     type: 'bar',
    //     data: {
    //       labels: ["Strongly Agree", "Agree", "Neutral", "Disagree", "Strongly Disagree"],
    //       datasets: [
    //         {
    //           label: "Respondents",
    //           backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
    //           data: [2478,5267,734,784,433]
    //         }
    //       ]
    //     },
    //     options: {
    //       legend: { display: false }
    //     }
    // });

    // var data = {
    //     datasets: [{
    //         data: [10, 20, 30]
    //     }],

    //     // These labels appear in the legend and in the tooltips when hovering different arcs
    //     labels: [
    //         'Red',
    //         'Yellow',
    //         'Blue'
    //     ]
    // };
    //End of Online member survey form results
    //60 40 ratio
    // new Chart(document.getElementById("chart3"), {
    //     type: 'pie',
    //     data: {
    //         labels: ["Academic", "Non-Academic"],
    //         datasets: [{
    //             label: "Respondents",
    //             backgroundColor: ["#3e95cd", "#8e5ea2"],
    //             data: [academic, nonAcademic]
    //         }]
    //     },
    //     options: {
    //         legend: {
    //             display: false
    //         },
    //         title: {
    //             display: true
    //         }
    //     }
    // });
    //60 40 ratio
    new Chart(document.getElementById("chart4"), {
        type: 'pie',
        data: {
            labels: ["Pushed Through", "Not pushed through"],
            datasets: [{
                label: "Respondents",
                backgroundColor: ["#3e95cd", "#8e5ea2"],
                data: [numPush, numNotPush]
            }]
        },
        options: {
            legend: {
                display: false
            },
            title: {
                display: true
            }
        }
    });
    //Activity Summary
    // color scheme
    // FF685B - Academic Contest
    // B153E8 - Distribution
    // 5BA0FF - General Assembly
    // 47E89A - Seminar/ Workshops
    // D3FF5B - Publicity/ Awareness Campaign
    // FF9F5A - Meetings
    // 795AFF - Spiritual Activity
    // 47D0E8 - Recruitment/ Audition
    // 5AFF62 - Recreation
    // E852A2
    //activity summary pie chart
    // new Chart(document.getElementById("chart5"), {
    //     type: 'pie',
    //     data: {
    //         labels: ["Academic Contest", "Distribution", "General Assembly",
    //             "Seminar/ Workshops", "Publicity/ Awareness Campaign", "Meetings",
    //             "Spiritual Activity", "Recruitment/ Audition", "Recreation"
    //         ],
    //         datasets: [{
    //             label: "Respondents",
    //             backgroundColor: [
    //                 "#FF685B",
    //                 "#B153E8",
    //                 "#5BA0FF",
    //                 "#47E89A",
    //                 "#D3FF5B",
    //                 "#FF9F5A",
    //                 "#795AFF",
    //                 "#47D0E8",
    //                 "#5AFF62"
    //             ],
    //             data: [
    //                 2478,
    //                 5267,
    //                 5267,
    //                 5267,
    //                 5267,
    //                 5267,
    //                 5267,
    //                 5267,
    //                 5267
    //             ]
    //         }]
    //     },
    //     options: {
    //         legend: {
    //             display: false
    //         },
    //         title: {
    //             display: true
    //         }
    //     }
    // });

    //amt charts
    new Chart(
        document.getElementById("chartamt1"), {
            type: 'radar',
            data: {
                labels: [
                    "Venue",
                    "Equipment"
                ],
                datasets: [{
                    label: "Average Grade",
                    backgroundColor: "rgba(200,0,0,0.2)",
                    data: [
                        venue,
                        equipment
                    ]
                }]
            }
        }
    );
    // new Chart(document.getElementById("chartamt1"), {
    //     type: 'bar',
    //     data: {
    //         labels: ["venue", "equipment"],
    //         datasets: [{
    //             label: "Average Grade",
    //             backgroundColor: ["#3e95cd", "#8e5ea2"],
    //             data: [venue, equipment]
    //         }]
    //     },
    //     options: {
    //         legend: {
    //             display: false
    //         },
    //         scales: {
    //             yAxes: [{
    //                 ticks: {
    //                     beginAtZero: true
    //                 }
    //             }]
    //         }
    //     }
    // });
    //activity process
    // new Chart(document.getElementById("chartamt2"), {
    //     type: 'bar',
    //     data: {
    //         labels: ["Opening Start", "Time end", "Activity Execution", "Registration"],
    //         datasets: [{
    //             label: "Average Grade",
    //             backgroundColor: ["#3e95cd", "#8e5ea2", "#3cba9f", "#e8c3b9"],
    //             data: [openingStart, timeEnd, activityExec, Registration]
    //         }]
    //     },
    //     options: {
    //         legend: {
    //             display: false
    //         },
    //         scales: {
    //             yAxes: [{
    //                 ticks: {
    //                     beginAtZero: true
    //                 }
    //             }]
    //         }
    //     }
    // });
    new Chart(
        document.getElementById("chartamt2"), {
            type: 'radar',
            data: {
                labels: ["Opening Start", "Time end", "Activity Execution", "Registration"],
                datasets: [{
                    label: "Average Grade",
                    backgroundColor: "rgba(200,0,0,0.2)",
                    data: [openingStart, timeEnd, activityExec, Registration]
                }]
            }
        }
    );
    //gen assembly
    // new Chart(document.getElementById("chartamt3"), {
    //     type: 'bar',
    //     data: {
    //         labels: ["Hosts", "Ushers", "Presentations", "Activities", "Standing Presentations"],
    //         datasets: [{
    //             label: "Average Grade",
    //             backgroundColor: ["#3e95cd", "#8e5ea2", "#3cba9f", "#e8c3b9", "#c45850"],
    //             data: [Hosts, Ushers, Presentations, activities, standingPresentation]
    //         }]
    //     },
    //     options: {
    //         legend: {
    //             display: false
    //         },
    //         scales: {
    //             yAxes: [{
    //                 ticks: {
    //                     beginAtZero: true
    //                 }
    //             }]
    //         }
    //     }
    // });
    new Chart(
        document.getElementById("chartamt3"), {
            type: 'radar',
            data: {
                labels: ["Hosts", "Ushers", "Presentations", "Activities", "Standing Presentations"],
                datasets: [{
                    label: "Average Grade",
                    backgroundColor: "rgba(200,0,0,0.2)",
                    data: [Hosts, Ushers, Presentations, activities, standingPresentation]
                }]
            }
        }
    );

    //audience feedback
    // new Chart(document.getElementById("chartamt6"), {
    //     type: 'bar',
    //     data: {
    //         labels: ["Announcements", "Interaction", "Interest", "Learning"],
    //         datasets: [{
    //             label: "Average Grade",
    //             backgroundColor: ["#3e95cd", "#8e5ea2", "#3cba9f", "#e8c3b9", "#FF685B", "#B153E8", "#5BA0FF"],
    //             data: [announcement, interaction, interest, learning]
    //         }]
    //     },
    //     options: {
    //         legend: {
    //             display: false
    //         },
    //         scales: {
    //             yAxes: [{
    //                 ticks: {
    //                     beginAtZero: true
    //                 }
    //             }]
    //         }
    //     }
    // });
    new Chart(
        document.getElementById("chartamt6"), {
            type: 'radar',
            data: {
                labels: ["Announcements", "Interaction", "Interest", "Learning"],
                datasets: [{
                    label: "Average Grade",
                    backgroundColor: "rgba(200,0,0,0.2)",
                    data: [announcement, interaction, interest, learning]
                }]
            }
        }
    );

    new Chart(
        document.getElementById("chartradar"), {
            type: 'radar',
            data: {
                labels: [
                    "Academic Contest",
                    "Distribution",
                    "General Assembly",
                    "Seminar/ Workshops",
                    "Publicity/ Awareness Campaign",
                    "Meetings",
                    "Spiritual Activity",
                    "Recruitment/ Audition",
                    "Recreation",
                    "Others"
                ],
                datasets: [{
                    label: "Current Term Activities",
                    backgroundColor: "rgba(200,0,0,0.2)",
                    data: [
                        numCompetition,
                        numDistribution,
                        numGeneralAssembly,
                        numSeminar,
                        numPublicity,
                        numMeetings,
                        numSpiritualActivity,
                        numRecruitment,
                        numRecreation,
                        numOthers
                    ]
                }]
            }
        }
    );
    // When the user scrolls down 20px from the top of the document, show the button
})();
