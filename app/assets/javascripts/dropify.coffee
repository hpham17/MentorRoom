$ ->
  Dropzone.options.myZone = {
    thumbnailWidth: 300,
    thumbnailHeight: 263,
    accept: (file, done) ->
      done()
  };
