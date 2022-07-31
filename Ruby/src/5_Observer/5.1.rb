# 5.1 通知を受けるその1
# まずは愚直な感じで
# ちなみにアレンジしてサッカー選手（アビスパ福岡の）関連にしています。

# Payroll = 経理部門
class Payroll
    def update(new_player)
        puts("#{new_player.name}が昇給します！")
        puts("彼の給料は#{new_player.salary}になりました。")
    end
end

# 選手クラスが経理部門を保持するw こりゃないっていう例なのでOK。
class Player
    attr_reader :name
    attr_accessor :position, :salary

    def initialize(name, position, salary, payroll)
        @name = name
        @position = position
        @salary = salary
        @payroll = payroll
    end

    def salary=(new_salary)
        @salary = new_salary
        @payroll.update(self)
    end

end

payroll = Payroll.new
tanaka = Player.new("田中 達也", "右サイドハーフ", 30000, payroll)

# 田中達也を昇給させる

tanaka.salary = 50000

# 田中 達也が昇給します！
# 彼の給料は50000になりました。
