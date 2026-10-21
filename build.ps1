$apps=Get-Content "$PSScriptRoot\apps.json" -Raw|ConvertFrom-Json
$u=New-Object Text.UTF8Encoding($false);$c='bossproductions86@gmail.com'
function Page($t,$b){"<!doctype html><html lang=en><head><meta charset=utf-8><meta name=viewport content='width=device-width,initial-scale=1'><title>$t</title><style>body{font:16px/1.6 system-ui,sans-serif;max-width:760px;margin:auto;padding:20px;color:#222}h1{font-size:26px}h2{font-size:18px;margin-top:26px}@media(prefers-color-scheme:dark){body{background:#111;color:#ddd}a{color:#8ab4f8}}</style></head><body>$b</body></html>"}
foreach($a in $apps){
$d="$PSScriptRoot\$($a.slug)";New-Item -ItemType Directory -Force $d|Out-Null;$n=$a.name
$ads=if($a.ads){"<h2>Advertising</h2><p>$n shows ads served by Google AdMob. AdMob may collect and use device identifiers (such as the Android advertising ID), your IP address and information about how you interact with ads, to deliver and measure ads and, where permitted, to personalise them. Users in the European Economic Area and the UK are asked for consent before personalised ads are shown. You can reset your advertising ID or opt out of ad personalisation in your device settings. See <a href='https://policies.google.com/technologies/partner-sites'>how Google uses data</a> and <a href='https://policies.google.com/privacy'>Google's Privacy Policy</a>.</p>"}else{"<h2>Advertising</h2><p>$n contains no advertising and no third-party analytics.</p>"}
$g=if($a.game){"<h2>No gambling</h2><p>$n is a free-to-play game. It offers no real-money gambling and no real-money prizes.</p>"}else{''}
$lst=if($a.location){'name, email address or contacts'}else{'name, email address, location or contacts'}
$st=if($a.stores){$a.stores}else{'settings, statistics and any game in progress'}
$li=''
if($a.sensor){$li+="<li>Readings from your device's $($a.sensor) are processed on your device. Recordings made in the App are saved on your device only and are not sent to us.</li>"}
if($a.location){$li+="<li>Location is optional. If you allow it, your position is read when a recording starts and is saved on your device with that recording so it can appear on the report. It is not sent to us and is never collected in the background. You can deny or withdraw permission in your device settings.</li>"}
if($a.maps){$li+="<li>When a map is shown, map tiles are requested from OpenStreetMap, which receives the map area being viewed and your IP address. See the <a href='https://wiki.osmfoundation.org/wiki/Privacy_Policy'>OpenStreetMap Privacy Policy</a>.</li>"}
if($a.notify){$li+="<li>$n shows a notification while a recording is running so that Android keeps it active with the screen off and, if you turn on alerts, when your chosen threshold is reached. These notifications are created on your device.</li>"}
if($li){$li="<ul>$li</ul>"}
$buy=if($a.premium){"<h2>Premium purchases</h2><p>Premium is a subscription sold through Google Play. Google Play processes the payment. Our subscription provider, RevenueCat, receives an anonymous app user ID and your purchase and subscription status so the App can tell whether Premium is active. We do not receive your name, email address or payment details. See the <a href='https://www.revenuecat.com/privacy'>RevenueCat Privacy Policy</a>.</p>"}else{''}
$shr=if($a.ads -or $a.maps -or $a.premium){'We do not share it with anyone except as described in this policy.'}else{'We do not share it with anyone.'}
$prem=if($a.premium){"<h2>Premium</h2><p>Premium is a subscription sold through Google Play that removes advertisements. It renews until cancelled and you can cancel at any time in Google Play. Refunds are handled by Google Play under its policies.</p>"}else{''}
$dis=if($a.disclaimer){"<h2>Accuracy and limitations</h2><p>$($a.disclaimer)</p>"}else{''}
$pp="<h1>$n Privacy Policy</h1><p>Effective $($a.date). This policy applies to the $n mobile app (the App) by Happy Apps For You (we, us).</p>
<h2>Information we collect</h2><p>We do not ask you to create an account and we do not collect your $lst. Your $st are stored only on your device and are deleted when you uninstall the App or clear its data.</p>$li
$ads
$buy
<h2>Sharing</h2><p>We do not sell your personal information. $shr</p>
<h2>Children</h2><p>The App is not directed at children under 13 and we do not knowingly collect information from them.</p>
<h2>Your choices</h2><p>You can remove all data stored by the App by uninstalling it or clearing its storage in your device settings. Contact us with any privacy request, including under the New Zealand Privacy Act 2020.</p>
<h2>Changes</h2><p>We may update this policy. The effective date above shows the latest version.</p>
<h2>Contact</h2><p><a href='mailto:$c'>$c</a></p><p><a href='terms.html'>Terms of Use</a></p>"
$tt="<h1>$n Terms of Use</h1><p>Effective $($a.date). By installing or using $n (the App), published by Happy Apps For You, you agree to these terms.</p>
<h2>Use of the App</h2><p>We grant you a personal, non-exclusive, non-transferable licence to use the App on your devices. Do not copy, modify, reverse engineer or resell the App except as the law allows.</p>
$dis
$g
$prem
<h2>Third-party services</h2><p>The App may show ads or link to websites from third parties such as Google. We are not responsible for their content or practices.</p>
<h2>No warranty</h2><p>The App is provided as is, without warranties of any kind, to the extent permitted by law. We do not guarantee that it will be error free or uninterrupted.</p>
<h2>Liability</h2><p>To the extent permitted by law we are not liable for indirect or consequential loss arising from use of the App. Nothing in these terms limits rights you have under consumer protection laws that cannot be excluded.</p>
<h2>Intellectual property</h2><p>The App, its artwork and its code belong to us or our licensors and are protected by copyright.</p>
<h2>Changes and governing law</h2><p>We may update these terms and the App at any time. These terms are governed by the laws of New Zealand.</p>
<h2>Contact</h2><p><a href='mailto:$c'>$c</a></p><p><a href='./'>Privacy Policy</a></p>"
[IO.File]::WriteAllText("$d\index.html",(Page "$n Privacy Policy" $pp),$u)
[IO.File]::WriteAllText("$d\terms.html",(Page "$n Terms of Use" $tt),$u)}
$rows=($apps|%{"<li><b>$($_.name)</b>: <a href='$($_.slug)/'>Privacy Policy</a> | <a href='$($_.slug)/terms.html'>Terms of Use</a></li>"}) -join ''
[IO.File]::WriteAllText("$PSScriptRoot\index.html",(Page "Happy Apps For You - Policies" "<h1>Happy Apps For You</h1><p>Privacy policies and terms for our apps.</p><ul>$rows</ul><p>Contact: <a href='mailto:$c'>$c</a></p>"),$u)
"Built $($apps.Count) app(s)"
