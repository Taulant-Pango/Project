package com.betaplan.taulant.test2.services;

import com.betaplan.taulant.test2.models.Course;
import com.betaplan.taulant.test2.repositories.CourseRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CourseService {
    @Autowired
    private CourseRepo courseRepo;

    public Course createCourse(Course course){
        return courseRepo.save(course);
    }

    public List<Course> findAll(){
        return courseRepo.findAll();
    }

    public Course updateCourse(Course course){
        return courseRepo.save(course);
    }

    public void deleteCourse(Course course){
        courseRepo.delete(course);
    }

    public Course findCourseById(Long id){
        Optional<Course> optional = courseRepo.findById(id);

        if (optional.isPresent()){
            return optional.get();
        } else {
            return null;
        }
    }
}
