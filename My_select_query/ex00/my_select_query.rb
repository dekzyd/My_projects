class MySelectQuery
    def initialize(csv_content)
        @csv = csv_content
    end

    def where(column_name, criteria)
        @col_name = column_name
        @crit = criteria
        # split csv
        @rows = @csv.split("\n")
        for i in 0..@rows.length - 1
            @col = @rows[i].split(",")
            if @col.include?(@crit)
                return [@rows[i]]
            end
        end
    end
end