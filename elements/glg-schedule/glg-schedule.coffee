###
  This is a schedule to display information on a given interval. Also,
  includes functions to determine usage and array disection.

  @demo elements/glg-schedule/demo/index.html
###

moment = require('moment')
_ = require('lodash')

Polymer(
  is: 'glg-schedule',

  properties: {
    meetings: {
      type: Array,
      value: () -> return []
    },

    day: {
      type: Object,
      value: () -> return moment().date()
    }

  },

  ready: ->
    @meetingHours = [0..12]
    @meetings = [{'date':'2015-07-08 13:00:26','title':'Show me the money meeting with Will and George', 'type': 'consultation'}, {'date':'2015-07-08 9:29:26','title':'Coffee time with Kevin', 'type': 'event'}, {'date':'2015-07-08 09:31:26','title':'Consultation with the restroom', 'type': 'consultation'}, {'date':'2015-07-08 09:30:26','title':'Pounding face on desk in frustration', 'type': 'event'}]

  getMeetingTime: (hour, minute) ->
    moment().hour(hour).minute(minute).format("h:mm")

  getRealHour: (hourPos) ->
    moment().hour(hourPos + 6).minute(0)

  getReadableHour: (hourPos) ->
    moment(@getRealHour(hourPos)).format("hA")

  isMeetingIntervalUsed: (hourPos) ->
    used = if _.includes(_.map(@meetings,(meeting) -> moment(meeting.date).format("H")), @getRealHour(hourPos).format("H")) then true else false

  getMeetingsDuring: (hourPos) ->
    realHour = @getRealHour(hourPos)
    meetingArr = _.map(@meetings,(meeting) -> {'hour': moment(meeting.date).format("H"), 'minute': moment(meeting.date).format("m"), 'title': meeting.title, 'type': meeting.type})
    meetingArr = _.filter(meetingArr ,(meeting) -> meeting.hour == realHour.format("H"))
    meetingArr = _.sortBy(meetingArr, 'minute')
    meetingArr

  getMeetingTypeIcon: (meeting) ->
    console.log meeting
    type = if meeting.type == 'consultation' then "phone" else "calendar"
    "meeting-icon icon-#{type}"

)