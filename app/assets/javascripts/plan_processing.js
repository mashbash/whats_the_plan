// var planProcessor = {
//   showRegex: new RegExp(/\/plans\/\d+$/),

//   init: function(location) {
//     if ( this.showRegex.test(location) && $('h1#processing').length > 0 ) {
//       this.pollPlans();
//     }
//   },

//   pollPlans: function() {
//     console.log("inside polling");
//     var self = this;
//     var path = window.location.pathname;
//     $.get(path + "/refresh", function(data){
//       if (data.sequenced) {

//         window.location.href = path
//       } else {
//         console.log("not sequenced");
//         setTimeout(self.pollPlans, 1000);
//       }
//     });
//   },
// }