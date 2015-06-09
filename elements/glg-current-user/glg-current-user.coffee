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

  @demo demo/index.html
###

Polymer
  is: 'glg-current-user'

  ###
    Fired when the user is fetched.

    @event user-changed
  ###

  properties:
    ###
      Epiquery url used to get user details.  See the template for the available properties
      exposed on the {User} object
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
      value: ''
      observer: '_usernameChanged'
    ###
      Property to bind to get the current user.
    ###
    user:
      type: Object
      notify: true

  ###
    Attempts to read the current username from internal GLG cookies and fetch
    that user's details.
  ###
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
    @user = window.glgUserCache[name] if window.glgUserCache[name]

    return if name == ''

    @debounce 'fetch', =>
      @$.xhr.generateRequest()
    , 200

  attached: ->
    if window.debugUserName
      @username = window.debugUserName
    else
      @getCurrentUser()

  created: ->
    window.glgUserCache = window.glgUserCache or {}