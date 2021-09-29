# frozen_string_literal: true

require 'normalize_text'

RSpec.describe NormalizeText do
  context 'version' do
    it 'has a version number' do
      expect(NormalizeText::VERSION).not_to be nil
    end
  end

  context '正規化された文字列を取得' do
    it '制御文字は削除' do
      text = "\u0001normalize\u0016text\u001C\u000B"
      expect(text.normalize).to eq 'normalizetext'
    end

    it '文字間の改行は半角スペースに置換' do
      text = "nor\rmali\nze\r\ntext"
      expect(text.normalize).to eq 'nor mali ze text'
    end

    it '絵文字除去' do
      text = 'normalizetext😄'
      expect(text.normalize).to eq 'normalizetext'
    end

    it '4バイト以上の文字を除去' do
      text = 'あ𠀋い𡈽う𡌛え𡑮お'
      expect(text.normalize).to eq 'あいうえお'
    end

    it '全角英数字は半角に置換' do
      text = 'ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ０１２３４５６７８９'
      expect(text.normalize).to eq 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
    end

    it '半角カタカナは全角に置換' do
      text = 'ﾊﾝｶｸ'
      expect(text.normalize).to eq 'ハンカク'
    end

    it 'ハイフンマイナスっぽい文字を置換' do
      text = 'o₋o'
      expect(text.normalize).to eq 'o-o'
    end

    it '長音記号っぽい文字を置換' do
      text = 'majika━'
      expect(text.normalize).to eq 'majikaー'
    end

    it '1回以上連続する長音記号は1回に置換' do
      text = 'スーパーーーー'
      expect(text.normalize).to eq 'スーパー'
    end

    it 'チルダっぽい文字は削除' do
      text = 'わ〰い'
      expect(text.normalize).to eq 'わい'
    end

    it '全角記号は半角に変換' do
      text = '！”＃＄％＆’（）＊＋，−．／：；＜＞？＠［￥］＾＿｀｛｜｝'
      expect(text.normalize).to eq "!\"\#$\%&'()*+,-./:;<>?@[¥]^_`{|}"
    end

    it '全角スペースは半角スペースに置換' do
      text = 'ゼンカク　スペース'
      # 文字間の半角スペースは除外
      expect(text.normalize).to eq 'ゼンカクスペース'
    end

    it '1つ以上の半角スペースは、1つの半角スペースに置換' do
      text = 'お             お'
      # 文字間の半角スペースは除外
      expect(text.normalize).to eq 'おお'
    end

    it '解析対象テキストの先頭と末尾の半角スペースは削除' do
      expect('      おお'.normalize).to eq 'おお'
      expect('おお      '.normalize).to eq 'おお'
    end

    it '「ひらがな・全角カタカナ・半角カタカナ・漢字・全角記号」間に含まれる半角スペースは削除' do
      text = '検索 エンジン 自作 入門 を 買い ました!!!'
      expect(text.normalize).to eq '検索エンジン自作入門を買いました!!!'
    end

    it '「ひらがな・全角カタカナ・半角カタカナ・漢字・全角記号」と「半角英数字」の間に含まれる半角スペースは削除' do
      text = 'アルゴリズム C'
      expect(text.normalize).to eq 'アルゴリズムC'
    end

    it '組み合わせ確認' do
      expect('Coding the Matrix'.normalize).to eq 'Coding the Matrix'
      expect('　　　ＰＲＭＬ　　副　読　本　　　'.normalize).to eq 'PRML副読本'

      expect('南アルプスの　天然水　Ｓｐａｒｋｉｎｇ　Ｌｅｍｏｎ　レモン一絞り'.normalize).to \
          eq '南アルプスの天然水Sparking Lemonレモン一絞り'

      expect('南アルプスの　天然水-　Ｓｐａｒｋｉｎｇ*　Ｌｅｍｏｎ+　レモン一絞り'.normalize).to \
          eq '南アルプスの天然水-Sparking*Lemon+レモン一絞り'
    end
  end
end
