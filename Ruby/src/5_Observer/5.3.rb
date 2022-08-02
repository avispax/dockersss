# 5.3 オブザーバに対する責務を分離する
# 基底クラスを作ってオブザーバー部分を分離する。
# → と見せかけて module という機能を使う。
# module は他のファイルにして、require 'Subject' みたいに呼び出せば良い。
# このファイルではめんどくさいから1ファイルで書いちゃいますけども。

# オブザーバクラス
module Subject
     def initialize
        @observers = []
     end

     def add_observer(observer)
        @observers << observer
     end

     def delete_observer(observer)
        @observers.delete(observer)
     end

     def notify_observers
        @observers.each do |observer|
            observer.update(self)
        end
    end
end

# Payroll = 経理部門
class Payroll
    def update(new_player)
        puts("#{new_player.name}が昇給します！")
        puts("彼の給料は#{new_player.salary}になりました。")
    end
end

# 税金通知もしたい
class TaxMan
    def update(new_player)
        puts("#{new_player.name}の税金が変わります！")
    end
end

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

payroll = Payroll.new
fp = Player.new("志知 孝明", "左サイドバック", 25000)

fp.add_observer(payroll)

# 税金通知もしてくれ。
taxman = TaxMan.new
fp.add_observer(taxman)

# 志知を昇給させる
fp.salary = 30000

# output

# 志知 孝明が昇給します！
# 彼の給料は30000になりました。
# 志知 孝明の税金が変わります！

