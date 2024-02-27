#!/usr/bin/env python3
import sys
from os.path import basename, dirname
import argparse

import ecflow

class DefsTraverser:
    """Traverse the ecflow.Defs definition and write to file.

    This demonstrates that all nodes in the node tree and all attributes are
    accessible.  Additionally the state data is also accessible. This class
    will write state data as comments. If the definition was returned from the
    server, it allows access to latest snapshot of the state data held in the
    server.
    """
    def __init__(self, suite, color=False):
        assert isinstance(suite, ecflow.Suite), "Expected ecflow.Suite as first argument"
        self._suite = suite
        self._color = color

    def print_to_stdout(self):
          # print("suite ")
          self._print_node(self._suite)
          # clock = suite.get_clock()
          # if clock:
          #     print(str(clock))
          #     del indent
          self._print_nc(self._suite)
          # print("endsuite")

    def _print_nc(self, node_container):
        for node in node_container.nodes:
            if isinstance(node, ecflow.Task):
                self._print_node(node)
            else:
                self._print_node(node)
                self._print_nc(node)

    def _output(self, text, colour):
        """Print out the node name using ANSI colour codes."""
        colour2ansicode = {
          'red': '\033[;31m',
          'green': '\033[;32m',
          'yellow': '\033[;33m',
          'blue': '\033[;34m',
          'purple': '\033[;35m',
          'cyan': '\033[;36m',
          'white': '\033[;37m',
          'orange': '\033[;91m',
          'end': '\033[0m',
        }
        if self._color:
            print(colour2ansicode[colour] + text + colour2ansicode['end'])
            # print(text)
        else:
            print(text)


    def _print_node(self, node):
        palette = {
          ecflow.DState.queued: 'cyan',
          ecflow.DState.submitted: 'blue',
          ecflow.DState.active: 'green',
          ecflow.DState.aborted: 'red',
          ecflow.DState.complete: 'yellow',
          ecflow.DState.unknown: 'white',
        }
        # print(node.name() + " # state: " + str(node.get_state()))
        if isinstance(node, ecflow.Task):
            node_type = "task"
        elif isinstance(node, ecflow.Family):
            node_type = "family"
        elif isinstance(node, ecflow.Suite):
            node_type = "suite"
        else:
            node_type = "unknown"

        abs_node_path = node.get_abs_node_path()
        nested_level = abs_node_path.count("/") - 1
        indent = '' * nested_level

        text = f"{indent}{abs_node_path} #{node_type} #{node.get_state()}"
        text += f" #def_{node.get_defstatus()}"
        colour = palette[node.get_state()]
        if node.is_suspended():
            text += "\033[1;91m #suspended\033[0m"
        self._output(text, colour)

        # defStatus = node.get_defstatus()
        # if defStatus != ecflow.DState.queued:
        #     print("defstatus " + str(defStatus))

        # autocancel = node.get_autocancel()
        # if autocancel: print(str(autocancel))

        # repeat = node.get_repeat()
        # if not repeat.empty(): print(str(repeat)  + " # value: " + str(repeat.value()))

        # late = node.get_late()
        # if late: print(str(late) + " # is_late: " + str(late.is_late()))

        # complete_expr = node.get_complete()
        # if complete_expr:
        #     for part_expr in complete_expr.parts:
        #         trig = "complete "
        #         if part_expr.and_expr(): trig = trig + "-a "
        #         if part_expr.or_expr():  trig = trig + "-o "
        #         print(trig)
        #         print( part_expr.get_expression() + "\n")
        # trigger_expr = node.get_trigger()
        # if trigger_expr:
        #     for part_expr in trigger_expr.parts:
        #         trig = "trigger "
        #         if part_expr.and_expr(): trig = trig + "-a "
        #         if part_expr.or_expr():  trig = trig + "-o "
        #         print(trig)
        #         print( part_expr.get_expression() + "\n")

        # for var in node.variables:    print("edit " + var.name() + " '" + var.value() + "'")
        # for meter in node.meters:     print(str(meter) + " # value: " + str(meter.value()))
        # for event in node.events:     print(str(event) + " # value: " + str(event.value()))
        # for label in node.labels:     print(str(label) + " # value: " + label.value())
        # for limit in node.limits:     print(str(limit) + " # value: " + str(limit.value()))
        # for inlimit in node.inlimits: print(str(inlimit))
        # for the_time in node.times:   print(str(the_time))
        # for today in node.todays :    print(str(today))
        # for date in node.dates:       print(str(date))
        # for day in node.days:         print(str(day))
        # for cron in node.crons:       print(str(cron))
        # for verify in node.verifies:  print(str(verify))
        # for zombie in node.zombies:   print(str(zombie))

        # del indent
    def __repr__(self):
        return f"DefsTraverser(self._suite, color={self._color})"

parser = argparse.ArgumentParser(description='Util to query ecflow server')

# parser.add_argument('suite', help='Suite name')
parser.add_argument('--host', type=str, default='ecflow-gen-sp0w-001',
                    help='Server name')
parser.add_argument('--port', type=int, default=3141, help='Port number')

parser.add_argument('--color', action='store_true', help='Enable color output')

# Parsea los argumentos de la línea de comandos
args = parser.parse_args()

# Create the client. This will read the default environment variables
ci = ecflow.Client(args.host, args.port)

# Get the node tree suite definition as stored in the server
# The definition is retrieved and stored on the variable 'ci'
ci.sync_local()

# access the definition retrieved from the server
server_defs = ci.get_defs()

if len(list(server_defs.suites)) == 0:
    print("The server has no suites")
    sys.exit(0)

for suite in server_defs.suites:
    traverser = DefsTraverser(suite, color=args.color).print_to_stdout()

