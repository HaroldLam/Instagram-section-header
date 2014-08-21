$(document).ready ->
  $(document).on "touchmove", (e) ->
    e.preventDefault()

  sectionTops = null
  distToTops = $(".profile-container").offset().top
  nthSection = 0
  lastScrollPos = 0

  # cache
  $sections = $(".section")
  $parent = $sections.parent()

  mainScroll = new IScroll(".super-container", {
    indicators: [{
      el: $(".parallax-bg")[0],
      resize: false,
      ignoreBoundaries: true,
      speedRatioY: 0.2
    }]
    HWCompositing: true
    probeType: 3
    mouseWheel: true
  })

  mainScroll.on "scrollStart", ->
    sectionTops = (
      - ($(section).offset().top - $parent.offset().top - distToTops) for section in $sections
    )

  mainScroll.on "scrollEnd", ->
    return

  mainScroll.on "scroll", ->
    if this.y < sectionTops[nthSection + 1]
      nthSection += 1
    else if this.y > sectionTops[nthSection - 1]
      nthSection -= 1

