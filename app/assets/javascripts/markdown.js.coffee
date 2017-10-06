$ ->
  marked.setOptions
    renderer: new marked.Renderer()
    gfm: true
    tables: true
    breaks: false
    pedantic: false
    sanitize: true
    smartLists: true
    smartypants: false
    highlight: (code) ->
      hljs.highlightAuto(code).value

  $('.markdown-body').each (index, el) ->
    $el = $(el)
    text = $el.text()
    $el.html marked(text)

  $('#preview-tab').click ->
    text = $('#write-content textarea').val()
    $('#preview-content').html ->
      if !!text then marked(text) else 'Nothing to preview'
