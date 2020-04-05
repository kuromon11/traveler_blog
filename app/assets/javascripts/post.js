$(function(){
//   // 画像用のinputを生成する関数
//   const buildFileField = (num)=> {
//     const html = `<div data-index="${num}" class="js-file_group">
//                     <label for="item_item_images_attributes_${num}_image_url">
//                       <i class="fa fa-image"></i>
//                       <input class="js-file" type="file"
//                       name="item[item_images_attributes][${num}][image_url]"
//                       id="item_item_images_attributes_${num}_image_url">
//                     </label><br>
//                     <div class="js-remove">削除</div>
//                   </div>`;
//     return html;
//   }
//   if ($('.js-file_group').length == 5){
//     $('#noremove').css('display','none');
//   }
//   // プレビュー用のimgタグを生成する関数
//   const buildImg = (index, url)=> {
//     const html = `<img data-index="${index}" src="${url}" width="100px" height="100px">`;
//     return html;
//   }
//   // file_fieldのnameに動的なindexをつける為の配列
//   let fileIndex = [1,2,3,4,5,6,7,8,9,10];
//   // 既に使われているindexを除外
//   lastIndex = $('.js-file_group:last').data('index');
//   fileIndex.splice(0, lastIndex);
//   $('.hidden-destroy').hide();

//   $('#image-box').on('change', '.js-file', function(e) {
//     const targetIndex = $(this).parent().parent().data('index');
//     // ファイルのブラウザ上でのURLを取得する
//     const file = e.target.files[0];
//     const blobUrl = window.URL.createObjectURL(file);
//     fileIndex.shift();
//     fileIndex.push(fileIndex[fileIndex.length - 1] + 1);
//     // 該当indexを持つimgがあれば取得して変数imgに入れる(画像変更の処理)
//     if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
    
//       img.setAttribute('src', blobUrl);
//     } else {  
//       // 新規画像追加の処理
      
//       $('#previews').append(buildImg(targetIndex, blobUrl));
//       // fileIndexの先頭の数字を使ってinputを作る
//       // 4こ以上増えない記述
//       if ($('.js-file').length < 4){
//         $('#forms').append(buildFileField(fileIndex[0]));
//       }
//     }
//   });

//   $('#image-box').on('click', '.js-remove', function() {
//     fileIndex.shift();
//     fileIndex.push(fileIndex[fileIndex.length - 1] + 1);
//     const targetIndex = $(this).parent().data('index');
//     // 該当indexを振られているチェックボックスを取得する
//     const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
//     // もしチェックボックスが存在すればチェックを入れる
//     if (hiddenCheck) hiddenCheck.prop('checked', true);
//     $(this).parent().remove();
//     //image削除
//     $(`img[data-index="${targetIndex}"]`).remove();
    
//     // 画像入力欄が４個にならないようにしておく
//     if ($('.js-file').length < 4) {
//       console.log($('.js-file').length);
//       $('#forms').append(buildFileField(fileIndex[0]));
//     }
//   });
});