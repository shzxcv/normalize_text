class String
  def normalize
    text = self

    text = text.gsub(/(?![\r\n])[[:cntrl:]]/, '')
    text = text.gsub(/\r\n/, ' ').gsub(/[\n|\r]/, ' ')

    text = RemoveEmoji::Sanitize.call(text)
    text = text.each_char.select { |c| c.bytes.count < 4 }.join
    text = text.unicode_normalize(:nfkc)

    hypon_reg = /(?:˗|֊|‐|‑|‒|–|⁃|⁻|₋|−)/
    text = text.gsub(hypon_reg, '-')

    choon_reg = /(?:﹣|－|ｰ|—|―|─|━)/
    text = text.gsub(choon_reg, 'ー')
    text = text.gsub(/ー+/, 'ー')

    chil_reg = /(?:~|∼|∾|〜|〰|～)/
    text = text.gsub(chil_reg, '')

    text = text.tr(%q{!"#$%&'()*+,-.\/:;<=>?@[¥]^_`{|}~｡､･｢｣"},
                   '！”＃＄％＆’（）＊＋，－．／：；＜＝＞？＠［￥］＾＿｀｛｜｝〜。、・「」')

    text = text.gsub(/　/, ' ')
    text = text.gsub(/ {1,}/, ' ')
    text = text.gsub(/^ +(.+?)$/, '\\1')
    text = text.gsub(/^(.+?) +$/, '\\1')

    while text =~ /([\p{InCjkUnifiedIdeographs}\p{InHiragana}\p{InKatakana}\p{InHalfwidthAndFullwidthForms}\p{InCJKSymbolsAndPunctuation}]+?) {1}([\p{InCjkUnifiedIdeographs}\p{InHiragana}\p{InKatakana}\p{InHalfwidthAndFullwidthForms}\p{InCJKSymbolsAndPunctuation}]+?)/
      text = text.gsub(
        /([\p{InCJKUnifiedIdeographs}\p{InHiragana}\p{InKatakana}\p{InHalfwidthAndFullwidthForms}\p{InCJKSymbolsAndPunctuation}]+?) {1}([\p{InCJKUnifiedIdeographs}\p{InHiragana}\p{InKatakana}\p{InHalfwidthAndFullwidthForms}\p{InCJKSymbolsAndPunctuation}]+?)/, '\\1\\2'
      )
    end

    while text =~ /(\p{InBasicLatin}+) {1}([\p{InCJKUnifiedIdeographs}\p{InHiragana}\p{InKatakana}\p{InHalfwidthAndFullwidthForms}\p{InCJKSymbolsAndPunctuation}]+)/
      text = text.gsub(
        /(\p{InBasicLatin}+) {1}([\p{InCJKUnifiedIdeographs}\p{InHiragana}\p{InKatakana}\p{InHalfwidthAndFullwidthForms}\p{InCJKSymbolsAndPunctuation}]+)/, '\\1\\2'
      )
    end

    while text =~ /([\p{InCJKUnifiedIdeographs}\p{InHiragana}\p{InKatakana}\p{InHalfwidthAndFullwidthForms}\p{InCJKSymbolsAndPunctuation}]+) {1}(\p{InBasicLatin}+)/
      text = text.gsub(
        /([\p{InCJKUnifiedIdeographs}\p{InHiragana}\p{InKatakana}\p{InHalfwidthAndFullwidthForms}\p{InCJKSymbolsAndPunctuation}]+) {1}(\p{InBasicLatin}+)/, '\\1\\2'
      )
    end

    text = text.tr(
      '！”＃＄％＆’（）＊＋，－．／：；＜＞？＠［￥］＾＿｀｛｜｝〜',
      %q{!"#$%&'()*+,-.\/:;<>?@[¥]^_`{|}~}
    )

    text
  end
end
