# 5.2 通知を受けるその2。1よりも良い方法
# 選手の給与が変わったときに、通知すべき一覧を選手が保有する（@observer）
# 関係性はあまり変わっていないが、まぁ配列を使うことでn件対応できるようにはなった。5.1.rbは1件だったから。

# 4章の考え方と同じく、PayrollとTaxManはインターフェイスを継承しない。
# これがJavaとかなら、ここがインターフェイスになる。

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
    attr_reader :name
    attr_accessor :position, :salary

    def initialize(name, position, salary)
        @name = name
        @position = position
        @salary = salary
        @observer = []
    end

    def salary=(new_salary)
        @salary = new_salary
        notify_observer
    end

    def notify_observer
        @observer.each do |observer|
            observer.update(self)
        end
    end

    def add_observer(observer)
        @observer << observer
    end

    def delete_observer(observer)
        @observer.delete(observer)
    end

end

payroll = Payroll.new
yama = Player.new("山岸 祐也", "フォワード", 30000)

yama.add_observer(payroll)

# 税金通知もしてくれ。
taxman = TaxMan.new
yama.add_observer(taxman)

# 山岸祐也を昇給させる
yama.salary = 50000

# output

# 山岸 祐也が昇給します！
# 彼の給料は50000になりました。
# 山岸 祐也の税金が変わります！