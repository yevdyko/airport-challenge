Airport Challenge [![Build Status](https://travis-ci.org/yevdyko/airport-challenge.svg?branch=master)](https://travis-ci.org/yevdyko/airport-challenge)  [![Coverage Status](https://coveralls.io/repos/github/yevdyko/airport-challenge/badge.svg?branch=master)](https://coveralls.io/github/yevdyko/airport-challenge?branch=master)  [![Code Climate](https://codeclimate.com/github/yevdyko/airport-challenge/badges/gpa.svg)](https://codeclimate.com/github/yevdyko/airport-challenge)
=================

```
         ______
         _\____\___
 =  = ==(____MA____)
           \_____\___________________,-~~~~~~~`-.._
           /     o o o o o o o o o o o o o o o o  |\_
           `~-.__       __..----..__                  )
                 `---~~\___________/------------`````
                 =  ===(_________)

```

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

Here is User Stories converted into a Domain Model

|Object  |      Messages      |
|--------|--------------------|
|airport |      land          |
|        |      take_off      |
|plane   |      land          |
|        |      take_off      |
|        |      airport       |
|weather |      stormy?       |

Installation
------------

1. Clone this repo
2. Run the command `gem install bundle` (if you don't have bundle already)
3. When the installation completes, run `bundle`

Running tests
-------------

To run tests use the command `rspec`

Instructions
------------

```
2.3.0 :001 > require './lib/airport'
 => true
2.3.0 :002 > require './lib/plane'
 => true
2.3.0 :003 > airport = Airport.new(1, 25)
 => #<Airport:0x007fb51a2a9708 @weather=1, @capacity=25, @planes=[]>
2.3.0 :004 > plane1 = Plane.new
 => #<Plane:0x007fb51a988c68 @flying=true>
2.3.0 :005 > plane2 = Plane.new
 => #<Plane:0x007fb51a2a1580 @flying=true>
2.3.0 :006 > airport.land(plane1)
```
