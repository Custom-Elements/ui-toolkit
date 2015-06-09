# glg-avatar
Fetches data all about the current user.

    ###
        <paper-input label="Enter a username" value="{{username}}"></paper-input>

        <glg-avatar username="{{username}}">
        </glg-avatar>

        <paper-icon-item>
          <div class="avatar blue" item-icon></div> <span>{{username}}</span>
        </paper-icon-item>

    ###

    Polymer
      is: 'glg-avatar'

      properties:
        ###
          The glg username name to fetch from Epiquery
        ###
        username:
          type: String
          value: ''

        ###
          The {User} object
          - firstName
          - middleInitial
          - lastName
          - loginName
          - email
          - personId
          - title
          - phoneMain
          - extension
          - fax
          - street1
          - street2
          - city
          - state
          - zip
          - userId (number)
          - personId (number)
          - phone
          - mobile
          - betagroups (array)
        ###

        user:
          type: Object
          notify: true