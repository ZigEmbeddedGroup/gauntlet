# Gauntlet

Gauntlet is [MicroZig](https://github.com/ZigEmbeddedGroup/microzig)'s
hardware-in-loop (HIL) testing system.

MicroZig gives users interfaces to program embedded hardware using Zig.
Contributors have to test manually, and both bugs and regressions make it into
the codebase regularly.

One may assume that software emulators would be the next logical step, they're
deterministic and can be run anywhere. This is still a lot of work, either
requires building our own simulators, or depending on others, and it doesn't
fully answer the question, does it actually work on hardware?

With this more ambitious project we put in more work and resources than the
simulator path, but we can truely answer the question of whether something works
on real hardware. The other thing this system will give us is the ability to
test Zig compiler codegen for embedded targets.

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
countries with different plugs. We will make use of the standard USB-PD range,
which can deliver 100W of power.

Only one DUT board is active at a time.

## Security Model

Security and convenience are often at odds and it takes good design to bridge
the two.

To kick this good design down the road while safely getting utility ASAP, members
running this system will manually trigger test runs after they have reviewed a
PR.

This design is open-source and anyone is welcome to build their own boards for
their own local testing. Only the results from core team members will be
trusted.
