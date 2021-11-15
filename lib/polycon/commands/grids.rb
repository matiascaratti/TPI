module Polycon
    module Commands
        module Grids
            class FilterByWeek < Dry::CLI::Command
                argument :week, required: true, desc: 'A week to generate the grid'
                option :professional, required: false, desc: 'An optional professional name to filter'

                example [
                    '"2021-09-16" --professional="Alma Estevez"',
                    '"2021-09-16"'
                ]

                def call(week: , professional: nil)

                end
            end

            class FilterByDay < Dry::CLI::Command
                argument :day, required: true, desc: 'A day to generate the grid'
                option :professional, required: false, desc: 'An optional professional name to filter'

                example [
                    '"2021-09-16" --professional="Alma Estevez"',
                    '"2021-09-16"'
                ]

                def call(day: , professional: nil)
                    Polycon::Utils.verify_date_format(day)
                    if (professional.nil?)
                        professionals = Polycon::Models::Professional.list()
                    else
                        professionals = [professional]
                    end
                    Polycon::Grid.filterByDay(day, professionals)
                end
            end
        end
    end
end