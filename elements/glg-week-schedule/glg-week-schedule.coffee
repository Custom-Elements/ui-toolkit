###
  This is a schedule to display information on a given interval. Also,
  includes functions to determine usage and array disection.

  @demo elements/glg-week-schedule/demo/index.html
###

moment = require('moment')
_ = require('lodash')

Polymer(
  is: 'glg-week-schedule',

  properties: {
    week: {
      type: Number,
      value: () -> return moment().week()
    },
    year: {
      type: Number,
      value: () -> return moment().year()
    },
    meetings: {
      type: Array,
      value: () -> return []
    }
    meetings: {
      type: Array,
      value: () -> return []
    }
  },
  listeners: {
    'minusWeek.click': 'minusWeek',
    'plusWeek.click': 'plusWeek',

  }, 
  observers: [
    'meetingsChanged(meetings)'
  ],  

  ready: ->
    @dayArr = [0..6]
    @hourArr = [0..23]
    @height = 0 

  attached: ->
    @async(() ->
      @height = parseInt(window.getComputedStyle(document.getElementById(moment().hour())).height) / (60 / moment().minute())
    ,1)

  meetingsChanged: (meetings) ->
    updatedMeetings = []
    _.each meetings, (meeting) =>
      meeting.OtherMeetingsDuringTimeFrame = _.filter(meetings, (otherMeeting) -> 
        moment(meeting.date) <= moment(otherMeeting.end) && moment(meeting.end) >= moment(otherMeeting.date)).length
      updatedMeetings.push(meeting)
    @updatedMeetings = updatedMeetings

  minusWeek: () ->
    @week = @week - 1

  plusWeek: () ->
    @week = @week + 1

  getMonth: (week) ->
    moment().week(@week).format("MMMM")

  getRealDate: (dayPos) ->
    moment().week(@week).day(dayPos)

  getRealHour: (hourPos) ->
    moment().week(@week).hour(hourPos)

  getHourLabel: (hourPos, week) ->
    @getRealHour(hourPos).format("h A")

  getDateLabelOne: (dayPos, week) ->
    moment(@getRealDate(dayPos)).format("ddd")

  getDateLabelTwo: (dayPos) ->
    moment(@getRealDate(dayPos)).format("D")

  getDayClasses: (dayPos, week) ->
    if moment().isSame(@getRealDate(dayPos)) then "currentDayLabel" else ""

  isCurrentHour: (hourPos) ->
    @getRealHour(hourPos).hour() == moment().hour()

  getWeekDayClasses: (dayPos) ->
    weekend = if dayPos == 0 || dayPos == 6 then " weekend" else ""
    current = if moment().isSame(@getRealDate(dayPos)) then " current" else ""
    endweek = if dayPos == 6 then " endweek" else ""
    "week-hour weekday#{weekend}#{current}#{endweek}"

  getMeetingStyles: (hourPos, dayPos, meetings) ->
    width = 100/(@getPlaceholderMeetings(hourPos, dayPos, meetings).length +  @getMeetingsDuring(hourPos, dayPos, meetings).length)
    "width:#{width}%"

  getTLPadding: (height) ->
    "padding-top: #{@height}px"

  getWeekHourId: (dayPos, hourPos) ->
    "#{hourPos},#{dayPos}"

  getMeetings: (dayPos, hourPos, meetings) ->
    realHour = @getRealHour(hourPos)
    meetingArr = _.map(meetings,(meeting) -> {'meetingId': meeting.id, 'day': moment(meeting.date).day(), 'hour': moment(meeting.date).hour(), 'minute': moment(meeting.date).minute(), 'title': meeting.title, 'type': meeting.type, 'end': meeting.end})
    meetingArr = _.filter meetingArr ,(meeting) -> meeting.day == dayPos && meeting.hour == hourPos
    meetingArr = _.sortByAll(meetingArr, ['hour','minute'])

  getMeetingsDuring: (hourPos, dayPos, meetings) ->
    _.filter meetings, (meeting) -> moment(meeting.date).hour() <= hourPos <= moment(meeting.end).hour() && dayPos == moment(meeting.date).day()

  getByHour: (hourPos, meetings) ->
    realHour = @getRealHour(hourPos)
    meetingArr = _.map meetings,(meeting) -> {'meetingId': meeting.id,'hour': moment(meeting.date).format("H"), 'minute': moment(meeting.date).format("m"), 'day': moment(meeting.date).day()}
    meetingArr = _.filter meetingArr ,(meeting) -> meeting.hour == realHour.format("H")
    meetingArr = _.sortBy(meetingArr, 'minute')
    meetingArr

  filterByDay: (meetingArr, dayPos) ->
    meetingArr = _.filter meetingArr ,(meeting) -> meeting.day == dayPos
    meetingArr
  
  getPlaceholderMeetings: (hourPos, dayPos, meetings) ->
    meetingArr = @getMeetingsDuring(hourPos, dayPos, meetings)
    if meetingArr.length
      return [] if meetingArr[0].OtherMeetingsDuringTimeFrame - meetingArr.length <= 0
      return [0..meetingArr[0].OtherMeetingsDuringTimeFrame - meetingArr.length - 1]

  isMeetingStart: (hourPos, meeting) ->
    moment(meeting.date).hour() == hourPos

)