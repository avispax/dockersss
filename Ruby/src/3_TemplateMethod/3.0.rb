class Report
    def initialize
        @title ='月次報告'
        @text = ['順調','最高の調子']
    end

    def output_report
        puts('<html>')
        puts('<head>')
        puts("<title>#{@title}</title>")
        puts('</head>')
        puts('<body>')
        @text.each do |line|
            puts("<title>#{line}</title>")
        end
        puts('</body>')
        puts('</html>')
    end
end

report = Report.new
report.output_report

# output結果は下

# <html>
# <head>
# <title>月次報告</title>
# </head>
# <body>
# <title>順調</title>
# <title>最高の調子</title>
# </body>
# </html>