package ru.privetdruk.socialnetwork.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import ru.privetdruk.socialnetwork.domain.City;

import java.util.Set;

@Repository
public interface CityRepository extends CrudRepository<City, Long> {
    Set<City> findAll();
    City findById(Integer id);
}