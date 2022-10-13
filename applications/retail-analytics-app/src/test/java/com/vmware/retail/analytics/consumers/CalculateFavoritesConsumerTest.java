package com.vmware.retail.analytics.consumers;

import com.vmware.retail.analytics.repository.ProductRepository;
import com.vmware.retail.domain.CustomerFavorites;
import com.vmware.retail.domain.customer.CustomerIdentifier;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;

import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;


@ExtendWith(MockitoExtension.class)
class CalculateFavoritesConsumerTest {


    @Mock
    private RedisTemplate<String, CustomerFavorites> redisTemplate;

    @Mock
    private ProductRepository productRepository;
    @Mock
    private ValueOperations<String, CustomerFavorites> valueOperations;

    @Test
    void given_customer_when_accept_then_cacheFavorites() {
        String customerId = "u01";
        int top3 = 3;

        when(redisTemplate.opsForValue()).thenReturn(valueOperations);

        var subject = new CalculateFavoritesConsumer(redisTemplate, productRepository,top3);
        CustomerIdentifier customIdentifier = new CustomerIdentifier(customerId);

        subject.accept(customIdentifier);

        verify(redisTemplate).opsForValue();
        verify(productRepository).findCustomerFavoritesByCustomerIdAndTopCount(customerId,top3);
    }
}