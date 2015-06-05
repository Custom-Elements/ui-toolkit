# glg-avatar
Fetches data all about the current user.

    Polymer
      is: 'glg-avatar'

      properties:
        username:
          type: String
          value: ''
        user:
          type: Object
          notify: true