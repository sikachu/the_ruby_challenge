$ ->
  if $("#presentation-list").length > 0
    updateCurrent = ->
      window.localStorage["left-screen"] = $(".current .left").html()
      window.localStorage["right-screen"] = $(".current .right").html()

    moveToSlide = (slide) ->
      $("#presentation-list .current").removeClass("current")
      $(slide).addClass("current")
      $(document).scrollTo(slide, 500)
      updateCurrent()

    $("li:first", @).addClass("current")
    updateCurrent()

    $(document).on "keydown", (e) ->
      switch e.keyCode
        when 33, 37, 38 # Page Up, Left, Up
          e.preventDefault()
          previousItem = $("#presentation-list .current").prev()
          moveToSlide(previousItem) if previousItem.length > 0

        when 34, 39, 40 # Page Down, Right, Down
          e.preventDefault()
          nextItem = $("#presentation-list .current").next()
          moveToSlide(nextItem) if nextItem.length > 0

    $("#presentation-list li").on "click", ->
      moveToSlide(@)


  $("#presentation #left-screen, #presentation #right-screen").each ->
    updateContent = =>
      newContent = window.localStorage[$(@).prop("id")]
      oldContent = $(@).data("content")

      if oldContent != newContent
        $(@).html(newContent)
        $(@).data("content", newContent)

        unless $(".CodeRay", @).length > 0
          $(@).fitText 1.0, maxFontSize: "80px"

        if $(".floating", @).length > 0
          $(".floating", @).appendTo("body")
        else
          $(".floating").remove()

    setInterval updateContent, 100
