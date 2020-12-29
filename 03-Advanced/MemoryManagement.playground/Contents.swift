class Course {
    var title: String
    unowned var teacher: Teacher
    var students: [Student]
    
    lazy var description: () -> String = {
        [weak self] in
        guard let self = self else {
           return ""
        }
        
        return "\(self.title) by \(self.teacher.name)"
    }
    
    init(_ title: String, teacher: Teacher, students: [Student]) {
        self.title = title
        self.teacher = teacher
        self.students = students
    }
    
    deinit {
        print("\(title) has ened!")
    }
}

class Academic {
    var name: String
    
    init(_ name: String) {
        self.name = name
    }
}

class Teacher: Academic {
//    prevent memory leak
    unowned var course: Course?
    
    override init(_ name: String) {
        super.init(name)
    }
    
    deinit {
        print("\(name) is no longer teaching \(course?.title ?? "")")
    }
}

class Student: Academic {
    var course: Course?
    
    override init(_ name: String) {
        super.init(name)
    }
    
    deinit {
        print("\(name) has graduated")
    }
}

enum Alfabeth: String, CaseIterable {
   case a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z
}

do {
    var students: [Student] = []
    let teacher = Teacher("Veronica")
    let course = Course("iOS development", teacher: teacher, students: [])
    
    for letter in Alfabeth.allCases {
        let student = Student(letter.rawValue)
        students.append(student)
        student.course = course
    }
    
    course.students = students
    teacher.course = course
    
    course.description()
}
