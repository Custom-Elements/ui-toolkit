# glg-current-user
Fetches data all about the current user.

    Cookies = require 'cookies-js'
    QueryString = require 'querystring'

    Polymer
      is: 'glg-current-user'

      properties:
        url:
          type: String
          value: "https://query.glgroup.com/glgCurrentUser/getUserByLogin.mustache"
        qs:
          type: Object
          computed: 'buildQueryString(username)'
        username:
          type: String
          value: ''
        user:
          type: Object
          notify: true

##Observers

      buildQueryString: (name) ->
        return @qs if name == ''
        @user = window.glgUserCache[name] if window.glgUserCache[name]
        return { login: @domainifyUsername(name) }

## Methods

###getCurrentUser
Fetch full details for the current user by reading the auth cookie, and fetching them from the database.

      getCurrentUser: ->
        userParams = if (Cookies.get 'glgroot')? then QueryString.parse Cookies.get 'glgroot' else Cookies.get 'starphleet_user'

        if not userParams
          userParams = Cookies.get 'glgSAM'
        if userParams
          if userParams['username']?
            bits = userParams['username'].split '\\'
            @username = if bits.length is 2 then bits[1] else bits[0]
          else
            @username = userParams

###domainifyUsername
Appends glgroup to the username if not present

      domainifyUsername: (name) ->
        if name.toLowerCase().indexOf('glgroup') is -1
          "glgroup\\#{name}"
        else
          name

## Handlers

###getUserDetails
iron-ajax handler for epiquery response

      handleUser: (evt) ->
        @user = evt.detail.response[0]

## Polymer Lifecycle

      attached: ->
        if window.debugUserName
          @username = window.debugUserName
        else
          @getCurrentUser()

      created: ->
        window.glgUserCache = window.glgUserCache or {}