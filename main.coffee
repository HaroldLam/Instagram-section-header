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
  sectionHeights = ($(section).find(".header").height() for section in $sections)

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
    # console.log sectionHeights
    # console.log this.y
    # console.log sectionTops[nthSection + 1] + sectionHeights[nthSection + 1]
    # console.log "===================="
    if nthSection is null
      if this.y < sectionTops[0]
        nthSection = 0
        affixHeader($sections.eq(nthSection))
    else
      if this.y < sectionTops[nthSection + 1]
        nthSection += 1
        affixHeader($sections.eq(nthSection))
      else if this.y < sectionTops[nthSection + 1] + sectionHeights[nthSection + 1]
        diff = this.y - sectionTops[nthSection + 1] - sectionHeights[nthSection + 1]
        $fakeHeader.css("-webkit-transform", "translate3d(0, #{diff}px, 0)")
      else if this.y > sectionTops[nthSection]
        if nthSection is 0
          if $fakeHeader
            $fakeHeader.remove()
            $fakeHeader = null
            nthSection = null
        else
          nthSection -= 1
          affixHeader($sections.eq(nthSection))

  affixHeader = ($section) ->
    if $fakeHeader
      $fakeHeader.remove()
    $fakeHeader = $section
      .find(".header")
      .clone()
      .addClass("affixed")
      .appendTo($superContainer)

