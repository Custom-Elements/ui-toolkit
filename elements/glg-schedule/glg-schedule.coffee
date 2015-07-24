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
    date: {
      type: Number,
      value: () -> return moment().date()
    },
    month: {
      type: Number,
      value: () -> return moment().month()
    },
    year: {
      type: Number,
      value: () -> return moment().year()
    }

    meetings:{
      type: Array
    }

  },

  ready: ->
    @meetingHours = [0..12]
    
  getMeetingTime: (hour, minute) ->
    moment().hour(hour).minute(minute).format("h:mm")

  getRealHour: (hourPos) ->
    moment().hour(hourPos + 6).minute(0)

  getReadableHour: (hourPos) ->
    moment(@getRealHour(hourPos)).format("hA")

  getReadableMonth: (month) ->
    moment().month(month).format("MMMM")

  getReadableDate: (date) ->
    moment().date(date).format("Do")

  isMeetingIntervalUsed: (hourPos) ->
    _.includes(_.map(@meetings,(meeting) -> moment(meeting.date).format("H")), @getRealHour(hourPos).format("H"))

  getMeetingsDuringHour: (hourPos) ->
    realHour = @getRealHour(hourPos)
    meetingArr = _.map(@meetings,(meeting) -> {'meetingId': meeting.id, 'hour': moment(meeting.date).format("H"), 'minute': moment(meeting.date).format("m"), 'title': meeting.title, 'type': meeting.type})
    meetingArr = _.filter(meetingArr ,(meeting) -> meeting.hour == realHour.format("H"))
    meetingArr = _.sortBy(meetingArr, 'minute')

  getMeetingTypeIcon: (meeting) ->
    type = if meeting.type == 'consultation' then "phone" else "calendar"
    "meeting-icon icon-#{type}"

  meetingClick: (event) ->
    @fire('consultationSelected', detail: {'consultations': event.model.meeting});

  switchToCalendar: (event) ->
    @fire('switchToCalendar')

)