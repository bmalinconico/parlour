# typed: true
module Parlour
  class RbiGenerator
    class Namespace
      extend T::Sig

      include RbiObject

      sig do
        implementation.overridable.params(
          indent_level: Integer,
          options: Options
        ).returns(T::Array[String])
      end
      def generate_rbi(indent_level, options)
        result = []

        if includes.any? || extends.any?
          result += includes.map do |i|
            options.indented(indent_level, "include #{i}")
          end
          result += extends.map do |e|
            options.indented(indent_level, "extend #{e}")
          end
          result << ""
        end

        first, *rest = children
        return [] unless first

        result += first.generate_rbi(indent_level, options) + T.must(rest)
          .map { |obj| obj.generate_rbi(indent_level, options) }
          .map { |lines| [""] + lines }
          .flatten

        result
      end

      sig { params(block: T.nilable(T.proc.params(x: Namespace).void)).void }
      def initialize(&block)
        @children = []
        @extends = []
        @includes = []
        yield_self(&block)
      end

      sig { returns(T::Array[RbiObject]) }
      attr_reader :children

      sig { returns(T::Array[String]) }
      attr_reader :extends

      sig { returns(T::Array[String]) }
      attr_reader :includes

      sig do
        params(
          name: String,
          superclass: T.nilable(String),
          abstract: T::Boolean,
          block: T.nilable(T.proc.params(x: ClassNamespace).void)
        ).returns(ClassNamespace)
      end
      def create_class(name, superclass: nil, abstract: false, &block)
        new_class = ClassNamespace.new(name, superclass, abstract, &block)
        children << new_class
        new_class
      end

      def create_module
        raise 'NYI'
      end

      sig do
        params(
          name: String,
          parameters: T::Array[Parameter],
          return_type: T.nilable(String),
          abstract: T::Boolean,
          implementation: T::Boolean,
          override: T::Boolean,
          overridable: T::Boolean,
          class_method: T::Boolean
        ).returns(Method)
      end
      def create_method(name, parameters, return_type = nil, abstract: false, implementation: false, override: false, overridable: false, class_method: false)
        new_method = RbiGenerator::Method.new(
          name,
          parameters,
          return_type,
          abstract: abstract,
          implementation: implementation, 
          override: override,
          overridable: overridable,
          class_method: class_method
        )
        children << new_method
        new_method
      end

      sig { params(name: String).void }
      def add_extend(name)
        extends << name
      end
      sig { params(name: String).void }
      def add_include(name)
        includes << name
      end
    end
  end
end