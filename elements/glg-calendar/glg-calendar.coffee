###
  This is a pill to display tag and short information. Also, includes
  a deletable behavior.

  @demo elements/glg-pill/demo/index.html
###

moment = require('moment')
_ = require('lodash')

Polymer(
  is: 'glg-calendar',
  
  properties: {
    meetings: {
      type: Array,
      value: () -> return []
    }
  },

  listeners: {
    'minusMonth.tap': 'minusMonth',
    'plusMonth.tap': 'plusMonth'
  },  
  observers: [
    'meetingsChanged(meetings)'
  ],  


  ready: ->
    @date = moment()
    @month = @date.month()
    @year = @date.year()
    @firstofmonth = @getWeekDay(1)
    @lastofmonth = @getWeekDay(@date.daysInMonth())
    @realDays = @getRealDays()
    @monthString = @date.format("MMMM")
    @CalPositions = [0..41]

  meetingsChanged: () ->

  minusMonth: ->
    @moveMonth(-1)

  plusMonth: ->
    @moveMonth(1)

  moveMonth: (num) ->
    @date = @date.add(num, 'M')
    @year = @date.year()
    @firstofmonth = @getWeekDay(1)
    @lastofmonth = @getWeekDay(@date.daysInMonth())
    @realDays = @getRealDays()
    @month = @date.month()
    @monthString = @date.format("MMMM")

  getStartOfMonth: ->
    @date.startOf("month")

  getWeekDay: (day) ->
    @getStartOfMonth().date(day).format("d")

  getRealDay: (calPos, month) ->
    pos = @realDays[calPos].daynum

  getMeetings: (calPos, meetings, month) ->
    return _.filter meetings, (m) => 
      moment(m.Date).format('MM/DD/YYYY') == @date.date(@getRealDay(calPos)).format('MM/DD/YYYY') if (@getRealDay(calPos))

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