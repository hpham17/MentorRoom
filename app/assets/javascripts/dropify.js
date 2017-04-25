$(function() {
  return Dropzone.options.myZone = {
    thumbnailWidth: 300,
    thumbnailHeight: 263,
    maxFilesize: 8,
    addRemoveLinks: true,
    accept: function(file, done) {
      done();
      return $('#upload-pic').val(file.name);
    }
  };
});
