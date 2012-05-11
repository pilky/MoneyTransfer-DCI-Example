Money Transfer DCI Example
==================

This is a basic bank app designed to show how DCI (Data-Context-Integration) could work in Objective-C/Cocoa.

What is DCI?
----------

DCI is an attempt to improve the readability and understandability of code by making the various use cases of software first class citizens, rather than things that are relegated to being spread across multiple objects.

You can find more information at [fulloo.info](http://fulloo.info)

About the project
--------------

There are currently two Xcode projects in this repository. The first is the bank app written in a plain old MVC style. The second is the same app written using DCI principles. The reason for having two apps is to help show the differences, but also to help show whether DCI actually is beneficial (this is very much an experiment).

The DCI example has two important classes that implement DCI:

- **DCIContext** This is subclassed in order to create the contexts for each use case. It holds all the role information and does the job of applying the roles to the objects playing them.

- **DCIRole** This represents a role for an object. It contains the methods for the role, which can then be applied to any object at runtime.

Alternative branches
-----------------

There are a number of alternative branches for the project, as I experiment with different ways of implementing DCI. An explanation of the differences and thought processes behind each branch is below:

- **master** This is the initial attempt at DCI. The context is very lightweight, with most of the heavy lifting done by the developer in the subclass. It stores the relationships between player objects and roles and provides an execute method that will invoke the passed block in the context after applying roles to the players

- **alternative1** This branch tries to formalise things such as error handling and models a context in a similar way to an NSOperation. From the outside objects call *-start:* which sets up the environment, runs the code and returns an error if one occurs. The code to start a context is put in the *-main* method. If an error occurs the returnError: method can be called to set the error on the context. The idea behind this change is to make it easier to add support for concurrent/asynchronous contexts.

Licence
------

All this code is available under the MIT licence.