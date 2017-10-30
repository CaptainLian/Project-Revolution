jQuery(document).ready(function($) {
     $('.transactions').hide();
	$('#transaction').on('change', function() {
	    /*

	    */
	    var val = $(this).val();
	    switch (val) {
	        case '1'://cash advance
	           $('.transactions').hide();
	           $('#CC').show();
	           console.log(val);
	            break;
	        case '2':
	            $('.transactions').hide();
	            $('#CP').show();
	            break;
	        case '3':
	            $('.transactions').hide();
	            $('#PCF').show();
	            break;
	        default:
	            $('.transactions').hide();
	            break;
	    }
	});	
    //Cancellation of Check
    (function() {
        $('#transactionWizard').wizard({
            onInit: function() {
                $('#validation').formValidation({
                    framework: 'bootstrap',
                    fields: {
                        prs: {
                            validators: {
                                notEmpty: {
                                    message: 'The payment requisition number is required'
                                },
                                stringLength :{
                                	min: 6,
                                    max: 6,
                                    message: 'The prs number must be 6 digits long'
                                },
                                regexp: {
									regexp:/[0-9]/,
									message:'The prs number must only contain digits'
                                }
                            }
                        },
                        reason:{
                        	validators:{
                        		notEmpty:{
                        			message:'this field is required.'
                        		}
                        	}
                        },
                        check:{
                            validators:{
                                notEmpty:{
                                    message:'this field is required.'
                                }
                            }
                        }
                    }
                });
            },
            validator: function() {
                var fv = $('#validation').data('formValidation');
                var $this = $(this);
                // Validate the container
                fv.validateContainer($this);
                var isValidStep = fv.isValidContainer($this);
                if (isValidStep === false || isValidStep === null) {
                    return false;
                }
                return true;
            },
            onFinish: function() {
                $.post("keep.php", $("#validation").serialize()).done(function() {
                    alert("hiiii");
                });
            }
        });
        $('#accordion').wizard({
            step: '[data-toggle="collapse"]',
            buttonsAppendTo: '.panel-collapse',
            templates: {
                buttons: function() {
                    var options = this.options;
                    return '<div class="panel-footer"><ul class="pager">' + '<li class="previous">' + '<a href="#' + this.id + '" data-wizard="back" role="button">' + options.buttonLabels.back + '</a>' + '</li>' + '<li class="next">' + '<a href="#' + this.id + '" data-wizard="next" role="button">' + options.buttonLabels.next + '</a>' + '<a href="#' + this.id + '" data-wizard="finish" role="button">' + options.buttonLabels.finish + '</a>' + '</li>' + '</ul></div>';
                }
            },
            onBeforeShow: function(step) {
                step.$pane.collapse('show');
            },
            onBeforeHide: function(step) {
                step.$pane.collapse('hide');
            },
            onFinish: function() {
                alert('finish');
            }
        });
    })();
    //
    (function() {
        $('#CPWizard').wizard({
            onInit: function() {
                $('#CPvalidation').formValidation({
                    framework: 'bootstrap',
                    fields: {
                        CPprs: {
                            validators: {
                                notEmpty: {
                                    message: 'The payment requisition number is required'
                                },
                                stringLength :{
                                    min: 6,
                                    max: 6,
                                    message: 'The prs number must be 6 digits long'
                                },
                                regexp: {
                                    regexp:/[0-9]/,
                                    message:'The prs number must only contain digits'
                                }
                            }
                        },
                        PRStoRevise:{
                            validators:{
                                notEmpty:{
                                    message:'this field is required.'
                                }
                            }
                        },
                        CPreason:{
                            validators:{
                                notEmpty:{
                                    message:'this field is required.'
                                }

                            }
                        },
                        payeeName:{
                            validators:{
                                notEmpty:{
                                    message:'this field is required.'
                                }
                            }
                        }
                    }
                });
            },
            validator: function() {
                var fv = $('#CPvalidation').data('formValidation');
                var $this = $(this);
                // Validate the container
                fv.validateContainer($this);
                var isValidStep = fv.isValidContainer($this);
                if (isValidStep === false || isValidStep === null) {
                    return false;
                }
                return true;
            },
            onFinish: function() {
                $.post("keep.php", $("#validation").serialize()).done(function() {
                    alert("hiiii");
                });
            }
        });
        $('#accordion').wizard({
            step: '[data-toggle="collapse"]',
            buttonsAppendTo: '.panel-collapse',
            templates: {
                buttons: function() {
                    var options = this.options;
                    return '<div class="panel-footer"><ul class="pager">' + '<li class="previous">' + '<a href="#' + this.id + '" data-wizard="back" role="button">' + options.buttonLabels.back + '</a>' + '</li>' + '<li class="next">' + '<a href="#' + this.id + '" data-wizard="next" role="button">' + options.buttonLabels.next + '</a>' + '<a href="#' + this.id + '" data-wizard="finish" role="button">' + options.buttonLabels.finish + '</a>' + '</li>' + '</ul></div>';
                }
            },
            onBeforeShow: function(step) {
                step.$pane.collapse('show');
            },
            onBeforeHide: function(step) {
                step.$pane.collapse('hide');
            },
            onFinish: function() {
                alert('finish');
            }
        });
    })();

    (function() {
        $('#PCFWizard').wizard({
            onInit: function() {
                $('#PCFvalidation').formValidation({
                    framework: 'bootstrap',
                    fields: {
                        CPprs: {
                            validators: {
                                notEmpty: {
                                    message: 'The payment requisition number is required'
                                },
                                stringLength :{
                                    min: 6,
                                    max: 6,
                                    message: 'The prs number must be 6 digits long'
                                },
                                regexp: {
                                    regexp:/[0-9]/,
                                    message:'The prs number must only contain digits'
                                }
                            }
                        },
                        PRStoRevise:{
                            validators:{
                                notEmpty:{
                                    message:'this field is required.'
                                }
                            }
                        },
                        CPreason:{
                            validators:{
                                notEmpty:{
                                    message:'this field is required.'
                                }

                            }
                        },
                        payeeName:{
                            validators:{
                                notEmpty:{
                                    message:'this field is required.'
                                }
                            }
                        }
                    }
                });
            },
            validator: function() {
                var fv = $('#CPvalidation').data('formValidation');
                var $this = $(this);
                // Validate the container
                fv.validateContainer($this);
                var isValidStep = fv.isValidContainer($this);
                if (isValidStep === false || isValidStep === null) {
                    return false;
                }
                return true;
            },
            onFinish: function() {
                $.post("keep.php", $("#validation").serialize()).done(function() {
                    alert("hiiii");
                });
            }
        });
        $('#accordion').wizard({
            step: '[data-toggle="collapse"]',
            buttonsAppendTo: '.panel-collapse',
            templates: {
                buttons: function() {
                    var options = this.options;
                    return '<div class="panel-footer"><ul class="pager">' + '<li class="previous">' + '<a href="#' + this.id + '" data-wizard="back" role="button">' + options.buttonLabels.back + '</a>' + '</li>' + '<li class="next">' + '<a href="#' + this.id + '" data-wizard="next" role="button">' + options.buttonLabels.next + '</a>' + '<a href="#' + this.id + '" data-wizard="finish" role="button">' + options.buttonLabels.finish + '</a>' + '</li>' + '</ul></div>';
                }
            },
            onBeforeShow: function(step) {
                step.$pane.collapse('show');
            },
            onBeforeHide: function(step) {
                step.$pane.collapse('hide');
            },
            onFinish: function() {
                alert('finish');
            }
        });
    })();
});