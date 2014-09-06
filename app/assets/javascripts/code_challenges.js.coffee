$ ->
  $("form[class$=_code_challenge] textarea[id$=code_sample]").each ->
    textarea_id = $(@).prop("id")
    editor_id = "#{textarea_id}_editor"
    $(@).after $("<div>", id: editor_id, class: "ace-editor", data: { target: textarea_id })

    editor = ace.edit editor_id
    editor.setTheme "ace/theme/github"
    editor.setHighlightActiveLine false
    editor.getSession().setValue $(@).val()
    editor.getSession().setMode "ace/mode/ruby"
    editor.getSession().setTabSize 2
    editor.getSession().setUseSoftTabs true

    $(@).hide()

  $("form[class$=_code_challenge]").on "submit", ->
    $(".ace-editor").each ->
      textarea_id = $(@).data("target")
      $("##{textarea_id}").val ace.edit(@).getValue()
