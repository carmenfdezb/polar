#!/usr/bin/env ruby
# Generated by the protocol buffer compiler. DO NOT EDIT!

require 'protocol_buffers'

begin; require 'types.pb'; rescue LoadError; end
begin; require 'structures.pb'; rescue LoadError; end

module PolarData
  # forward declarations
  class PbExerciseCounters < ::ProtocolBuffers::Message; end
  class PbExerciseBase < ::ProtocolBuffers::Message; end

  class PbExerciseCounters < ::ProtocolBuffers::Message
    set_fully_qualified_name "polar_data.PbExerciseCounters"

    optional :uint32, :sprint_count, 1
  end

  class PbExerciseBase < ::ProtocolBuffers::Message
    set_fully_qualified_name "polar_data.PbExerciseBase"

    required ::PbLocalDateTime, :start, 1
    required ::PbDuration, :duration, 2
    required ::PbSportIdentifier, :sport, 3
    optional :float, :distance, 4
    optional :uint32, :calories, 5
    optional ::PbTrainingLoad, :training_load, 6
    repeated ::PbFeatureType, :available_sensor_features, 7
    optional ::PbRunningIndex, :running_index, 9
    optional :float, :ascent, 10
    optional :float, :descent, 11
    optional :double, :latitude, 12
    optional :double, :longitude, 13
    optional :string, :place, 14
    optional ::PolarData::PbExerciseCounters, :exercise_counters, 16
    optional :float, :speed_calibration_offset, 17, :default => 0
    optional :float, :walking_distance, 18
    optional ::PbDuration, :walking_duration, 19
  end

end