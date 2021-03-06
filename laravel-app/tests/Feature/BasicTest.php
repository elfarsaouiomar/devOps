<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;

class BasicTest extends TestCase
{
    /**
     * A basic feature test example.
     *
     * @return void
     */
    public function testExample()
    {
        $response = $this->get('/');
        $response->assertOk();
    }

    public function testProducts()
    {
        $response = $this->get('/products');
        $response->assertOk();
    }

    public function testCreateProducts()
    {
        $response = $this->post('/products',
            [
                'name' => 'this a test from php',
                'detail' => 'this a test from php ',        

            ]);

        $this->followingRedirects();
        $response->assertStatus(302);
        // $response->assertSeeText();
    }
}
