package com.betaplan.taulant.test2.repositories;

import com.betaplan.taulant.test2.models.Course;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface CourseRepo extends CrudRepository<Course, Long> {
    List<Course> findAll();
}
