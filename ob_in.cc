/*************************************************************************
	> File Name: ob_in.cc
	> Author: Crayon Chaney
	> Mail:mmmmmcclxxvii@gmail.com
	> Created Time: Wed Mar 25 16:35:16 2015
 ************************************************************************/

#include<iostream>
#include<string>
#include<ctime>
#include<cstdio>
using namespace std;


class Birthday{
	public:
		Birthday(int y, int m, int d):year(y),month(m),day(d){}
		void happy_birthday(){
			//CTime t = CTime::GetCurrentTime();
			//int y = t.GetYear();
			int m = 3;
			int d = 28;
			if(m == month && d == day){
				cout << "Happy birthday to you !" << endl;
			}
			else{
				int diff;
				if(m > month || (month == m && day > d) ){
					
					if(day > d) {
						diff = day -d + 31; 
					}else{
						diff = d - day;
					}
					cout << 365 - (m - month)*31 - diff <<" days later will be your birthday" <<endl;
				}else{
					 
					if(day >= d){
						diff = day - d;
					}else{
						diff = 31 - d + day;
					}
					cout << (month - m)*31 + diff << " days later will be your birthday" <<endl; 
				}
			}
		}
		~Birthday(){}
	private:
		int year;
		int month;
		int day;
};
class Person{
	public:
		Person(string nam, int a , char s, int y = 2015 , int m = 3 , int d = 27):name(nam),age(a), sex(s),birth(y,m,d){}
		void basic_info(){
			cout << "========== Person info ===========" <<endl;

			cout << name << endl << age << endl << sex << endl;
			cout << "============person================" <<endl;
		}
		void Grad_info(){
			cout << "Just for the test ." <<endl;
		}
		~Person(){
			cout << "Person class:" << name << "destroy" <<endl;
		}
	protected:
		string name;
		int age;
		char sex;
		Birthday birth;
};

class Teacher:virtual public Person{
	public:
		Teacher(string nam, int a, char s, string sub,int n):Person(nam, a , s),subject(sub),num(n){}
		void Tea_info(){
			cout << "======== Teacher info ==========" <<endl;
			basic_info();
			cout << "Teacher ID " << num <<endl;
			cout << "I teach : " << subject << endl;
			cout << "===========teacher==============" <<endl;
		}
		~Teacher(){
			cout << "Teacher class: " << name << "destroy" <<endl;
		}
	protected:
		string subject;
		int num;
};

class Student:virtual public Person{
	public:
		Student(string nam, int a, char s, string pro,int n):Person(nam,a,s),major(pro),num(n){}
		void Stu_info(){
			cout << "========== Student info =========" << endl;
			basic_info();
			cout << "Student ID " << num <<endl;
			cout << "Major in : "<< major << endl;
			cout << "========== student ==============" <<endl;
		}
		~Student(){
			cout << "Student class: " << name << "destroy" <<endl;
		}
	protected:
		string major;
		int num;
};

class Professor: public Teacher{
	public:
		Professor(string nam,int a, char s, string sub,int n, string proj):Person(nam,a,s),Teacher(nam,a,s,sub,n),project(proj){}
		void Prof_info(){
			cout << "====== Professor info =========" << endl;
			Tea_info();
			cout << "Undertaking project : "<< project << endl;
		   cout << "======== professor ============" <<endl;	
		}
		~Professor(){
			cout << "Professor class : " << name << "destroy" << endl;
		}
	private:
		string project;
};

class Graduate: public Teacher , public Student{
	public:
		Graduate(string nam, int a, char s, string sub,int nt,string pro,int ns,double pay):Person(nam,a,s),Teacher(nam,a,s,sub,nt),Student(nam,a,s,pro,ns),pays(pay){}
		void Grad_info(){
			cout << "=========== Graduate info ===========" <<endl;
			Tea_info();
			Stu_info();
			cout << "Payment : " << pays <<endl;
			cout << "test unspecify num : " <<Student::num <<endl;
		} 

		void g_birth(){
			birth.happy_birthday();
		}
		~Graduate(){
			cout << "Graduate class : " << name << "destroy" <<endl;
		}
	private:
		double pays;
};


int main(){
	Person p("chenye",21,'f');
	Teacher t("Taohaijun",35,'f',"C++",10010);
	Student s("xuqiqi",23,'m',"Marketing",1030444217);
	Professor f("Jobs",45,'f',"Macintosh",0,"Apple");
	Graduate g("chenye_f",22,'f',"Computer Science",77,"Linux",277,5277.88);

	g.Grad_info();
	g.g_birth();

	f.Prof_info();
	
	cout << endl << endl <<endl;

	Person *pt = &p;
	pt->basic_info();
	pt = &g;
	cout << endl << endl << endl;
	pt->Grad_info();
	// g.birth.happy_birthday();


	return 0;
}
