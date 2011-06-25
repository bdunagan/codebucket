window.onload = function () {
// Include the following scripts in the header:
// * raphael-min.js
// * g.raphael-min.js
// * g.bar-min.js

// Add hover functions.
var fin = function () { this.flag = r.g.popup(this.bar.x, this.bar.y, this.bar.value || "0").insertBefore(this); };
var fout = function () { this.flag.animate({opacity: 0}, 60, function () {this.remove();}); };

// Getting Data: fetch data from local files and separate into weekdays and weekends to allow grey/red bars in sparklines.

// Get cached GA data.
var ga_xhr = new XMLHttpRequest();
ga_xhr.open('GET', '/files/ga.txt', false);
ga_xhr.send(null);
var ga_response = ga_xhr.responseText;
var ga_data = JSON.parse(ga_response);
var ga_dates = [];
for (var ga_key in ga_data) { ga_dates.push(ga_key); }
ga_dates = ga_dates.sort();
var ga_weekday_values = [];
var ga_weekend_values = [];
for (var ga_dates_key in ga_dates) {
    var ga_key = ga_dates[ga_dates_key];
    var key_date = new Date(ga_key);
    var key_day = key_date.getDay();
    if (key_day == 0 || key_day == 6) {
        ga_weekday_values.push("");
        ga_weekend_values.push(ga_data[ga_key]);
    }
    else {
        ga_weekday_values.push(ga_data[ga_key]);
        ga_weekend_values.push("");
    }
}

// Get cached RML data.
var rml_xhr = new XMLHttpRequest();
rml_xhr.open('GET', '/files/rml.txt', false);
rml_xhr.send(null);
var rml_response = rml_xhr.responseText;
var rml_data = JSON.parse(rml_response);
var rml_dates = [];
for (var rml_key in rml_data) { rml_dates.push(rml_key); }
rml_dates = rml_dates.sort();
var rml_weekday_values = [];
var rml_weekend_values = [];
for (var rml_dates_key in rml_dates) {
    var rml_key = rml_dates[rml_dates_key];
    var key_date = new Date(rml_key);
    var key_day = key_date.getDay();
    if (key_day == 0 || key_day == 6) {
        rml_weekday_values.push("");
        rml_weekend_values.push(rml_data[rml_key]);
    }
    else {
        rml_weekday_values.push(rml_data[rml_key]);
        rml_weekend_values.push("");
    }
}

// Get cached DC data.
var dc_xhr = new XMLHttpRequest();
dc_xhr.open('GET', '/files/dc.txt', false);
dc_xhr.send(null);
var dc_response = dc_xhr.responseText;
var dc_data = JSON.parse(dc_response);
var dc_dates = [];
for (var dc_key in dc_data) { dc_dates.push(dc_key); }
dc_dates = dc_dates.sort();
var dc_weekday_values = [];
var dc_weekend_values = [];
for (var dc_dates_key in dc_dates) {
    var dc_key = dc_dates[dc_dates_key];
    var key_date = new Date(dc_key);
    var key_day = key_date.getDay();
    if (key_day == 0 || key_day == 6) {
        dc_weekday_values.push("");
        dc_weekend_values.push(dc_data[dc_key]);
    }
    else {
        dc_weekday_values.push(dc_data[dc_key]);
        dc_weekend_values.push("");
    }
}

// Graph GA sparkline with gRaphael.
var r = Raphael("gadata");
var chart = r.g.barchart(10, 10, 160, 50, [ga_weekday_values, ga_weekend_values], {stacked: true});
chart.bars[0].attr({"fill": "#666"});
chart.bars[1].attr({"fill": "#CD0000"});
chart.hover(fin, fout);

// Graph RML sparkline with gRaphael.
var r = Raphael("rmldata");
var chart = r.g.barchart(10, 10, 160, 50, [rml_weekday_values, rml_weekend_values], {stacked: true});
chart.bars[0].attr({"fill": "#666"});
chart.bars[1].attr({"fill": "#CD0000"});
chart.hover(fin, fout);

// Graph DC sparkline with gRaphael.
var r = Raphael("dcdata");
var chart = r.g.barchart(10, 10, 160, 50, [dc_weekday_values, dc_weekend_values], {stacked: true});
chart.bars[0].attr({"fill": "#666"});
chart.bars[1].attr({"fill": "#CD0000"});
chart.hover(fin, fout);
}