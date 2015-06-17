###
  Displays an avatar for the current user.

      <template is="dom-bind">
        <paper-input label="Enter a username" value="{{username}}"></paper-input>
        <glg-avatar username="{{username}}"></glg-avatar>
      </template>

  @demo elements/glg-avatar/demo/index.html
###

Polymer
  is: 'glg-avatar'

  colors: [
    'blue'
    'red'
    'amber'
    'green'
  ]

  properties:
    ###
      AWS Url for user image
    ###
    imageUrl:
      value: ''
      computed: '_imageUrl(username)'
      type: String
    imageUri:
      type: String
      value: ''
    ###
      Set this to fetch a user explicitly.
    ###
    username:
      type: String
      notify: true
    ###
      Property to bind to get the current user.
    ###
    user:
      type: Object
      notify: true
      value: null

    color:
      type: String
      computed: '_color(user)'
      value: 'blue'

    initials:
      type: String
      computed: '_initials(user)'
      value: ''

    showInitials:
      type: Boolean
      computed: '_showInitials(imageUri)'
      value: true

  _color: ->
    @colors[Math.floor(Math.random()*@colors.length)]

  _imageUrl: (username) ->
    return "" if username == ""
    "https://s3.amazonaws.com/employees.glg.it/#{username}/default-200.jpg?cb="

  _initials: (user) ->
    return '' unless user
    "#{user.firstName[0]}#{user.lastName[0]}"

  _setImage: (event) ->
    return unless event.detail.response
    arr = new Uint8Array event.detail.response
    raw = String.fromCharCode.apply null, arr
    b64 = btoa raw

    @imageUri = "data:image/jpeg;base64,#{b64}"

  _getBackgroundImage: (imageUri) ->
    return "" if imageUri == ""
    "background-image: url(#{imageUri}); background-color: rgba(0,0,0,0)"

  _showInitials: ->
    return true if @imageUri != ""
    return false