Airport Challenge
=================

[![Build Status](https://travis-ci.org/yevdyko/airport-challenge.svg?branch=master)](https://travis-ci.org/yevdyko/airport-challenge)  [![Coverage Status](https://coveralls.io/repos/github/yevdyko/airport-challenge/badge.svg?branch=master)](https://coveralls.io/github/yevdyko/airport-challenge?branch=master)  [![Code Climate](https://codeclimate.com/github/yevdyko/airport-challenge/badges/gpa.svg)](https://codeclimate.com/github/yevdyko/airport-challenge)

We have a request from a client to write the software to control the flow of planes at an airport. The planes can land and take off provided that the weather is sunny. Occasionally it may be stormy, in which case no planes can land or take off.  Here are the user stories that we worked out in collaboration with the client:

User Stories
------------

```
As an air traffic controller
So planes can land safely at my airport
I would like to instruct a plane to land

As an air traffic controller
So planes can take off safely from my airport
I would like to instruct a plane to take off

As an air traffic controller
So that I can avoid collisions
I want to prevent airplanes landing when my airport if full

As an air traffic controller
So that I can avoid accidents
I want to prevent airplanes landing or taking off when the weather is stormy

As an air traffic controller
So that I can ensure safe take off procedures
I want planes only to take off from the airport they are at

As the system designer
So that the software can be used for many different airports
I would like a default airport capacity that can be overridden as appropriate

As an air traffic controller
So the system is consistent and correctly reports plane status and location
I want to ensure a flying plane cannot take off and cannot be in an airport

As an air traffic controller
So the system is consistent and correctly reports plane status and location
I want to ensure a plane that is not flying cannot land and must be in an airport

As an air traffic controller
So the system is consistent and correctly reports plane status and location
I want to ensure a plane that has taken off from an airport is no longer in that airport
```

Here are the User Stories converted into a Domain Model:

| Object  |  Messages  | Object | Messages | Object  | Messages |
|---------|------------|--------|----------|---------|----------|
| airport |  land      | plane  | land     | weather |  stormy? |
|         |  take_off  |        | take_off |         |          |
|         |            |        | airport  |         |          |

Approach
--------

I decided to use a separate class to implement the weather behaviour, with this
class containing a single class method `#stormy?` which returned true with a
probability of 5%. It has been implemented with the Kernel method rand.

Setup
-----

1. Clone the repository:

  `$ git clone git@github.com:yevdyko/airport-challenge.git`

2. Change into the directory:

  `$ cd airport-challenge`

3. If you don't have bundle already, run the command:

  `$ gem install bundle`

4. Install all dependencies with:

  `$ bundle`

Testing
-------

To run the tests:

  `$ rspec`

How to use
----------

To see the code in action, open IRB and follow the instructions:

1. Require the files:

  ```ruby
  2.3.0 :001 > require './lib/weather'
   => true
  2.3.0 :002 > require './lib/plane'
   => true
  2.3.0 :003 > require './lib/airport'
   => true
  ```

2. Create a weather object:

  ```ruby
  2.3.0 :004 > weather = Weather.new
   => #<Weather:0x007f94420bb430>
  ```

3. Create a new airport:

  ```ruby
  2.3.0 :005 > airport = Airport.new(weather)
   => #<Airport:0x007f94420b22b8 @weather=#<Weather:0x007f94420bb430>,
   @capacity=25, @planes=[]>
  ```

4. Create some planes:

  ```ruby
  2.3.0 :006 > plane1 = Plane.new
   => #<Plane:0x007f94420aa1d0 @flying=true>
  2.3.0 :007 > plane2 = Plane.new
   => #<Plane:0x007f94420a02c0 @flying=true>
  ```

5. Land planes:

  ```ruby
  2.3.0 :008 > airport.land(plane1)
   => [#<Plane:0x007f94420aa1d0 @flying=false, @airport=#<Airport:0x007f94420b22b8
   @weather=#<Weather:0x007f94420bb430>, @capacity=25, @planes=[...]>>]
  2.3.0 :009 > airport.land(plane2)
   => [#<Plane:0x007f94420aa1d0 @flying=false, @airport=#<Airport:0x007f94420b22b8
   @weather=#<Weather:0x007f94420bb430>, @capacity=25, @planes=[...]>>,
   #<Plane:0x007f94420a02c0 @flying=false, @airport=#<Airport:0x007f94420b22b8
   @weather=#<Weather:0x007f94420bb430>, @capacity=25, @planes=[...]>>]
  ```

  If the weather is stormy, you may need to try landing the plane a few times.

6. Send a plane to take off:

  ```ruby
  2.3.0 :010 > airport.take_off(plane2)
   => #<Plane:0x007f94420a02c0 @flying=false, @airport=#<Airport:0x007f94420b22b8
   @weather=#<Weather:0x007f94420bb430>, @capacity=25, @planes=[#<Plane:0x007f94420aa1d0
   @flying=false, @airport=#<Airport:0x007f94420b22b8 ...>>,
   #<Plane:0x007f9442098890 @flying=false, @airport=#<Airport:0x007f94420b22b8 ...>>]>>
  ```

7. Check the planes in the airport:

  ```ruby
  2.3.0 :011 > airport.planes
   => [#<Plane:0x007f94420aa1d0 @flying=false, @airport=#<Airport:0x007f94420b22b8
   @weather=#<Weather:0x007f94420bb430>, @capacity=25, @planes=[...]>>]
  ```
