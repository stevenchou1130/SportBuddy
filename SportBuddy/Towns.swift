//
//  Towns.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/3/31.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import Foundation

// swiftlint:disable type_body_length
struct Towns {

    var list = [
        "臺北市中正": "1",
        "臺北市大同": "2",
        "臺北市中山": "3",
        "臺北市松山": "4",
        "臺北市大安": "5",
        "臺北市萬華": "6",
        "臺北市信義": "7",
        "臺北市士林": "8",
        "臺北市北投": "9",
        "臺北市內湖": "10",
        "臺北市南港": "11",
        "臺北市文山": "12",
        "基隆市仁愛": "13",
        "基隆市信義": "14",
        "基隆市中正": "15",
        "基隆市中山": "16",
        "基隆市安樂": "17",
        "基隆市暖暖": "18",
        "基隆市七堵": "19",
        "新北市萬里": "20",
        "新北市金山": "21",
        "新北市板橋": "26",
        "新北市汐止": "27",
        "新北市深坑": "28",
        "新北市石碇": "29",
        "新北市瑞芳": "30",
        "新北市平溪": "31",
        "新北市雙溪": "32",
        "新北市貢寮": "33",
        "新北市新店": "34",
        "新北市坪林": "35",
        "新北市烏來": "36",
        "新北市永和": "37",
        "新北市中和": "38",
        "新北市土城": "39",
        "新北市三峽": "40",
        "新北市樹林": "41",
        "新北市鶯歌": "42",
        "新北市三重": "43",
        "新北市新莊": "44",
        "新北市泰山": "45",
        "新北市林口": "46",
        "新北市蘆洲": "47",
        "新北市五股": "48",
        "新北市八里": "49",
        "新北市淡水": "50",
        "新北市三芝": "51",
        "新北市石門": "52",
        "連江縣南竿": "22",
        "連江縣北竿": "23",
        "連江縣莒光": "24",
        "連江縣東引": "25",
        "宜蘭縣宜蘭": "53",
        "宜蘭縣頭城": "54",
        "宜蘭縣礁溪": "55",
        "宜蘭縣壯圍": "56",
        "宜蘭縣員山": "57",
        "宜蘭縣羅東": "58",
        "宜蘭縣三星": "59",
        "宜蘭縣大同": "60",
        "宜蘭縣五結": "61",
        "宜蘭縣冬山": "62",
        "宜蘭縣蘇澳": "63",
        "宜蘭縣南澳": "64",
        "新竹市東區": "65",
        "新竹市香山": "66",
        "新竹市北區": "67",
        "新竹縣竹北": "68",
        "新竹縣湖口": "69",
        "新竹縣新豐": "70",
        "新竹縣新埔": "71",
        "新竹縣關西": "72",
        "新竹縣芎林": "73",
        "新竹縣寶山": "74",
        "新竹縣竹東": "75",
        "新竹縣五峰": "76",
        "新竹縣橫山": "77",
        "新竹縣尖石": "78",
        "新竹縣北埔": "79",
        "新竹縣峨眉": "80",
        "桃園市中壢": "81",
        "桃園市平鎮": "82",
        "桃園市龍潭": "83",
        "桃園市楊梅": "84",
        "桃園市新屋": "85",
        "桃園市觀音": "86",
        "桃園市桃園": "87",
        "桃園市龜山": "88",
        "桃園市八德": "89",
        "桃園市大溪": "90",
        "桃園市復興": "91",
        "桃園市大園": "92",
        "桃園市蘆竹": "93",
        "苗栗縣竹南": "94",
        "苗栗縣頭份": "95",
        "苗栗縣三灣": "96",
        "苗栗縣南庄": "97",
        "苗栗縣獅潭": "98",
        "苗栗縣後龍": "99",
        "苗栗縣通霄": "100",
        "苗栗縣苑裡": "101",
        "苗栗縣苗栗": "102",
        "苗栗縣造橋": "103",
        "苗栗縣頭屋": "104",
        "苗栗縣公館": "105",
        "苗栗縣大湖": "106",
        "苗栗縣泰安": "107",
        "苗栗縣銅鑼": "108",
        "苗栗縣三義": "109",
        "苗栗縣西湖": "110",
        "苗栗縣卓蘭": "111",
        "臺中市中區": "112",
        "臺中市東區": "113",
        "臺中市南區": "114",
        "臺中市西區": "115",
        "臺中市北區": "116",
        "臺中市北屯": "117",
        "臺中市西屯": "118",
        "臺中市南屯": "119",
        "臺中市太平": "120",
        "臺中市大里": "121",
        "臺中市霧峰": "122",
        "臺中市烏日": "123",
        "臺中市豐原": "124",
        "臺中市后里": "125",
        "臺中市石岡": "126",
        "臺中市東勢": "127",
        "臺中市和平": "128",
        "臺中市新社": "129",
        "臺中市潭子": "130",
        "臺中市大雅": "131",
        "臺中市神岡": "132",
        "臺中市大肚": "133",
        "臺中市沙鹿": "134",
        "臺中市龍井": "135",
        "臺中市梧棲": "136",
        "臺中市清水": "137",
        "臺中市大甲": "138",
        "臺中市外埔": "139",
        "臺中市大安": "140",
        "彰化縣彰化": "141",
        "彰化縣芬園": "142",
        "彰化縣花壇": "143",
        "彰化縣秀水": "144",
        "彰化縣鹿港": "145",
        "彰化縣福興": "146",
        "彰化縣線西": "147",
        "彰化縣和美": "148",
        "彰化縣伸港": "149",
        "彰化縣員林": "150",
        "彰化縣社頭": "151",
        "彰化縣永靖": "152",
        "彰化縣埔心": "153",
        "彰化縣溪湖": "154",
        "彰化縣大村": "155",
        "彰化縣埔鹽": "156",
        "彰化縣田中": "157",
        "彰化縣北斗": "158",
        "彰化縣田尾": "159",
        "彰化縣埤頭": "160",
        "彰化縣溪州": "161",
        "彰化縣竹塘": "162",
        "彰化縣二林": "163",
        "彰化縣大城": "164",
        "彰化縣芳苑": "165",
        "彰化縣二水": "166",
        "南投縣南投": "167",
        "南投縣中寮": "168",
        "南投縣草屯": "169",
        "南投縣國姓": "170",
        "南投縣埔里": "171",
        "南投縣仁愛": "172",
        "南投縣名間": "173",
        "南投縣集集": "174",
        "南投縣水里": "175",
        "南投縣魚池": "176",
        "南投縣信義": "177",
        "南投縣竹山": "178",
        "南投縣鹿谷": "179",
        "嘉義市西區": "180",
        "嘉義市東區": "181",
        "嘉義縣番路": "182",
        "嘉義縣梅山": "183",
        "嘉義縣竹崎": "184",
        "嘉義縣阿里": "185",
        "嘉義縣中埔": "186",
        "嘉義縣大埔": "187",
        "嘉義縣水上": "188",
        "嘉義縣鹿草": "189",
        "嘉義縣太保": "190",
        "嘉義縣朴子": "191",
        "嘉義縣東石": "192",
        "嘉義縣六腳": "193",
        "嘉義縣新港": "194",
        "嘉義縣民雄": "195",
        "嘉義縣大林": "196",
        "嘉義縣溪口": "197",
        "嘉義縣義竹": "198",
        "嘉義縣布袋": "199",
        "雲林縣斗南": "200",
        "雲林縣大埤": "201",
        "雲林縣虎尾": "202",
        "雲林縣土庫": "203",
        "雲林縣褒忠": "204",
        "雲林縣東勢": "205",
        "雲林縣台西": "206",
        "雲林縣崙背": "207",
        "雲林縣麥寮": "208",
        "雲林縣斗六": "209",
        "雲林縣林內": "210",
        "雲林縣古坑": "211",
        "雲林縣莿桐": "212",
        "雲林縣西螺": "213",
        "雲林縣二崙": "214",
        "雲林縣北港": "215",
        "雲林縣水林": "216",
        "雲林縣口湖": "217",
        "雲林縣四湖": "218",
        "雲林縣元長": "219",
        "臺南市中西": "220",
        "臺南市東區": "221",
        "臺南市南區": "222",
        "臺南市北區": "223",
        "臺南市安平": "224",
        "臺南市安南": "225",
        "臺南市永康": "226",
        "臺南市歸仁": "227",
        "臺南市新化": "228",
        "臺南市左鎮": "229",
        "臺南市玉井": "230",
        "臺南市楠西": "231",
        "臺南市南化": "232",
        "臺南市仁德": "233",
        "臺南市關廟": "234",
        "臺南市龍崎": "235",
        "臺南市官田": "236",
        "臺南市麻豆": "237",
        "臺南市佳里": "238",
        "臺南市西港": "239",
        "臺南市七股": "240",
        "臺南市將軍": "241",
        "臺南市學甲": "242",
        "臺南市北門": "243",
        "臺南市新營": "244",
        "臺南市後壁": "245",
        "臺南市白河": "246",
        "臺南市東山": "247",
        "臺南市六甲": "248",
        "臺南市下營": "249",
        "臺南市柳營": "250",
        "臺南市鹽水": "251",
        "臺南市善化": "252",
        "臺南市大內": "253",
        "臺南市山上": "254",
        "臺南市新市": "255",
        "臺南市安定": "256",
        "高雄市新興": "257",
        "高雄市前金": "258",
        "高雄市苓雅": "259",
        "高雄市鹽埕": "260",
        "高雄市鼓山": "261",
        "高雄市旗津": "262",
        "高雄市前鎮": "263",
        "高雄市三民": "264",
        "高雄市楠梓": "265",
        "高雄市小港": "266",
        "高雄市左營": "267",
        "高雄市仁武": "268",
        "高雄市大社": "269",
        "高雄市岡山": "270",
        "高雄市路竹": "271",
        "高雄市阿蓮": "272",
        "高雄市田寮": "273",
        "高雄市燕巢": "274",
        "高雄市橋頭": "275",
        "高雄市梓官": "276",
        "高雄市彌陀": "277",
        "高雄市永安": "278",
        "高雄市湖內": "279",
        "高雄市鳳山": "280",
        "高雄市大寮": "281",
        "高雄市林園": "282",
        "高雄市鳥松": "283",
        "高雄市大樹": "284",
        "高雄市旗山": "285",
        "高雄市美濃": "286",
        "高雄市六龜": "287",
        "高雄市內門": "288",
        "高雄市杉林": "289",
        "高雄市甲仙": "290",
        "高雄市桃源": "291",
        "高雄市那瑪": "292",
        "高雄市茂林": "293",
        "高雄市茄萣": "294",
        "澎湖縣馬公": "295",
        "澎湖縣西嶼": "296",
        "澎湖縣望安": "297",
        "澎湖縣七美": "298",
        "澎湖縣白沙": "299",
        "澎湖縣湖西": "300",
        "金門縣金沙": "301",
        "金門縣金湖": "302",
        "金門縣金寧": "303",
        "金門縣金城": "304",
        "金門縣烈嶼": "305",
        "金門縣烏坵": "306",
        "屏東縣屏東": "307",
        "屏東縣三地": "308",
        "屏東縣霧台": "309",
        "屏東縣瑪家": "310",
        "屏東縣九如": "311",
        "屏東縣里港": "312",
        "屏東縣高樹": "313",
        "屏東縣鹽埔": "314",
        "屏東縣長治": "315",
        "屏東縣麟洛": "316",
        "屏東縣竹田": "317",
        "屏東縣內埔": "318",
        "屏東縣萬丹": "319",
        "屏東縣潮州": "320",
        "屏東縣泰武": "321",
        "屏東縣來義": "322",
        "屏東縣萬巒": "323",
        "屏東縣崁頂": "324",
        "屏東縣新埤": "325",
        "屏東縣南州": "326",
        "屏東縣林邊": "327",
        "屏東縣東港": "328",
        "屏東縣琉球": "329",
        "屏東縣佳冬": "330",
        "屏東縣新園": "331",
        "屏東縣枋寮": "332",
        "屏東縣枋山": "333",
        "屏東縣春日": "334",
        "屏東縣獅子": "335",
        "屏東縣車城": "336",
        "屏東縣牡丹": "337",
        "屏東縣恆春": "338",
        "屏東縣滿州": "339",
        "臺東縣臺東": "340",
        "臺東縣綠島": "341",
        "臺東縣蘭嶼": "342",
        "臺東縣延平": "343",
        "臺東縣卑南": "344",
        "臺東縣鹿野": "345",
        "臺東縣關山": "346",
        "臺東縣海端": "347",
        "臺東縣池上": "348",
        "臺東縣東河": "349",
        "臺東縣成功": "350",
        "臺東縣長濱": "351",
        "臺東縣太麻": "352",
        "臺東縣金峰": "353",
        "臺東縣大武": "354",
        "臺東縣達仁": "355",
        "花蓮縣花蓮": "356",
        "花蓮縣新城": "357",
        "花蓮縣秀林": "358",
        "花蓮縣吉安": "359",
        "花蓮縣壽豐": "360",
        "花蓮縣鳳林": "361",
        "花蓮縣光復": "362",
        "花蓮縣豐濱": "363",
        "花蓮縣瑞穗": "364",
        "花蓮縣萬榮": "365",
        "花蓮縣玉里": "366",
        "花蓮縣卓溪": "367",
        "花蓮縣富里": "368"
    ]

}
// swiftlint:enable type_body_length
