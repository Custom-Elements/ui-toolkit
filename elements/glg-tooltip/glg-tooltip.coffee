###
  This is an implementation of a material design style tooltip. You wrap
  it around an element you want to tip on hover, and include an additional
  section for the tip content.

  ```html
  <glg-tooltip>
    <iron-icon icon="menu"></icon-icon>
    <tip>This is a tooltip!</tip>
  </glg-tooltip>
  ```

  @demo elements/glg-tooltip/demo/index.html
###

Polymer
  is: 'glg-tooltip'

  behaviors: [
    Polymer.NeonAnimationRunnerBehavior
  ]

  listeners:
    'neon-animation-finish': '_onNeonAnimationFinish'
    'mouseenter': '_onMouseEnter'
    'mouseleave': '_onMouseLeave'

  animationConfig:
    value: ->
      show:
        name: 'fade-in-animation'
        node: @
      hide:
        name: 'fade-out-animation'
        node: @

  properties:
    ###
     If true, the button should be styled with a shadow.
    ###
    showtip:
      type: Boolean
      reflectToAttribute: true
      value: false
      observer: '_onshowTip'

  _onshowTip: ->
    if @showtip
      @_position()
      @playAnimation 'show'
    else
      @playAnimation 'hide'

  _onNeonAnimationFinish: ->

  _onMouseEnter: ->
    @showtip = true

  _onMouseLeave: ->
    @showtip = false

  _position: ->
    tip = @getBoundingClientRect()
    body = document.querySelector('body').getBoundingClientRect()
    xStep = document.documentElement.clientWidth / 3
    yStep = document.documentElement.clientHeight / 3

    if @hasAttribute 'xposition'
      @$.tooltip.style.left = @getAttribute('xposition') + 'px'

    if @hasAttribute 'yposition'
      @$.tooltip.style.top = @getAttribute('yposition') + 'px'

    @$.tooltip.removeAttribute 'up'
    @$.tooltip.removeAttribute 'down'
    if tip.top < yStep*2
      @$.tooltip.setAttribute 'down', ''
    else
      @$.tooltip.setAttribute 'up', ''
