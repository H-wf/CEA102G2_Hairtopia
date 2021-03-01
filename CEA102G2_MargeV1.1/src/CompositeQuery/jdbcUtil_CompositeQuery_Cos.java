/*
 *  1. 萬用複合查詢-可由客戶端隨意增減任何想查詢的欄位
 *  2. 為了避免影響效能:
 *        所以動態產生萬用SQL的部份,本範例無意採用MetaData的方式,也只針對個別的Table自行視需要而個別製作之
 * */


package CompositeQuery;

import java.util.*;

public class jdbcUtil_CompositeQuery_Cos {

	public static String get_aCondition_For_Oracle(String columnName, String value) {

		String aCondition = null;

		if ("cosNo".equals(columnName) || "lecNo".equals(columnName) || "cosTypeNo".equals(columnName) ||
				"cosCount".equals(columnName) || "cosRate".equals(columnName)  || "cosStatus".equals(columnName) || 
				"cosMinCount".equals(columnName) || "cosMaxCount".equals(columnName) || "cosPrice".equals(columnName))// 用於其他
			aCondition = columnName + "=" + value;
		else if ("cosIntro".equals(columnName) || "cosAdd".equals(columnName) || "cosName".equals(columnName)) // 用於varchar
			aCondition = columnName + " like '%" + value + "%'";
		else if ("cosFrom".equals(columnName) || "cosTo".equals(columnName) || "cosApplyFrom".equals(columnName) || "cosApplyTo".equals(columnName))                          // 用於Oracle的date
			aCondition = columnName + "=" + "'" + value + "'";
		return aCondition + " ";
	}

	public static String get_WhereCondition(Map<String, String[]> map) {
		Set<String> keys = map.keySet();
		StringBuffer whereCondition = new StringBuffer();
		int count = 0;
		for (String key : keys) {
			String value = map.get(key)[0];//key可換成"empno"
			if (value != null && value.trim().length() != 0	&& !"action".equals(key)) {//key可換成"empno"
				count++;
				String aCondition = get_aCondition_For_Oracle(key, value.trim());//key可換成"empno"

				if (count == 1)
					whereCondition.append(" where " + aCondition);
				else
					whereCondition.append(" and " + aCondition);

				System.out.println("有送出查詢資料的欄位數count = " + count);
			}
		}
		
		return whereCondition.toString();
	}

	public static void main(String argv[]) {

		// 配合 req.getParameterMap()方法 回傳 java.util.Map<java.lang.String,java.lang.String[]> 之測試
				Map<String, String[]> map = new TreeMap<String, String[]>();
				map.put("cosNo", new String[] { "1" });
				map.put("lecNo", new String[] { "1" });
				map.put("cosTypeNo", new String[] { "1" });
				map.put("cosFrom", new String[] { "2021-01-02 00:00:00" });
				map.put("cosTo", new String[] { "2021-01-04 00:00:00" });
				map.put("cosIntro", new String[] { "瘋狂理髮師大衛德兒，承襲自英國鬼魅紳士剪刀手愛德華。" });
				map.put("cosAdd", new String[] { "台北市100號" });
				map.put("cosCount", new String[] { "0" });// 注意Map裡面會含有action的key
				map.put("cosRate", new String[] { "0" });
				map.put("cosStatus", new String[] { "1" });
				map.put("cosMinCount", new String[] { "60" });
				map.put("cosMaxCount", new String[] { "100" });
				map.put("cosPrice", new String[] { "1000" });
				map.put("cosApplyFrom", new String[] { "2021-01-04 00:00:00" });
				map.put("cosApplyTo", new String[] { "2021-01-04 00:00:00" });
				map.put("cosName", new String[] { "瘋狂理髮師" });
				map.put("action", new String[] { "getXXX" });

				String finalSQL = "select * from course "
						          + jdbcUtil_CompositeQuery_Cos.get_WhereCondition(map)
						          + "order by cosNo";
				System.out.println("●●finalSQL = " + finalSQL);

			}
}
