package com.resume.ecommerce.config;

import com.resume.ecommerce.model.Product;
import com.resume.ecommerce.repository.ProductRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class DataLoader {
    @Bean
    CommandLineRunner loadData(ProductRepository repository) {
        return args -> {
            if (repository.count() == 0) {
                repository.save(new Product("Wireless Headphones", "Bluetooth over-ear headphones", 2499, 50));
                repository.save(new Product("Mechanical Keyboard", "RGB mechanical keyboard", 3999, 30));
                repository.save(new Product("Smart Watch", "Fitness and notification smartwatch", 5999, 25));
                repository.save(new Product("Gaming Mouse", "High precision wireless mouse", 1799, 80));
            }
        };
    }
}
