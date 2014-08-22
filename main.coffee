$(document).ready ->
  $(document).on "touchmove", (e) ->
    e.preventDefault()


  # cache
  $sections = $(".section")
  $parent = $sections.parent()
  $superContainer = $(".super-container")
  $fakeHeader = null
  $firstHeaderImg = $sections.eq(0).find("img")
  $parallaxBgImg = $(".parallax-bg img")



  distToTops = $(".profile-container").offset().top
  nthSection = null
  lastScrollPos = 0


  sectionTops =  (- $(section).offset().top for section in $sections)
  sectionHeights = ($(section).find(".header").height() for section in $sections)

  # page setup
  $firstHeaderImg.css("-webkit-transform", "translate3d(0, -#{distToTops}px, 0)")

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
        affixHeader($sections.eq(nthSection))
      else
        # blurry header parallax
        displacement = this.y * 0.2 - this.y - 200
        $firstHeaderImg.css("-webkit-transform", "translate3d(0, #{displacement}px, 0)")
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
      else
        # prevent `slippage` when scrolling too fast
        $fakeHeader.css("-webkit-transform", "translate3d(0, 0, 0)")

  affixHeader = ($section) ->
    if $fakeHeader
      $fakeHeader.remove()
    $fakeHeader = $section
      .find(".header")
      .clone()
      .addClass("affixed")
      .appendTo($superContainer)

