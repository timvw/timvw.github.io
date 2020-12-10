---
title: OneToMany relationships with Java Persistence (JSR 220)
layout: post
tags:
  - Hibernate
---
Let's experiment a bit with [Hibernate](http://www.hibernate.org). We want to model the tables employee and shift. Each employee has multiple shifts (and each shift belongs to an employee). We want an employee table and a shift table (which has the employee_id as a foreign key).

```java 
// Employee.java
@OneToMany(targetEntity=Shift.class) public List getShifts() {...}
// Shift.java
@ManyToOne public Employee getEmployee() {...}
```

The code above generates the following tables: employee, employee_shift and shift. Time to read the documentation and discover the mappedBy attribute.

```java
// Employee.java
@OneToMany(targetEntity=Shift.class, mappedBy="employee") public List getShifts() {...}
```

Ok, now we get the tables we want. Let's remove an employee that has shifts referencing him. An exception is thrown because of a foreign key constraint.

```java
// Employee.java
@OneToMany(targetEntity=Shift.class, mappedBy="employee", cascade=CascadeType.REMOVE) public List getShifts() {...}
```

Ok, now we have cascading deletes working. Let's try cascading inserts:

```java
// Employee.java
@OneToMany(targetEntity=Shift.class, mappedBy="employee", cascade=CascadeType.ALL) public List getShifts() {...}

// Main.java
Employee employee = new Employee();
Shift shift = new Shift();
Vector shifts = new Vector();
shifts.add(shift);
employee.setShifts(shifts);
em.persist(employee);
```

With the code above the foreign key of shift will NULL instead of the employee_id. According to the documentation it is expected behaviour that cascading inserts only work when the children are saved.

```java
// Employee.java
@OneToMany(targetEntity=Shift.class, mappedBy="employee", cascade=CascadeType.ALL) public List getShifts() {...}
// Main.java
Employee employee = new Employee();
Shift shift = new Shift(); 
shift.setEmployee(employee);
Vector shifts = new Vector();
shifts.add(shift);
employee.setShifts(shifts);
em.persist(employee);
```

It appears we can get cascading inserts to work as long as we do not forget to set the employee. We add a constraint so employee can not be null.

```java
// Shift.java
@ManyToOne @Column(nullable=false) public Employee getEmployee() {...}
// Main.java
Shift shift = new Shift();
em.persist(shift);
```

WTF? I can persist a NULL reference anyway? The value for employee_id is allowed to be NULL? Have we found a bug? Let's check the documentation:

```java
// Shift.java
@ManyToOne @JoinColumn(nullable=false) public Employee getEmployee() {...}
// Main.java
Shift shift = new Shift(); 
em.persist(shift);
```

Ok, now are getting somewhere. And exception is thrown if we try to persist a shift that references to an employee that does not exist in the database yet.

```java
// Shift.java
@ManyToOne(cascade=CascadeType.PERSIST) @JoinColumn(nullable=false) public Employee getEmployee() {...}
```

CascadeType.ALL means that i want to cascade events on ALL events. My only requirements where that i cascade on PERSIST (insert) and on REMOVE (delete). So i need to change my annotation as following:

```java
// Employee.java
@OneToMany(  
  targetEntity=Shift.class,  
  mappedBy="employee",  
  cascade={     
    CascadeType.PERSIST,    
    CascadeType.REMOVE  
  } 
)
public List getShifts() {return shifts;}
```
