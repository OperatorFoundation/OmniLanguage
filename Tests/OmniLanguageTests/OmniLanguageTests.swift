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
        
        // Instance 1
        let effect1 = GhostwriterSpeakEffect()
        let binding1 = Binding(value: .structuredText(StructuredText(
            .text("+OK POP3 server ready."), .newline(.crlf)
        )))
        let instance1 = EffectInstance(effect: effect1, binding: binding1)
        
        // Instance 2
        let effect2 = GhostwriterListenEffect()
        let binding2 = Binding(value: .structuredText(StructuredText(
            .text("STLS"), .newline(.crlf)
        )))
        let instance2 = EffectInstance(effect: effect2, binding: binding2)

        // Instance
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

        let spacing = chain.findSpacing()
        print(chain.format(spacing: spacing))
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
        let instance1 = EffectInstance(effect: effect1, binding: binding1)

        let effect2 = GhostwriterSpeakEffect()
        let binding2 = Binding(value: .structuredText(StructuredText(
            .text("STLS"), .newline(.crlf)
        )))
        let instance2 = EffectInstance(effect: effect2, binding: binding2)

        let effect3 = GhostwriterListenEffect()
        let binding3 = Binding(value: .structuredText(StructuredText(
            .text("+OK Begin TLS Negotiation"), .newline(.crlf)
        )))
        let instance3 = EffectInstance(effect: effect3, binding: binding3)

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
    
    func testSMTPClient() throws
    {
        // let _ = try await listen(structuredText: StructuredText(TypedText.text("220 "), TypedText.regexp("^([a-zA-Z0-9.-]+)"), TypedText.text(" SMTP service ready"), TypedText.newline(.crlf)), maxSize: 253, timeout: .seconds(Int.max))
        let listen1 = GhostwriterListenEffect()
        let binding1 = Binding(value: .structuredText(StructuredText(TypedText.text("220 "), TypedText.regexp("^([a-zA-Z0-9.-]+)"), TypedText.text(" SMTP service ready"), TypedText.newline(.crlf))
        ))
        let maxSize = MaxSize(.number(.int(253)))
        let instance1 = EffectInstance(effect: listen1, binding: binding1, refinements: [maxSize])

        // try await speak(structuredText: StructuredText(TypedText.text("EHLO mail.imc.org"), TypedText.newline(.crlf)))
        let speak1 = GhostwriterSpeakEffect()
        let binding2 = Binding(value: .structuredText(StructuredText(TypedText.text("EHLO mail.imc.org"), TypedText.newline(.crlf))
        ))
        let instance2 = EffectInstance(effect: speak1, binding: binding2)

        //  _ = try await listen(structuredText: StructuredText(TypedText.text("250 STARTTLS"), TypedText.newline(.crlf)), maxSize: 253, timeout: .seconds(10))
        let listen2 = GhostwriterListenEffect()
        let binding3 = Binding(value: .structuredText(StructuredText(TypedText.text("250 STARTTLS"), TypedText.newline(.crlf))
        ))
        let instance3 = EffectInstance(effect: listen2, binding: binding3, refinements: [maxSize])
        
        // try await speak(structuredText: StructuredText(TypedText.text("STARTTLS"), TypedText.newline(.crlf)))
        let speak2 = GhostwriterSpeakEffect()
        let binding4 = Binding(value: .structuredText(StructuredText(TypedText.text("STARTTLS"), TypedText.newline(.crlf))
        ))
        let instance4 = EffectInstance(effect: speak2, binding: binding4)
        
        // _ = try await listen(structuredText: StructuredText(TypedText.regexp("^(.+)$"), TypedText.newline(.crlf)), maxSize: 253, timeout: .seconds(10))
        
        let listen3 = GhostwriterListenEffect()
        let binding5 = Binding(value: .structuredText(StructuredText(TypedText.regexp("^(.+)$"), TypedText.newline(.crlf))
        ))
        let instance5 = EffectInstance(effect: listen3, binding: binding5, refinements: [maxSize])

        let end = EndProgramEffect()
        let instance6 = EffectInstance(effect: end)

        let timeout = TimeDuration(resolution: .seconds, ticks: 10)

        let chain = EffectChain(
            instance: instance1,
            sequencer: Waiting(),
            chain: EffectChain(
                instance: instance2,
                sequencer: Sequential(),
                chain: EffectChain(
                    instance: instance3,
                    sequencer: Waiting(timeout),
                    chain: EffectChain(
                        instance: instance4,
                        sequencer: Sequential(),
                        chain: EffectChain(
                            instance: instance5,
                            sequencer: Waiting(timeout),
                            chain: EffectChain(
                                instance: instance6
                            )
                        )
                    )
                )
            )
        )

        print(chain.description)

        let spacing = chain.findSpacing()
        print(chain.format(spacing: spacing))

        let compiler = SwiftOmniCompiler()
        let result = try compiler.compile("SMTPClient", chain)

        print(result)
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
        let instance2 = EffectInstance(effect: effect2, binding: binding2)

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
        let instance1 = EffectInstance(effect: effect1, binding: binding1)

        let effect2 = GhostwriterSpeakEffect()
        let binding2 = Binding(value: .structuredText(StructuredText(
            .text("STLS"), .newline(.crlf)
        )))
        let instance2 = EffectInstance(effect: effect2, binding: binding2)

        let effect3 = GhostwriterListenEffect()
        let binding3 = Binding(value: .structuredText(StructuredText(
            .text("+OK Begin TLS Negotiation"), .newline(.crlf)
        )))
        let instance3 = EffectInstance(effect: effect3, binding: binding3)

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
        let result = try compiler.compile("POP3Client", chain)

        print(result)
    }
}
