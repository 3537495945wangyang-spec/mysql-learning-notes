# Sharpen your thinking.
##  first code
## variable
1. 作为一个变量存储数字、字母、字符串
- 类似与数学当中的x,区别是不局限于数字
2. 八个基本变量类型
- 有一个特殊的规则，使用float类型的时候，需要在值的后面加上f
3. 基本数据类型（primitive）与引用数据类型（reference）的区别
- 字节数，基本数据类型一般占8个字节，引用数据类型没有界限，由使用者决定（user defined）
- 基本数据类型只有数据，引用数据类型既有数字又有地址
- 基本数据类型只有一个值，引用数据类型有多个值
- 基本数据类型使用的内存少，引用数据类型占用内存多
- 基本数据类型操作更快
4. 如何create a variable
- declaration 声明变量 int x;
- assignment 赋值 x = 123;
- initialization 初始化 int x = 123;
5. 变量之间值的互换
```java
String x = "water";
String y = "coffee";
String temp = null;//temperate临时

temp = x;
x = y;
y = temp;
```
6. 自动类型转换
	byte → short → int → long → float → double
           ↗
         char
    小范围类型自动转换为大范围类型，无需显示声明
	自动转换的场景
	    - **赋值时**：double d = 100; （int → double）
		- **方法调用时**：Math.sqrt(25);  （int → double）
		- **表达式计算时**：不同类型运算，自动向大类型转换
		- char类型可以自动转换为int反过来不行
			-  char c = 'a' ; int i = 66;
			 int n = i+c ;√
			 c = n ;×
		- **返回值**：方法返回时自动转换
	强制转换的风险
		精度丢失（浮点数 → 整数）
		数据溢出（大范围整数 → 小范围整数）
	    意外结果（负数转换）
	    表达式中自动提升（整数相加自动提升为int 
	    小数相加自动提升为double）
	```java
	// 溢出示例
int bigNum = 1000;
byte small = (byte) bigNum;  // 1000 → -24（溢出！）

// 浮点数截断
double precise = 9.999999;
int rough = (int) precise;  // 9（不是10！）

// 负数转换
int negative = 130
byte b = (byte) negative;  // -126
	```

## Scanner
1. 导包 `import java.util.Scanner;`
2. 创建对象`Scanner sc = new Scanner(System.in);`
3. `Int x = sc.nextInt();`
4. `sc.nextLine();`
5. `String y = sc.nextLine;`
- ### **==next nextInt nextLine的区别==
	
	- next 读取下一个字符串 遇到空白符制表符 换行符停止**不能读取换行符**
	- nextInt 读取下一个整数 遇到非数字符停止**不能读取换行符**
	- nextLine 读取一整行 直到换行符 **读取并且丢弃换行符**
	``` java
	//### 方案1：在 nextInt() 后加额外的 nextLine()
	System.out.print("请输入年龄: ");
	int age = sc.nextInt();
	String uesName = sc.next();
	//⭐ 输入完之后会停止，但是打进去的回车“\n”还在，所以如果后面接的是nextLine 的话会导致后面的直接关闭哦！
	sc.nextLine();  // ⭐ 关键：消耗掉残留的换行符

	System.out.print("请输入姓名: ");
	String name = sc.nextLine();  // 现在正常了
	//方案2：全部使用 nextLine()，然后转换
	System.out.print("请输入年龄: ");
	int age = Integer.parseInt(sc.nextLine());  // 读取整行，转为int

	System.out.print("请输入姓名: ");
	String name = sc.nextLine();
	```
## expression 表达式 
1. 加减乘除
2. 进行**加法**因为加号也可以作为字符串对象的连接，如果一个字符串类型加一个其他数据类型会自动将其他数据类型转为字符串
3. 进行**除法**时，如果除数或者被除数出现浮点数则结果是浮点数
4. 取%**余数时如果出现负数** 规则是余数的符号与被除数相同且余数的绝对值小于除数的（==可以直接把负号去掉进行计算，再通过被除数的符号考虑加上符号==）
5. 位运算符
	1. &（按位与）：两位都为1，结果才为1；
	2. |（按位或）：有一位为1，结果就为1；
	3. ^（按位异或）：两位不同为1，相同为0；
	4. ~（按位取反）：0变1，1变0；
	5. <<（左移）：左移指定位数，低位补0；
	6. />>（右移）：右移，保留符号位；（整数为0，负数为1）
	7./ >>>（无符号右移）：右移，左边补0。
- 简单写法
		前自增 先加1再使用该变量
		后自增先使用该变量再加1
`friends++；friends--；`
- 使用除法的时候，因为除不尽会忽略小数部分，如果要保留就得强转为double类型
`double friends = 10; friends = (double) friends/3;`
## GUI
`import javax.swing.JOptionPane;`
```java
String name = JOptionPane.showInputDialog("请输入你的名字");  
JOptionPane.showMessageDialog(null,"hello "+name);    
int age = Integer.parseInt(JOptionPane.showInputDialog("请输入你的年龄"));
//JOptionPane输出的是字符串  
JOptionPane.showMessageDialog(null,"you are "+age+" years old");    
double height = Double.parseDouble(JOptionPane.showInputDialog("请输入你的身高"));
JOptionPane.showMessageDialog(null,"you are "+height+" cm");
```
## Math API
1. max`Math.max(x,y);`
2. min
3. abs 绝对值`Math.abs();`
4. sqrt平方根`Math.sqrt();`
5. round四舍五入
6. ceil 向上舍入 floor向下舍入
7. 计算斜边
```java
double x;  
double y;  
double z;  
Scanner sc = new Scanner(System.in);  
System.out.println("Enter side x:  ");  
x = sc.nextDouble();  
System.out.println("Enter side y:  ");  
y = sc.nextDouble();    
z = Math.sqrt(x*x + y*y);  
System.out.println("The hypotenuse is " + z);
sc.close();
```
8. random生成的随机数属于伪随机数，是数学算法产生的，可以预测的
```java
Random random = new Random();  
int x = random.nextInt(6) + 1; //括号里限制的是最大值，加上一后生成1-6 
boolean y = random.nextBoolean();
```
## if statement
perform a block of code if it's condition evaluates to be true
展示一部分代码当条件为真的时候 
- 如果if或else花括号中只有一条语句可以省略花括号
## Switch
statement that allows a variable to be tested for equality against a list of values
替代多个if语句 开关有多种可能匹配的值
- ==case加上条件之后加的是**冒号**
 
```java
String day = "Friday";  
switch (day){  
    case "Monday":  
        System.out.println("Today is Monday");  
     //case "Monday" -> System.out.println("Today is Monday");  
  break;  
  case "Tuesday":  
        System.out.println("Today is Tuesday");  
  break;  
  case "Wednesday":  
        System.out.println("Today is Wednesday");  
  break;  
  case "Thursday":  
        System.out.println("Today is Thursday");  
  break;  
  case "Friday":  
        System.out.println("Today is Friday,i love it");
  default:
			  System.out.println("That is not a day");
```
- 多值匹配 箭头写法不会贯穿,==同时可以完成赋值==
```java
```String type = switch (day) {
    case 1, 2, 3, 4, 5 -> "工作日";
    case 6, 7 -> "周末";
    default -> "无效日期";
};```
```
- 当case里面有多个语句时 用yield返回结果
	- yield需要在大括号中使用，需要有default条件
	- return会直接跳出当前方法或者循环，yield只会跳出Switch块
```java
```int score = 85;
String level = switch (score / 10) {
    case 10, 9 -> "优秀";
    case 8 -> {
        System.out.println("良好");
        yield "良好";
    }
    case 7 -> "中等";
    case 6 -> "及格";
    default -> "不及格";
};```
```
## & and | and !逻辑运算符
1. && both condition must be true
```java
int temp = 25;  
if(temp > 30){  
    System.out.println("It's hot outside");  
} else if (temp > 20 && temp <=30) {  
    System.out.println("It's warm outside");  
}else if (temp > 10 && temp <=20) {  
    System.out.println("It's cold outside");  
} else {  
    System.out.println("It's very cold outside");  
}
```
2. || either condition must be true
```java
String respond = "q";  
if(respond.equals("q") || respond.equals("Q")) {  
    System.out.println("Goodbye");  
  }else {  
    System.out.println("Still playing");  
}
```
3. ! reverses boolean value of a condition
```java
String respond = "q";  
if(!respond.equals("q") && !respond.equals("Q")) {  
    System.out.println("Still playing");  
  }else {  
    System.out.println("Goodbye");  
}
```
## 循环 
1.  While 
> executes(执行) a block of code as long as a it's condition remains true  
```java
String name = "";  
while(name.isBlank()){  
    System.out.println("Enter your name: ");  
  name = sc.nextLine();  
}  
System.out.println("Hello " + name);
```
2. do while 循环至少执行一次再检查条件
```java
String name = "";  
do{  
    System.out.println("Enter your name: ");  
  name = sc.nextLine();  
}  while(name.isBlank());
System.out.println("Hello " + name);
```
3. for loop 
 >for loop = executes(执行)  a block of code a limited amount of times
 
  for(index索引/count计数器；condition；端口)
```java
for(int i = 0;i<=10;i++){
	System.out.println(i);
}
```
可以有多个变量，中间用逗号分割
4. 循环嵌套 
>nested loops = a loop inside of a loop

```java
int rows;  
int columns;  
String symbol;  
System.out.println("Enter number of rows: ");  
rows = sc.nextInt();  
System.out.println("Enter number of columns: ");  
columns = sc.nextInt();  
System.out.println("Enter symbol: ");  
symbol = sc.next();  
for(int i = 1;i<=rows;i++){  
    System.out.println();  
  for(int j = 1; j<=columns;j++){  
        System.out.print(symbol);  
  }  
}
```
5. break跳出循环 带标签的可以跳出循环结构或者语句块
```java
```outer:
for (int i = 1; i <= 3; i++) {
    for (int j = 1; j <= 3; j++) {
        if (i == 2 && j == 2) {
            break outer; // 直接跳出 outer 标签的循环
        }
        System.out.println(i + "," + j);
    }
}```
```
6. continue 终止当前的迭代，从下次迭代开始
```java
```outer:
for (int i = 1; i <= 3; i++) {
    for (int j = 1; j <= 3; j++) {
        if (i == 2 && j == 2) {
            continue outer;
        }
        System.out.println(i + "," + j);
    }
}```
```
## **==Array==**
> used to store multiple values in a single variable
> 存储单个变量中的多个值
>2 demonstrate array = an array of arrays
```java
String[] cars = {"ss","fsd","sff"};
String[] ages = new String[3];
String[] cars = student[1];//

义一个新数组拿出原来二维数组中的一行
```
``
- 数组的**复制 **
```java
int [] arrays = {4,30,34,7,12,2};  
//数组的复制  
int [] arrays1 = arrays;  
// 不是复制，只是让 arrays1和arrays 指向同一个数组
  
int[] arrays2 = new  int[arrays.length];  
//                               原数组  原起始位置  后数组  后起始位置  长度  
System.arraycopy(arrays,             0,        arrays2,          0,     arrays.length);  
import java.util.Arrays;
int[] array4 = Arrays.copyOf(arrays,arrays.length);  
//自动创建新数组 只能从零开始 需要导入arraysAPI
```

- 数组的排序
	-    Arrays.sort(arr)是对整个数组排序的简写；
		Arrays.sort(arr, 0, arr.length)是区间排序的特例；（有可能出现数组索引越界的问题）
		**两者结果相同，但语义不同，后者更灵活，前者更简洁安全。**
- 数组的比较
	-  (a.equals(b));//比较的是地址 
	- Arrays.equals(a,b));//比较的是内容  
		- Arrays.equals()对基本类型数组直接比值（int double）
			对于自己创建的==对象数组 需要重写equals==
			不然对象默认equals等价于=
			**String**可以直接使用是因为**已经重写**过了
	- Arrays.deepEquals(a, b)//比较多维数组
	```java
		int[][] d = new int[2][2];  
		int[][] e = new int[2][2];  
		for (int j = 0; j <d.length ; j++) {  
		Arrays.fill(d[j],45);  
		}  
		for (int jj = 0; jj <e.length ; jj++) {  
		Arrays.fill(e[jj],45);  
		}  
		System.out.println(Arrays.deepEquals(d,e));
		//比较整个多维数组true
		System.out.println(Arrays.equals(d,e));
		//仅比较第一行而且是“==”false
	```
- 数组的填充
	- 一维数组的填充
		```java
		```int[] a = new int[5];
		Arrays.fill(a, 45);
		int[] a = new int[5];
		Arrays.fill(a, 1, 4, 99);//左闭右开```
		```
	- 二维数组的填充
		```java
		//遍历，逐行填充
		```for (int i = 0; i < d.length; i++) {
	    Arrays.fill(d[i], 45);}```
		//增强for循环写法
	    for (int[] row : d) {
	    Arrays.fill(row, 45);
		}
	    ```
	- 对象数组的填充
		不能直接使用fill这样每个位置填进去的是同一个对象，一个改变之后就都会发生改变
		```java
		```for (int i = 0; i < s.length; i++) {
		    s[i] = new Student();}```
		```
- 增强for循环
		- 一维数组
		int[] arr = {1, 2, 3, 4};
		for (int num : arr) {
	    System.out.println(num);}
		- 二维数组
		for (int[] row : matrix) {
	    for (int num : row) {
        System.out.print(num + " ");
	    }
		适合使用于遍历元素，只有对象内容可以修改 基本类型不能修改内容
    
		
## String
- 字符串字面值不可以分在两行来写 但可以用+链接
	```java
	```String s = "我爱Java" 
				“怎么可能”;  ❌️
	String s =  "我爱Java" +
				“怎么可能”;  ✅️
				
	```
- 常用String方法	
	- isEmpty()：判断字符串长度是否为 0
		isBlank()：判断字符串是否为空 或只包含空白字符
```java
 String name = "  Stick  ";  
boolean result = name.equals("Stick");  
int result = name.length();  
char letter = name.charAt(0);  
int result = name.indexOf("S");  
boolean result = name.isEmpty();  
String result = name.toUpperCase(); 
String result = name.toLowerCase(); 
String result = name.trim();//移除空白  
String result = name.replace('t','l');
```
## Wrapper包装类
>由原始数据类型变化为引用数据类型
>引用数据类型含有一些特别的方法可供使用useful methods

auto boxing自动类型转换
`Boolean a = true
Character b = ‘a’
Integer c = 23
Double d c= 2.14
String e = "Stick"` 
## Array List
```java
List<String> food = new ArrayList<String>();  
food.add("pizza");  
food.add("hamburger");  
food.add("hotdog");  
food.set(0,"sushi");  
food.remove(2);  
food.clear();  
for(int i=0;i<food.size();i++){  
    System.out.println(food.get(i));  
}
```

- 2 D Array List 
>a dynamic list of lists动态列表
>you can change the size of these lists during runtime运行时可以改变大小

```java
List<ArrayList<String>> groceeyList = new ArrayList<>();  
  
ArrayList<String> BakeryList = new ArrayList<>();  
BakeryList.add("pasta");  
BakeryList.add("garlic bread");  
BakeryList.add("donuts");  
  
ArrayList<String> ProduceList = new ArrayList<>();  
ProduceList.add("tomatoes");  
ProduceList.add("zucchini");  
  
  
ArrayList<String> DrinkList = new ArrayList<>();  
DrinkList.add("soda");  
DrinkList.add("coffee");  
  
groceeyList.add(BakeryList);  
groceeyList.add(ProduceList);  
groceeyList.add(DrinkList);  
System.out.println(groceeyList);  
System.out.println(groceeyList.get(0).get(1));
```
## for each loop

```java
String[] animals = {"cat","dog","bird"};  
for(String animal : animals){  
    System.out.println(animal);  
}
```

## Method
1. 方法的名字由小写字母开头
2. 为了保证传递进方法的参数不会混乱，方法需要先设置一个参数
形成一组互相匹配的变量
3. overload 相同名字，不同参数  

## object oriented programming
-  对象可以保存数据（属性）执行操作（方法）
> 是一种引用数据类型reference data
- 可复用 可拓展 易维护
- 栈内存存储局部变量以及方法先进后出（枯井）
- 堆内存存储创建的对象以及数组（餐厅）
- 方法区内存static代码
![[1776174978471.jpg]]
```java
String make = "Ford福特";  
int year = 2026;  
double price = 50000;  
boolean isElectric = false;  
void start(){  
    isElectric = true;  
  System.out.println("you start the engine");  
}  
void stop(){  
    System.out.println("you stop the engine");  
}  
void drive(){  
    System.out.println("you drive the " + make);  
}  
void brake(){  
    System.out.println("you brake the " + make);  
}
```

- 方法调用
	- 对象调用类的实例方法
	- 类中的方法调用本类中的其他方法
	- 类名直接调用static方法
- 创建构造函数
> overload constructor
> array of objects
> 构造器的格式 仅需要一个public 加上一模一样的类名称
- 方法参数传递时
	- 基本数据类型，若在方法中被修改了，在方法返回时值依旧不会改变（如果是不可变引用对象如string类则不会改变）
	- 引用数据类型，对象的状态可能会改变，引用不能改变
		将person看作电视机 p就是遥控器
		- 单纯改变p就是调节电视机 改变对象状态
		- new一个person就是创建一个新的电视机，对原来没有影响
	```java
	```static void change(Person p) {
    p = new Person(); // ❌ 只改了局部变量
    p.age = 50;//新建了一个对象，后面的修改就是对新建的对象副本进行的修改不会影响原来传入的对象
	}

	public static void main(String[] args) {
    Person person = new Person();
    person.age = 20;
    change(person);
    System.out.println(person.age); // 20
	}```
	```
	```java
	```class Person {
    int age;
	}
	public class Test {
    static void change(Person p) {
        p.age = 30; // ✅ 修改对象状态
    }
    public static void main(String[] args) {
        Person person = new Person();
        person.age = 20;
        change(person);
        System.out.println(person.age); // 30
    }
	}```
	```

```java
Ccar[] cars = new Ccar[]{  
        new Ccar("Ford","Red"),  
  new Ccar("Mustang","Black"),  
  new Ccar("Tesla","White")};  
  
for(Ccar c : cars){  
  c.drive();  
}
```
## extend继承
- ==this谁引用它，它就指代谁
	哪个对象调用这个方法，this就拿到哪个对象
	- 区分成员变量与局部变量  区分方法参数与成员变量
		```java
		```public Person(String name) {
        this.name = name; // this.name 是成员变量，name 是构造器参数
	    }```
	    ```
	- 调用当前类的其他构造方法（兄弟构造器）
		```java
		```public Teacher (String name,int age,String subject){  
		    //this调用兄弟构造器，必须写在构造器的第一行  
		    this(name,age,subject,"gdut");  
		}  
  
  
		public Teacher(String name, int age, String subject, 
			String university) {  
		    super();  
		    this.name = name;  
		    this.age = age;  
		    this.subject = subject;  
		    this.university=university;  
			}```
	    ```
	- 返回当前对象（链式调用）
		```java
		```public Person setName(String name) {
        this.name = name;
        return this; // 返回当前对象
	    }
	    public void print() {
        System.out.println(name);
	    }
	    new Person().setName("张三").print();```
	    ```
- ==super关键字
	- 调用父类构造方法
		```java
		```public Teacher(String name, char sex) {
	    super(name, sex); // 调用 People(String, char)
		}```
		```
	- 子类无参构造器如果父类有无参构造器时就可以正常写，父类==**没有无参构造器**==时需要super（“”，‘’） 
	- 父类没有==**任何无参构造器或者写了无参构造器**==的情况下，子类会有默认的无参构造器
	- 访问父类的成员变量
		```java
		```public Teacher(String name) {
        super.name = name; // 访问父类的 name
        this.name = name;  // 子类的 name
	    }```
	    ```
	- 调用父类的成员方法
		```java
		```public void show() {
        super.show(); // 调用父类的 show
        System.out.println("Teacher");
	    }```
	    ```
- 修饰符
	- - ==private
	    - 只能在==当前类==中访问
	    - 封装性最强，最常用在成员变量上
	    - 一般通过 getter / setter 对外提供访问
        
	- ==缺省(default)  
	    - 不使用任何修饰符
	    - 仅限==同一包==内访问
	    - 不同包的子类也无法访问
    
	- ==protected
	    - 同一包内可访问 
	    - ==不同包下的子类==也可访问
	    - 常用于“希望子类使用，但不对外开放”的成员
        
	- ==public
	    - ==任何地方==都可以访问
	    - 封装性最弱
	    - 多用于对外接口、方法（如 getter / setter）
	    -
- 多态
	- 对于成员变量，静态方法 编译看左边，运行看左边
	```java
		```System.out.println(h1.name);
		//成员变量：编译看左边，运行也看左边```
	```
	- 对于方法（重写）编译看左边，运行看右边
		编译器会在hero里面找live方法，jvm运行时拿到的是doubleC
		```java
		```Hero h1 = new DoubleC();  
		h1.live();
		```
	- 父类调用子类特有的方法或者变量时
	```java
		```if (h instanceof DoubleC dc) {//判断类型同时强转
	    dc.zuoLao();
	    System.out.println(dc.skill);
		}```
		if (h instanceof DoubleC) {//先判断类型 再进行强转
	    DoubleC dc = (DoubleC) h;
	    dc.zuoLao();
		}
	```
## static
属于类而不属于任何对象,由类拥有，所有对象都可以访问
- 静态变量可以通过**类名访问**也可以通过**实例名**访问
- 静态方法只能使用静态变量只能调用静态方法
```java
public class Friends{
String name;  
static int numOfFriends;  
  
Friends(String name) {  
    this.nama = name;  
  numOfFriends++;  
}
static void printNumOfFriends(){  
    System.out.println("You have " + numOfFriends + " friends");  
}
}
Friends f1 = new Friends("Spongebob");  
Friends f2 = new Friends("Patrick");  
Friends f3 = new Friends("Sandy");  
  
System.out.println(Friends.numOfFriends);
```
- 静态工厂方法
	- 是用 `static`修饰的、返回该类实例的方法，用来**创建对象**。
	```java
	```class Person {
    private String name;

    private Person(String name) {
        this.name = name;
    }

    public static Person create(String name) {
        return new Person(name);
    }
	}```
	```
- 递归算法
	
	先一路向下算到最底层，
	再一路向上把结果一层层传回来
	```java
	```public class Fibonacci {
    public static int fib(int n) {
        if (n == 2) {
            return 1;
        }
        if (n == 1) {
            return 1;
        }
        return fib(n - 1) + fib(n - 2);
    }
    public static void main(String[] args) {
        System.out.println(fib(10)); // 55
    }
	}```
	```
## 方法重载
 方法重载的核心规则
方法重载的依据是**参数列表的不同**，具体包括：
- **参数类型**不同
- **参数个数**不同
- **参数顺序**不同（类型顺序不同）
> ⚠️ 注意：**仅返回值类型不同**​ 不能构成重载，编译器会报错。
- **返回类型和访问修饰符**可以不同

## 三元运算符
- 基本语法
```
条件表达式 ? 表达式1 : 表达式2
```
- **条件表达式**：布尔类型（true/false）
- **表达式1**：当条件为 true 时执行/返回
- **表达式2**：当条件为 false 时执行/返回
- ```java
  public static void print(int score)  {  
    String result = "" ;  
    result = score >=60 ?"及格":"不及格";  
    System.out.println(result);  
}  
public static int  getmax(int a,int b,int c)  {  
    int max = a > b ? a : b;  
    max = max > c ?max : c;  
    return max ;  
}
  ```

## equals方法
```java
```@Override
public boolean equals(Object o) {
    if (this == o) return true;
    if (o == null || getClass() != o.getClass()) return false;
    Person person = (Person) o;
    return id == person.id &&
           Objects.equals(name, person.name );
}```
@Override
public int hashCode() {
    return Objects.hash(id, name);
}
```