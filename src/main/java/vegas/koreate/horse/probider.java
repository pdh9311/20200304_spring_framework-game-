
	package vegas.koreate.horse;

	import javax.inject.Inject;

import org.apache.ibatis.jdbc.SQL;

import vegas.koreate.horse.dao.HDAO;
import vegas.koreate.horse.vo.HVO;

	public class probider {
		
		
		@Inject
		HVO hvo;
		HDAO hdao;
		
		
		public String update_total(int hnum) throws Exception {
			
			SQL sql = new SQL() 
			{
		
				
				{
					if(hnum==1) {
					UPDATE("h_total");
					SET("h1 + hbet");
					WHERE("where hnum ==1");
					}else if(hnum==2){
					UPDATE("h_total");
					SET("h2 + hbet");
					WHERE("where hnum ==2");
					}else if(hnum==3){
					UPDATE("h_total");
					SET("h3 + hbet");
					WHERE("where hnum ==3");
					}else if(hnum==4){
					UPDATE("h_total");
					SET("h4 + hbet");
					WHERE("where hnum ==4");
					}else if(hnum==5){
					UPDATE("h_total");
					SET("h5 + hbet");
					WHERE("where hnum ==5");
					}else if(hnum==6){
					UPDATE("h_total");
					SET("h6 + hbet");
					WHERE("where hnum ==6");
					}else if(hnum==7){
					UPDATE("h_total");
					SET("h7 + hbet");
					WHERE("where hnum ==7");
					}else if(hnum==8){
					UPDATE("h_total");
					SET("h8 + hbet");
					WHERE("where hnum ==8");
				}
				
				}
				};
			String query= sql.toString();
			System.out.println(query);
			return query;
			
		}
		
		
public String victory(int hnum) throws Exception {
			
			SQL sql = new SQL() 
			{
		
				
				{
					switch(hnum) {
					
					case '1' :
					SELECT("h1"); FROM("h_total");
						break;
					case '2' :
						SELECT("h2"); FROM("h_total");
							break;
					case '3' :
						SELECT("h3"); FROM("h_total");
							break;		
					case '4' :
						SELECT("h4"); FROM("h_total");
							break;
					case '5' :
						SELECT("h5"); FROM("h_total");
							break;
					case '6' :
						SELECT("h6"); FROM("h_total");
							break;
					case '7' :
						SELECT("h7"); FROM("h_total");
							break;
					case '8' :
					SELECT("h8"); FROM("h_total");
						break;
				}
				}
				
				
			};
			String query= sql.toString();
			System.out.println(query);
			
			
			return query;
			
		}
		
		
		
	


}
