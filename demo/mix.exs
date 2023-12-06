defmodule Demo.MixProject do
  use Mix.Project

  def project do
    [
      app: :demo,
      version: "0.0.0",
      elixir: "~> 1.12",
      elixirc_options: [warnings_as_errors: halt_on_warnings?(Mix.env())],
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      dialyzer: dialyzer(),
      gettext: gettext()
    ]
  end

  def application do
    [
      mod: {Demo.Application, []},
      extra_applications: [:logger, :runtime_tools, :os_mon]
    ]
  end

  defp halt_on_warnings?(:test), do: false
  defp halt_on_warnings?(:dev), do: false
  defp halt_on_warnings?(_), do: true

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(:dev), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:libcluster, "~> 3.2"},
      {:ex_doc, "~> 0.23", only: [:dev, :test], runtime: false},
      {:phoenix, "~> 1.7.6"},
      {:phoenix_pubsub, "~> 2.0"},
      {:phoenix_ecto, "~> 4.0"},
      {:ecto_sql, "~> 3.1"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 3.2"},
      {:phoenix_live_view, "~> 0.19.0"},
      {:phoenix_live_dashboard, "~> 0.8"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:esbuild, "~> 0.5", runtime: Mix.env() == :dev},
      {:tailwind, "~> 0.2.0", runtime: Mix.env() == :dev},
      {:telemetry_poller, "~> 1.0"},
      {:telemetry_metrics, "~> 0.6"},
      {:ecto_psql_extras, "~> 0.2"},
      {:circular_buffer, "~> 0.4.0"},
      {:gettext, "~> 0.18"},
      {:plug_cowboy, "~> 2.5"},
      {:dialyxir, "~> 1.0", only: [:dev, :test], runtime: false},
      {:credo, "~> 1.6.1", only: [:dev, :test], runtime: false},
      {:sobelow, "~> 0.8", only: [:dev, :test]},
      {:mix_audit, "~> 2.0", only: [:dev, :test], runtime: false},
      {:sentry, "~> 9.0"},
      {:ex_machina, "~> 2.3"},
      {:hackney, "~> 1.17", override: true},
      {:faker, "~> 0.17"},
      {:swoosh, "~> 1.0"},
      {:phoenix_swoosh, "~> 1.0"},
      {:gen_smtp, "~> 1.1"},
      {:backpex, path: "../."},
      {:tailwind_formatter, "~> 0.3.2", only: [:dev, :test], runtime: false},
      {:csv, "~> 3.2.0"},
      {:tesla, "~> 1.4"},
      {:jason, ">= 1.0.0"}
    ]
  end

  defp aliases do
    [
      setup: ["deps.get", "ecto.setup"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.seed": ["run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.rollback --all", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test --warnings-as-errors"],
      "assets.deploy": ["tailwind default --minify", "esbuild default --minify", "phx.digest"]
    ]
  end

  defp dialyzer do
    [
      plt_core_path: "../priv/plts",
      plt_local_path: "priv/plts",
      plt_add_apps: [:ex_unit, :mix],
      ignore_warnings: "dialyzer.ignore-warnings"
    ]
  end

  defp gettext() do
    [
      write_reference_comments: false,
      sort_by_msgid: :case_insensitive
    ]
  end
end
