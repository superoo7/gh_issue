defmodule GhProject.CLI do
    @default_count 4

    @moduledoc """
    Handle the command line parsing and dispatch to
    the various functions that end up generating a
    table of the last _n_ issues in a github project
    """

    def run(argv) do
        argv
        |> parse_args
        |> process
    end

    @doc """
    `argv` can be -h or --help, which returns :help

    Otherwise it is a github user name, project name, and (optionally)
    the number of entries to format.

    Return a tuple of `{ user, project, count }`, or    `:help` if help was given

    ## Examples

        iex> import GhProject.CLI
        iex> parse_args(["-h", "anything"])
        :help
        iex> parse_args(["--help", "anything"])
        :help
        iex> parse_args(["user", "project", "20"])
        {"user", "project", 20}
        iex> parse_args(["user", "project"])
        {"user", "project", 4}
    """
    def parse_args(argv) do
        parse = OptionParser.parse(argv, switches: [ help: :boolean],
                                         aliases: [ h: :help ])
        case parse do
            { [ help: true ], _, _ }
                -> :help
            { _, [ user, project, count ], _ }
                -> { user, project, String.to_integer(count) }
            { _, [ user, project ], _ }
                -> { user, project, @default_count }
            _ 
                -> :help
        end
    end

    def process(:help) do
        IO.puts """
        usage: issues <user> <project> [ count | #{@default_count} ]
        """
        System.halt(0)
    end
end