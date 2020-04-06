$(function(){
  // 画像用のinputを生成する関数
  const buildFileField = (num)=> {
    const html = `<div data-index="${num}" class="js-file_group">
                    <input class="js-file" type="file"
                    name="post[images_attributes][${num}][src]"
                    id="post_images_attributes_${num}_src"><br>
                    <div class="js-remove">削除z</div>
                  </div>`;
    return html;
  }
  // if ($('.js-file_group').length == 10){
  //   $('#noremove').css('display','none');
  // }
  // プレビュー用のimgタグを生成する関数
  const buildImg = (index, url)=> {
    const html = `<img data-index="${index}" src="${url}" width="100px" height="100px">`;
    return html;
  }
  // file_fieldのnameに動的なindexをつける為の配列。1枚の画像が追加されるたびに最後尾に配列の値を追加し1ずつずれる。
  let fileIndex = [1,2,3,4,5,6,7,8];
  // 既に使われているindexを除外。1番目,2番目,…と除外
  lastIndex = $('.js-file_group:last').data('index');
  // console.log(lastIndex);
  fileIndex.splice(0, lastIndex);
  $('.hidden-destroy').hide();


//画像を追加した時(file_fieldで画像を選択した時)
  $('#image-box').on('change', '.js-file', function(e) {
    //imgタグが存在するかで判断するための変数
    const targetIndex = $(this).parent().data('index');
    // ファイルのブラウザ上でのURLを取得する
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);
      // 末尾の数に1足した数を追加する
    // console.log(targetIndex);
    // imgタグが存在すれば、該当indexを持つimgがあれば取得して変数imgに入れる(画像変更の処理)
    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
      img.setAttribute('src', blobUrl);
      console.log("差替");
    } else {  
      // 新規画像追加の処理
      $('#previews').append(buildImg(targetIndex, blobUrl));
      // fileIndexの先頭の数字を使ってinputを作る
      $('#image-box').append(buildFileField(fileIndex[0]));
      fileIndex.shift();
      fileIndex.push(fileIndex[fileIndex.length - 1] + 1);
      // 4こ以上増えない記述
      // if ($('.js-file').length < 4){
      //   console.log($("フォーム追加").length);
      //   $('#forms').append(buildFileField(fileIndex[0]));
      // }
    }
  });

// 画像を削除した時
  $('#image-box').on('click', '.js-remove', function() {
    fileIndex.shift();
    fileIndex.push(fileIndex[fileIndex.length - 1] + 1);
    const targetIndex = $(this).parent().data('index');
    // 該当indexを振られているチェックボックスを取得する
    const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
    // もしチェックボックスが存在すればチェックを入れる
    if (hiddenCheck) hiddenCheck.prop('checked', true);
    $(this).parent().remove();
    //image削除
    $(`img[data-index="${targetIndex}"]`).remove();
    
    // // 画像入力欄が5個にならないようにしておく
    // if ($('.js-file').length < 5) {
    //   console.log($('.js-file').length);
    //   $('#forms').append(buildFileField(fileIndex[0]));
    // }
  });
});