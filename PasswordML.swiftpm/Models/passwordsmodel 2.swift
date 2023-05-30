//
// passwordsmodel_2.swift
//
// This file was automatically generated and should not be edited. NOTE: The file was manually copied from a similar XCode project, to make running the ML model possible
//

import CoreML


/// Model Prediction Input Type
@available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
class passwordsmodel_2Input : MLFeatureProvider {

    /// Password as string value
    var Password: String

    /// Special characters as double value
    var Special_characters: Double

    /// Numbers as double value
    var Numbers: Double

    /// Letters as double value
    var Letters: Double

    /// Capital Letters as double value
    var Capital_Letters: Double

    var featureNames: Set<String> {
        get {
            return ["Password", "Special characters", "Numbers", "Letters", "Capital Letters"]
        }
    }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        if (featureName == "Password") {
            return MLFeatureValue(string: Password)
        }
        if (featureName == "Special characters") {
            return MLFeatureValue(double: Special_characters)
        }
        if (featureName == "Numbers") {
            return MLFeatureValue(double: Numbers)
        }
        if (featureName == "Letters") {
            return MLFeatureValue(double: Letters)
        }
        if (featureName == "Capital Letters") {
            return MLFeatureValue(double: Capital_Letters)
        }
        return nil
    }
    
    init(Password: String, Special_characters: Double, Numbers: Double, Letters: Double, Capital_Letters: Double) {
        self.Password = Password
        self.Special_characters = Special_characters
        self.Numbers = Numbers
        self.Letters = Letters
        self.Capital_Letters = Capital_Letters
    }

}


/// Model Prediction Output Type
@available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
class passwordsmodel_2Output : MLFeatureProvider {

    /// Source provided by CoreML
    private let provider : MLFeatureProvider

    /// Est. Security as double value
    var Est__Security: Double {
        return self.provider.featureValue(for: "Est. Security")!.doubleValue
    }

    var featureNames: Set<String> {
        return self.provider.featureNames
    }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        return self.provider.featureValue(for: featureName)
    }

    init(Est__Security: Double) {
        self.provider = try! MLDictionaryFeatureProvider(dictionary: ["Est. Security" : MLFeatureValue(double: Est__Security)])
    }

    init(features: MLFeatureProvider) {
        self.provider = features
    }
}


/// Class for model loading and prediction
@available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
class passwordsmodel_2 {
    let model: MLModel

    /// URL of model assuming it was installed in the same bundle as this class
    class var urlOfModelInThisBundle : URL {
        let bundle = Bundle(for: self)
        return bundle.url(forResource: "passwordsmodel 2", withExtension:"mlmodelc")!
    }

    /**
        Construct passwordsmodel_2 instance with an existing MLModel object.

        Usually the application does not use this initializer unless it makes a subclass of passwordsmodel_2.
        Such application may want to use `MLModel(contentsOfURL:configuration:)` and `passwordsmodel_2.urlOfModelInThisBundle` to create a MLModel object to pass-in.

        - parameters:
          - model: MLModel object
    */
    init(model: MLModel) {
        self.model = model
    }

    /**
        Construct passwordsmodel_2 instance by automatically loading the model from the app's bundle.
    */
    @available(*, deprecated, message: "Use init(configuration:) instead and handle errors appropriately.")
    convenience init() {
        try! self.init(contentsOf: type(of:self).urlOfModelInThisBundle)
    }

    /**
        Construct a model with configuration

        - parameters:
           - configuration: the desired model configuration

        - throws: an NSError object that describes the problem
    */
    @available(macOS 10.14, iOS 12.0, tvOS 12.0, watchOS 5.0, *)
    convenience init(configuration: MLModelConfiguration) throws {
        try self.init(contentsOf: type(of:self).urlOfModelInThisBundle, configuration: configuration)
    }

    /**
        Construct passwordsmodel_2 instance with explicit path to mlmodelc file
        - parameters:
           - modelURL: the file url of the model

        - throws: an NSError object that describes the problem
    */
    convenience init(contentsOf modelURL: URL) throws {
        try self.init(model: MLModel(contentsOf: modelURL))
    }

    /**
        Construct a model with URL of the .mlmodelc directory and configuration

        - parameters:
           - modelURL: the file url of the model
           - configuration: the desired model configuration

        - throws: an NSError object that describes the problem
    */
    @available(macOS 10.14, iOS 12.0, tvOS 12.0, watchOS 5.0, *)
    convenience init(contentsOf modelURL: URL, configuration: MLModelConfiguration) throws {
        try self.init(model: MLModel(contentsOf: modelURL, configuration: configuration))
    }

    /**
        Construct passwordsmodel_2 instance asynchronously with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - configuration: the desired model configuration
          - handler: the completion handler to be called when the model loading completes successfully or unsuccessfully
    */
    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    class func load(configuration: MLModelConfiguration = MLModelConfiguration(), completionHandler handler: @escaping (Swift.Result<passwordsmodel_2, Error>) -> Void) {
        return self.load(contentsOf: self.urlOfModelInThisBundle, configuration: configuration, completionHandler: handler)
    }

    /**
        Construct passwordsmodel_2 instance asynchronously with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - configuration: the desired model configuration
    */
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    class func load(configuration: MLModelConfiguration = MLModelConfiguration()) async throws -> passwordsmodel_2 {
        return try await self.load(contentsOf: self.urlOfModelInThisBundle, configuration: configuration)
    }

    /**
        Construct passwordsmodel_2 instance asynchronously with URL of the .mlmodelc directory with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - modelURL: the URL to the model
          - configuration: the desired model configuration
          - handler: the completion handler to be called when the model loading completes successfully or unsuccessfully
    */
    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    class func load(contentsOf modelURL: URL, configuration: MLModelConfiguration = MLModelConfiguration(), completionHandler handler: @escaping (Swift.Result<passwordsmodel_2, Error>) -> Void) {
        MLModel.load(contentsOf: modelURL, configuration: configuration) { result in
            switch result {
            case .failure(let error):
                handler(.failure(error))
            case .success(let model):
                handler(.success(passwordsmodel_2(model: model)))
            }
        }
    }

    /**
        Construct passwordsmodel_2 instance asynchronously with URL of the .mlmodelc directory with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - modelURL: the URL to the model
          - configuration: the desired model configuration
    */
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    class func load(contentsOf modelURL: URL, configuration: MLModelConfiguration = MLModelConfiguration()) async throws -> passwordsmodel_2 {
        let model = try await MLModel.load(contentsOf: modelURL, configuration: configuration)
        return passwordsmodel_2(model: model)
    }

    /**
        Make a prediction using the structured interface

        - parameters:
           - input: the input to the prediction as passwordsmodel_2Input

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as passwordsmodel_2Output
    */
    func prediction(input: passwordsmodel_2Input) throws -> passwordsmodel_2Output {
        return try self.prediction(input: input, options: MLPredictionOptions())
    }

    /**
        Make a prediction using the structured interface

        - parameters:
           - input: the input to the prediction as passwordsmodel_2Input
           - options: prediction options

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as passwordsmodel_2Output
    */
    func prediction(input: passwordsmodel_2Input, options: MLPredictionOptions) throws -> passwordsmodel_2Output {
        let outFeatures = try model.prediction(from: input, options:options)
        return passwordsmodel_2Output(features: outFeatures)
    }

    /**
        Make a prediction using the convenience interface

        - parameters:
            - Password as string value
            - Special_characters as double value
            - Numbers as double value
            - Letters as double value
            - Capital_Letters as double value

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as passwordsmodel_2Output
    */
    func prediction(Password: String, Special_characters: Double, Numbers: Double, Letters: Double, Capital_Letters: Double) throws -> passwordsmodel_2Output {
        let input_ = passwordsmodel_2Input(Password: Password, Special_characters: Special_characters, Numbers: Numbers, Letters: Letters, Capital_Letters: Capital_Letters)
        return try self.prediction(input: input_)
    }

    /**
        Make a batch prediction using the structured interface

        - parameters:
           - inputs: the inputs to the prediction as [passwordsmodel_2Input]
           - options: prediction options

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as [passwordsmodel_2Output]
    */
    @available(macOS 10.14, iOS 12.0, tvOS 12.0, watchOS 5.0, *)
    func predictions(inputs: [passwordsmodel_2Input], options: MLPredictionOptions = MLPredictionOptions()) throws -> [passwordsmodel_2Output] {
        let batchIn = MLArrayBatchProvider(array: inputs)
        let batchOut = try model.predictions(from: batchIn, options: options)
        var results : [passwordsmodel_2Output] = []
        results.reserveCapacity(inputs.count)
        for i in 0..<batchOut.count {
            let outProvider = batchOut.features(at: i)
            let result =  passwordsmodel_2Output(features: outProvider)
            results.append(result)
        }
        return results
    }
}
