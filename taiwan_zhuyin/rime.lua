-- 時間
function time_translator(input, seg)
   local text = string.lower(input)
   if (text == "date") or (text == "dd") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d"), ""))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d"), ""))
   elseif (text == "time") or (text == "tt")  then
      yield(Candidate("time", seg.start, seg._end, os.date("%H:%M"), ""))
      yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), ""))
   elseif (text == "w1") then
      yield(Candidate("Monday", seg.start, seg._end, "週一", ""))
      yield(Candidate("Monday", seg.start, seg._end, "星期一", ""))
      yield(Candidate("Monday", seg.start, seg._end, "Monday", ""))
   elseif (text == "w2") then
      yield(Candidate("Monday", seg.start, seg._end, "週二", ""))
      yield(Candidate("Tuesday", seg.start, seg._end, "星期二", ""))
      yield(Candidate("Tuesday", seg.start, seg._end, "Tuesday", ""))
   elseif (text == "w3") then
      yield(Candidate("Monday", seg.start, seg._end, "週三", ""))
      yield(Candidate("Wednesday", seg.start, seg._end, "星期三", ""))
      yield(Candidate("Wednesday", seg.start, seg._end, "Wednesday", ""))
   elseif (text == "w4") then
      yield(Candidate("Monday", seg.start, seg._end, "週四", ""))
      yield(Candidate("Thursday", seg.start, seg._end, "星期四", ""))
      yield(Candidate("Thursday", seg.start, seg._end, "Thursday", ""))
   elseif (text == "w5") then
      yield(Candidate("Monday", seg.start, seg._end, "週五", ""))
      yield(Candidate("Friday", seg.start, seg._end, "星期五", ""))
      yield(Candidate("Friday", seg.start, seg._end, "Friday", ""))
   elseif (text == "w6") then
      yield(Candidate("Monday", seg.start, seg._end, "週六", ""))
      yield(Candidate("Saturday", seg.start, seg._end, "星期六", ""))
      yield(Candidate("Saturday", seg.start, seg._end, "Saturday", ""))
   elseif (text == "w7") then
      yield(Candidate("Monday", seg.start, seg._end, "週日", ""))
      yield(Candidate("Sunday", seg.start, seg._end, "星期日", ""))
      yield(Candidate("Sunday", seg.start, seg._end, "Sunday", ""))
   -- 整點
   elseif string.match(text, "^o%d%d?$") then
      yield(Candidate("oclock", seg.start, seg._end, string.sub(text, 2, -1).."點", ""))
   elseif string.match(text, "^%d%d?o$") then
      yield(Candidate("oclock", seg.start, seg._end, string.sub(text, 1, -2).."點", ""))
   -- 日 
   elseif string.match(text, "^d%d+$") then
      if (text == "d0") then
          yield(Candidate("Today", seg.start, seg._end, "今天", ""))
      else
          yield(Candidate("day", seg.start, seg._end, string.sub(text, 2, -1).."日", ""))
      end
      yield(Candidate("day", seg.start, seg._end, string.sub(text, 2, -1).."天", ""))
   elseif string.match(text, "^%d+d$") then
      if (text == "0d") then
          yield(Candidate("Today", seg.start, seg._end, "今天", ""))
      else
          yield(Candidate("day", seg.start, seg._end, string.sub(text, 1, -2).."日", ""))
      end
      yield(Candidate("day", seg.start, seg._end, string.sub(text, 1, -2).."天", ""))
   -- 月
   elseif string.match(text, "^m%d%d?$") then
      if (text == "m0") then
          yield(Candidate("month", seg.start, seg._end, "今月", ""))
      else
          yield(Candidate("month", seg.start, seg._end, string.sub(text, 2, -1).."月", ""))
      end
   elseif string.match(text, "^%d%d?m$") then
      if (text == "0m") then
          yield(Candidate("month", seg.start, seg._end, "今月", ""))
      else
          yield(Candidate("month", seg.start, seg._end, string.sub(text, 1, -2).."月", ""))
      end
   -- 年
   elseif string.match(text, "^y%d+$") then
      if (text == "y0") then
          yield(Candidate("year", seg.start, seg._end, "今年", ""))
      else
          yield(Candidate("year", seg.start, seg._end, string.sub(text, 2, -1).."年", ""))
      end
   elseif  string.match(text, "^%d+y$") then
      if (text == "0y") then
          yield(Candidate("year", seg.start, seg._end, "今年", ""))
      else
          yield(Candidate("year", seg.start, seg._end, string.sub(text, 1, -2).."年", ""))
      end
   -- 下個時間系列
   elseif string.match(text, "^n[dwmy]") then
      if (text == "nd") then
          yield(Candidate("Tomorrow", seg.start, seg._end, "明天", ""))
      elseif string.match(text, "nw%d") then
          if (text == "nw1") then
              yield(Candidate("NextMonday", seg.start, seg._end, "下週一", ""))
          elseif (text == "nw2") then
              yield(Candidate("NextTuesday", seg.start, seg._end, "下週二", ""))
          elseif (text == "nw3") then
              yield(Candidate("NextWendnesday", seg.start, seg._end, "下週三", ""))
          elseif (text == "nw4") then
              yield(Candidate("NextThursday", seg.start, seg._end, "下週四", ""))
          elseif (text == "nw5") then
              yield(Candidate("NextFriday", seg.start, seg._end, "下週五", ""))
          elseif (text == "nw6") then
              yield(Candidate("NextSaturday", seg.start, seg._end, "下週六", ""))
          elseif (text == "nw7") then
              yield(Candidate("NextSunday", seg.start, seg._end, "下週日", ""))
          end
      elseif (text == "nw") then
          yield(Candidate("NextWeek", seg.start, seg._end, "下週", ""))
      elseif (text == "nm") then
          yield(Candidate("NextMonth", seg.start, seg._end, "下個月", ""))
      elseif (text == "ny") then
          yield(Candidate("NextYear", seg.start, seg._end, "明年", ""))
      end
   -- 上個時間系列
   elseif string.match(text, "^l[dwmy]") then
      if (text == "ld") then
          yield(Candidate("Tomorrow", seg.start, seg._end, "昨天", ""))
      elseif string.match(text, "lw%d") then
          if (text == "lw1") then
              yield(Candidate("LastMonday", seg.start, seg._end, "上週一", ""))
          elseif (text == "lw2") then
              yield(Candidate("LastTuesday", seg.start, seg._end, "上週二", ""))
          elseif (text == "lw3") then
              yield(Candidate("LastWendnesday", seg.start, seg._end, "上週三", ""))
          elseif (text == "lw4") then
              yield(Candidate("LastThursday", seg.start, seg._end, "上週四", ""))
          elseif (text == "lw5") then
              yield(Candidate("LastFriday", seg.start, seg._end, "上週五", ""))
          elseif (text == "lw6") then
              yield(Candidate("LastSaturday", seg.start, seg._end, "上週六", ""))
          elseif (text == "lw7") then
              yield(Candidate("LastSunday", seg.start, seg._end, "上週日", ""))
          end
      elseif (text == "lw") then
          yield(Candidate("LastWeek", seg.start, seg._end, "上週", ""))
      elseif (text == "lm") then
          yield(Candidate("LastMonth", seg.start, seg._end, "上個月", ""))
      elseif (text == "ly") then
          yield(Candidate("LastYear", seg.start, seg._end, "去年", ""))
      end
   -- 八位數字轉日期
   elseif string.match(text, "%d%d%d%d%d%d%d%d") then
      yield(Candidate("date", seg.start, seg._end, string.sub(text, 1, 4) .. "-" .. string.sub(text, 5, 6) .. "-" .. string.sub(text, 7, 8), ""))
      yield(Candidate("date", seg.start, seg._end, string.sub(text, 1, 4) .. "/" .. string.sub(text, 5, 6) .. "/" .. string.sub(text, 7, 8), ""))
      yield(Candidate("date", seg.start, seg._end, string.sub(text, 1, 4) .. "年" .. string.sub(text, 5, 6) .. "月" .. string.sub(text, 7, 8) .. "日", ""))
   end


end


-- 繪文字
function emoji_translator(input, seg)
   local text = string.lower(input)
   if (text == "em") or (text == "emoji") then
      yield(Candidate("🤣", seg.start, seg._end, "🤣", "笑翻了"))
      yield(Candidate("😂", seg.start, seg._end, "😂", "感動"))
      yield(Candidate("🙈", seg.start, seg._end, "🙈", "非禮勿視"))
      yield(Candidate("💪", seg.start, seg._end, "💪", "肌肉"))
      yield(Candidate("🤔", seg.start, seg._end, "🤔", "思考"))
      yield(Candidate("❤️", seg.start, seg._end, "❤️", "愛心"))
      yield(Candidate("😅", seg.start, seg._end, "😅", "汗"))
      yield(Candidate("👀", seg.start, seg._end, "👀", "雙眼"))
      yield(Candidate("👍", seg.start, seg._end, "👍", "讚"))
      yield(Candidate("😭", seg.start, seg._end, "😭", "哭"))
      yield(Candidate("😎", seg.start, seg._end, "😎", "墨鏡"))
      yield(Candidate("😆", seg.start, seg._end, "😆", "狂笑"))
      yield(Candidate("🥲", seg.start, seg._end, "🥲", "微笑帶淚"))
      yield(Candidate("😏", seg.start, seg._end, "😏", "冷笑"))
      yield(Candidate("😒", seg.start, seg._end, "😒", "不高興"))
      yield(Candidate("😯", seg.start, seg._end, "😯", "哦"))
      yield(Candidate("😁", seg.start, seg._end, "😁", "嘻嘻"))
      yield(Candidate("😍", seg.start, seg._end, "😍", "花痴"))
      yield(Candidate("🤦‍♀️", seg.start, seg._end, "🤦‍♀️", "遮臉"))
      yield(Candidate("💕", seg.start, seg._end, "💕", "心心相印"))
      yield(Candidate("🫣", seg.start, seg._end, "🫣", "一眼偷看的臉"))
      yield(Candidate("😋", seg.start, seg._end, "😋", "口水"))
      yield(Candidate("😠", seg.start, seg._end, "😠", "不爽"))
      yield(Candidate("😵", seg.start, seg._end, "😵", "頭暈目眩"))
      yield(Candidate("🤮", seg.start, seg._end, "🤮", "狂吐中"))
      yield(Candidate("🥺", seg.start, seg._end, "🥺", "請求的臉"))
      yield(Candidate("🤤", seg.start, seg._end, "🤤", "流口水"))
      yield(Candidate("🤫", seg.start, seg._end, "🤫", "噓"))
      yield(Candidate("😜", seg.start, seg._end, "😜", "吐舌頭"))
      yield(Candidate("🙅", seg.start, seg._end, "🙅", "不行"))
      yield(Candidate("🙆", seg.start, seg._end, "🙆", "可以"))
      yield(Candidate("🙋", seg.start, seg._end, "🙋", "舉手"))
      yield(Candidate("🤦", seg.start, seg._end, "🤦", "哦不"))
      yield(Candidate("🙇", seg.start, seg._end, "🙇", "鞠躬"))
      yield(Candidate("🤷", seg.start, seg._end, "🤷", "聳肩"))
      yield(Candidate("🤏", seg.start, seg._end, "🤏", "捏"))
      yield(Candidate("👎", seg.start, seg._end, "👎", "遜"))
      yield(Candidate("😞", seg.start, seg._end, "😞", "失望"))
      yield(Candidate("🙏", seg.start, seg._end, "🙏", "感恩"))
      yield(Candidate("🧧", seg.start, seg._end, "🧧", "紅包"))
      yield(Candidate("🎁", seg.start, seg._end, "🎁", "禮物"))
      yield(Candidate("🎉", seg.start, seg._end, "🎉", "拉炮"))
      yield(Candidate("🎊", seg.start, seg._end, "🎊", "五彩紙屑"))
      yield(Candidate("💯", seg.start, seg._end, "💯", "滿分"))
      yield(Candidate("⁉️", seg.start, seg._end, "⁉️", "驚歎號加問號"))
      yield(Candidate("🈲", seg.start, seg._end, "🈲", "禁"))
      yield(Candidate("©️", seg.start, seg._end, "©️", "版權"))
      yield(Candidate("®️", seg.start, seg._end, "®️", "註冊"))
      yield(Candidate("™️", seg.start, seg._end, "™️", "商標"))
      yield(Candidate("💤", seg.start, seg._end, "💤", "睡著"))
      yield(Candidate("💢", seg.start, seg._end, "💢", "怒"))
      yield(Candidate("🥂", seg.start, seg._end, "🥂", "乾杯"))
      yield(Candidate("📷", seg.start, seg._end, "📷", "相機"))
      yield(Candidate("🥳", seg.start, seg._end, "🥳", "慶祝的臉"))
      yield(Candidate("😩", seg.start, seg._end, "😩", "唉"))
      yield(Candidate("😟", seg.start, seg._end, "😟", "擔心"))
   elseif (text == "ok")  then
      yield(Candidate("👌", seg.start, seg._end, "👌", "OK"))
   end
end

-- 固定文字類型
function text_translator(input, seg)
   local text = string.lower(input)
   if (input == "--")  then
      yield(Candidate("--", seg.start, seg._end, "--", ""))
   elseif (input == ",")  then
      yield(Candidate("，", seg.start, seg._end, "，", ""))
   elseif (input == ".")  then
      yield(Candidate("。", seg.start, seg._end, "。", ""))
   -- 純英或純數
   elseif string.match(input, "^[%d%.: ]*[%d%.: ]$") or string.match(input, "^[%a%.,$- ]*[%a%.,%- ]$")  then
      yield(Candidate("time", seg.start, seg._end, input, ""))
   end
end


-- 個人
function personal_translator(input, seg)
   local text = string.lower(input)
   if (text == "email") or (text == "mail")  then
      yield(Candidate("email", seg.start, seg._end, "your-email@mail.com", "example-mail"))
   elseif (input == "name")  then
      yield(Candidate("name", seg.start, seg._end, "your-name", ""))
   elseif (input == "address") or (input == "addr")  then
      yield(Candidate("address", seg.start, seg._end, "your-address", "公司"))
   elseif (input == "phone") or (input == "pn")  then
      yield(Candidate("phone", seg.start, seg._end, "09xx-xxxxxx", "手機"))
   elseif (input == "comp") or (input == "company")  then
      yield(Candidate("name", seg.start, seg._end, "your-company", ""))
   end
end

-- 加減乘除
function count_translator(input, seg)
   -- 加法
   if string.match(input, "^%d+(ru8 )%d+") then
      local deliPos = string.find(input, "(ru8 )")
      local num = tonumber(string.sub(input, 1, deliPos-1)) + tonumber(string.sub(input, deliPos+4, -1))
      yield(Candidate("time", seg.start, seg._end, num, ""))
   end
   if string.match(input, "^%d+%+%d+") then
      local sum = 0
      for s in string.gmatch(input, "(%-?%d+)") do
        sum = sum + tonumber(s)
      end
      yield(Candidate("time", seg.start, seg._end, sum, ""))
   end
   -- 減法
   if string.match(input, "^%d+(ru03)%d+") then
      local deliPos = string.find(input, "(ru03)")
      local num = tonumber(string.sub(input, 1, deliPos-1)) - tonumber(string.sub(input, deliPos+4, -1))
      yield(Candidate("time", seg.start, seg._end, num, ""))
   end
   if string.match(input, "^%d+(%-)%d+") then
      local sum = 0
      for s in string.gmatch(input, "(%-?%d+)") do
        sum = sum + tonumber(s)
      end
      yield(Candidate("time", seg.start, seg._end, sum, ""))
   end
   -- 乘法
   if string.match(input, "^%d+(t/6)%d+") then
      local deliPos = string.find(input, "(t/6)")
      local num = tonumber(string.sub(input, 1, deliPos-1)) * tonumber(string.sub(input, deliPos+3, -1))
      yield(Candidate("time", seg.start, seg._end, num, ""))
   end
   -- 除法
   if string.match(input, "^%d+(tj6)%d+") then
      local deliPos = string.find(input, "(tj6)")
      local num = tonumber(string.sub(input, 1, deliPos-1)) / tonumber(string.sub(input, deliPos+3, -1))
      yield(Candidate("time", seg.start, seg._end, num, ""))
   end
end
