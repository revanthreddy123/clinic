Type.registerNamespace("AjaxControlToolkitPlus");AjaxControlToolkitPlus.TimeSpan = function() {
if (arguments.length == 0) this._ctor$0.apply(this, arguments);else if (arguments.length == 1) this._ctor$1.apply(this, arguments);else if (arguments.length == 3) this._ctor$2.apply(this, arguments);else if (arguments.length == 4) this._ctor$3.apply(this, arguments);else if (arguments.length == 5) this._ctor$4.apply(this, arguments);else throw Error.parameterCount();}
AjaxControlToolkitPlus.TimeSpan.prototype = {
_ctor$0 : function() {
this._ticks = 0;}, 
_ctor$1 : function(ticks) {
this._ctor$0();this._ticks = ticks;},
_ctor$2 : function(hours, minutes, seconds) {
this._ctor$0();this._ticks = 
(hours * AjaxControlToolkitPlus.TimeSpan.TicksPerHour) +
(minutes * AjaxControlToolkitPlus.TimeSpan.TicksPerMinute) +
(seconds * AjaxControlToolkitPlus.TimeSpan.TicksPerSecond);},
_ctor$3 : function(days, hours, minutes, seconds) {
this._ctor$0();this._ticks = 
(days * AjaxControlToolkitPlus.TimeSpan.TicksPerDay) +
(hours * AjaxControlToolkitPlus.TimeSpan.TicksPerHour) +
(minutes * AjaxControlToolkitPlus.TimeSpan.TicksPerMinute) +
(seconds * AjaxControlToolkitPlus.TimeSpan.TicksPerSecond);},
_ctor$4 : function(days, hours, minutes, seconds, milliseconds) {
this._ctor$0();this._ticks = 
(days * AjaxControlToolkitPlus.TimeSpan.TicksPerDay) +
(hours * AjaxControlToolkitPlus.TimeSpan.TicksPerHour) +
(minutes * AjaxControlToolkitPlus.TimeSpan.TicksPerMinute) +
(seconds * AjaxControlToolkitPlus.TimeSpan.TicksPerSecond) +
(milliseconds * AjaxControlToolkitPlus.TimeSpan.TicksPerMillisecond);},
getDays : function() { 
return Math.floor(this._ticks / AjaxControlToolkitPlus.TimeSpan.TicksPerDay);},
getHours : function() { 
return Math.floor(this._ticks / AjaxControlToolkitPlus.TimeSpan.TicksPerHour) % 24;},
getMinutes : function() { 
return Math.floor(this._ticks / AjaxControlToolkitPlus.TimeSpan.TicksPerMinute) % 60;},
getSeconds : function() { 
return Math.floor(this._ticks / AjaxControlToolkitPlus.TimeSpan.TicksPerSecond) % 60;},
getMilliseconds : function() { 
return Math.floor(this._ticks / AjaxControlToolkitPlus.TimeSpan.TicksPerMillisecond) % 1000;},
getDuration : function() { 
return new AjaxControlToolkitPlus.TimeSpan(Math.abs(this._ticks));},
getTicks : function() { 
return this._ticks;},
getTotalDays : function() { 
Math.floor(this._ticks / AjaxControlToolkitPlus.TimeSpan.TicksPerDay);},
getTotalHours : function() { 
return Math.floor(this._ticks / AjaxControlToolkitPlus.TimeSpan.TicksPerHour);},
getTotalMinutes : function() { 
return Math.floor(this._ticks / AjaxControlToolkitPlus.TimeSpan.TicksPerMinute);},
getTotalSeconds : function() { 
return Math.floor(this._ticks / AjaxControlToolkitPlus.TimeSpan.TicksPerSecond);},
getTotalMilliseconds : function() { 
return Math.floor(this._ticks / AjaxControlToolkitPlus.TimeSpan.TicksPerMillisecond);},
add : function(value) { 
return new AjaxControlToolkitPlus.TimeSpan(this._ticks + value.getTicks());},
subtract : function(value) { 
return new AjaxControlToolkitPlus.TimeSpan(this._ticks - value.getTicks());},
negate : function() { 
return new AjaxControlToolkitPlus.TimeSpan(-this._ticks);},
equals : function(value) { 
return this._ticks == value.getTicks();},
compareTo : function(value) { 
if(this._ticks > value.getTicks()) 
return 1;else if(this._ticks < value.getTicks()) 
return -1;else 
return 0;},
toString : function() { 
return this.format("F");},
format : function(format) { 
if (!format) {
format = "F";}
if (format.length == 1) {
switch (format) {
case "t": format = AjaxControlToolkitPlus.TimeSpan.ShortTimeSpanPattern;break;case "T": format = AjaxControlToolkitPlus.TimeSpan.LongTimeSpanPattern;break;case "F": format = AjaxControlToolkitPlus.TimeSpan.FullTimeSpanPattern;break;default: throw Error.createError(String.format(AjaxControlToolkitPlus.Resources.Common_DateTime_InvalidTimeSpan, format));}
}
var regex = /dd|d|hh|h|mm|m|ss|s|nnnn|nnn|nn|n/g;var builder = new Sys.StringBuilder();var ticks = this._ticks;if (ticks < 0) {
builder.append("-");ticks = -ticks;}
for (;;) {
var index = regex.lastIndex;var ar = regex.exec(format);builder.append(format.slice(index, ar ? ar.index : format.length));if (!ar) break;switch (ar[0]) {
case "dd":
case "d":
builder.append($common.padLeft(Math.floor(ticks / AjaxControlToolkitPlus.TimeSpan.TicksPerDay, ar[0].length, '0')));break;case "hh":
case "h":
builder.append($common.padLeft(Math.floor(ticks / AjaxControlToolkitPlus.TimeSpan.TicksPerHour) % 24, ar[0].length, '0'));break;case "mm":
case "m":
builder.append($common.padLeft(Math.floor(ticks / AjaxControlToolkitPlus.TimeSpan.TicksPerMinute) % 60, ar[0].length, '0'));break;case "ss":
case "s":
builder.append($common.padLeft(Math.floor(ticks / AjaxControlToolkitPlus.TimeSpan.TicksPerSecond) % 60, ar[0].length, '0'));break;case "nnnn":
case "nnn":
case "nn":
case "n":
builder.append($common.padRight(Math.floor(ticks / AjaxControlToolkitPlus.TimeSpan.TicksPerMillisecond) % 1000, ar[0].length, '0', true));break;default:
Sys.Debug.assert(false);}
}
return builder.toString();}
}
AjaxControlToolkitPlus.TimeSpan.parse = function(text) {
var parts = text.split(":");var d = 0;var h = 0;var m = 0;var s = 0;var n = 0;var ticks = 0;switch(parts.length) {
case 1:
if (parts[0].indexOf(".") != -1) {
var parts2 = parts[0].split(".");s = parseInt(parts2[0]);n = parseInt(parts2[1]);} else {
ticks = parseInt(parts[0]);}
break;case 2:
h = parseInt(parts[0]);m = parseInt(parts[1]);break;case 3:
h = parseInt(parts[0]);m = parseInt(parts[1]);if (parts[2].indexOf(".") != -1) {
var parts2 = parts[2].split(".");s = parseInt(parts2[0]);n = parseInt(parts2[1]);} else {
s = parseInt(parts[2]);}
break;case 4:
d = parseInt(parts[0]);h = parseInt(parts[1]);m = parseInt(parts[2]);if (parts[3].indexOf(".") != -1) {
var parts2 = parts[3].split(".");s = parseInt(parts2[0]);n = parseInt(parts2[1]);} else {
s = parseInt(parts[3]);}
break;}
ticks += (d * AjaxControlToolkitPlus.TimeSpan.TicksPerDay) +
(h * AjaxControlToolkitPlus.TimeSpan.TicksPerHour) +
(m * AjaxControlToolkitPlus.TimeSpan.TicksPerMinute) +
(s * AjaxControlToolkitPlus.TimeSpan.TicksPerSecond) +
(n * AjaxControlToolkitPlus.TimeSpan.TicksPerMillisecond);if(!isNaN(ticks)) {
return new AjaxControlToolkitPlus.TimeSpan(ticks);} 
throw Error.create(AjaxControlToolkitPlus.Resources.Common_DateTime_InvalidFormat);}
AjaxControlToolkitPlus.TimeSpan.fromTicks = function(ticks) { 
return new AjaxControlToolkitPlus.TimeSpan(ticks);}
AjaxControlToolkitPlus.TimeSpan.fromDays = function(days) { 
return new AjaxControlToolkitPlus.TimeSpan(days * AjaxControlToolkitPlus.TimeSpan.TicksPerDay);}
AjaxControlToolkitPlus.TimeSpan.fromHours = function(hours) { 
return new AjaxControlToolkitPlus.TimeSpan(hours * AjaxControlToolkitPlus.TimeSpan.TicksPerHour);}
AjaxControlToolkitPlus.TimeSpan.fromMinutes = function(minutes) { 
return new AjaxControlToolkitPlus.TimeSpan(minutes * AjaxControlToolkitPlus.TimeSpan.TicksPerMinute);}
AjaxControlToolkitPlus.TimeSpan.fromSeconds = function(seconds) { 
return new AjaxControlToolkitPlus.TimeSpan(minutes * AjaxControlToolkitPlus.TimeSpan.TicksPerSecond);}
AjaxControlToolkitPlus.TimeSpan.fromMilliseconds = function(milliseconds) { 
return new AjaxControlToolkitPlus.TimeSpan(minutes * AjaxControlToolkitPlus.TimeSpan.TicksPerMillisecond);}
AjaxControlToolkitPlus.TimeSpan.TicksPerDay = 864000000000;AjaxControlToolkitPlus.TimeSpan.TicksPerHour = 36000000000;AjaxControlToolkitPlus.TimeSpan.TicksPerMinute = 600000000;AjaxControlToolkitPlus.TimeSpan.TicksPerSecond = 10000000;AjaxControlToolkitPlus.TimeSpan.TicksPerMillisecond = 10000;AjaxControlToolkitPlus.TimeSpan.FullTimeSpanPattern = "dd:hh:mm:ss.nnnn";AjaxControlToolkitPlus.TimeSpan.ShortTimeSpanPattern = "hh:mm";AjaxControlToolkitPlus.TimeSpan.LongTimeSpanPattern = "hh:mm:ss";Date.prototype.getTimeOfDay = function Date$getTimeOfDay() {
return new AjaxControlToolkitPlus.TimeSpan(
0, 
this.getHours(), 
this.getMinutes(), 
this.getSeconds(), 
this.getMilliseconds());}
Date.prototype.getDateOnly = function Date$getDateOnly() {
return new Date(this.getFullYear(), this.getMonth(), this.getDate());}
Date.prototype.add = function Date$add(span) {
return new Date(this.getTime() + span.getTotalMilliseconds());}
Date.prototype.subtract = function Date$subtract(span) {
return this.add(span.negate());}
Date.prototype.getTicks = function Date$getTicks() {
return this.getTime() * AjaxControlToolkitPlus.TimeSpan.TicksPerMillisecond;}
AjaxControlToolkitPlus.FirstDayOfWeek = function() {
}
AjaxControlToolkitPlus.FirstDayOfWeek.prototype = {
Sunday : 0,
Monday : 1,
Tuesday : 2,
Wednesday : 3,
Thursday : 4,
Friday : 5,
Saturday : 6,
Default : 7
}
AjaxControlToolkitPlus.FirstDayOfWeek.registerEnum("AjaxControlToolkitPlus.FirstDayOfWeek");