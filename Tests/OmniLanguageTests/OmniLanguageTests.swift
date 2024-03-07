import XCTest
@testable import OmniCompiler
@testable import OmniLanguage

import Ghostwriter
import Time

final class OmniLanguageTests: XCTestCase
{
    func testEffectInstance() throws
    {
        let effect = GhostwriterSpeakEffect()
        let instance = EffectInstance(effect: effect)
        let chain = EffectChain(instance: instance)
        print(chain)
    }

    func testEffectInstanceWithBinding() throws
    {
        let effect = GhostwriterSpeakEffect()
        let binding = Binding(value: .structuredText(StructuredText(texts: [.string("test")])))
        let instance = EffectInstance(effect: effect, binding: binding)
        print(instance)
    }

    func testEffectChainWithBindingAndSequencer() throws
    {
        let effect2 = GhostwriterListenEffect()
        let binding2 = Binding(value: .structuredText(StructuredText(texts: [.string("hello")])))
        let instance2 = EffectInstance(effect: effect2, binding: binding2)
        let chain2 = EffectChain(instance: instance2)

        let effect1 = GhostwriterSpeakEffect()
        let binding1 = Binding(value: .structuredText(StructuredText(texts: [.string("test")])))
        let instance1 = EffectInstance(effect: effect1, binding: binding1)
        let chain1 = EffectChain(instance: instance1, sequencer: Sequential(), chain: chain2)

        print(chain1)
    }

    func testPop3Server() throws
    {
        /*
        S> +OK POP3 server ready.
        C> STLS
        S> +OK Begin TLS Negotiation
        */

        let effect1 = GhostwriterSpeakEffect()
        let binding1 = Binding(value: .structuredText(StructuredText(
            .text("+OK POP3 server ready."), .newline(.crlf)
        )))
        let instance1 = EffectInstance(effect: effect1, binding: binding1)

        let effect2 = GhostwriterListenEffect()
        let binding2 = Binding(value: .structuredText(StructuredText(
            .text("STLS"), .newline(.crlf)
        )))
        let refinement = Refinement(name: "timeout", value: .timeDuration(TimeDuration(resolution: .seconds, ticks: 5)))
        let instance2 = EffectInstance(effect: effect2, binding: binding2, refinement: refinement)

        let effect3 = GhostwriterSpeakEffect()
        let binding3 = Binding(value: .structuredText(StructuredText(
            .text("+OK Begin TLS Negotiation"), .newline(.crlf)
        )))
        let instance3 = EffectInstance(effect: effect3, binding: binding3)

        let chain = EffectChain(
            instance: instance1,
            sequencer: Sequential(),
            chain: EffectChain(
                instance: instance2,
                sequencer: Blocking(),
                chain: EffectChain(
                    instance: instance3
                )
            )
        )

        print(chain.description)
    }

    func testPop3Client() throws
    {
        /*
         S> +OK POP3 server ready.
         C> STLS
         S> +OK Begin TLS Negotiation
         */

        let effect1 = GhostwriterListenEffect()
        let binding1 = Binding(value: .structuredText(StructuredText(
            .text("+OK POP3 server ready."), .newline(.crlf)
        )))
        let refinement1 = Refinement(name: "timeout", value: .timeDuration(TimeDuration(resolution: .seconds, ticks: 5)))
        let instance1 = EffectInstance(effect: effect1, binding: binding1, refinement: refinement1)

        let effect2 = GhostwriterSpeakEffect()
        let binding2 = Binding(value: .structuredText(StructuredText(
            .text("STLS"), .newline(.crlf)
        )))
        let instance2 = EffectInstance(effect: effect2, binding: binding2)

        let effect3 = GhostwriterListenEffect()
        let binding3 = Binding(value: .structuredText(StructuredText(
            .text("+OK Begin TLS Negotiation"), .newline(.crlf)
        )))
        let refinement3 = Refinement(name: "timeout", value: .timeDuration(TimeDuration(resolution: .seconds, ticks: 5)))
        let instance3 = EffectInstance(effect: effect3, binding: binding3, refinement: refinement3)

        let chain = EffectChain(
            instance: instance1,
            sequencer: Blocking(),
            chain: EffectChain(
                instance: instance2,
                sequencer: Sequential(),
                chain: EffectChain(
                    instance: instance3
                )
            )
        )

        print(chain.description)
    }

    func testCompilePop3Server() throws
    {
        /*
         S> +OK POP3 server ready.
         C> STLS
         S> +OK Begin TLS Negotiation
         */

        let effect1 = GhostwriterSpeakEffect()
        let binding1 = Binding(value: .structuredText(StructuredText(
            .text("+OK POP3 server ready."), .newline(.crlf)
        )))
        let instance1 = EffectInstance(effect: effect1, binding: binding1)

        let effect2 = GhostwriterListenEffect()
        let binding2 = Binding(value: .structuredText(StructuredText(
            .text("STLS"), .newline(.crlf)
        )))
        let refinement = Refinement(name: "timeout", value: .timeDuration(TimeDuration(resolution: .seconds, ticks: 5)))
        let instance2 = EffectInstance(effect: effect2, binding: binding2, refinement: refinement)

        let effect3 = GhostwriterSpeakEffect()
        let binding3 = Binding(value: .structuredText(StructuredText(
            .text("+OK Begin TLS Negotiation"), .newline(.crlf)
        )))
        let instance3 = EffectInstance(effect: effect3, binding: binding3)

        let chain = EffectChain(
            instance: instance1,
            sequencer: Sequential(),
            chain: EffectChain(
                instance: instance2,
                sequencer: Blocking(),
                chain: EffectChain(
                    instance: instance3
                )
            )
        )

        print(chain.description)

        let compiler = SwiftOmniCompiler()
        let result = try compiler.compile("POP3Server", chain)

        print(result)
    }

    func testCompilePop3Client() throws
    {
        /*
         S> +OK POP3 server ready.
         C> STLS
         S> +OK Begin TLS Negotiation
         */

        let effect1 = GhostwriterListenEffect()
        let binding1 = Binding(value: .structuredText(StructuredText(
            .text("+OK POP3 server ready."), .newline(.crlf)
        )))
        let refinement1 = Refinement(name: "timeout", value: .timeDuration(TimeDuration(resolution: .seconds, ticks: 5)))
        let instance1 = EffectInstance(effect: effect1, binding: binding1, refinement: refinement1)

        let effect2 = GhostwriterSpeakEffect()
        let binding2 = Binding(value: .structuredText(StructuredText(
            .text("STLS"), .newline(.crlf)
        )))
        let instance2 = EffectInstance(effect: effect2, binding: binding2)

        let effect3 = GhostwriterListenEffect()
        let binding3 = Binding(value: .structuredText(StructuredText(
            .text("+OK Begin TLS Negotiation"), .newline(.crlf)
        )))
        let refinement3 = Refinement(name: "timeout", value: .timeDuration(TimeDuration(resolution: .seconds, ticks: 5)))
        let instance3 = EffectInstance(effect: effect3, binding: binding3, refinement: refinement3)

        let chain = EffectChain(
            instance: instance1,
            sequencer: Blocking(),
            chain: EffectChain(
                instance: instance2,
                sequencer: Sequential(),
                chain: EffectChain(
                    instance: instance3
                )
            )
        )

        print(chain.description)

        let compiler = SwiftOmniCompiler()
        let result = try compiler.compile("POP3Server", chain)

        print(result)
    }
}
