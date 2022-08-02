# 5.6 Observerパターンの使用上の注意
# まぁそもそも値を変えたぐらいじゃ notify しないよね、ということです。
# 通知のタイミングが来たら「notifyして」ってやろうよ、ということ。
# たぶんこっちが普通。

# オブザーバクラス
module Subject
     def initialize
        @observers = []
     end

     def add_observer(&observer)
        @observers << observer
     end

     def delete_observer(observer)
        @observers.delete(observer)
     end

     def notify_observers
        @observers.each do |observer|
            observer.call(self)
        end
    end
end

class Player
    include Subject
    attr_reader :name
    attr_accessor :position, :salary, :is_change_salary, :is_change_position

    def initialize(name, position, salary)
        super()
        @name = name
        @position = position
        @salary = salary
        @is_change_salary = false
        @is_change_position = false
    end

    def salary=(new_salary)
        if @salary == new_salary
            return
        end

        @salary = new_salary
        @is_change_salary = true
    end

    def position=(new_position)
        if @position == new_position
            return 
        end

        @position = new_position
        @is_change_position = true
    end

    # 今回新登場。通知していいよって合図。
    def changes_complete
        notify_observers
    end
end

fp = Player.new("城後 寿", "ボランチ", 10000)

# 経理部門用Lambda
fp.add_observer do |new_player|
    if new_player.is_change_salary
        puts("#{new_player.name}が昇給します！")
        puts("彼の給料は#{new_player.salary}になりました。")
    end
end

# ポジション変更Lambda
fp.add_observer do |new_player|
    if new_player.is_change_position
        puts("#{new_player.name}はコンバートされます！")
        puts("彼のポジションは#{new_player.position}になりました。")
    end
end

# 選手を昇給させる
fp.salary = 30000
fp.position = "フォワード"

# 彼の変更は終わったので通知していいよ。
fp.changes_complete

# output

# 城後 寿が昇給します！
# 彼の給料は30000になりました。
# 城後 寿はコンバートされます！
# 彼のポジションはフォワードになりました。

# 補記 : 値を変えなければその分の処理はスキップされるようにif文を配置。
