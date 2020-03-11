// formDataが対応しているか
// if( window.FormData ){
//   alert("対応しています");
// } else {
//   alert("対応していません");
// }

// $(function(){
//   //いいね追加。クリックイベントで実行。
//   $('#likes').on('click', function(e){
//     e.preventDefault();
//     console.log("成功");
//     var likes = new FormData(this);
//     //url取得
//     var url = $(this).attr('action');
//     // console.log(this);
//     $.ajax({
//       url: url,
//       type: "POST",
//       data: likes,
//       dataType: 'json',
//       processData: false,
//       contentType: false
//     });
//   });
// });

// $(function(){
//   //いいね解除
//   $('#likes').on('click', function(e){
//     console.log('解除');
//     e.preventDefault();
//     var formData = new FormData(this);
//     var url = $(this).attr('data-method');
//     console.log(this);
//     $.ajax({
//       url: url,
//       type: "DELETE",
//       data: formData,
//       dataType: 'json',
//       processData: false,
//       contentType: false
//     });
//   });
// });