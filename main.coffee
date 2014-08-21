$(document).ready ->
  $(document).on "touchmove", (e) ->
    e.preventDefault()


  # cache
  $sections = $(".section")
  $parent = $sections.parent()
  $superContainer = $(".super-container")
  $fakeHeader = null



  distToTops = $(".profile-container").offset().top
  nthSection = null
  lastScrollPos = 0


  sectionTops =  (- $(section).offset().top for section in $sections)

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

  mainScroll.on "scrollEnd", ->
    return

  mainScroll.on "scroll", ->
    if nthSection is null
      if this.y < sectionTops[0]
        nthSection = 0
        fixHeader($sections.eq(nthSection))
    else
      if this.y < sectionTops[nthSection + 1]
        nthSection += 1
        fixHeader($sections.eq(nthSection))
      else if this.y > sectionTops[nthSection]
        nthSection -= 1
        fixHeader($sections.eq(nthSection))

  fixHeader = ($section) ->
    $fakeHeader = $section
      .find(".header")
      .clone()
      .addClass("attached")
      .appendTo($superContainer)

