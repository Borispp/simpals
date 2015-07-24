define [
  'jquery'
  'handlebars'

	# templates
	'text!./article.html'
],
(
  $
  Handlebars

	# templates
  ArticleTemplate
) ->

  class Article
    constructor: (@$block) ->
      @localStorage = window.localStorage
      @ArticleTemplate = Handlebars.compile ArticleTemplate
      @init()
    init: ->
      @getData()

    getData: ->
      $.ajax
        method: 'get'
        crossDomain: true
        type: 'POST'
        dataType: "json"
        url: '../json/posts.json'
        success: (response) =>
          console.log response

          # Rewrite localStorage from actual ServerData if localStorage.articles is not defined
          if @localStorage.getItem 'articles'?
            @setLocalStorage(response)
          else
            @render()

        error: (response) =>
          console.log 'Error'

    render: () ->
      localArticles = JSON.parse(@localStorage.getItem 'articles')
      @$block.html @ArticleTemplate
        conditions: localArticles

      $('.btn-danger').on 'click', (e) =>
        deleteId = $(e.target).data('delete')
        if deleteId != ''
          @removeArticle({"id": deleteId, "localArticles": localArticles})
        else
          deleteKey = $(e.target).data('keydelete')
          @removeArticle({"id": deleteKey, "localArticles": localArticles, "deleteByKey": true})


      $('#post-add button[type="submit"]').on 'click', =>
        nameVal = $('#post-add input[name="title"]').val()
        bodyVal = $('#post-add input[name="body"]').val()
        tagsVal = $('#post-add input[name="tags"]').val()

        if nameVal? && bodyVal? && tagsVal?
          @addArticle(nameVal, bodyVal, tagsVal, localArticles)

    addArticle: (nameVal, bodyVal, tagsVal, localArticles) ->

      article = {}
      article.title = nameVal
      article.body = bodyVal
      article.tags = tagsVal.split(',')

      localArticles.push(article)

      @localStorage.setItem 'articles', JSON.stringify(localArticles)

    removeArticle: (options) ->
      # Front Remove
      console.log options.id
      if !options.deleteByKey?
        $('[data-id='+options.id+']').fadeOut('500', ->
          @.remove()
          )
        # Remove from localStorage
        i = 0
        while i < options.localArticles.length
          if options.localArticles[i].id == options.id
            options.localArticles.splice i, 1
          i++

        @localStorage.setItem 'articles', JSON.stringify(options.localArticles)
      else
        $('[data-key='+options.id+']').fadeOut('500', ->
          @.remove()
          )
        # Remove from localStorage
        options.localArticles.splice options.id, 1

        @localStorage.setItem 'articles', JSON.stringify(options.localArticles)


    setLocalStorage: (response) ->
       @localStorage.setItem 'articles', JSON.stringify(response)
       @render()

  new Article $('#posts')
