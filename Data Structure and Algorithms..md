# Data Structure and Algorithms.
## Time Complexity
> 时间的复杂性主要随着输入数据的大小增加
### Linear Search 线性搜索
> 一个一个进行搜索，按照数组排列的顺序，随着体型增大需要检索的步骤也逐渐增大
1. 得到一个搜索需要的总长度n
2. 基本上是从0到n-1  
3. 一一进行比对，if相同择返回

> 看着代码简单，但是时间复杂度很长
```java
private static int linearSearch(int[] nums, int target) {  
    for(int i=0 ;i <= nums.length ; i++){  
        if(nums[i] == target){  
            return i;  
  }  
    }  
    return -1;  
}
```

### Binary Search二分查找
> 假设有一个已经排列好的数组

1. 先给每个元素都设置序列号，将数组分成两个部分，找到中间值 m=(s+e)*0.5
2. 按照大小改变原来的起始点s 或者结束点 e
3. 不断查找最后返回正确的值
```java
private static int binarySearch(int[] nums, int target) {  
  int left = 0;  
  int right = nums.length-1;  
  while (left<=right){  
        int mid = (left + right)/2;  
  if(nums[mid] == target){  
            return mid;  
  } else if (nums[mid]<target ) {  
            left = mid+1;  
  }else{  
            right = mid-1;  
  }  
    }  
    return -1;  
}
```
```java
private static int binarySearch(int[] nums, int target, int left, int right) {  
  if(left > right)  return -1;  
  int mid = left + (right - left) / 2;  
  if (nums[mid] == target)  return mid;  
  else if (nums[mid] < target)  
  return binarySearch(nums, target, mid + 1, right);  
  else   return binarySearch(nums, target, left, mid - 1);  
  
}
```
### Big O Notation
>用于描述算法的时间复杂度或空间复杂度，特别是在输入规模变得很大时，表示算法性能的增长速度。它关注的是算法的 **最坏情况**
>输入规模增加时，算法执行时间或空间需求的增长率

-   **O(1)**：常数时间复杂度。无论输入数据的大小如何，算法的执行时间都保持不变。例如，访问数组的一个元素。
    
-   **O(log n)**：对数时间复杂度。随着输入规模的增长，执行时间按对数级别增长。常见的例子是二分查找。
    
-   **O(n)**：线性时间复杂度。随着输入规模增加，执行时间也按比例增加。例如，遍历一个数组。  

## Sort Theory排序法
### Bubble Sort
> 效率不高 因为有两个循环所以随着数据的增加属于o(n^2)

> 两重循环
> - 外层循环负责控制迭代的次数
> -  内层循环负责进行比较和交换

```java
public static void main(String[] args) {  
	  int nums[] = {6,4,5,9,3,8,7,};  
	  int size = nums.length;  
	  int temp = 0;  
  
    for(int i=0;i<size;i++){  
        for (int j = 0; j < size-i-1; j++) {  
            if (nums[j]>nums[j+1]){  
	              temp = nums[j];  
				  nums[j] = nums[j+1];  
				  nums[j+1] = temp;  
	  }  
        }  
        System.out.println();  
  }  
    
}
```

### Selection Sort

> 减少冒泡排序当中每次都得在内循环里面进行数据交换。减少频繁交换
> 选择排序是一种简单直观的**比较排序算法**。它的基本思想是：**每次从未排序的部分中选择最小（或最大）的元素，放到已排序部分的末尾**。
```java
public static void main(String[] args) {  
    int nums[] = {6,4,5,9,3,8,7,};  
	  int size = nums.length;  
	  int temp = 0;  
	  int minIndex = -1;  
	 
    for (int i = 0; i < size-1; i++) {  
        minIndex = i;  
	  for (int j = i; j < size; j++) {  
        if(nums[minIndex]>nums[j]){  
            minIndex = j;  
			  }  
	  }  
    temp = nums[minIndex];  
	  nums[minIndex] = nums[i];  
	  nums[i] = temp;  
	  }  
}
```

### Insertion Sort插入

> 插入排序的工作方式非常像我们打扑克牌时整理手牌的过程：

> 在计算机科学中，插入排序将数组分为两个部分：
>- **已排序部分**：通常位于数组的左侧，初始时只有第一个元素。  
>- **未排序部分**：通常位于数组的右侧，包含了剩余的所有元素。  
>算法会依次将未排序部分的元素取出，插入到已排序部分的正确位置上。

```java
int nums[] = {6,4,5,9,3,8,7,};  
  
for (int i = 1; i < nums.length ; i++) {  
    int key = nums[i];  
    int j = i-1;  
    while(j>=0 && nums[j]>key){  
        nums[j+1] = nums[j];  
        j--;  
    }  
    nums[j+1] = key;  
  
}
```
- 假设左侧第一个数字是**已排序的**
- 设置一个key保存要**插入点元素值**，在移动的过程中比较
- j指针从已排序的****末尾开始**，**向左**扫描寻找插入位置

### Quick Sort快速搜索

>快速排序的核心思想是“分而治之”：
>1. **选择基准**：从数组中选择一个元素作为“基准”。 
>2. **分区操作**：重新排列数组，使得所有比基准小的元素都放在基准前面，所有比基准大的元素都放在基准后面。在这个操作结束之后，该基准就处于其最终的正确位置。这个步骤称为“分区”。
>3. **递归排序**：递归地将小于基准的子数组和大于基准的子数组进行快速排序。
>递归的终止条件是子数组的大小为零或为一，此时它们自然是有序的。
```java
public static void main(String[] args) {  
    int nums[] = {6,4,5,9,3,8,7};  
    
    quickSort(nums,0,nums.length-1);

    }
  
private static void quickSort(int[] nums, int low, int high) {  
    if(low<high){  
        int pi = partition(nums,low,high);  
  
        quickSort(nums,low,pi-1);  
        quickSort(nums,pi+1,high);  
    }  
}  
  
private static int partition(int[] nums, int low, int high) {  
    int pivot = nums[high];  
    int i = low-1;  
  
    for (int j = low; j < high; j++) {  
        if(nums[j]<pivot){  
            i++;  
            int temp = nums[i];  
            nums[i] = nums[j];  
            nums[j] = temp;  
        }  
  
    }int temp = nums[i+1];  
    nums[i+1] = nums[high];  
    nums[high] = temp;  
    return i+1;  
}
```
- **随机找一个值作为基准，比较出这个值的正确位置，然后分成比他大的和比他小的两个部分，再各自进行递归比较**
1.  取最右侧的值作为基准，从左侧开始与它进行比较，比他小的值就往前移动，知道找出所有在他前面的值；
2.  把值分成比基准大和比基准小之后，各自再进行迭代，直到最后一组里面的两个值比较完成 

## Divide and Conquer
> 将主问题分割成许多个小问题，分而治之，最后再合并