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
    @meetings = [{'date':'2015-07-08 13:29:26','title':'Show me the money meeting with Will and George'}, {'date':'2015-07-08 9:29:26','title':'Coffee time with Kevin'}, {'date':'2015-07-08 09:31:26','title':'Consultation with the restroom'}, {'date':'2015-07-08 09:30:26','title':'Pounding face on desk in frustration'}]

  getMeetingTime: (hour, minute) ->
    moment().hour(hour).minute(minute).format("h:mm")

  getRealHour: (hourPos) ->
    moment().hour(hourPos + 6).minute(0)

  getHalfHour: (hourPos) ->
    @getRealHour(hourPos).minute(30).format("h:mm A")

  getReadableHour: (hourPos) ->
    moment(@getRealHour(hourPos)).format("hA")

  isMeetingIntervalUsed: (hourPos) ->
    used = if _.includes(_.map(@meetings,(meeting) -> moment(meeting.date).format("H")), @getRealHour(hourPos).format("H")) then true else false

  getMeetingsDuring: (hourPos) ->
    realHour = @getRealHour(hourPos)
    meetingArr = _.map(@meetings,(meeting) -> {'hour': moment(meeting.date).format("H"), 'minute': moment(meeting.date).format("m"), 'title': meeting.title})
    meetingArr = _.filter(meetingArr ,(meeting) -> meeting.hour == realHour.format("H"))
    meetingArr = _.sortBy(meetingArr, 'minute')
    meetingArr

  # insertHalfHour: (meetingInterval, pos) ->
  #   bool = false
  #   if pos != 0
  #     meetingArr = @getMeetingsDuring(meetingInterval)
  #     bool = if @isBeforeHalfHour(meetingArr[pos - 1]) and !@isBeforeHalfHour(meetingArr[pos]) then true else false
  #   bool      

  isBeforeHalfHour: (meetingObj) ->
    bool = if meetingObj.minute < 30 then true else false

)