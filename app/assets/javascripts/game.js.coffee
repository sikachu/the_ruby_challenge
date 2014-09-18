$ ->
  if $("#code-challenges").length > 0
    $("#code-challenges li a:first").parent().addClass("current")
    currentScore = parseInt($("#score").html())

    updateCurrent = ->
      window.localStorage["left-screen"] = $("#code-challenges")[0].outerHTML +
        "<aside>Current Score: #{currentScore}</aside>"
      window.localStorage["right-screen"] = $("#code-challenges")[0].outerHTML +
        "<aside>Current Score: #{currentScore}</aside>"

    moveTo = (codeChallenge) ->
      $("#code-challenges .current").removeClass("current")
      $(codeChallenge).addClass("current")
      updateCurrent()


    if $("#code-challenges li a").length + currentScore < 3
      window.localStorage["left-screen"] = "<h1>Game over</h1>"
      window.localStorage["right-screen"] = "<h1>ゲームオーバー</h1>"
    else if $("#score").html() == "3"
      window.localStorage["left-screen"] = "<h1>Congratulations!</h1>"
      window.localStorage["right-screen"] = "<h1>おめでとう！</h1>"
    else
      updateCurrent()

    newgameClicked = false

    $(document).on "keydown", (e) ->
      if e.keyCode != 116 && e.keyCode != 27
        newgameClicked = false

      switch e.keyCode
        when 33, 37, 38 # Page Up, Left, Up
          e.preventDefault()
          previousItem = $("#code-challenges .current").prev()
          moveTo(previousItem) if previousItem.length > 0

        when 34, 39, 40 # Page Down, Right, Down
          e.preventDefault()
          nextItem = $("#code-challenges .current").next()
          moveTo(nextItem) if nextItem.length > 0

        when 190
          e.preventDefault()
          $("#code-challenges .current a")[0].click()

        when 116, 27 # F5 and ESC
          e.preventDefault()

          if newgameClicked
            $("form#new_game").submit()
          else
            newgameClicked = true

  if $("#left-code-sample").length > 0
    if $("#left-code-sample").hasClass("selected")
      $("#left-code-sample .CodeRay").addClass("active")

    if $("#right-code-sample").hasClass("selected")
      $("#right-code-sample .CodeRay").addClass("active")

    updateScreen = ->
      window.localStorage["left-screen"] = $("#left-code-sample").html()
      window.localStorage["right-screen"] = $("#right-code-sample").html()

    updateScreen()

    $(document).on "keydown", (e) ->
      switch e.keyCode
        when 33, 37, 38 # Page Up, Left, Up
          e.preventDefault()
          if $("#left-code-sample .CodeRay").hasClass("active")
            $("form.edit_code_challenge #side").val("left")
            $("form.edit_code_challenge").submit()
          else
            $("#right-code-sample .CodeRay").removeClass("active")
            $("#left-code-sample .CodeRay").addClass("active")
            updateScreen()

        when 34, 39, 40 # Page Down, Right, Down
          e.preventDefault()
          if $("#right-code-sample .CodeRay").hasClass("active")
            $("form.edit_code_challenge #side").val("right")
            $("form.edit_code_challenge").submit()
          else
            $("#left-code-sample .CodeRay").removeClass("active")
            $("#right-code-sample .CodeRay").addClass("active")
            updateScreen()

        when 190
          e.preventDefault()
          $("#game-link")[0].click()
