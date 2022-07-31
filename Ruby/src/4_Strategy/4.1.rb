# p.72
# 4.1 委譲の形にしてFormatterクラスに出力ロジックを集約する。

class Formatter
    def output_report(title, text)
        raise 'Abstract method called'
    end
end

class HTMLFormatter < Formatter
    def output_report(title, text)
        puts('<html>')
        puts('<head>')
        puts("<title>#{title}</title>")
        puts('</head>')
        puts('<body>')
        text.each do |line|
            puts("<p>#{line}</p>")
        end
        puts('</body>')
        puts('</html>')
    end
end

class PlainTextFormatter < Formatter
    def output_report(title, text)
        puts("*** #{title} ***")
        text.each do |line|
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
        @formatter.output_report(@title, @text)
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