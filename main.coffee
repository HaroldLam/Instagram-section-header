$(document).ready ->
  $(document).on "touchmove", (e) ->
    e.preventDefault()

  scroll = new IScroll(".super-container")