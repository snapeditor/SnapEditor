define ["jquery.custom", "core/browser"], ($, Browser) ->
  class Link
    register: (@api) ->

    getUI: (ui) ->
      link = ui.button(action: "link", description: "Insert Link", shortcut: "Ctrl+K", icon: { url: @api.assets.image("link.png"), width: 24, height: 24, offset: [3, 3] })
      return {
        "toolbar:default": "link"
        link: link
      }

    getActions: ->
      return {
        link: @link
      }

    getKeyboardShortcuts: ->
      return {
        "ctrl.k": "link"
      }

    # TODO:
    # NOTE:
    # You cannot use this method to call up a prompt because the preventDefault()
    # does not work properly in Firefox. The default action (go to search box)
    # still fires for some reason. The solution is probably to use our own
    # input boxes so we'll have to do that by ourself later. For now, we just
    # use default 'http://'
    #
    # I did try using the setTimeout but in Firefox, the function loses its
    # context making it difficult to locate the insertLinkDialog method that
    # we used to launch the prompt. IE isn't the only quirky browser.
    #
    # TODO: In opera, preventDefault doesn't work so it keeps popping up a dialog.
    link: =>
      if @api.isValid()
        href = prompt("Enter URL of link", "http://")
        if href
          href = $.trim(href)
          parentLink = @api.getParentElement("a")
          # if a parentLink is found, then just change the href
          if parentLink
            $(parentLink).attr("href", href)
          # if range is collapsed, then insert a new link
          else if @api.isCollapsed()
            link = $("<a href=\"#{href}\">#{href}</a>")
            @api.paste(link[0])
          # if range is not collapsed, then surround contents with the new link
          else
            link = $("<a href=\"#{href}\"></a>")
            @api.surroundContents(link[0])
          @update()

    update: ->
      @api.clean()
      @api.update()

  return Link
