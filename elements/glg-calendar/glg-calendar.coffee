###
  This is a pill to display tag and short information. Also, includes
  a deletable behavior.

  @demo elements/glg-pill/demo/index.html
###

moment = require('moment')

Polymer(
  is: 'glg-calendar',
    
  ready: ->
    @date = moment()
    @month = @date.month()
    @year = @date.year()
    @firstofmonth = @getWeekDay(1)
    @lastofmonth = @getWeekDay(moment().daysInMonth())
    @realDays = @getMonthArray()
    @monthString = @date.format("MMMM")
    @weekArr = [0,1,2,3,4,5]
    @dayArr = [0,1,2,3,4,5,6]

  moveMonth: (num) ->
    alert("hi")
    @date = @date.add("month", -1)

  getStartOfMonth: ->
    @date.startOf("month")

  getWeekDay: (day) ->
    @getStartOfMonth().date(day).format("d")

  getRealDay: (weekPos, dayPos) ->
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

  getDayClasses: (weekPos, dayPos) ->
    day = @realDays[(weekPos * 7) + dayPos]
    active = if !(day.active) then " fakeday" else ""
    current = if (day.daynum == moment().date() and @month = moment().month()) then " currentDay" else ""

    "day#{active}#{current}"


)