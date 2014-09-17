$ ->
  if $("#presentation-list").length > 0
    updateCurrent = =>
      window.localStorage["left-screen"] = $(".current .left").html()
      window.localStorage["right-screen"] = $(".current .right").html()

    $("li:first", @).addClass("current")
    updateCurrent()

    $(document).on "keydown", (e) ->
      switch e.keyCode
        when 33, 37, 38 # Page Up, Left, Up
          e.preventDefault()
          previousItem = $("#presentation-list .current").prev()

          if previousItem.length > 0
            $("#presentation-list .current").removeClass("current")
            previousItem.addClass("current")
            $(document).scrollTo(previousItem, 500)
            updateCurrent()

        when 34, 39, 40 # Page Down, Right, Down
          e.preventDefault()
          nextItem = $("#presentation-list .current").next()

          if nextItem.length > 0
            $("#presentation-list .current").removeClass("current")
            nextItem.addClass("current")
            $(document).scrollTo(nextItem, 500)
            updateCurrent()

  $("#presentation #left-screen, #presentation #right-screen").each ->
    updateContent = =>
      $(@).html(window.localStorage[$(@).prop("id")]).fitText 1.0,
        maxFontSize: "80px"

    setInterval updateContent, 100

  if $("#ticket-numbers").length > 0
    getRandomNumber = ->
      number = Math.floor(Math.random() * 180) + 1
      "000#{number}".slice(-3)

    printRandomNumbers = (numbers) ->
      $("#ticket-numbers").html $.map numbers, (number) ->
        "<li>#{number}</li>"
      window.localStorage["left-screen"] = $("#ticket-numbers")[0].outerHTML
      window.localStorage["right-screen"] = $("#ticket-numbers")[0].outerHTML

    currentNumbers = window.localStorage["ticket-numbers"]?.split(",") ? []
    printRandomNumbers(currentNumbers)

    $("#new-number").on "click", ->
      randomNumber = getRandomNumber()

      while currentNumbers.indexOf(randomNumber) > -1
        randomNumber = getRandomNumber()

      currentNumbers.push(randomNumber)
      window.localStorage["ticket-numbers"] = currentNumbers.join(",")
      printRandomNumbers(currentNumbers)

    $("#clear-numbers").on "click", ->
      window.localStorage.removeItem("ticket-numbers")
      currentNumbers = []
      printRandomNumbers(currentNumbers)
