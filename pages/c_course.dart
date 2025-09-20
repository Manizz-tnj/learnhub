import 'package:flutter/material.dart';
import 'package:learnhub/pages/quiz_page.dart';

class CCourse extends StatefulWidget {
  const CCourse({super.key});

  @override
  State<CCourse> createState() => _CCourseState();
}

class _CCourseState extends State<CCourse> {
  int _currentLessonIndex = 0;
  bool _showContent = true;
  
  final List<Map<String, dynamic>> _lessons = [
    {
      'title': 'Introduction to C Programming',
      'content': '''
# Introduction to C Programming

C is a general-purpose programming language created in the early 1970s by Dennis Ritchie at Bell Labs. It is one of the most widely used programming languages of all time and has influenced many other languages.

## Key Features of C

- **Efficiency**: C provides constructs that map efficiently to machine instructions
- **Portability**: Programs written in C are portable across different platforms
- **Power and Flexibility**: C gives programmers direct access to memory and low-level operations
- **Rich Library Support**: C comes with a wide range of library functions

## First C Program

Let's look at a simple "Hello, World!" program in C:

```c
#include <stdio.h>

int main() {
    printf("Hello, World!");
    return 0;
}
```

In this program:
- `#include <stdio.h>` includes the standard input/output library
- `int main()` is the main function where execution begins
- `printf()` outputs text to the console
- `return 0` indicates successful program execution

## C Program Structure

A C program consists of:
1. Preprocessor directives
2. Function declarations
3. Variables
4. Program statements and expressions
5. Comments

C is a building block for many applications including operating systems, embedded systems, and high-performance applications.
      ''',
    },
    {
      'title': 'Variables and Data Types',
      'content': '''
# Variables and Data Types in C

Variables are named storage locations that hold values that can be modified during program execution. In C, every variable must have a specific data type.

## Basic Data Types in C

1. **int**: Used for integers (whole numbers)
   - Example: `int age = 25;`

2. **float**: Used for single-precision floating-point numbers
   - Example: `float price = 19.99;`

3. **double**: Used for double-precision floating-point numbers
   - Example: `double pi = 3.14159265359;`

4. **char**: Used for storing single characters
   - Example: `char grade = 'A';`

## Variable Declaration

In C, variables must be declared before they can be used. The syntax is:

```c
data_type variable_name = initial_value;
```

Examples:
```c
int count = 0;
float temperature;
char initial = 'J';
```

## Constants

Constants are values that cannot be modified during program execution:

```c
const int MAX_SIZE = 100;
#define PI 3.14159
```

## Type Modifiers

C provides type modifiers to alter the range or precision of data types:
- `short`
- `long`
- `signed`
- `unsigned`

Example:
```c
unsigned long int population = 7800000000;
```

## Type Conversion

C allows conversion between different data types:
1. **Implicit conversion**: Performed automatically by the compiler
2. **Explicit conversion (Casting)**: Manually specified by the programmer

Example of casting:
```c
float average = (float)total / count;
```

Understanding data types is crucial for writing efficient C programs and avoiding unexpected behavior.
      ''',
    },
    {
      'title': 'Control Structures',
      'content': '''
# Control Structures in C

Control structures allow you to control the flow of program execution based on conditions or for repetitive tasks.

## Conditional Statements

### 1. if Statement

The `if` statement executes a block of code if a specified condition is true.

```c
if (condition) {
    // code to execute if condition is true
}
```

Example:
```c
if (age >= 18) {
    printf("You are eligible to vote.");
}
```

### 2. if-else Statement

The `if-else` statement executes one block of code if a condition is true and another block if it's false.

```c
if (condition) {
    // code to execute if condition is true
} else {
    // code to execute if condition is false
}
```

Example:
```c
if (score >= 60) {
    printf("You passed!");
} else {
    printf("You failed.");
}
```

### 3. if-else if-else Ladder

For multiple conditions:

```c
if (condition1) {
    // code for condition1
} else if (condition2) {
    // code for condition2
} else {
    // code if none of the conditions are true
}
```

Example:
```c
if (score >= 90) {
    printf("Grade: A");
} else if (score >= 80) {
    printf("Grade: B");
} else if (score >= 70) {
    printf("Grade: C");
} else {
    printf("Grade: F");
}
```

### 4. switch Statement

The `switch` statement selects one of many code blocks to execute based on the value of an expression.

```c
switch (expression) {
    case value1:
        // code for value1
        break;
    case value2:
        // code for value2
        break;
    default:
        // default code
}
```

Example:
```c
switch (day) {
    case 1:
        printf("Monday");
        break;
    case 2:
        printf("Tuesday");
        break;
    // other cases
    default:
        printf("Invalid day");
}
```

## Looping Statements

### 1. for Loop

The `for` loop executes a block of code a specified number of times.

```c
for (initialization; condition; update) {
    // code to repeat
}
```

Example:
```c
for (int i = 0; i < 5; i++) {
    printf("%d ", i);
}
```

### 2. while Loop

The `while` loop executes a block of code as long as a specified condition is true.

```c
while (condition) {
    // code to repeat
}
```

Example:
```c
int i = 0;
while (i < 5) {
    printf("%d ", i);
    i++;
}
```

### 3. do-while Loop

The `do-while` loop executes a block of code once, and then repeats it as long as a specified condition is true.

```c
do {
    // code to repeat
} while (condition);
```

Example:
```c
int i = 0;
do {
    printf("%d ", i);
    i++;
} while (i < 5);
```

Control structures are fundamental building blocks for creating logical and efficient programs in C.
      ''',
    },
    {
      'title': 'Functions',
      'content': '''
# Functions in C

Functions are self-contained blocks of code that perform a specific task. They help in organizing code, making it reusable, and easier to maintain.

## Function Declaration and Definition

A function consists of:
- Return type
- Function name
- Parameters (optional)
- Function body

Syntax:
```c
return_type function_name(parameter_list) {
    // function body
    return value; // if return_type is not void
}
```

Example:
```c
int add(int a, int b) {
    int sum = a + b;
    return sum;
}
```

## Function Prototypes

A function prototype tells the compiler about the function name, return type, and parameters before the actual function definition.

```c
return_type function_name(parameter_list);
```

Example:
```c
int add(int, int); // Function prototype

int main() {
    int result = add(5, 3);
    printf("Sum: %d", result);
    return 0;
}

int add(int a, int b) {
    return a + b;
}
```

## Types of Functions

1. **Standard Library Functions**: Pre-defined functions provided by C libraries (e.g., `printf()`, `scanf()`)
2. **User-defined Functions**: Functions created by the programmer

## Function Parameters

1. **Formal Parameters**: Variables in the function definition
2. **Actual Parameters (Arguments)**: Values passed to the function when called

## Parameter Passing Methods

1. **Call by Value**: Copies the actual value of an argument into the formal parameter
2. **Call by Reference**: Copies the address of an argument into the formal parameter

Example of call by reference:
```c
void swap(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

int main() {
    int x = 5, y = 10;
    swap(&x, &y);
    printf("x = %d, y = %d", x, y); // Output: x = 10, y = 5
    return 0;
}
```

## Recursive Functions

A recursive function is one that calls itself:

```c
int factorial(int n) {
    if (n <= 1)
        return 1;
    else
        return n * factorial(n-1);
}
```

Functions are one of the most powerful features in C, allowing for modular and organized code.
      ''',
    },
    {
      'title': 'Arrays and Pointers',
      'content': '''
# Arrays and Pointers in C

Arrays and pointers are fundamental concepts in C that allow efficient memory management and data manipulation.

## Arrays

An array is a collection of elements of the same type stored in contiguous memory locations.

### Array Declaration

```c
data_type array_name[array_size];
```

Example:
```c
int numbers[5]; // Declares an array of 5 integers
```

### Array Initialization

```c
int numbers[5] = {10, 20, 30, 40, 50};
char name[] = "John"; // Implicitly sized array
```

### Accessing Array Elements

Array elements are accessed using their index (starting from 0):

```c
int firstElement = numbers[0]; // Access the first element
numbers[2] = 35;              // Update the third element
```

### Multi-dimensional Arrays

C supports multi-dimensional arrays:

```c
int matrix[3][4]; // 3 rows, 4 columns

// Initialization
int matrix[3][3] = {
    {1, 2, 3},
    {4, 5, 6},
    {7, 8, 9}
};
```

## Pointers

A pointer is a variable that stores the memory address of another variable.

### Pointer Declaration

```c
data_type *pointer_name;
```

Example:
```c
int *ptr; // Declares a pointer to an integer
```

### Pointer Operations

1. **Address-of Operator (&)**: Gets the address of a variable
2. **Dereference Operator (*)**: Accesses the value at the address stored in a pointer

```c
int x = 10;
int *ptr = &x; // ptr stores the address of x

printf("Value of x: %d", x);        // 10
printf("Address of x: %p", &x);     // Memory address of x
printf("Value of ptr: %p", ptr);    // Same as address of x
printf("Value at address ptr: %d", *ptr); // 10 (value of x)

*ptr = 20; // Changes the value of x to 20
```

### Pointer Arithmetic

```c
int numbers[] = {10, 20, 30, 40, 50};
int *ptr = numbers; // points to first element

printf("%d", *ptr);       // 10
printf("%d", *(ptr + 1)); // 20
printf("%d", *(ptr + 2)); // 30
```

## Relationship Between Arrays and Pointers

In many contexts, array names decay into pointers to their first elements:

```c
int arr[5] = {10, 20, 30, 40, 50};
int *ptr = arr; // ptr points to arr[0]

// These are equivalent:
printf("%d", arr[2]);
printf("%d", *(arr + 2));
printf("%d", *(ptr + 2));
printf("%d", ptr[2]);
```

## Dynamic Memory Allocation

Pointers enable dynamic memory allocation using functions from `<stdlib.h>`:

1. **malloc()**: Allocates memory of specified size
2. **calloc()**: Allocates and initializes memory to zero
3. **realloc()**: Resizes previously allocated memory
4. **free()**: Releases allocated memory

```c
int *ptr = (int*)malloc(5 * sizeof(int)); // Allocate memory for 5 integers

if (ptr == NULL) {
    printf("Memory allocation failed");
    return 1;
}

// Use the allocated memory
for (int i = 0; i < 5; i++) {
    ptr[i] = i * 10;
}

// Free the allocated memory when done
free(ptr);
ptr = NULL; // Good practice to avoid dangling pointers
```

Understanding arrays and pointers is crucial for effective memory management and data manipulation in C.
      ''',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final currentLesson = _lessons[_currentLessonIndex];
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('C Programming'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Course Progress
          Container(
            padding: const EdgeInsets.all(16),
            // ignore: deprecated_member_use
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: const Text(
                    'C',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'C Programming',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Lesson ${_currentLessonIndex + 1} of ${_lessons.length}',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: (_currentLessonIndex + 1) / _lessons.length,
                          backgroundColor: Colors.grey.shade300,
                          color: Theme.of(context).colorScheme.primary,
                          minHeight: 8,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Lesson Navigation
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    currentLesson['title'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: _currentLessonIndex > 0
                          ? () {
                              setState(() {
                                _currentLessonIndex--;
                              });
                            }
                          : null,
                      icon: const Icon(Icons.arrow_back),
                      color: _currentLessonIndex > 0
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey.shade400,
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: _currentLessonIndex < _lessons.length - 1
                          ? () {
                              setState(() {
                                _currentLessonIndex++;
                              });
                            }
                          : null,
                      icon: const Icon(Icons.arrow_forward),
                      color: _currentLessonIndex < _lessons.length - 1
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey.shade400,
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Lesson Content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Content/Resources Toggle
                    SegmentedButton<bool>(
                      segments: const [
                        ButtonSegment<bool>(
                          value: true,
                          label: Text('Content'),
                          icon: Icon(Icons.book),
                        ),
                        ButtonSegment<bool>(
                          value: false,
                          label: Text('Resources'),
                          icon: Icon(Icons.folder),
                        ),
                      ],
                      selected: {_showContent},
                      onSelectionChanged: (newSelection) {
                        setState(() {
                          _showContent = newSelection.first;
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.resolveWith<Color>(
                          (states) {
                            if (states.contains(WidgetState.selected)) {
                              return Theme.of(context).colorScheme.primary;
                            }
                            return Colors.grey.shade200;
                          },
                        ),
                        foregroundColor: WidgetStateProperty.resolveWith<Color>(
                          (states) {
                            if (states.contains(WidgetState.selected)) {
                              return Colors.white;
                            }
                            return Colors.black87;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // Main Content
                    _showContent
                        ? Text(
                            currentLesson['content'],
                            style: const TextStyle(
                              fontSize: 16,
                              height: 1.5,
                            ),
                          )
                        : _buildResourcesList(),
                    
                    const SizedBox(height: 24),
                    
                    // Next Lesson Button
                    if (_currentLessonIndex < _lessons.length - 1)
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              _currentLessonIndex++;
                            });
                          },
                          icon: const Icon(Icons.arrow_forward),
                          label: const Text('Next Lesson'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                        ),
                      )
                    else
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const QuizPage(
                                  courseTitle: 'C Programming',
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.quiz),
                          label: const Text('Take Quiz'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.secondary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResourcesList() {
    final List<Map<String, dynamic>> resources = [
      {
        'title': 'C Programming Tutorial PDF',
        'type': 'PDF',
        'size': '2.4 MB',
        'icon': Icons.picture_as_pdf,
        'color': Colors.red,
      },
      {
        'title': 'Introduction to C - Video Lecture',
        'type': 'Video',
        'duration': '18:24',
        'icon': Icons.video_library,
        'color': Colors.blue,
      },
      {
        'title': 'C Programming Exercises',
        'type': 'Document',
        'size': '1.1 MB',
        'icon': Icons.description,
        'color': Colors.orange,
      },
      {
        'title': 'Example Code Snippets',
        'type': 'Code',
        'size': '456 KB',
        'icon': Icons.code,
        'color': Colors.green,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Supplementary Resources',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...resources.map((resource) => Card(
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: resource['color'].withOpacity(0.1),
                  child: Icon(
                    resource['icon'],
                    color: resource['color'],
                  ),
                ),
                title: Text(resource['title']),
                subtitle: Text(
                  resource.containsKey('duration')
                      ? '${resource['type']} • ${resource['duration']}'
                      : '${resource['type']} • ${resource['size']}',
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.download),
                  onPressed: () {},
                ),
                onTap: () {},
              ),
            )),
      ],
    );
  }
}