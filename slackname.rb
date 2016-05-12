#!/usr/bin/env ruby

require 'dotenv'
require 'json'

Dotenv.load

token = ENV['SLACK_TOKEN']
user  = ENV['SLACK_USER']

last_name_prefix = ENV['SLACK_LAST_NAME_PREFIX']

emojis = %w{
😀 😬 😁 😂 😃 😄 😅 😆 😇 😉 😊 🙂 🙃 ☺️ 😋 😌 😍 😘 😗 😙 😚 😜 😝 😛 🤑 🤓 😎 🤗 😏 😶 🙄 🤔 😵 😲 🤐 😷 🤒 🤕 😴
💤 💩 😈 👹 👺 💀 👻 👽 🤖 😺 😸 😹 😻 😼 😽 🙀 😿 😾 🙌 👏 👋 👍 👊 ✊ ✌️ 👌 ✋ 💪 🙏 ☝️ 👆 👇 👈 👉 🖕 🤘 🖖 ✍️ 💅
👄 👅 👂 👃 👁 👀 👤 🗣 👶 👦 👧 👨 👩 👱 👴 👵 👲 👳 👮 👷 💂 🕵 🎅 👼 👸 👰 🚶 🏃 💃 👯 👫 👬 👭 🙇 💁 🙅 🙆 🙋 🙎
🙍 💇 💆 💑 👩❤️👧 👚 👕 👖 👔 👗 👙 👘 💄 💋 👣 👠 👡 👢 👞 👟 👒 🎩 ⛑ 🎓 👑 🎒 👝 👛 👜 💼 👓 🕶 💍 🌂 🐶 🐱 🐭 🐹
🐰 🐻 🐼 🐨 🐯 🦁 🐮 🐷 🐽 🐸 🐙 🐵 🙈 🙉 🙊 🐒 🐔 🐧 🐦 🐤 🐣 🐥 🐺 🐗 🐴 🦄 🐝 🐛 🐌 🐞 🐜 🕷 🦂 🦀 🐍 🐢 🐠 🐟 🐡
🐬 🐳 🐋 🐊 🐆 🐅 🐃 🐂 🐄 🐪 🐫 🐘 🐐 🐏 🐑 🐎 🐖 🐀 🐁 🐓 🦃 🕊 🐕 🐩 🐈 🐇 🐿 🐾 🐉 🐲 🌵 🎄 🌲 🌳 🌴 🌱 🌿 ☘ 🍀
🎍 🎋 🍃 🍂 🍁 🌾 🌺 🌻 🌹 🌷 🌼 🌸 💐 🍄 🌰 🎃 🐚 🕸 🌎 🌍 🌏 🌕 🌖 🌗 🌘 🌑 🌒 🌓 🌔 🌚 🌝 🌛 🌜 🌞 🌙 ⭐️ 🌟 💫 ✨
☄ ☀️ 🌤 ⛅️ 🌥 🌦 ☁️ 🌧 ⛈ 🌩 ⚡️ 🔥 💥 ❄️ 🌨 🔥 💥 ❄️ 🌨 ☃️ ⛄️ 🌬 💨 🌪 ☂️ ☔️ 💧 💦 🌊 🍏 🍎 🍐 🍊 🍋 🍌 🍉 🍇 🍓 🍈
🍒 🍑 🍍 🍅 🍆 🌶 🌽 🍠 🍯 🍞 🧀 🍗 🍖 🍤 🍳 🍔 🍟 🌭 🍕 🍝 🌮 🌯 🍜 🍲 🍥 🍣 🍱 🍛 🍙 🍚 🍘 🍢 🍡 🍧 🍨 🍦 🍰 🎂 🍮
🍬 🍭 🍫 🍿 🍩 🍪 🍺 🍻 🍷 🍸 🍹 🍾 🍶 🍵 ☕️ 🍼 🍴 🍽 ⚽️ 🏀 🏈 ⚾️ 🎾 🏐 🏉 🎱 ⛳️ 🏌 🏓 🏸 🏒 🏑 🏏 🎿 ⛷ 🏂 ⛸ 🏹 🎣
🚣 🏊 🏄 🛀 ⛹ 🏋 🚴 🚵 🏇 🕴 🏆 🎽 🏅 🎖 🎗 🏵 🎫 🎟 🎭 🎨 🎪 🎤 🎧 🎼 🎹 🎷 🎺 🎸 🎻 🎬 🎮 👾 🎯 🎲 🎰 🎳 🚗 🚕 🚙
🚌 🚎 🏎 🚓 🚑 🚒 🚐 🚚 🚛 🚜 🏍 🚲 🚨 🚔 🚍 🚘 🚖 🚡 🚠 🚟 🚃 🚋 🚝 🚄 🚅 🚈 🚞 🚂 🚆 🚇 🚊 🚉 🚁 🛩 ✈️ 🛫 🛬 ⛵️ 🛥
🚤 ⛴ 🛳 🚀 🛰 💺 ⚓️ 🚧 ⛽️ 🚏 🚦 🚥 🏁 🚢 🎡 🎢 🎠 🏗 🌁 🗼 🏭 ⛲️ 🎑 ⛰ 🏔 🗻 🌋 🗾 🏕 ⛺️ 🏞 🛣 🛤 🌅 🌄 🏜 🏖 🏝 🌇
🌆 🏙 🌃 🌉 🌌 🌠 🎇 🎆 🌈 🏘 🏰 🏯 🏟 🗽 🏠 🏡 🏚 🏢 🏬 🏣 🏤 🏥 🏦 🏨 🏪 🏫 🏩 💒 🏛 ⛪️ 🕌 🕍 🕋 ⛩ ⌚️ 📱 📲 💻 ⌨
🖥 🖨 🖱 🖲 🕹 🗜 💽 💾 💿 📀 📼 📷 📸 📹 🎥 📽 🎞 📞 ☎️ 📟 📠 📺 📻 🎙 🎚 🎛 ⏱ ⏲ ⏰ 🕰 ⏳ ⌛️ 📡 🔋 🔌 💡 🔦 🕯 🗑
🛢 💸 💵 💴 💶 💷 💰 💳 💎 ⚖ 🔧 🔨 ⚒ 🛠 ⛏ 🔩 ⚙ ⛓ 🔫 💣 🔪 🗡 ⚔ 🛡 🚬 ☠ ⚰ ⚱ 🏺 🔮 📿 💈 ⚗ 🔭 🔬 🕳 💊 💉 🌡
🏷 🔖 🚽 🚿 🛁 🔑 🗝 🛋 🛌 🛏 🚪 🛎 🖼 🗺 ⛱ 🗿 🛍 🎈 🎏 🎀 🎁 🎊 🎉 🎎 🎐 🎌 🏮 ✉️ 📩 📨 📧 💌 📮 📪 📫 📬 📭 📦 📯
📥 📤 📜 📃 📑 📊 📈 📉 📄 📅 📆 🗓 📇 🗃 🗳 🗄 📋 🗒 📁 📂 🗂 🗞 📰 📓 📕 📗 📘 📙 📔 📒 📚 📖 🔗 📎 🖇 ✂️ 📐 📏 📌
📍 🚩 🏳 🏴 🔐 🔒 🔓 🔏 🖊 🖊 🖋 ✒️ 📝 ✏️ 🖍 🖌 🔍 🔎 ❤️ 💛 💙 💜 💔 ❣️ 💕 💞 💓 💗 💖 💘 💝 💟 ☮ ✝️ ☪ 🕉 ☸ ✡️ 🔯
🕎 ☯️ ☦ 🛐 ⛎ ♈️ ♉️ ♊️ ♋️ ♌️ ♍️ ♎️ ♏️ ♐️ ♑️ ♒️ ♓️ 🆔 ⚛ ☢ ☣ 📴 📳 🅰️ 🅱️ 🆎 🆑 🅾️ ⛔️ 📛 🚫 ❌ ⭕️ 💢 ♨️ 🚷 🚯 🚳 🚱
🔞 📵 ❗️ ❕ ❓ ❔ ‼️ ⁉️ 💯 🔅 🔆 🔱 ⚜ ⚠️ 🚸 🔰 ♻️ 💹 ❇️ ✳️ ❎ ✅ 💠 🌀 ➿ 🌐 Ⓜ️ 🏧 🛂 🛃 🛄 🛅 ♿️ 🚭 🚾 🅿️ 🚰 🚹 🚺
🚼 🚻 🚮 🎦 📶 🆖 🆗 🆙 🆒 🆕 🆓 🔢 ▶️ ⏸ ⏯ ⏹ ⏺ ⏭ ⏮ ⏩ ⏪ 🔀 🔁 🔂 ◀️ 🔼 🔽 ⏫ ⏬ ➡️ ⬅️ ⬆️ ⬇️ ↗️ ↘️ ↙️ ↖️ ↕️ ↔️
🔄 ↪️ ↩️ ⤴️ ⤵️ #️⃣ *️⃣ ℹ️ 🔤 🔡 🔠 🔣 🎵 🎶 ➰ ✔️ 🔃 ➕ ➖ ➗ ✖️ 💲 💱 ©️ ®️ ™️ 🔚 🔙 🔛 🔝 🔜 ☑️ 🔘 ⚪️ ⚫️ 🔴 🔵 🔸 🔹
🔶 🔷 🔺 ▪️ ▫️ ⬛️ ⬜️ 🔻 ◼️ ◻️ ◾️ ◽️ 🔲 🔳 🔈 🔉 🔊 🔇 📣 📢 🔔 🔕 🃏 🀄️ ♠️ ♣️ ♥️ ♦️ 🎴 👁 💭 🗯 💬 🕐 🕑 🕒 🕓 🕔 🕕
🕖 🕗 🕘 🕙 🕚 🕛 🕜 🕝 🕞 🕟 🕠 🕡 🕢 🕣 🕤 🕥 🕦
}

emoji = emojis.sample

puts Time.now.strftime('%A, %b %d')
40.times { print "#{emoji} " }

presence_response = `curl -s 'https://slack.com/api/users.getPresence?token=#{token}&user=#{user}'`
presence = JSON.parse(presence_response)['presence']

if presence == 'active'
  `curl -s -XPOST 'https://slack.com/api/users.profile.set?token=#{token}&user=#{user}&profile=%7B"last_name":"#{last_name_prefix}%20#{emoji}"%7D'`
end
