class app.FormResponse
  constructor: (options = {}) ->
    @selector = options.selector  || throw new Error "You must specify an ID"
    @el = $("#{@selector}")
    @fill = options.fill || false
    @fixed = options.fixed || false

  show: (options = {}) ->
    _self = @
    @el.find(".form-response-holder").remove()
    @el.prepend JST["includes/form_response/template"]($.extend({}, options, {fill: @fill, fixed: @fixed}))
    $el_icon = @el.find('.form-response .icon')
    @el.find(".form-response .msg").html options.message

    if options.icon_class
      $el_icon.removeClass()
      $el_icon.addClass options.icon_class
    
    @el.find('.form-response').addClass('show')
    if options.auto_hide
      @hide(
        delay: options.auto_hide
      )

    if @fill
      @el.find(".form-response-holder").css({height: @el.height()})
    else if @fixed
      @el.find(".form-response-holder").css({height: $(window).height()})
      $(window).on 'resize', ->
        _self.el.find(".form-response-holder").css({height: $(window).height()})

  hide: (options = {})->
    _self = @
    setTimeout(
      (->
        _self.el.find('.form-response').removeClass('show');
      )
      options.delay
    )
    setTimeout (-> _self.el.find('.form-response-holder').remove()), (options.delay+100)