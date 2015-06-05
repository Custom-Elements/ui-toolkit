# &lt;glg-current-user&gt;

Renders the body content if, and only if, there is a current authenticated user present. The current user is
exposed to the context. Reads the local authentication cookie, and only works internally.

See [src/glg-current-user.litcoffee](src/glg-current-user.litcoffee) for more details.


## Available Properties

  * firstName
  * middleInitial
  * lastName
  * loginName
  * email
  * personId
  * title
  * phoneMain
  * extension
  * fax
  * street1
  * street2
  * city
  * state
  * zip
  * userId (number)
  * personId (number)
  * phone
  * mobile
  * betagroups (array)

### Typical Usage (>= Polymer 1.0)

```html
  <template is="dom-bind">
    <paper-input label="Enter a username" value="{{username}}"></paper-input>
    <glg-current-user username="{{username}}" user="{{user}}" id="simple"></glg-current-user>
    <template is="dom-if" if="{{user}}">
      <span>
        Welcome <b>{{user.firstName}}</b> from <span>{{user.city}}</span>!
      </span>
    </template>
  </template>
```

### Debugging

Both `glg-user` and `glg-current-user` have debug properties.

Assign to `window.debugUserName` to force the `glg-current-user` username.
Assign to `window.glgUserCache[USERNAMEHERE]` to force the `glg-user`
`currentuser` property.
