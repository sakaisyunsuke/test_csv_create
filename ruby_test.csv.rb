require "csv"
require "securerandom"
require "time"

t=DateTime.now.strftime('(%Y年%m月%d日%H時%M分%S秒)')

print "何人ですか？:"
count = gets.to_i
if count == 0
    count = 100
end

data = [
    'ID','利用者識別ID','性別','年齢','訪問開始時間','訪問終了時間',
    '摂食','睡眠','服薬','保清','環境整備','金銭管理','対人関係',
    '食事','移動','排泄','着替','入浴','整容','摂食（備考）','睡眠（備考）',
    '服薬（備考）','保清（備考）','環境整備（備考）','金銭管理（備考）','対人関係（備考）',
    '食事（備考）','移動（備考）','排泄（備考）','着替（備考）','入浴（備考）',
    '整容（備考）','体温','呼吸','脈拍','血圧（最大）','血圧(最低)',
    '症状の変化','症状の内容','看護内容（備考）','特記事項'
]

eating_Item = ['規則', '過食', '拒食', '不規則']
sleep_Item = ['良眠', '早期覚醒', '中途覚醒', '入眠困難', '不眠', 'その他']
medication_Item = ['規則', '拒薬', '怠薬', '不規則', '過剰服薬']
maintenance_Item = ['清潔', 'やや不潔', '不潔']
environment_Item = ['整頓', 'やや散乱', '散乱']
moneyManagement_Item = ['自己管理', '他者管理', '浪費']
relation_Item = ['良好', '不良']
assistance_Item = ['自立', '一部介助', '全介助']
special_Mention = ['特記すべき症状変化あり','']
sex = ['男性','女性']

random = Random.new()
num=0
start_day=Time.local(1900,1,1,10,0)
end_day=Time.local(2019,12,31,16,0)

CSV.open("#{count}人のsample_test#{t}.csv",'w') do |csv|
    csv << data
    count.times do 
        users_info = [SecureRandom.rand(1000..9999),sex[rand(0..1)],random.rand(20..75)]
        54.times do 
            days = SecureRandom.rand(start_day..end_day)
            while days.hour < 10 || days.hour > 15 || days.sunday? || days.saturday? do #土日と10時から16時までを判定
                days = SecureRandom.rand(start_day..end_day)
            end
            csv << [num = num+1,#ID
            users_info[0],#顧客ID
            users_info[1],#性別
            users_info[2],#年齢
            days.strftime("%Y年%m月%d日%H時%M分"),#<<ここに行く時の時間
            (days + rand(900..2700)).strftime("%Y年%m月%d日%H時%M分"),#<<ここに帰る時時間
            eating_Item[rand(0..3)],#摂食
            sleep_Item[rand(0..5)],#睡眠
            medication_Item[rand(0..4)],#服薬
            maintenance_Item[rand(0..2)],#保清
            environment_Item[rand(0..2)],#環境整備
            moneyManagement_Item[rand(0..2)],#金銭管理
            relation_Item[rand(0..1)],#対人関係
            assistance_Item[rand(0..2)],#食事
            assistance_Item[rand(0..2)],#移動
            assistance_Item[rand(0..2)],#排泄
            assistance_Item[rand(0..2)],#着替え
            assistance_Item[rand(0..2)],#入浴
            assistance_Item[rand(0..2)],#整容
            '','','','','','','','','','','','','','','','','','',#←ここ空白
            if rand(10)+1==1
                special_Mention[rand(0..1)]
            end,#<<ここに全体の１割に特記すべき症状変化あり
            '','','',]#←ここも空白   
        end
    end
end
