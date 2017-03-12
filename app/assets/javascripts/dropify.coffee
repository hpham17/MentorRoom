$ ->
  Dropzone.options.myZone = {
    thumbnailWidth: 300,
    thumbnailHeight: 263,
    maxFilesize: 8,
    addRemoveLinks: true,
    accept: (file, done) ->
      done()
      $('#upload-pic').val file.name
  };
