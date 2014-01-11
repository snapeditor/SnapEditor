# Copyright (c) 2012-2013 8098182 Canada Inc. All rights reserved.
# For licensing, see LICENSE.
define ["core/range"], (Range) ->
  return {
    start: (api) ->
      api.el.contentEditable = true
      # IE includes annoying image resize handlers that cannot be removed.
      # Instead, we prevent any resizing from happening by preventing the
      # event.
      #
      # NOTE: The event handler must be attached and detached using native
      # JavaScript or it will not work.
      if api.el.addEventListener
        api.el.addEventListener("resizestart", @preventResize, false)
      else
        api.el.attachEvent("onresizestart", @preventResize)

    deactivateBrowser: (api) ->
      if api.el.removeEventListener
        api.el.removeEventListener("resizestart", @preventResize, false)
      else
        api.el.detachEvent("onresizestart", @preventResize)

    preventResize: (e) ->
      e.returnValue = false
  }
