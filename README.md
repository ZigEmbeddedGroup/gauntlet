# Gauntlet

Gauntlet is [MicroZig](https://github.com/ZigEmbeddedGroup/microzig)'s
hardware-in-loop (HIL) testing system.

MicroZig gives users interfaces to program hardware using Zig. Up until now
For the vast
majority of the project engineers have programmed

## Architecture

The physical structure of the testing system follows the
[Eurocard](https://en.wikipedia.org/wiki/Eurocard_(printed_circuit_board))
format. This is a common mechanical standard which enforces no connector or
signal formats, but means there are different enclosure options, many of which
are rack mountable! It also means we can design different sized versions of the
system.

There are three types of components in the system:

- A main board housing a computer, power supply, and bus control circuitry.
- Individual device-under-test (DUT) boards.
- A backplane which houses the bus. All the boards plug into it.

The power plug for this system will be USB-C as we have members in different
contents with different plugs. We will make use of the standard USB-PD range,
which can deliver 100W of power. This should meet all possible requirements and
anything going beyond that means

Only one board is active at a time.

## Security Model

Security and convenience are often at odds and it takes good design to bridge
the two.

To kick this good design down the road while safely getting utility ASAP, members
running this system will manually trigger test runs after they have reviewed a
PR.

This design is open-source and anyone is welcome to build their own boards for
their own local testing. Only the results from core team members will be
trusted.
