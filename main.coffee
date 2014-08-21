$(document).ready ->
  $(document).on "touchmove", (e) ->
    e.preventDefault()

  scroll = new IScroll(".super-container", {
    indicators: [{
      el: $(".parallax-bg")[0],
      resize: false,
      ignoreBoundaries: true,
      speedRatioY: 0.4
    }]
  })