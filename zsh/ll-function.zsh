# ~/.config/zsh/ll-function.zsh - 高機能lsコマンド

# 高機能な ls コマンド（8進数パーミッション、色付け、日付フォーマット対応）
ll() {
    _ll_print_header
    ls -al "$@" | _ll_process_output
}

# ll関数のヘッダー出力
_ll_print_header() {
    printf "\033[1;33m%-3s %-11s %-3s %-8s %-8s %8s %-16s %s\033[0m\n" \
        "OCT" "PERMISSIONS" "LNK" "OWNER" "GROUP" "SIZE" "UPDATED_AT" "NAME"
}

# ll関数のメイン処理（awk部分）
_ll_process_output() {
    awk '
    BEGIN {
        _init_month_map()
        _get_current_year()
    }
    
    NR > 1 { _process_line() }
    
    function _init_month_map() {
        month_map["Jan"] = "01"; month_map["Feb"] = "02"; month_map["Mar"] = "03"
        month_map["Apr"] = "04"; month_map["May"] = "05"; month_map["Jun"] = "06"
        month_map["Jul"] = "07"; month_map["Aug"] = "08"; month_map["Sep"] = "09"
        month_map["Oct"] = "10"; month_map["Nov"] = "11"; month_map["Dec"] = "12"
    }
    
    function _get_current_year() {
        "date +%Y" | getline current_year
        close("date +%Y")
    }
    
    function _process_line() {
        if (NF < 9) return
        
        oct_permission = _calculate_octal_permission()
        formatted_date = _format_date()
        filename = _extract_filename()
        
        _print_colored_line(oct_permission, formatted_date, filename)
    }
    
    function _calculate_octal_permission(    i, k) {
        k = 0
        for (i = 0; i <= 8; i++) {
            if (substr($1, i+2, 1) ~ /[rwx]/) {
                k += 2^(8-i)
            }
        }
        return k
    }
    
    function _format_date(    month, day, time_or_year, month_num) {
        month = $6
        day = $7
        time_or_year = $8
        
        month_num = month_map[month]
        if (!month_num) month_num = "01"
        
        if (length(day) == 1) day = "0" day
        
        if (index(time_or_year, ":") > 0) {
            return current_year "-" month_num "-" day " " time_or_year
        } else {
            return time_or_year "-" month_num "-" day " 00:00"
        }
    }
    
    function _extract_filename(    i, filename) {
        filename = ""
        for (i = 9; i <= NF; i++) {
            filename = filename (i == 9 ? "" : " ") $i
        }
        return filename
    }
    
    function _print_colored_line(oct_permission, formatted_date, filename,    oct_str, output_line, color) {
        oct_str = (oct_permission > 0) ? sprintf("%3o", oct_permission) : "   "
        
        output_line = sprintf("%-3s %-11s %3s %-8s %-8s %8s %-16s %s", 
                             oct_str, $1, $2, $3, $4, $5, formatted_date, filename)
        
        # 色の選択: ディレクトリ(シアン), シンボリックリンク(緑), ファイル(白)
        if (substr($1, 1, 1) == "d") {
            color = "36"  # シアン
        } else if (substr($1, 1, 1) == "l") {
            color = "32"  # 緑
        } else {
            color = "37"  # 白
        }
        
        printf("\033[%sm%s\033[0m\n", color, output_line)
    }'
}
