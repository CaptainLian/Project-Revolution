jQuery(document).ready(function($) {
    $('.transactions').hide();
	$('#transaction').on('change', function() {
	    /*
            <option value="1">Book Transfer</option>
            <option value="2">Petty Cash Replenishment</option>
            <option value="3">Reimbursement</option>
            <option value="4">Liquidation</option>
            <option value="5">Fund Raising Activity</option>
            <option value="6">No Expense</option>
	    */
	    var val = $(this).val();
	    switch (val) {
	        case '1'://BOOK TRANSFER
	           $('.transactions').hide();
	           $('#BT').show();
	           console.log(val);
	            break;
	        case '2':
	            $('.transactions').hide();
	            $('#PCR').show();
	            break;
	        case '3':
	            $('.transactions').hide();
	            $('#RM').show();
	            break;
	        case '4':
	            $('.transactions').hide();
	            $('#LQ').show();
	            break;
	        case '5':
	            $('.transactions').hide();
	            $('#FRA').show();
	            break;
	        case '6':
	            $('.transactions').hide();
	            $('#NE').show();
	            break;
	        default:
	            $('.transactions').hide();
	            break;
	    }
	});	

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
                        justification:{
                        	validators:{
                        		notEmpty:{
                        			message:'this field is required.'
                        		}

                        	}
                        },
                        lop:{
                            validators:{
                                notEmpty:{
                                    message:'This field is required.'
                                }
                            }
                        },
                        moc:{
                            validators:{
                                notEmpty:{
                                    message:'This field is required.'
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

    (function() {
        $('#DPPAWizard').wizard({
            onInit: function() {
                $('#DPPAvalidation').formValidation({
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
                        justification:{
                            validators:{
                                notEmpty:{
                                    message:'this field is required.'
                                }

                            }
                        },
                        DPFRF:{
                            validators:{
                                notEmpty:{
                                    message:'This field is required.'
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
    })();});