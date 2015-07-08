###
  This is a pill to display tag and short information. Also, includes
  a deletable behavior.

  @demo elements/glg-pill/demo/index.html
###

moment = require('moment')
_ = require('lodash')

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
    @realDays = @getRealDays()
    @monthString = @date.format("MMMM")

    @CalPositions = [0..41]
    # @meetings = [{Date: '2015-02-08 09:30:26', title: 'blah' }]

  minusMonth: ->
    @moveMonth(-1)

  plusMonth: ->
    @moveMonth(1)

  moveMonth: (num) ->
    @date = @date.add(num, 'M')
    @month = @date.month()
    @year = @date.year()
    @firstofmonth = @getWeekDay(1)
    @lastofmonth = @getWeekDay(@date.daysInMonth())
    
    @realDays = @getRealDays()
    @monthString = @date.format("MMMM")

  getCalPosArray: () ->

  getStartOfMonth: ->
    @date.startOf("month")

  getWeekDay: (day) ->
    @getStartOfMonth().date(day).format("d")

  getRealDay: (calPos, month) ->
    pos = @realDays[calPos].daynum

  getMeetings: (week, dayPos, month) ->
    return _.filter @meetings, (m) => moment(m.Date).format('MM/DD/YYYY') == @date.day(getRealDay(week, day, month)).format('MM/DD/YYYY')

  getRealDays: ->
    realDays = []
    daynum = 0
    for i in [0..41]
      active = false
      if (i >= @firstofmonth && daynum < @getStartOfMonth().daysInMonth())
        daynum++
        active = true
      realDays.push {daynum, active}
    realDays

  getWeekPos: (num) ->
    weekDays = []
    for i in [(num * 7)..((num + 1) * 7 - 1)]
      weekDays.push i
    weekDays  

  getDayClasses: (calPos, month) ->
    day = @realDays[calPos]
    active = if !(day.active) then " fakeday" else ""
    current = if (day.daynum == moment().date() and @year == moment().year() and @month == moment().month()) then " currentDay" else ""
    minusleft = if(calPos % 7 == 0) then " minusleft" else ""
    bottom = if(_.indexOf(@getWeekPos(5), calPos) > -1) then " plus-bottom" else ""

    "day#{active}#{current}#{minusleft}#{bottom}"


)