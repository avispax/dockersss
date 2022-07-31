# p.76
# 4.3 Ruby っぽくする。
# まず、何もしてないFormatterクラスは不要。概念としての親クラスなんて不要でしょ。
# 「一般にRubistたちはFormatter基底クラスをすっ飛ばすやり方を好みます。」

class HTMLFormatter
    def output_report(context)
        puts('<html>')
        puts('<head>')
        puts("<title>#{context.title}</title>")
        puts('</head>')
        puts('<body>')
        context.text.each do |line|
            puts("<p>#{line}</p>")
        end
        puts('</body>')
        puts('</html>')
    end
end

class PlainTextFormatter
    def output_report(context)
        puts("*** #{context.title} ***")
        context.text.each do |line|
            puts(line)
        end
    end
end

class Report
    attr_reader :title, :text
    attr_accessor :formatter

    def initialize(formatter)
        @title = '月次報告'
        @text = ['順調','最高の調子']
        @formatter = formatter
    end

    def output_report
        @formatter.output_report(self)
    end
end

report = Report.new(HTMLFormatter.new)
report.output_report
puts "-----"
report.formatter = PlainTextFormatter.new
report.output_report

# output結果は下

# <html>
# <head>
# <title>月次報告</title>
# </head>
# <body>
# <p>順調</p>
# <p>最高の調子</p>
# </body>
# </html>
# -----
# *** 月次報告 ***
# 順調
# 最高の調子