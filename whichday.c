/*************************************************************************
	> File Name: whichday.c
	> Author: Crayon Chaney
	> Mail:mmmmmcclxxvii@gmail.com
	> Created Time: Mon 13 Nov 2017 05:27:01 AM CST
 ************************************************************************/

#include<stdio.h>
#include<stdlib.h>

#define ISLEAPYEAR(x) ((!x%4 && x%100) || (!x%400))

struct date{
	int year;
	int month;
	int day;
};

void testShowDate(struct date d){
	printf("year :%d\nmonth:%d\nday  :%d\n",d.year,d.month,d.day);
}

int main(){
	int dayInMonth[2][12] = {
		{
			31,28,31,30,31,30,31,31,30,31,30,31
		},
		{
			31,29,31,30,31,30,31,31,30,31,30,31
		}
	};

	struct date nowday;
	while(scanf("%d%d%d",&nowday.year,&nowday.month,&nowday.day)!=EOF){
		/* testShowDate(nowday); */
		int totaldaysince = 0;
		for(int year = 1990;year<nowday.year;year++){
			if(ISLEAPYEAR(year)){
				totaldaysince += 366;
			}else{
				totaldaysince += 365;
			}
		}
		int isleapyear = ISLEAPYEAR(nowday.year);
		for(int mon = 1; mon < nowday.month; mon ++){
			totaldaysince += dayInMonth[isleapyear][mon-1]; 
		}

		totaldaysince += nowday.day;
		printf("days since 1990/1/1 :%d\n",totaldaysince);
		if((totaldaysince%5)%4){
			printf("fishing day\n");
		}else{
			printf("resting day\n");
		}
		
	}
	return 0;
}
