# 5.4 オブザーバとしてのコードブロック
# 前章でもやった、Classの代わりにLambdaにしちゃえよ、というやつ。

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

# 以下はもう不要。Lambdaになりましたんで
# Payroll = 経理部門
# class Payroll
#     def update(new_player)
#         puts("#{new_player.name}が昇給します！")
#         puts("彼の給料は#{new_player.salary}になりました。")
#         end
# end

# こちらももう不要。
# 税金通知もしたい
# class TaxMan
#     def update(new_player)
#         puts("#{new_player.name}の税金が変わります！")
#     end
# end

class Player
    include Subject
    attr_reader :name, :position
    attr_accessor :salary

    def initialize(name, position, salary)
        super()
        @name = name
        @position = position
        @salary = salary
    end

    def salary=(new_salary)
        @salary = new_salary
        notify_observers
    end
end

fp = Player.new("フアンマ・デルガド", "フォワード", 50000)

# 経理部門用Lambda
fp.add_observer do |new_player|
    puts("#{new_player.name}が昇給します！")
    puts("彼の給料は#{new_player.salary}になりました。")
end

# 税金通知Lambda
fp.add_observer do |new_player|
    puts("#{new_player.name}の税金が変わります！")
end

# 選手を昇給させる
fp.salary = 80000

# output

# フアンマ・デルガドが昇給します！
# 彼の給料は80000になりました。
# フアンマ・デルガドの税金が変わります！
