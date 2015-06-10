Cookies = require 'cookies-js'
QueryString = require 'querystring'

###
  Renders the body content if, and only if, there is a current authenticated user present. The current user is
  exposed to the context. Reads the local authentication cookie, and only works internally.

  Example:

      <glg-current-user username="{{username}}" user="{{user}}">
        <template is="dom-if" if="{{user}}">
          <span>
            Hello <b>{{user.firstName}}</b> from <span>{{user.city}}</span>!
          </span>
        </template>
      </glg-current-user>

  @demo glg-current-user/demo/index.html
###

Polymer
  is: 'glg-current-user'

  ###
    Fired when the user is fetched.

    @event user-changed
  ###

  properties:
    ###
      Epiquery url used to get user details.  See the [template](https://github.com/glg/epiquery-templates/blob/prod/glgCurrentUser/getUserByLogin.mustache) for the available properties
      exposed on the `User` object.
    ###
    url:
      type: String
      value: "https://query.glgroup.com/glgCurrentUser/getUserByLogin.mustache"
    ###
      Computed property that gets updated when the `username` changes.
    ###
    qs:
      type: Object
      computed: '_buildQueryString(username)'
      value: ''
    ###
      Set this to fetch a user explicitly.
    ###
    username:
      type: String
      value: ->
        if window.debugUserName then window.debugUserName else ''

        userParams = ''
        userParams = if (Cookies.get 'glgroot')? then QueryString.parse Cookies.get 'glgroot' else Cookies.get 'starphleet_user'
        userParams = Cookies.get('glgSAM') if not userParams

        if userParams?.hasOwnProperty['username']
          bits = userParams['username'].split '\\'
          userParams = if bits.length is 2 then bits[1] else bits[0]

        console.log('username', userParams)

        return userParams
      observer: '_usernameChanged'
      notify: true
      reflect: true
    ###
      Property to bind to get the current user.
    ###
    user:
      type: Object
      notify: true

  _domainifyUsername: (name) ->
    if name.toLowerCase().indexOf('glgroup') is -1
      "glgroup\\#{name}"
    else
      name

  _handleUser: (evt) ->
    @user = evt.detail.response[0]

  _buildQueryString: (name) ->
    { login: @_domainifyUsername(name) }

  _usernameChanged: (name) ->
    console.log 'change', @username
    @user = window.glgUserCache[name] if window.glgUserCache[name]
    @debounce 'fetch', =>
      @$.xhr.generateRequest()
    , 200

  created: ->
    window.glgUserCache = window.glgUserCache or {}

  attached: ->
    console.log(@username)