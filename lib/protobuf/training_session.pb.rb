#!/usr/bin/env ruby
# Generated by the protocol buffer compiler. DO NOT EDIT!

require 'protocol_buffers'

begin; require 'types.pb'; rescue LoadError; end
begin; require 'structures.pb'; rescue LoadError; end

module PolarData
  # forward declarations
  class PbSessionHeartRateStatistics < ::ProtocolBuffers::Message; end
  class PbTrainingSession < ::ProtocolBuffers::Message; end

  class PbSessionHeartRateStatistics < ::ProtocolBuffers::Message
    set_fully_qualified_name "polar_data.PbSessionHeartRateStatistics"

    optional :uint32, :average, 1
    optional :uint32, :maximum, 2
  end

  class PbTrainingSession < ::ProtocolBuffers::Message
    set_fully_qualified_name "polar_data.PbTrainingSession"

    required ::PbLocalDateTime, :start, 1
    optional ::PbLocalDateTime, :end, 20
    required :uint32, :exercise_count, 2
    optional :string, :device_id, 3
    optional :string, :model_name, 4
    optional ::PbDuration, :duration, 5
    optional :float, :distance, 6
    optional :uint32, :calories, 7
    optional ::PolarData::PbSessionHeartRateStatistics, :heart_rate, 8
    repeated ::PbDuration, :heart_rate_zone_duration, 9
    optional ::PbTrainingLoad, :training_load, 10
    optional ::PbOneLineText, :session_name, 11
    optional :float, :feeling, 12
    optional ::PbMultiLineText, :note, 13
    optional ::PbOneLineText, :place, 14
    optional :double, :latitude, 15
    optional :double, :longitude, 16
    optional ::PbExerciseFeedback, :benefit, 17
    optional ::PbSportIdentifier, :sport, 18
    optional ::PbTrainingSessionTargetId, :training_session_target_id, 19
    optional ::PbTrainingSessionFavoriteId, :training_session_favorite_id, 21
  end

end