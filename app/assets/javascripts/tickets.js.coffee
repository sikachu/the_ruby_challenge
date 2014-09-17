$ ->
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
