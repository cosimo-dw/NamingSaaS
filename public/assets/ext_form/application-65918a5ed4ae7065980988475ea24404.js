// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//


// init bootstrap-datetimepicker
$(document).on('dt_picker_load', 'input:text', function (e) {
    var input = $(e.target);
    var options = {};

    options.format = (input.data('format') || 'yyyy-MM-dd hh:mm:ss');
    options.language = (input.data('language') || 'pt-BR');
    options.maskInput = !(input.data('mask-input') === false);
    options.pickDate = !(input.data('pick-date') === false);
    options.pickTime = !(input.data('pick-time') === false);
    options.pickSeconds = !(input.data('pick-seconds') === false);
    options.pick12HourFormat = (input.data('pick-12-hour-format') === true);
    if (input.data('start-date')) {
        var dateArray = input.data('start-date').split('-');
        options.startDate = new Date(Date.UTC(dateArray[0], parseInt(dateArray[1]) - 1, dateArray[2]));
    }

    if (input.data('end-date')) {
        var dateArray = input.data('end-date').split('-');
        options.endDate = new Date(Date.UTC(dateArray[0], parseInt(dateArray[1]) - 1, dateArray[2]));
    }

    options.minViewMode = (input.data('min-view-mode') || 0);
    options.viewMode = (input.data('view-mode') || 0);
    options.weekStart = (input.data('week-start') || 1);

    input.parent().datetimepicker(options);
});

//init typeahead.js
$(document).on('auto_complete_load', 'input:text', function (e) {
    var input = $(e.target);
    input.typeahead(input.data('dataset'));

    // if mapping is specified, automatically setup value of mapped inputs.
    if (input.data('mapping')) {
        input.on('typeahead:selected', this, function (e, selectedObj, selectedDatasetName) {
            $.each(input.data('mapping'), function (k, v) {
                $('#' + v).val(selectedObj[k]);
            });
        });

        input.on('typeahead:closed', this, function (e) {
            if ($(this).data('changed')) {
                $.each(input.data('mapping'), function (k, v) {
                    $('#' + v).val('');
                });

                $(this).data('changed', false);
            }
        });

        input.on('change', this, function (e) {
            $(this).data('changed', true);
        });
    }
});

//init select2
$(document).on('select2_load', 'select', function (e) {
    var input = $(e.target);
    input.select2();
});

