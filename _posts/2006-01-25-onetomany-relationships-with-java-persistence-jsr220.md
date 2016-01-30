---
ID: 61
post_title: >
  OneToMany relationships with Java
  Persistence (JSR 220)
author: timvw
post_date: 2006-01-25 21:36:36
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/01/25/onetomany-relationships-with-java-persistence-jsr220/
published: true
dsq_thread_id:
  - "1922442871"
---
<p>Let's experiment a bit with <a href="http://www.hibernate.org">Hibernate</a>. We want to model the tables employee and shift. Each employee has multiple shifts (and each shift belongs to an employee). We want an employee table and a shift table (which has the employee_id as a foreign key).</p>
[code lang="java"]
// Employee.java
@OneToMany(targetEntity=Shift.class) public List getShifts() {...}
// Shift.java
@ManyToOne public Employee getEmployee() {...}
[/code]
<p>The code above generates the following tables: employee, employee_shift and shift. Time to read the documentation and discover the mappedBy attribute.</p>
[code lang="java"]
// Employee.java
@OneToMany(targetEntity=Shift.class, mappedBy="employee") public List getShifts() {...}
[/code]
<p>Ok, now we get the tables we want. Let's remove an employee that has shifts referencing him. An exception is thrown because of a foreign key constraint.</p>
[code lang="java"]
// Employee.java
@OneToMany(targetEntity=Shift.class, mappedBy="employee", cascade=CascadeType.REMOVE) public List getShifts() {...}
[/code]
<p>Ok, now we have cascading deletes working. Let's try cascading inserts:</p>
[code lang="java"]
// Employee.java
@OneToMany(targetEntity=Shift.class, mappedBy="employee", cascade=CascadeType.ALL) public List getShifts() {...}
// Main.java
Employee employee = new Employee();
Shift shift = new Shift();
Vector shifts = new Vector();
shifts.add(shift);
employee.setShifts(shifts);
em.persist(employee);
[/code]
<p>With the code above the foreign key of shift will NULL instead of the employee_id. According to the documentation it is expected behaviour that cascading inserts only work when the children are saved.</p>
[code lang="java"]
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
[/code]
<p>It appears we can get cascading inserts to work as long as we don't forget to set the employee. We add a constraint so employee can't be null.</p>
[code lang="java"]
// Shift.java
@ManyToOne @Column(nullable=false) public Employee getEmployee() {...}
// Main.java
Shift shift = new Shift();
em.persist(shift);
[/code]
<p>WTF? I can persist a NULL reference anyway? The value for employee_id is allowed to be NULL? Have we found a bug? Let's check the documentation:</p>
[code lang="java"]
// Shift.java
@ManyToOne @JoinColumn(nullable=false) public Employee getEmployee() {...}
// Main.java
Shift shift = new Shift();
em.persist(shift);
[/code]
<p>Ok, now are getting somewhere. And exception is thrown if we try to persist a shift that references to an employee that doesn't exist in the database yet.</p>
[code lang="java"]
// Shift.java
@ManyToOne(cascade=CascadeType.PERSIST) @JoinColumn(nullable=false) public Employee getEmployee() {...}
[/code]
<p>CascadeType.ALL means that i want to cascade events on ALL events. My only requirements where that i cascade on PERSIST (insert) and on REMOVE (delete). So i need to change my annotation as following:</p>
[code lang="java"]
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
[/code]