class Report
    def initialize
        @title ='月次報告'
        @text = ['順調','最高の調子']
    end

    def output_report
        output_start
        output_head
        output_body_start
        output_body
        output_body_end
        output_end
    end

    def output_start
    end

    def output_head
        output_line(@title)
    end

    def output_body_start
    end

    def output_body
        @text.each do |line|
            output_line(line)
        end
    end

    def output_line(line)
        raise 'Called abstract method: output_line'
    end

    def output_body_end
    end

    def output_end
    end

end

class HTMLReport < Report
    def output_start
        puts('<html>')
    end

    def output_head
        puts('<head>')
        puts("<title>#{@title}</title>")
        puts('</head>')
    end

    def output_body_start
        puts('<body>')
    end

    def output_line(line)
        puts("<p>#{line}</p>")
    end

    def output_body_end
        puts('</body>')
    end

    def output_end
        puts('</html>')
    end
end

class PlainTextReport < Report
    def output_head
        puts("*** #{@title} ***")
    end

    def output_line(line)
        puts(line)
    end
end

report = HTMLReport.new
report.output_report
puts "-----"
report = PlainTextReport.new
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