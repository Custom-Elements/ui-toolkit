###
  This is a pill to display tag and short information. Also, includes
  a deletable behavior.

  @demo elements/glg-pill/demo/index.html
###

moment = require('moment')

Polymer(
  is: 'glg-calendar',
  
  listeners: {
    'minusMonth.tap': 'minusMonth',
    'plusMonth.tap': 'plusMonth'
  },  

  ready: ->
    @date = moment()
    @month = @date.month()
    @year = @date.year()
    @firstofmonth = @getWeekDay(1)
    @lastofmonth = @getWeekDay(@date.daysInMonth())
    @realDays = @getMonthArray()
    @monthString = @date.format("MMMM")
    @weekArr = [0,1,2,3,4,5]
    @dayArr = [0,1,2,3,4,5,6]

  minusMonth: ->
    @moveMonth(-1)

  plusMonth: ->
    @moveMonth(1)

  moveMonth: (num) ->
    @date = @date.month(@date.month() + num)
    @month = @date.month()
    @year = @date.year()
    @firstofmonth = @getWeekDay(1)
    @lastofmonth = @getWeekDay(@date.daysInMonth())
    @realDays = @getMonthArray()
    @monthString = @date.format("MMMM")

  getStartOfMonth: ->
    @date.startOf("month")

  getWeekDay: (day) ->
    @getStartOfMonth().date(day).format("d")

  getRealDay: (weekPos, dayPos, month) ->
    pos = @realDays[(weekPos * 7) + dayPos].daynum

  getMonthArray: ->
    realDays = []
    daynum = 0
    for i in [0..41]
      active = false
      if (i >= @firstofmonth && daynum < @getStartOfMonth().daysInMonth())
        daynum++
        active = true
      realDays.push {daynum, active}
    realDays

  getDayClasses: (weekPos, dayPos, month) ->
    day = @realDays[(weekPos * 7) + dayPos]
    active = if !(day.active) then " fakeday" else ""
    current = if (day.daynum == moment().date() and @year == moment().year() and @month == moment().month()) then " currentDay" else ""
    bottom = if(weekPos == 5) then " plus-bottom" else ""

    "day#{active}#{current}#{bottom}"


)