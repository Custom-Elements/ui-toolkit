###
  Displays an avatar for the current user.

    <template is="dom-bind">
      <paper-input label="Enter a username" value="{{username}}"></paper-input>
      <glg-avatar username="{{username}}"></glg-avatar>
    </template>

  @demo glg-avatar/demo/index.html
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
      Set this to fetch a user explicitly.
    ###
    username:
      type: String
      notify: true
      value: ->
        if window.debugUserName then window.debugUserName else ''
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

  _color: ->
    @colors[Math.floor(Math.random()*@colors.length)]

  _initials: (user) ->
    return '' unless user
    "#{user.firstName[0]}#{user.lastName[0]}"
