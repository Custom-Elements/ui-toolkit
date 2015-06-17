###
  This is a pill to display tag and short information. Also, includes
  a deletable behavior.

  @demo elements/glg-pill/demo/index.html
###

Polymer(
  is: 'glg-pill'

  behaviors: [
    Polymer.PaperButtonBehavior
  ]

  properties:
    ###
     If true, the button should be styled with a shadow.
    ###
    raised:
      type: Boolean
      reflectToAttribute: true
      value: false
      observer: '_calculateElevation'

  _calculateElevation: () ->
    if (!@raised)
      @_elevation = 0
    else
      Polymer.PaperButtonBehaviorImpl._calculateElevation.apply(@)

  _computeContentClass: (receivedFocusFromKeyboard) ->
    className = 'content '
    if (receivedFocusFromKeyboard)
      className += ' keyboard-focus'
    return className
)