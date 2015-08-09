HTMLWidgets.widget({

  name: 'mapshaper',

  type: 'output',

  initialize: function(el, width, height) {

    return {
      // TODO: add instance fields as required
    }

  },

  renderValue: function(el, x, instance) {

    // stackoverflow http://stackoverflow.com/questions/27159179/how-to-convert-blob-to-file-in-javascript?rq=1
    function blobToFile(theBlob, fileName){
      //A Blob() is almost a File() - it's just missing the two properties below which we will add
      theBlob.lastModifiedDate = new Date();
      theBlob.name = fileName;
      return theBlob;
    }

    // https://developer.mozilla.org/en-US/docs/Web/API/Blob?redirectlocale=en-US&redirectslug=DOM%2FBlob
    var jsonBlob = blobToFile(
      new Blob([JSON.stringify(x.geojson)], {type : 'application/json'}),// the blob
      "test.geojson"
    )

    // http://www.2ality.com/2013/06/triggering-events.html
    //   https://developer.mozilla.org/en-US/docs/Web/Events/drop
    var dropEvent = new Event(
    	"drop",
    	{
    		bubbles: true,
    		cancelable: true
    	}
    );

    dropEvent.dataTransfer = { files: [jsonBlob] }

    document.body.dispatchEvent( dropEvent );
  },

  resize: function(el, width, height, instance) {

  }

});
