###
  This is an implementation of a material design style tooltip. You wrap
  it around an element you want to tip on hover, and include an additional
  section for the tip content.

  Any content you like can be the toolitp, just mark it with the attribute
  `tip`.

  ```html
  <glg-tooltip>
    <iron-icon icon="menu"></icon-icon>
    <span tip>This is a tooltip!</span>
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

  properties:
    ###
      This configures a `show` and `hide` animation using `Polymer.NeonAnimationRunnerBehavior`.
    ###
    animationConfig:
      value: ->
        show:
          name: 'scale-up-animation'
          node: @tipHolder
        hide:
          name: 'fade-out-animation'
          node: @tipHolder
    ###
     Show the tooltip. Or not. Your call.
    ###
    showtip:
      type: Boolean
      reflectToAttribute: true
      observer: '_onshowTip'

  ###
    When creating, we need an element at root of the page to allow the
    tooltip to hover over anything.
  ###
  created: ->
    @tipHolder = document.createElement 'section'

  attached: ->
    document.querySelector('body').appendChild @tipHolder

  detached: ->
    @tipHolder.remove()

  _onshowTip: ->
    if @showtip
      @tipHolder.removeAttribute 'hidden'
      @_position()
      @playAnimation 'show'
    else
      @playAnimation 'hide'

  _onNeonAnimationFinish: ->
    if not @showtip
      @tipHolder.setAttribute 'hidden', ''

  _onMouseEnter: ->
    @showtip = true

  _onMouseLeave: ->
    @showtip = false

  ###
    Tooltips appear relative to the wrapped element based on screen position
    with a simple 9 square blocking system to figure if an element is mostly
    in the upper left, or lower right, and then push the tooltip in the
    opposite direction to make sure it can be seen.

    And -- the tooltip is positioned fixed into the containing page so that it
    really floats above the wrapped element, this way it works even if you
    end up bumping an over the edge of a `overflow: hidden;`.
  ###
  _position: ->
    all = @getBoundingClientRect()
    body = document.querySelector('body').getBoundingClientRect()
    xStep = document.documentElement.clientWidth / 3
    yStep = document.documentElement.clientHeight / 3

    @tipHolder.style.cssText = window.getComputedStyle(@$.tooltip).cssText
    @tipHolder.style.display = 'inline-flex'
    @tipHolder.style.position = 'fixed'
    if all.top < xStep*2
      @tipHolder.style.left = "#{all.left + (all.right - all.left) / 2}px"
    else
      @tipHolder.style.right = "#{all.right - (all.right - all.left) / 2}px"
    if all.top < yStep*2
      @tipHolder.style.top = "calc(#{all.bottom}px + 1em)"
    else
      @tipHolder.style.bottom = "calc(#{all.top}px - 1em)"
    @tipHolder.innerHTML = @$.tooltip.innerHTML
