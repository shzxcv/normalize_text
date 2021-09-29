class String
  def normalize
    text = self

    text.gsub!(/(?![\r\n])[[:cntrl:]]/, '')
    text.gsub!(/\r\n/, ' ').gsub(/[\n|\r]/, ' ')

    text = RemoveEmoji::Sanitize.call(text)
    text = text.each_char.select { |c| c.bytes.count < 4 }.join

    text = text.unicode_normalize(:nfkc)

    hypon_reg = /(?:˗|֊|‐|‑|‒|–|⁃|⁻|₋|−)/
    text.gsub!(hypon_reg, '-')

    choon_reg = /(?:﹣|－|ｰ|—|―|─|━)/
    text.gsub!(choon_reg, 'ー')
    text.gsub!(/ー+/, 'ー')

    chil_reg = /(?:~|∼|∾|〜|〰|～)/
    text.gsub!(chil_reg, '')

    text.tr!(%q{!"#$%&'()*+,-.\/:;<=>?@[¥]^_`{|}~｡､･｢｣"},
                   '！”＃＄％＆’（）＊＋，－．／：；＜＝＞？＠［￥］＾＿｀｛｜｝〜。、・「」')

    text.gsub!(/　/, ' ')
    text.gsub!(/ {1,}/, ' ')
    text.gsub!(/^ +(.+?)$/, '\\1')
    text.gsub!(/^(.+?) +$/, '\\1')

    while text =~ /([\p{InCjkUnifiedIdeographs}\p{InHiragana}\p{InKatakana}\p{InHalfwidthAndFullwidthForms}\p{InCJKSymbolsAndPunctuation}]+?) {1}([\p{InCjkUnifiedIdeographs}\p{InHiragana}\p{InKatakana}\p{InHalfwidthAndFullwidthForms}\p{InCJKSymbolsAndPunctuation}]+?)/
      text.gsub!(
        /([\p{InCJKUnifiedIdeographs}\p{InHiragana}\p{InKatakana}\p{InHalfwidthAndFullwidthForms}\p{InCJKSymbolsAndPunctuation}]+?) {1}([\p{InCJKUnifiedIdeographs}\p{InHiragana}\p{InKatakana}\p{InHalfwidthAndFullwidthForms}\p{InCJKSymbolsAndPunctuation}]+?)/, '\\1\\2'
      )
    end

    while text =~ /(\p{InBasicLatin}+) {1}([\p{InCJKUnifiedIdeographs}\p{InHiragana}\p{InKatakana}\p{InHalfwidthAndFullwidthForms}\p{InCJKSymbolsAndPunctuation}]+)/
      text.gsub!(
        /(\p{InBasicLatin}+) {1}([\p{InCJKUnifiedIdeographs}\p{InHiragana}\p{InKatakana}\p{InHalfwidthAndFullwidthForms}\p{InCJKSymbolsAndPunctuation}]+)/, '\\1\\2'
      )
    end

    while text =~ /([\p{InCJKUnifiedIdeographs}\p{InHiragana}\p{InKatakana}\p{InHalfwidthAndFullwidthForms}\p{InCJKSymbolsAndPunctuation}]+) {1}(\p{InBasicLatin}+)/
      text.gsub!(
        /([\p{InCJKUnifiedIdeographs}\p{InHiragana}\p{InKatakana}\p{InHalfwidthAndFullwidthForms}\p{InCJKSymbolsAndPunctuation}]+) {1}(\p{InBasicLatin}+)/, '\\1\\2'
      )
    end

    text.tr!(
      '！”＃＄％＆’（）＊＋，－．／：；＜＞？＠［￥］＾＿｀｛｜｝〜',
      %q{!"#$%&'()*+,-.\/:;<>?@[¥]^_`{|}~}
    )

    text
  end
end
