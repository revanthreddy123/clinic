Type.registerNamespace("AjaxControlToolkitPlus");AjaxControlToolkitPlus.CalendarBehavior = function(element) {
AjaxControlToolkitPlus.CalendarBehavior.initializeBase(this, [element]);this._showDdlHeader = false;this._ddlMaxNumberOfYears = 10;this._ddlMouseDown = false;this._ddlAnchorYear = '';this._ddlAnchorPosition = AjaxControlToolkitPlus.DdlAnchorPosition.Middle;this._ddlYearOrder = AjaxControlToolkitPlus.DdlYearOrder.Ascending;this._showArrows = true;this._showToday = true;this._workWeekFirstDay = AjaxControlToolkitPlus.WeekDays.Monday;this._workWeekLastDay = AjaxControlToolkitPlus.WeekDays.Friday;this._enableWorkDays = true;this._enableWeekendDays = true;this._textbox = AjaxControlToolkitPlus.TextBoxWrapper.get_Wrapper(element);this._format = "d";this._cssClass = "ajax__calendar";this._enabled = true;this._animated = true;this._buttonID = null;this._layoutRequested = 0;this._layoutSuspended = false;this._button = null;this._popupMouseDown = false;this._selectedDate = null;this._visibleDate = null;this._todaysDate = null;this._firstDayOfWeek = AjaxControlToolkitPlus.FirstDayOfWeek.Default;this._container = null;this._popupDiv = null;this._header = null;this._prevArrow = null;this._nextArrow = null;this._title = null;this._body = null;this._today = null;this._days = null;this._daysTable = null;this._daysTableHeader = null;this._daysTableHeaderRow = null;this._daysBody = null;this._months = null;this._monthsTable = null;this._monthsBody = null;this._years = null;this._yearsTable = null;this._yearsBody = null;this._popupPosition = AjaxControlToolkitPlus.CalendarPosition.BottomLeft;this._popupBehavior = null;this._modeChangeAnimation = null;this._modeChangeMoveTopOrLeftAnimation = null;this._modeChangeMoveBottomOrRightAnimation = null;this._mode = "days";this._selectedDateChanging = false;this._isOpen = false;this._isAnimating = false;this._width = 170;this._height = 139;this._modes = {"days" : null, "months" : null, "years" : null};this._modeOrder = {"days" : 0, "months" : 1, "years" : 2 };this._hourOffsetForDst = 12;this._blur = new AjaxControlToolkitPlus.DeferredOperation(1, this, this.blur);this._ddl$delegates = {
mousedown: Function.createDelegate(this, this._ddl_onmousedown),
change: Function.createDelegate(this, this._ddl_onselectedindexchanged),
blur : Function.createDelegate(this, this.blur)
}
this._button$delegates = {
click : Function.createDelegate(this, this._button_onclick),
keypress : Function.createDelegate(this, this._button_onkeypress),
blur : Function.createDelegate(this, this._button_onblur)
} 
this._element$delegates = {
change : Function.createDelegate(this, this._element_onchange),
keypress : Function.createDelegate(this, this._element_onkeypress),
click : Function.createDelegate(this, this._element_onclick),
focus : Function.createDelegate(this, this._element_onfocus),
blur : Function.createDelegate(this, this._element_onblur)
}
this._popup$delegates = { 
mousedown: Function.createDelegate(this, this._popup_onmousedown),
mouseup: Function.createDelegate(this, this._popup_onmouseup),
drag: Function.createDelegate(this, this._popup_onevent),
dragstart: Function.createDelegate(this, this._popup_onevent),
select: Function.createDelegate(this, this._popup_onevent)
}
this._cell$delegates = {
mouseover : Function.createDelegate(this, this._cell_onmouseover),
mouseout : Function.createDelegate(this, this._cell_onmouseout),
click : Function.createDelegate(this, this._cell_onclick)
}
}
AjaxControlToolkitPlus.CalendarBehavior.prototype = { 
get_animated : function() {
return this._animated;},
set_animated : function(value) {
if (this._animated != value) {
this._animated = value;this.raisePropertyChanged("animated");}
},
get_enabled : function() {
return this._enabled;},
set_enabled : function(value) {
if (this._enabled != value) {
this._enabled = value;this.raisePropertyChanged("enabled");}
},
get_button : function() {
return this._button;},
set_button : function(value) {
if (this._button != value) {
if (this._button && this.get_isInitialized()) {
$common.removeHandlers(this._button, this._button$delegates);}
this._button = value;if (this._button && this.get_isInitialized()) {
$addHandlers(this._button, this._button$delegates);}
this.raisePropertyChanged("button");}
},
get_popupPosition : function() {
return this._popupPosition;},
set_popupPosition : function(value) {
if (this._popupPosition != value) {
this._popupPosition = value;this.raisePropertyChanged('popupPosition');}
},
get_format : function() { 
return this._format;},
set_format : function(value) { 
if (this._format != value) {
this._format = value;this.raisePropertyChanged("format");}
},
get_selectedDate : function() {
if (this._selectedDate == null) 
{
var value = this._textbox.get_Value();if (value) 
{
value = this._parseTextValue(value);if (value) 
{
this._selectedDate = value.getDateOnly();this._selectedDate = this._forceRange(this._selectedDate);}
}
}
return this._selectedDate;},
set_selectedDate : function(value) 
{
if(value && (String.isInstanceOfType(value)) && (value.length != 0)) 
{
value = new Date(value);}
if (value) value = value.getDateOnly();if (this._selectedDate != value) 
{
value = this._forceRange(value);this._selectedDate = value;this._selectedDateChanging = true;var text = "";if (value) 
{
text = value.localeFormat(this._format);}
if (text != this._textbox.get_Value()) 
{
this._textbox.set_Value(text);this._fireChanged();}
this._selectedDateChanging = false;this.invalidate();this.raisePropertyChanged("selectedDate");}
},
get_maximumDate : function() {
return this._maximumDate;},
set_maximumDate : function(value) {
if(value && (String.isInstanceOfType(value)) && (value.length != 0)) {
value = new Date(value);}
if (value) value = value.getDateOnly();if (this._maximumDate != value) {
this._maximumDate = value;this.raisePropertyChanged("maximumDate");}
},
get_minimumDate : function() {
return this._minimumDate;},
set_minimumDate : function(value) {
if(value && (String.isInstanceOfType(value)) && (value.length != 0)) {
value = new Date(value);}
if (value) value = value.getDateOnly();if (this._minimumDate != value) {
this._minimumDate = value;this.raisePropertyChanged("minimumDate");}
},
get_showArrows : function() {
return this._showArrows;},
set_showArrows : function(value) {
if (this._showArrows != value) {
this._showArrows = value;this.raisePropertyChanged("showArrows");}
},
get_showToday : function() {
return this._showToday;},
set_showToday : function(value) {
if (this._showToday != value) {
this._showToday = value;this.raisePropertyChanged("showToday");}
},
get_showDdlHeader : function() {
return this._showDdlHeader;},
set_showDdlHeader : function(value) {
if (this._showDdlHeader != value) {
this._showDdlHeader = value;this.raisePropertyChanged("showDdlHeader");}
},
get_ddlMaxNumberOfYears : function() {
return this._ddlMaxNumberOfYears;},
set_ddlMaxNumberOfYears : function(value) {
if(value)
{
if (parseInt(value) > 0)
{
if (value != this._ddlMaxNumberOfYears)
{
this._ddlMaxNumberOfYears = parseInt(value);this.raisePropertyChanged("ddlMaxNumberOfYears");}
}
}
},
get_ddlAnchorYear : function() {
return this._ddlAnchorYear;},
set_ddlAnchorYear : function(value) {
if(value)
{
if (!isNaN(value))
{
if (value != this._ddlAnchorYear)
{
this._ddlAnchorYear = value;this.raisePropertyChanged("ddlAnchorYear");}
}
}
},
get_ddlAnchorPosition : function() {
return this._ddlAnchorPosition;},
set_ddlAnchorPosition : function(value) {
if (this._ddlAnchorPosition != value) {
this._ddlAnchorPosition = value;this.raisePropertyChanged('ddlAnchorPosition');}
},
get_ddlYearOrder : function() {
return this._ddlYearOrder;},
set_ddlYearOrder : function(value) {
if (this._ddlYearOrder != value) {
this._ddlYearOrder = value;this.raisePropertyChanged('ddlYearOrder');}
},
get_workWeekFirstDay : function() {
return this._workWeekFirstDay;},
set_workWeekFirstDay : function(value) {
if (this._workWeekFirstDay != value) {
this._workWeekFirstDay = value;this.raisePropertyChanged('workWeekFirstDay');}
},
get_workWeekLastDay : function() {
return this._workWeekLastDay;},
set_workWeekLastDay : function(value) {
if (this._workWeekLastDay != value) {
this._workWeekLastDay = value;this.raisePropertyChanged('workWeekLastDay');}
},
get_enableWorkDays : function() {
return this._enableWorkDays;},
set_enableWorkDays : function(value) {
if (this._enableWorkDays != value) {
this._enableWorkDays = value;this.raisePropertyChanged("enableWorkDays");}
},
get_enableWeekendDays : function() {
return this._enableWeekendDays;},
set_enableWeekendDays : function(value) {
if (this._enableWeekendDays != value) {
this._enableWeekendDays = value;this.raisePropertyChanged("enableWeekendDays");}
},
get_visibleDate : function() {
return this._visibleDate;},
set_visibleDate : function(value) {
if (value) value = value.getDateOnly();if (this._visibleDate != value) {
this._switchMonth(value, !this._isOpen);this.raisePropertyChanged("visibleDate");}
},
get_isOpen : function() {
return this._isOpen;},
get_todaysDate : function() 
{
if (this._todaysDate != null) 
{
return this._todaysDate;}
return new Date().getDateOnly();},
set_todaysDate : function(value) {
if (value) value = value.getDateOnly();if (this._todaysDate != value) {
this._todaysDate = value;this.invalidate();this.raisePropertyChanged("todaysDate");}
},
get_firstDayOfWeek : function() {
return this._firstDayOfWeek;},
set_firstDayOfWeek : function(value) {
if (this._firstDayOfWeek != value) {
this._firstDayOfWeek = value;this.invalidate();this.raisePropertyChanged("firstDayOfWeek");}
},
get_cssClass : function() {
return this._cssClass;},
set_cssClass : function(value) {
if (this._cssClass != value) {
if (this._cssClass && this.get_isInitialized()) {
Sys.UI.DomElement.removeCssClass(this._container, this._cssClass);}
this._cssClass = value;if (this._cssClass && this.get_isInitialized()) {
Sys.UI.DomElement.addCssClass(this._container, this._cssClass);}
this.raisePropertyChanged("cssClass");}
},
get_todayButton : function() {
return this._today;},
get_dayCell : function(row, col) {
if (this._daysBody) {
return this._daysBody.rows[row].cells[col].firstChild;}
return null;},
add_showing : function(handler) {
this.get_events().addHandler("showing", handler);},
remove_showing : function(handler) {
this.get_events().removeHandler("showing", handler);},
raiseShowing : function(eventArgs) {
var handler = this.get_events().getHandler('showing');if (handler) {
handler(this, eventArgs);}
},
add_shown : function(handler) {
this.get_events().addHandler("shown", handler);},
remove_shown : function(handler) {
this.get_events().removeHandler("shown", handler);},
raiseShown : function() {
var handlers = this.get_events().getHandler("shown");if (handlers) {
handlers(this, Sys.EventArgs.Empty);}
},
add_hiding : function(handler) {
this.get_events().addHandler("hiding", handler);},
remove_hiding : function(handler) {
this.get_events().removeHandler("hiding", handler);},
raiseHiding : function(eventArgs) {
var handler = this.get_events().getHandler('hiding');if (handler) {
handler(this, eventArgs);}
},
add_hidden : function(handler) {
this.get_events().addHandler("hidden", handler);},
remove_hidden : function(handler) {
this.get_events().removeHandler("hidden", handler);},
raiseHidden : function() {
var handlers = this.get_events().getHandler("hidden");if (handlers) {
handlers(this, Sys.EventArgs.Empty);}
},
add_dateSelectionChanged : function(handler) {
this.get_events().addHandler("dateSelectionChanged", handler);},
remove_dateSelectionChanged : function(handler) {
this.get_events().removeHandler("dateSelectionChanged", handler);},
raiseDateSelectionChanged : function() {
var handlers = this.get_events().getHandler("dateSelectionChanged");if (handlers) {
handlers(this, Sys.EventArgs.Empty);}
},
initialize : function() {
AjaxControlToolkitPlus.CalendarBehavior.callBaseMethod(this, "initialize");var elt = this.get_element();$addHandlers(elt, this._element$delegates);if (this._button) {
$addHandlers(this._button, this._button$delegates);}
this._modeChangeMoveTopOrLeftAnimation = new AjaxControlToolkitPlus.Animation.LengthAnimation(null, null, null, "style", null, 0, 0, "px");this._modeChangeMoveBottomOrRightAnimation = new AjaxControlToolkitPlus.Animation.LengthAnimation(null, null, null, "style", null, 0, 0, "px");this._modeChangeAnimation = new AjaxControlToolkitPlus.Animation.ParallelAnimation(null, .25, null, [ this._modeChangeMoveTopOrLeftAnimation, this._modeChangeMoveBottomOrRightAnimation ]);var value = this.get_selectedDate();if (value) {
this.set_selectedDate(value);} 
},
dispose : function() {
if (this._popupBehavior) {
this._popupBehavior.dispose();this._popupBehavior = null;}
this._modes = null;this._modeOrder = null;if (this._modeChangeMoveTopOrLeftAnimation) {
this._modeChangeMoveTopOrLeftAnimation.dispose();this._modeChangeMoveTopOrLeftAnimation = null;}
if (this._modeChangeMoveBottomOrRightAnimation) {
this._modeChangeMoveBottomOrRightAnimation.dispose();this._modeChangeMoveBottomOrRightAnimation = null;}
if (this._modeChangeAnimation) {
this._modeChangeAnimation.dispose();this._modeChangeAnimation = null;}
if (this._container) {
if(this._container.parentNode) { 
this._container.parentNode.removeChild(this._container);}
this._container = null;}
if (this._popupDiv) {
$common.removeHandlers(this._popupDiv, this._popup$delegates);this._popupDiv = null;} 
if (this._prevArrow) {
if (this._showArrows)
{
$common.removeHandlers(this._prevArrow, this._cell$delegates);}
this._prevArrow = null;}
if (this._nextArrow) {
if (this._showArrows)
{
$common.removeHandlers(this._nextArrow, this._cell$delegates);}
this._nextArrow = null;}
if (this._title) {
if (!this._showDdlHeader)
{
$common.removeHandlers(this._title, this._cell$delegates);}
this._title = null;}
if (this._today) {
if (this._showToday)
{
$common.removeHandlers(this._today, this._cell$delegates);}
this._today = null;}
if (this._button) {
$common.removeHandlers(this._button, this._button$delegates);this._button = null;}
if (this._daysBody) 
{
for (var i = 0;i < this._daysBody.rows.length;i++) 
{
var row = this._daysBody.rows[i];for (var j = 0;j < row.cells.length;j++) 
{
try{
$common.removeHandlers(row.cells[j].firstChild, this._cell$delegates);}
catch(ex) {}
}
}
this._daysBody = null;}
if (this._monthsBody) 
{
for (var i = 0;i < this._monthsBody.rows.length;i++) 
{
var row = this._monthsBody.rows[i];for (var j = 0;j < row.cells.length;j++) 
{
try
{
$common.removeHandlers(row.cells[j].firstChild, this._cell$delegates);}
catch (ex) {}
}
}
this._monthsBody = null;}
if (this._yearsBody) 
{
for (var i = 0;i < this._yearsBody.rows.length;i++) 
{
var row = this._yearsBody.rows[i];for (var j = 0;j < row.cells.length;j++) 
{
try
{
$common.removeHandlers(row.cells[j].firstChild, this._cell$delegates);}
catch (ex) {}
}
}
this._yearsBody = null;} 
var elt = this.get_element();$common.removeHandlers(elt, this._element$delegates);AjaxControlToolkitPlus.CalendarBehavior.callBaseMethod(this, "dispose");},
show : function() {
this._ensureCalendar();if (!this._isOpen) {
var eventArgs = new Sys.CancelEventArgs();this.raiseShowing(eventArgs);if (eventArgs.get_cancel()) {
return;}
this._isOpen = true;this._switchMonth(null, true);this._popupBehavior.show();this.raiseShown();}
}, 
hide : function() {
if (this._isOpen) {
var eventArgs = new Sys.CancelEventArgs();this.raiseHiding(eventArgs);if (eventArgs.get_cancel()) {
return;}
if (this._container) {
this._popupBehavior.hide();this._switchMode("days", true);}
this._isOpen = false;this.raiseHidden();this._popupMouseDown = false;}
},
focus : function() {
if (this._button) {
this._button.focus();} else {
this.get_element().focus();}
},
blur : function(force) {
if (!force && Sys.Browser.agent === Sys.Browser.Opera) {
this._blur.post(true);} else {
if (!this._popupMouseDown) {
this.hide();} 
this._popupMouseDown = false;}
},
suspendLayout : function() {
this._layoutSuspended++;},
resumeLayout : function() {
this._layoutSuspended--;if (this._layoutSuspended <= 0) {
this._layoutSuspended = 0;if (this._layoutRequested) {
this._performLayout();}
}
},
invalidate : function() {
if (this._layoutSuspended > 0) {
this._layoutRequested = true;} else {
this._performLayout();}
},
_buildCalendar : function() {
var elt = this.get_element();var id = this.get_id();this._container = $common.createElementFromTemplate({
nodeName : "div",
properties : { id : id + "_container" },
cssClasses : [this._cssClass]
}, elt.parentNode);this._popupDiv = $common.createElementFromTemplate({ 
nodeName : "div",
events : this._popup$delegates, 
properties : {
id : id + "_popupDiv"
},
cssClasses : ["ajax__calendar_container"], 
visible : false 
}, this._container);},
_buildHeader : function() {
var id = this.get_id();this._header = $common.createElementFromTemplate({ 
nodeName : "div",
properties : { id : id + "_header" },
cssClasses : [ "ajax__calendar_header" ]
}, this._popupDiv);var prevArrowWrapper = $common.createElementFromTemplate({ nodeName : "div" }, this._header);this._prevArrow = $common.createElementFromTemplate({ 
nodeName : "div",
properties : {
id : id + "_prevArrow",
mode : "prev"
},
events : (this._showArrows ? this._cell$delegates : null),
cssClasses : [ (this._showArrows ? "ajax__calendar_prev" : "" ) ] 
}, prevArrowWrapper);var nextArrowWrapper = $common.createElementFromTemplate({ nodeName : "div" }, this._header);this._nextArrow = $common.createElementFromTemplate({ 
nodeName : "div",
properties : {
id : id + "_nextArrow",
mode : "next"
},
events : (this._showArrows ? this._cell$delegates : null), 
cssClasses : [ (this._showArrows ? "ajax__calendar_next" : "" ) ] 
}, nextArrowWrapper);var titleWrapper = $common.createElementFromTemplate({ nodeName : "div" }, this._header);this._title = $common.createElementFromTemplate({ 
nodeName : "div",
properties : {
id : id + "_title",
mode : "title"
},
events : (this._showDdlHeader ? null : this._cell$delegates), 
cssClasses : [ "ajax__calendar_title" ] 
}, titleWrapper);},
_buildBody : function() {
this._body = $common.createElementFromTemplate({ 
nodeName : "div",
properties : { id : this.get_id() + "_body" },
cssClasses : [ "ajax__calendar_body" ]
}, this._popupDiv);this._buildDays();this._buildMonths();this._buildYears();},
_buildFooter : function() {
if (this._showToday)
{
var todayWrapper = $common.createElementFromTemplate({ nodeName : "div" }, this._popupDiv);this._today = $common.createElementFromTemplate({
nodeName : "div",
properties : {
id : this.get_id() + "_today",
mode : "today"
},
events : this._cell$delegates,
cssClasses : [ "ajax__calendar_footer", "ajax__calendar_today" ]
}, todayWrapper);}
},
_buildDays : function() {
var dtf = Sys.CultureInfo.CurrentCulture.dateTimeFormat;var id = this.get_id();this._days = $common.createElementFromTemplate({ 
nodeName : "div",
properties : { id : id + "_days" },
cssClasses : [ "ajax__calendar_days" ]
}, this._body);this._modes["days"] = this._days;this._daysTable = $common.createElementFromTemplate({ 
nodeName : "table",
properties : {
id : id + "_daysTable",
cellPadding : 0,
cellSpacing : 0,
border : 0,
style : { margin : "auto" }
} 
}, this._days);this._daysTableHeader = $common.createElementFromTemplate({ nodeName : "thead", properties : { id : id + "_daysTableHeader" } }, this._daysTable);this._daysTableHeaderRow = $common.createElementFromTemplate({ nodeName : "tr", properties : { id : id + "_daysTableHeaderRow" } }, this._daysTableHeader);for (var i = 0;i < 7;i++) {
var dayCell = $common.createElementFromTemplate({ nodeName : "td" }, this._daysTableHeaderRow);var dayDiv = $common.createElementFromTemplate({
nodeName : "div",
cssClasses : [ "ajax__calendar_dayname" ]
}, dayCell);}
this._daysBody = $common.createElementFromTemplate({ nodeName: "tbody", properties : { id : id + "_daysBody" } }, this._daysTable);for (var i = 0;i < 6;i++) {
var daysRow = $common.createElementFromTemplate({ nodeName : "tr" }, this._daysBody);for(var j = 0;j < 7;j++) {
var dayCell = $common.createElementFromTemplate({ nodeName : "td" }, daysRow);var dayDiv = $common.createElementFromTemplate({
nodeName : "div",
properties : {
mode : "day",
id : id + "_day_" + i + "_" + j,
innerHTML : "&nbsp;"
},
events : null,
cssClasses : [ "ajax__calendar_day" ]
}, dayCell);}
}
},
_buildMonths : function() {
var dtf = Sys.CultureInfo.CurrentCulture.dateTimeFormat;var id = this.get_id();this._months = $common.createElementFromTemplate({
nodeName : "div",
properties : { id : id + "_months" },
cssClasses : [ "ajax__calendar_months" ],
visible : false
}, this._body);this._modes["months"] = this._months;this._monthsTable = $common.createElementFromTemplate({
nodeName : "table",
properties : {
id : id + "_monthsTable",
cellPadding : 0,
cellSpacing : 0,
border : 0,
style : { margin : "auto" }
}
}, this._months);this._monthsBody = $common.createElementFromTemplate({ nodeName : "tbody", properties : { id : id + "_monthsBody" } }, this._monthsTable);for (var i = 0;i < 3;i++) {
var monthsRow = $common.createElementFromTemplate({ nodeName : "tr" }, this._monthsBody);for (var j = 0;j < 4;j++) {
var monthCell = $common.createElementFromTemplate({ nodeName : "td" }, monthsRow);var monthDiv = $common.createElementFromTemplate({
nodeName : "div",
properties : {
id : id + "_month_" + i + "_" + j,
mode : "month",
month : (i * 4) + j,
innerHTML : "<br />" + dtf.AbbreviatedMonthNames[(i * 4) + j]
},
events : null,
cssClasses : [ "ajax__calendar_month" ]
}, monthCell);}
}
},
_buildYears : function() {
var id = this.get_id();this._years = $common.createElementFromTemplate({
nodeName : "div",
properties : { id : id + "_years" },
cssClasses : [ "ajax__calendar_years" ],
visible : false
}, this._body);this._modes["years"] = this._years;this._yearsTable = $common.createElementFromTemplate({
nodeName : "table",
properties : {
id : id + "_yearsTable",
cellPadding : 0,
cellSpacing : 0,
border : 0,
style : { margin : "auto" }
}
}, this._years);this._yearsBody = $common.createElementFromTemplate({ nodeName : "tbody", properties : { id : id + "_yearsBody" } }, this._yearsTable);for (var i = 0;i < 3;i++) {
var yearsRow = $common.createElementFromTemplate({ nodeName : "tr" }, this._yearsBody);for (var j = 0;j < 4;j++) {
var yearCell = $common.createElementFromTemplate({ nodeName : "td" }, yearsRow);var yearDiv = $common.createElementFromTemplate({ 
nodeName : "div", 
properties : { 
id : id + "_year_" + i + "_" + j,
mode : "year",
year : ((i * 4) + j) - 1
},
events : null,
cssClasses : [ "ajax__calendar_year" ]
}, yearCell);}
}
},
_StripCellHandlers : function(cell)
{
try
{
$common.removeHandlers(cell, this._cell$delegates);}
catch (ex) {}
},
_forceRange : function (value)
{
if (value < this._minimumDate)
{
value = this._minimumDate;}
else if (value > this._maximumDate)
{
value = this._maximumDate;} 
return value;},
_buildAlternateHeader : function (visibleDate) 
{
var months = new Array("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec");var ddlMonth = $common.createElementFromTemplate({
nodeName : "select",
properties : {
id : this._id + "_ddlMonths",
mode : "month"
},
events : this._ddl$delegates
}, this._header);for (var j = 0;j < 12;j++) 
{
var curDate = new Date(visibleDate.getFullYear(), j, 1, this._hourOffsetForDst);var monthCssClass = this._getCssClass(curDate, 'M');if (monthCssClass != "ajax__calendar_other")
{
var monthOption = $common.createElementFromTemplate({
nodeName : "option",
properties : {
id : this._id + "_ddlMonths_" + curDate.getMonth(),
value: curDate.getMonth()
}
}, ddlMonth);monthOption.appendChild(document.createTextNode(months[curDate.getMonth()]));ddlMonth.appendChild(monthOption);}
}
this._title.appendChild(ddlMonth);ddlMonth.value = visibleDate.getMonth();var ddlYear = $common.createElementFromTemplate({
nodeName : "select",
properties : {
id : this._id + "_ddlYear",
mode : "year"
},
events : this._ddl$delegates
}, this._header);var yearBuffer = Math.floor(this._ddlMaxNumberOfYears / 2);var upperBound = visibleDate.getFullYear() + yearBuffer;var lowerBound = visibleDate.getFullYear() - yearBuffer;if (this._ddlAnchorYear != '')
{
var intAnchorYear = parseInt(this._ddlAnchorYear);var anchorIsValid = true;if (this._minimumDate) { anchorIsValid = anchorIsValid && (intAnchorYear >= this._minimumDate.getFullYear());}
if (this._maximumDate) { anchorIsValid = anchorIsValid && (intAnchorYear <= this._maximumDate.getFullYear());}
if (anchorIsValid)
{
upperBound = intAnchorYear + yearBuffer;lowerBound = intAnchorYear - yearBuffer;if (this._ddlAnchorPosition)
{
if (((this._ddlAnchorPosition == AjaxControlToolkitPlus.DdlAnchorPosition.Top) &&
(this._ddlYearOrder == AjaxControlToolkitPlus.DdlYearOrder.Ascending)) ||
((this._ddlAnchorPosition == AjaxControlToolkitPlus.DdlAnchorPosition.Bottom) && 
(this._ddlYearOrder == AjaxControlToolkitPlus.DdlYearOrder.Descending)))
{
lowerBound = intAnchorYear;upperBound = intAnchorYear + this._ddlMaxNumberOfYears;}
else if (this._ddlAnchorPosition != AjaxControlToolkitPlus.DdlAnchorPosition.Middle)
{
lowerBound = intAnchorYear - this._ddlMaxNumberOfYears;upperBound = intAnchorYear;}
}
}
}
if (this._ddlYearOrder == AjaxControlToolkitPlus.DdlYearOrder.Descending)
{ 
for (var j = upperBound;j > lowerBound - 1;j--) 
{
this._addYearToDdl(ddlYear, j);}
}
else 
{
for (var j = lowerBound;j < upperBound + 1;j++) 
{
this._addYearToDdl(ddlYear, j);}
}
this._title.appendChild(ddlYear);ddlYear.value = visibleDate.getFullYear();},
_addYearToDdl : function(ddlYear, year)
{
var showYear = true;if (this._minimumDate) { showYear = showYear && (year >= this._minimumDate.getFullYear());}
if (this._maximumDate) { showYear = showYear && (year <= this._maximumDate.getFullYear());}
if (showYear)
{
var yearOption = $common.createElementFromTemplate({
nodeName : "option",
properties : {
id : this._id + "_ddlYear_" + year,
value: year
}
}, ddlYear);yearOption.appendChild(document.createTextNode(year));ddlYear.appendChild(yearOption);}
},
_showHidePrevArrow: function(arrow, part)
{
if (this._minimumDate)
{
switch (part)
{
case "days":
arrow.style.visibility = (
(arrow.date.getMonth() < this._minimumDate.getMonth() && 
(arrow.date.getFullYear() == this._minimumDate.getFullYear()))
? 'hidden' : '');break;case "months":
arrow.style.visibility = (arrow.date.getFullYear() < this._minimumDate.getFullYear() ? 'hidden' : '');break;case "years":
arrow.style.visibility = ((arrow.date.getFullYear() + 11) < this._minimumDate.getFullYear() ? 'hidden' : '');break;}
}
else
{
arrow.style.visibility = '';}
},
_showHideNextArrow: function(arrow)
{
arrow.style.visibility = (arrow.date > this._maximumDate ? 'hidden' : '');},
_performLayout : function() {
var elt = this.get_element();if (!elt) return;if (!this.get_isInitialized()) return;if (!this._isOpen) return;var dtf = Sys.CultureInfo.CurrentCulture.dateTimeFormat;var selectedDate = this.get_selectedDate();var visibleDate = this._getEffectiveVisibleDate();var todaysDate = this.get_todaysDate();switch (this._mode) {
case "days":
var firstDayOfWeek = this._getFirstDayOfWeek();var daysToBacktrack = visibleDate.getDay() - firstDayOfWeek;if (daysToBacktrack <= 0)
daysToBacktrack += 7;var startDate = new Date(visibleDate.getFullYear(), visibleDate.getMonth(), visibleDate.getDate() - daysToBacktrack, this._hourOffsetForDst);var currentDate = startDate;for (var i = 0;i < 7;i++) {
var dayCell = this._daysTableHeaderRow.cells[i].firstChild;if (dayCell.firstChild) {
dayCell.removeChild(dayCell.firstChild);}
dayCell.appendChild(document.createTextNode(dtf.ShortestDayNames[(i + firstDayOfWeek) % 7]));}
for (var week = 0;week < 6;week ++) 
{
var weekRow = this._daysBody.rows[week];for (var dayOfWeek = 0;dayOfWeek < 7;dayOfWeek++) 
{
var dayCell = weekRow.cells[dayOfWeek].firstChild;if (dayCell.firstChild) 
{
dayCell.removeChild(dayCell.firstChild);}
dayCell.date = currentDate;var dayCssClass = this._getCssClass(dayCell.date, 'd');$common.removeCssClasses(dayCell.parentNode, [ "ajax__calendar_other", "ajax__calendar_active", "ajax__calendar_today" ]);Sys.UI.DomElement.addCssClass(dayCell.parentNode, dayCssClass);this._StripCellHandlers(dayCell);dayCell.appendChild(document.createTextNode(currentDate.getDate()));if (dayCssClass != "ajax__calendar_other")
{
dayCell.title = currentDate.localeFormat("D");$addHandlers(dayCell, this._cell$delegates)
}
currentDate = new Date(currentDate.getFullYear(), currentDate.getMonth(), currentDate.getDate() + 1, this._hourOffsetForDst);}
}
this._prevArrow.date = new Date(visibleDate.getFullYear(), visibleDate.getMonth() - 1, 1, this._hourOffsetForDst);this._nextArrow.date = new Date(visibleDate.getFullYear(), visibleDate.getMonth() + 1, 1, this._hourOffsetForDst);while (this._title.firstChild) {
this._title.removeChild(this._title.firstChild);}
if (this._showDdlHeader)
{
this._buildAlternateHeader(visibleDate);}
else
{
this._title.appendChild(document.createTextNode(visibleDate.localeFormat("MMMM, yyyy")));this._title.date = visibleDate;}
break;case "months":
for (var i = 0;i < this._monthsBody.rows.length;i++) 
{
var row = this._monthsBody.rows[i];for (var j = 0;j < row.cells.length;j++) 
{
var cell = row.cells[j].firstChild;cell.date = new Date(visibleDate.getFullYear(), cell.month, 1, this._hourOffsetForDst);$common.removeCssClasses(cell.parentNode, [ "ajax__calendar_other", "ajax__calendar_active" ]);var monthCssClass = this._getCssClass(cell.date, 'M');Sys.UI.DomElement.addCssClass(cell.parentNode, monthCssClass);this._StripCellHandlers(cell);if (monthCssClass != "ajax__calendar_other")
{
cell.title = cell.date.localeFormat("Y");$addHandlers(cell, this._cell$delegates)
}
}
}
if (this._title.firstChild) {
this._title.removeChild(this._title.firstChild);}
this._title.appendChild(document.createTextNode(visibleDate.localeFormat("yyyy")));this._title.date = visibleDate;this._prevArrow.date = new Date(visibleDate.getFullYear() - 1, 0, 1, this._hourOffsetForDst);this._nextArrow.date = new Date(visibleDate.getFullYear() + 1, 0, 1, this._hourOffsetForDst);break;case "years":
var minYear = (Math.floor(visibleDate.getFullYear() / 10) * 10);for (var i = 0;i < this._yearsBody.rows.length;i++) {
var row = this._yearsBody.rows[i];for (var j = 0;j < row.cells.length;j++) 
{
var cell = row.cells[j].firstChild;cell.date = new Date(minYear + cell.year, 0, 1, this._hourOffsetForDst);if (cell.firstChild) 
{
cell.removeChild(cell.lastChild);} 
else 
{
cell.appendChild(document.createElement("br"));}
$common.removeCssClasses(cell.parentNode, [ "ajax__calendar_other", "ajax__calendar_active" ]);var yearCssClass = this._getCssClass(cell.date, 'y');Sys.UI.DomElement.addCssClass(cell.parentNode, yearCssClass);this._StripCellHandlers(cell);cell.appendChild(document.createTextNode(minYear + cell.year));if (yearCssClass != "ajax__calendar_other")
{
$addHandlers(cell, this._cell$delegates)
}
}
}
if (this._title.firstChild) {
this._title.removeChild(this._title.firstChild);}
this._title.appendChild(document.createTextNode(minYear.toString() + "-" + (minYear + 9).toString()));this._title.date = visibleDate;this._prevArrow.date = new Date(minYear - 10, 0, 1, this._hourOffsetForDst);this._nextArrow.date = new Date(minYear + 10, 0, 1, this._hourOffsetForDst);break;}
this._showHidePrevArrow(this._prevArrow, this._mode);this._showHideNextArrow(this._nextArrow);if (this._today)
{
if (this._today.firstChild) {
this._today.removeChild(this._today.firstChild);}
this._today.appendChild(document.createTextNode(String.format(AjaxControlToolkitPlus.Resources.Calendar_Today, todaysDate.localeFormat("MMMM d, yyyy"))));this._today.date = todaysDate;}
},
_ensureCalendar : function() {
if (!this._container) {
var elt = this.get_element();this._buildCalendar();this._buildHeader();this._buildBody();this._buildFooter();this._popupBehavior = new $create(AjaxControlToolkitPlus.PopupBehavior, { parentElement : elt }, {}, {}, this._popupDiv);if (this._popupPosition == AjaxControlToolkitPlus.CalendarPosition.TopLeft) {
this._popupBehavior.set_positioningMode(AjaxControlToolkitPlus.PositioningMode.TopLeft);} else if (this._popupPosition == AjaxControlToolkitPlus.CalendarPosition.TopRight) {
this._popupBehavior.set_positioningMode(AjaxControlToolkitPlus.PositioningMode.TopRight);} else if (this._popupPosition == AjaxControlToolkitPlus.CalendarPosition.BottomRight) {
this._popupBehavior.set_positioningMode(AjaxControlToolkitPlus.PositioningMode.BottomRight);} else if (this._popupPosition == AjaxControlToolkitPlus.CalendarPosition.Right) {
this._popupBehavior.set_positioningMode(AjaxControlToolkitPlus.PositioningMode.Right);} else if (this._popupPosition == AjaxControlToolkitPlus.CalendarPosition.Left) {
this._popupBehavior.set_positioningMode(AjaxControlToolkitPlus.PositioningMode.Left);} else {
this._popupBehavior.set_positioningMode(AjaxControlToolkitPlus.PositioningMode.BottomLeft);}
}
},
_fireChanged : function() {
var elt = this.get_element();if (document.createEventObject) {
elt.fireEvent("onchange");} else if (document.createEvent) {
var e = document.createEvent("HTMLEvents");e.initEvent("change", true, true);elt.dispatchEvent(e);}
},
_switchMonth : function(date, dontAnimate) {
if (this._isAnimating) {
return;}
var visibleDate = this._getEffectiveVisibleDate();if ((date && date.getFullYear() == visibleDate.getFullYear() && date.getMonth() == visibleDate.getMonth())) {
dontAnimate = true;}
if (this._animated && !dontAnimate) {
this._isAnimating = true;var newElement = this._modes[this._mode];var oldElement = newElement.cloneNode(true);this._body.appendChild(oldElement);if (visibleDate > date) {
$common.setLocation(newElement, {x:-162,y:0});$common.setVisible(newElement, true);this._modeChangeMoveTopOrLeftAnimation.set_propertyKey("left");this._modeChangeMoveTopOrLeftAnimation.set_target(newElement);this._modeChangeMoveTopOrLeftAnimation.set_startValue(-this._width);this._modeChangeMoveTopOrLeftAnimation.set_endValue(0);$common.setLocation(oldElement, {x:0,y:0});$common.setVisible(oldElement, true);this._modeChangeMoveBottomOrRightAnimation.set_propertyKey("left");this._modeChangeMoveBottomOrRightAnimation.set_target(oldElement);this._modeChangeMoveBottomOrRightAnimation.set_startValue(0);this._modeChangeMoveBottomOrRightAnimation.set_endValue(this._width);} else {
$common.setLocation(oldElement, {x:0,y:0});$common.setVisible(oldElement, true);this._modeChangeMoveTopOrLeftAnimation.set_propertyKey("left");this._modeChangeMoveTopOrLeftAnimation.set_target(oldElement);this._modeChangeMoveTopOrLeftAnimation.set_endValue(-this._width);this._modeChangeMoveTopOrLeftAnimation.set_startValue(0);$common.setLocation(newElement, {x:162,y:0});$common.setVisible(newElement, true);this._modeChangeMoveBottomOrRightAnimation.set_propertyKey("left");this._modeChangeMoveBottomOrRightAnimation.set_target(newElement);this._modeChangeMoveBottomOrRightAnimation.set_endValue(0);this._modeChangeMoveBottomOrRightAnimation.set_startValue(this._width);}
this._visibleDate = date;this.invalidate();var endHandler = Function.createDelegate(this, function() { 
this._body.removeChild(oldElement);oldElement = null;this._isAnimating = false;this._modeChangeAnimation.remove_ended(endHandler);});this._modeChangeAnimation.add_ended(endHandler);this._modeChangeAnimation.play();} else {
this._visibleDate = date;this.invalidate();}
},
_switchMode : function(mode, dontAnimate) {
if (this._isAnimating || (this._mode == mode)) {
return;}
var moveDown = this._modeOrder[this._mode] < this._modeOrder[mode];var oldElement = this._modes[this._mode];var newElement = this._modes[mode];this._mode = mode;if (this._animated && !dontAnimate) { 
this._isAnimating = true;this.invalidate();if (moveDown) {
$common.setLocation(newElement, {x:0,y:-this._height});$common.setVisible(newElement, true);this._modeChangeMoveTopOrLeftAnimation.set_propertyKey("top");this._modeChangeMoveTopOrLeftAnimation.set_target(newElement);this._modeChangeMoveTopOrLeftAnimation.set_startValue(-this._height);this._modeChangeMoveTopOrLeftAnimation.set_endValue(0);$common.setLocation(oldElement, {x:0,y:0});$common.setVisible(oldElement, true);this._modeChangeMoveBottomOrRightAnimation.set_propertyKey("top");this._modeChangeMoveBottomOrRightAnimation.set_target(oldElement);this._modeChangeMoveBottomOrRightAnimation.set_startValue(0);this._modeChangeMoveBottomOrRightAnimation.set_endValue(this._height);} else {
$common.setLocation(oldElement, {x:0,y:0});$common.setVisible(oldElement, true);this._modeChangeMoveTopOrLeftAnimation.set_propertyKey("top");this._modeChangeMoveTopOrLeftAnimation.set_target(oldElement);this._modeChangeMoveTopOrLeftAnimation.set_endValue(-this._height);this._modeChangeMoveTopOrLeftAnimation.set_startValue(0);$common.setLocation(newElement, {x:0,y:139});$common.setVisible(newElement, true);this._modeChangeMoveBottomOrRightAnimation.set_propertyKey("top");this._modeChangeMoveBottomOrRightAnimation.set_target(newElement);this._modeChangeMoveBottomOrRightAnimation.set_endValue(0);this._modeChangeMoveBottomOrRightAnimation.set_startValue(this._height);}
var endHandler = Function.createDelegate(this, function() { 
this._isAnimating = false;this._modeChangeAnimation.remove_ended(endHandler);});this._modeChangeAnimation.add_ended(endHandler);this._modeChangeAnimation.play();} else {
this._mode = mode;$common.setVisible(oldElement, false);this.invalidate();$common.setVisible(newElement, true);$common.setLocation(newElement, {x:0,y:0});}
},
_isSelected : function(date, part) {
var value = this.get_selectedDate();if (!value) return false;switch (part) {
case 'd':
if (date.getDate() != value.getDate()) return false;case 'M':
if (date.getMonth() != value.getMonth()) return false;case 'y':
if (date.getFullYear() != value.getFullYear()) return false;break;}
return true;},
_isOther : function(date, part) {
date = date.getDateOnly();var value = this._getEffectiveVisibleDate();switch (part) {
case 'd': 
var result = (date.getFullYear() != value.getFullYear() || date.getMonth() != value.getMonth());if (this._minimumDate) { result = result || (date < this._minimumDate);}
if (this._maximumDate) { result = result || (date > this._maximumDate);}
result = result || (!this._enableWorkDays && this._isWorkDay(date.getDay()));result = result || (!this._enableWeekendDays && !this._isWorkDay(date.getDay()));return result;case 'M': 
var result = false;if (this._minimumDate) 
{ 
result = result || (date.getFullYear() < this._minimumDate.getFullYear()) ||
(date.getFullYear() == this._minimumDate.getFullYear() &&
date.getMonth() < this._minimumDate.getMonth());}
if (this._maximumDate) 
{ 
result = result || (date.getFullYear() > this._maximumDate.getFullYear()) ||
(date.getFullYear() == this._maximumDate.getFullYear() &&
date.getMonth() > this._maximumDate.getMonth());} 
return result;case 'y': 
var minYear = (Math.floor(value.getFullYear() / 10) * 10);var result = date.getFullYear() < minYear || (minYear + 10) <= date.getFullYear();if (this._minimumDate) { result = result || (date.getFullYear() < this._minimumDate.getFullYear());}
if (this._maximumDate) { result = result || (date.getFullYear() > this._maximumDate.getFullYear());}
return result;}
return false;},
_isWorkDay : function(dayOfWeek)
{
var result = true;var rangeStart = 0;var rangeEnd = 6;if (this._workWeekFirstDay != null) 
{
rangeStart = this._workWeekFirstDay;}
if (this._workWeekLastDay != null)
{
rangeEnd = this._workWeekLastDay;}
result = (dayOfWeek >= rangeStart)
if (rangeStart < rangeEnd)
{
result = result && (dayOfWeek <= rangeEnd);}
else
{
result = result || (dayOfWeek <= rangeEnd);}
return result;},
_getCssClass : function(date, part) {
var todaysDate = this.get_todaysDate();var isToday = ((todaysDate.getFullYear() == date.getFullYear()) && 
(todaysDate.getMonth() == date.getMonth()) && 
(todaysDate.getDate() == date.getDate()));if (this._isSelected(date, part)) {
return "ajax__calendar_active";} else if (this._isOther(date, part)) {
return "ajax__calendar_other";} else if (isToday) { 
return "ajax__calendar_today";} else {
return "";}
},
_getEffectiveVisibleDate : function() {
var value = this.get_visibleDate();if (value == null) 
value = this.get_selectedDate();if (value == null)
value = this.get_todaysDate();value = this._forceRange(value);return new Date(value.getFullYear(), value.getMonth(), 1, this._hourOffsetForDst);},
_getFirstDayOfWeek : function() {
if (this.get_firstDayOfWeek() != AjaxControlToolkitPlus.FirstDayOfWeek.Default) {
return this.get_firstDayOfWeek();}
return Sys.CultureInfo.CurrentCulture.dateTimeFormat.FirstDayOfWeek;},
_parseTextValue : function(text) {
var value = null;if(text) {
value = Date.parseLocale(text, this.get_format());}
if(isNaN(value)) {
value = null;}
return value;},
_element_onfocus : function(e) {
if (!this._enabled) return;if (!this._button) {
this.show();this._popupMouseDown = false;}
},
_element_onblur : function(e) {
if (!this._enabled) return;if (!this._button) {
this.blur();}
},
_element_onchange : function(e) {
if (!this._selectedDateChanging) {
var value = this._parseTextValue(this._textbox.get_Value());if (value) value = value.getDateOnly();this._selectedDate = value;if (this._isOpen) {
this._switchMonth(this._selectedDate, this._selectedDate == null);} 
}
},
_element_onkeypress : function(e) {
if (!this._enabled) return;if (!this._button && e.charCode == Sys.UI.Key.esc) {
e.stopPropagation();e.preventDefault();this.hide();}
},
_element_onclick : function(e) {
if (!this._enabled) return;if (!this._button) {
this.show();this._popupMouseDown = false;}
},
_popup_onevent : function(e) {
e.stopPropagation();e.preventDefault();},
_popup_onmousedown : function(e) {
this._popupMouseDown = true;},
_popup_onmouseup : function(e) {
if (!this._ddlMouseDown)
{
if (Sys.Browser.agent === Sys.Browser.Opera && this._blur.get_isPending()) {
this._blur.cancel();}
this.focus();}
else
{
this._ddlMouseDown = false;}
this._popupMouseDown = false;},
_cell_onmouseover : function(e) {
e.stopPropagation();if (Sys.Browser.agent === Sys.Browser.Safari) {
for (var i = 0;i < this._daysBody.rows.length;i++) {
var row = this._daysBody.rows[i];for (var j = 0;j < row.cells.length;j++) {
Sys.UI.DomElement.removeCssClass(row.cells[j].firstChild.parentNode, "ajax__calendar_hover");}
}
}
var target = e.target;Sys.UI.DomElement.addCssClass(target.parentNode, "ajax__calendar_hover");},
_cell_onmouseout : function(e) {
e.stopPropagation();var target = e.target;Sys.UI.DomElement.removeCssClass(target.parentNode, "ajax__calendar_hover");},
_cell_onclick : function(e) {
e.stopPropagation();e.preventDefault();if (!this._enabled) return;var target = e.target;var visibleDate = this._getEffectiveVisibleDate();Sys.UI.DomElement.removeCssClass(target.parentNode, "ajax__calendar_hover");switch(target.mode) {
case "prev":
case "next":
this._switchMonth(target.date);break;case "title":
switch (this._mode) {
case "days": this._switchMode("months");break;case "months": this._switchMode("years");break;}
break;case "month":
if (target.month == visibleDate.getMonth()) {
this._switchMode("days");} else {
this._visibleDate = target.date;this._switchMode("days");}
break;case "year":
if (target.date.getFullYear() == visibleDate.getFullYear()) {
this._switchMode("months");} else {
this._visibleDate = target.date;this._switchMode("months");}
break;case "day":
this.set_selectedDate(target.date);this._switchMonth(target.date);this._blur.post(true);this.raiseDateSelectionChanged();break;case "today":
this.set_selectedDate(target.date);this._switchMonth(target.date);this._blur.post(true);this.raiseDateSelectionChanged();break;}
},
_button_onclick : function(e) {
e.preventDefault();e.stopPropagation();if (!this._enabled) return;if (!this._isOpen) {
this.show();} else {
this.hide();}
this.focus();this._popupMouseDown = false;},
_button_onblur : function(e) {
if (!this._enabled) return;if (!this._popupMouseDown) {
this.hide();}
this._popupMouseDown = false;},
_button_onkeypress : function(e) {
if (!this._enabled) return;if (e.charCode == Sys.UI.Key.esc) {
e.stopPropagation();e.preventDefault();this.hide();}
this._popupMouseDown = false;},
_ddl_onmousedown : function(e) {
this._ddlMouseDown = true;this._popupMouseDown = true;},
_ddl_onselectedindexchanged : function(e) {
var visibleDate = this._getEffectiveVisibleDate();if (e.target.mode == "month")
{
if (e.target.value != visibleDate.getMonth()) 
{
visibleDate.setMonth(e.target.value);this._switchMonth(visibleDate);}
}
else if (e.target.mode == "year")
{
if (e.target.value != visibleDate.getFullYear()) 
{
visibleDate.setYear(e.target.value);this._switchMonth(visibleDate);}
}
this._ddlMouseDown = false;this.focus();}
}
AjaxControlToolkitPlus.CalendarBehavior.registerClass("AjaxControlToolkitPlus.CalendarBehavior", AjaxControlToolkitPlus.BehaviorBase);AjaxControlToolkitPlus.CalendarPosition = function() {
throw Error.invalidOperation();}
AjaxControlToolkitPlus.CalendarPosition.prototype = {
BottomLeft: 0,
BottomRight: 1,
TopLeft: 2,
TopRight: 3,
Right: 4,
Left: 5
}
AjaxControlToolkitPlus.CalendarPosition.registerEnum('AjaxControlToolkitPlus.CalendarPosition');AjaxControlToolkitPlus.DdlAnchorPosition = function() {
throw Error.invalidOperation();}
AjaxControlToolkitPlus.DdlAnchorPosition.prototype = {
Top: 1,
Middle: 2,
Bottom: 3
}
AjaxControlToolkitPlus.DdlAnchorPosition.registerEnum('AjaxControlToolkitPlus.DdlAnchorPosition');AjaxControlToolkitPlus.DdlYearOrder = function() {
throw Error.invalidOperation();}
AjaxControlToolkitPlus.DdlYearOrder.prototype = {
Ascending: 1,
Descending: 2
}
AjaxControlToolkitPlus.DdlYearOrder.registerEnum('AjaxControlToolkitPlus.DdlYearOrder');AjaxControlToolkitPlus.WeekDays = function() {
throw Error.invalidOperation();}
AjaxControlToolkitPlus.WeekDays.prototype = {
Sunday: 0,
Monday: 1,
Tuesday: 2,
Wednesday: 3,
Thursday: 4,
Friday: 5,
Saturday: 6
}
AjaxControlToolkitPlus.WeekDays.registerEnum('AjaxControlToolkitPlus.WeekDays');