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
    },

    selected: {
      type: Array,
      notify: true
    }

    month: {
      type: Number,
      value: () -> return moment().month(),
      notify: true
    },

    year: {
      type: Number,
      value: () -> return moment().year(),
      notify: true
    }
  },

  listeners: {
    'minusMonth.click': 'minusMonth',
    'plusMonth.click': 'plusMonth',
    'minusMonthMobile.click': 'minusMonth',
    'plusMonthMobile.click': 'plusMonth'

  }, 
  observers: [
    'meetingsChanged(meetings)'
  ],  


  ready: ->
    @date = moment()
    @firstofmonth = @getWeekDay(1)
    @lastofmonth = @getWeekDay(@date.daysInMonth())
    @meetingDays = [1..@date.daysInMonth()]
    @realDays = @getRealDays()
    @monthString = @date.format("MMMM")
    @CalPositions = [0..41]

  #Events
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

  meetingClick: (event) ->
    console.log(event.model.meeting)
    @fire('consultationSelected', detail: {'consultations': event.model.meeting});

  dayClick: (event) ->
    @selected = @meetings[@getRealDay(event.model.calPos-1)]
    @fire('dayClicked', detail: {'date': @getRealDay(event.model.calPos), 'month': @month})

  #calendar functions
  getStartOfMonth: ->
    @date.startOf("month")

  getMonthLabel: (date, month) ->
    label = moment().date(date).format("Do")

  getWeekDay: (day) ->
    @getStartOfMonth().date(day).format("d")

  getRealDay: (calPos, month) ->
    pos = @realDays[calPos].daynum

  isRealDay: (calPos) ->
    bool = if @realDays[calPos].active == true then true else false

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


  #meeting functions
  getMeetings: (calPos, meetings, month) ->
    if (meetings.length && @getRealDay(calPos))
      return _.take(meetings[@getRealDay(calPos)-1],4)

  getMeetingsLength: (calPos, meetings, month) ->
    if (meetings.length && @getRealDay(calPos))
      dayMeetings = meetings[@getRealDay(calPos)-1]
      return 0 if !dayMeetings || dayMeetings.length-4 <= 0
      return dayMeetings.length-4

  getMeetingsDuringDay: (day, meetings) ->
    @meetings[day-1]

  getMeetingTimeFromDate: (date) ->
    time = moment(date).format("hA")  

  getMeetingTimeFromMeeting: (meeting) ->
    time = moment(meeting.date).format("ha")  

  getMeetingTypeIcon: (meeting) ->
    type = if meeting.type == 'consultation' then "phone" else "calendar"
    "meeting-icon icon-#{type}"

  isMeetingIntervalUsed: (day, meetings) ->
    if @meetings[day-1] && @meetings[day-1].length  
      return true 
    else 
      return false

  getMeetingClass: (meeting) ->
    highlight = if (meeting.highlight) then ' highlight' else ''
    "meeting#{highlight}"

)