# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
  * 3.2.1

* System dependencies
  * Docker and Docker compose
  
* Services
  * Four services will be running in Docker containers.
    * Rails server
    * Postgresql Database
    * Redis
    * Sidekiq

* Make command
  * Start all service
    ```
    make start
    ```
  * Stop all service
    ```
    make stop
    ```
  * Restart all service
    ```
    make restart
    ```
  * Rebuild rails server service
    ```
    make rebuild
    ```
  * Run rails console in rails server docker contrainer
    ```
    make c
    ```
  * Run command in rails server docker contrainer
    ```
    make exec cmd="command_to_run"
    ```
  * Log rails server
    ```
    make log
    ```
  * Run rspec
    ```
    make rspec
    ```

* Database creation and initialization
  * Create and run seed from Make file command
    ```
    make setup
    ```
  * Reset database
    ```
    make reset
    ```


* How to run the test suite
  * Run rspec
    ```
    make rspec
    ```
