package main

import (
	"errors"
	"strconv"
	"time"
)

// 加权因子
var weight = []int{7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2}

// 校验码映射表
var verifyMap = []byte{'1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2'}

// ValidateIDCard 校验 18 位身份证
// 返回 nil 表示校验通过；否则返回具体错误
func ValidateIDCard(id string) error {
	if len(id) != 18 {
		return errors.New("长度必须为 18 位")
	}

	// 1. 前 17 位必须是数字
	for i := 0; i < 17; i++ {
		if id[i] < '0' || id[i] > '9' {
			return errors.New("前 17 位必须全为数字")
		}
	}

	// 2. 校验码
	sum := 0
	for i := 0; i < 17; i++ {
		n, _ := strconv.Atoi(string(id[i]))
		sum += n * weight[i]
	}
	mod := sum % 11
	if id[17] != verifyMap[mod] {
		return errors.New("校验码错误")
	}

	// 3. 出生日期合法性
	birthStr := id[6:14]
	if _, err := time.Parse("20060102", birthStr); err != nil {
		return errors.New("出生日期无效")
	}

	return nil
}

// 示例
func main() {
	cases := []string{
		"11010519491231002X", // 正确
		"110105194912310021", // 校验码错误
		"11010519490230002X", // 日期错误
	}

	for _, c := range cases {
		if err := ValidateIDCard(c); err != nil {
			println(c, "->", err.Error())
		} else {
			println(c, "-> OK")
		}
	}
}