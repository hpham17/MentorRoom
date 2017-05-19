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

$(function() {
  return Dropzone.options.logoZone = {
    thumbnailWidth: 150,
    thumbnailHeight: 170,
    maxFilesize: 8,
    addRemoveLinks: true,
    accept: function(file, done) {
      done();
      return $('#organization_logo').val(file.name);
    }
  };
});
