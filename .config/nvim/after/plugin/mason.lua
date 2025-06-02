require('mason').setup({})
require('mason-lspconfig').setup({
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,
        ['clangd'] = function()
            require('lspconfig').clangd.setup({
                -- cmd = { "clangd", "--clang-tidy", },
            })
        end,
        ['ruff'] = function()
            require('lspconfig').ruff.setup({
                init_options = {
                    settings = {
                        configuration = '~/.config/lsp/ruff.toml'
                    }
                }
            })
        end,
        -- ['basedpyright'] = function()
        --     require('lspconfig').basedpyright.setup({
        --         settings = {
        --             basedpyright = {
        --                 analysis = {
        --                     typeCheckingMode = 'basic',
        --                     diagnosticSeverityOverrides = {
        --                         -- Microsoft is a bunch of degens so this is the only way to
        --                         -- turn all errors from pyright into warnings
        --                         reportGeneralTypeIssues = 'warning',
        --                         reportPropertyTypeMismatch = 'warning',
        --                         reportFunctionMemberAccess = 'warning',
        --                         reportMissingImports = 'warning',
        --                         reportMissingModuleSource = 'warning',
        --                         reportInvalidTypeForm = 'warning',
        --                         reportMissingTypeStubs = 'warning',
        --                         reportImportCycles = 'warning',
        --                         reportUnusedImport = 'warning',
        --                         reportUnusedClass = 'warning',
        --                         reportUnusedFunction = 'warning',
        --                         reportUnusedVariable = 'warning',
        --                         reportDuplicateImport = 'warning',
        --                         reportWildcardImportFromLibrary = 'warning',
        --                         reportAbstractUsage = 'warning',
        --                         reportArgumentType = 'warning',
        --                         reportAssertTypeFailure = 'warning',
        --                         reportAssignmentType = 'warning',
        --                         reportAttributeAccessIssue = 'warning',
        --                         reportCallIssue = 'warning',
        --                         reportInconsistentOverload = 'warning',
        --                         reportIndexIssue = 'warning',
        --                         reportInvalidTypeArguments = 'warning',
        --                         reportNoOverloadImplementation = 'warning',
        --                         reportOperatorIssue = 'warning',
        --                         reportOptionalMemberAccess = 'warning',
        --                         reportOptionalCall = 'warning',
        --                         reportOptionalIterable = 'warning',
        --                         reportOptionalContextManager = 'warning',
        --                         reportOptionalOperand = 'warning',
        --                         reportRedeclaration = 'warning',
        --                         reportReturnType = 'warning',
        --                         reportTypedDictNotRequiredAccess = 'warning',
        --                         reportUntypedFunctionDecorator = 'warning',
        --                         reportUntypedClassDecorator = 'warning',
        --                         reportUntypedBaseClass = 'warning',
        --                         reportUntypedNamedTuple = 'warning',
        --                         reportPrivateUsage = 'warning',
        --                         reportTypeCommentUsage = 'warning',
        --                         reportPrivateImportUsage = 'warning',
        --                         reportConstantRedefinition = 'warning',
        --                         reportDeprecated = 'warning',
        --                         reportIncompatibleMethodOverride = 'warning',
        --                         reportIncompatibleVariableOverride = 'warning',
        --                         reportInconsistentConstructor = 'warning',
        --                         reportOverlappingOverload = 'warning',
        --                         reportMissingSuperCall = 'warning',
        --                         reportUninitializedInstanceVariable = 'warning',
        --                         reportInvalidStringEscapeSequence = 'warning',
        --                         reportUnknownParameterType = 'warning',
        --                         reportUnknownArgumentType = 'warning',
        --                         reportUnknownLambdaType = 'warning',
        --                         reportUnknownVariableType = 'warning',
        --                         reportUnknownMemberType = 'warning',
        --                         reportMissingParameterType = 'warning',
        --                         reportMissingTypeArgument = 'warning',
        --                         reportInvalidTypeVarUse = 'warning',
        --                         reportCallInDefaultInitializer = 'warning',
        --                         reportUnnecessaryIsInstance = 'warning',
        --                         reportUnnecessaryCast = 'warning',
        --                         reportUnnecessaryComparison = 'warning',
        --                         reportUnnecessaryContains = 'warning',
        --                         reportAssertAlwaysTrue = 'warning',
        --                         reportSelfClsParameterName = 'warning',
        --                         reportImplicitStringConcatenation = 'warning',
        --                         reportUndefinedVariable = 'warning',
        --                         reportUnboundVariable = 'warning',
        --                         reportUnhashable = 'warning',
        --                         reportInvalidStubStatement = 'warning',
        --                         reportIncompleteStub = 'warning',
        --                         reportUnsupportedDunderAll = 'warning',
        --                         reportUnusedCallResult = 'warning',
        --                         reportUnusedCoroutine = 'warning',
        --                         reportUnusedExcept = 'warning',
        --                         reportUnusedExpression = 'warning',
        --                         reportUnnecessaryTypeIgnoreComment = 'warning',
        --                         reportMatchNotExhaustive = 'warning',
        --                         reportImplicitOverride = 'warning',
        --                         reportShadowedImports = 'warning',
        --
        --                         -- Suppress shit warnings
        --                         reportOptionalSubscript = 'none',
        --                         reportPossiblyUnboundVariable = 'none',
        --                     }
        --                 }
        --             }
        --         }
        -- })
        -- end
    },
})
