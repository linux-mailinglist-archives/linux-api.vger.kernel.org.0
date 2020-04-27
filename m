Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0341BAA7C
	for <lists+linux-api@lfdr.de>; Mon, 27 Apr 2020 18:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbgD0QyR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Mon, 27 Apr 2020 12:54:17 -0400
Received: from albireo.enyo.de ([37.24.231.21]:57964 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbgD0QyR (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 27 Apr 2020 12:54:17 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1jT71A-0003bs-8O; Mon, 27 Apr 2020 16:54:04 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1jT71A-00084T-3W; Mon, 27 Apr 2020 18:54:04 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        carlos <carlos@redhat.com>, Rich Felker <dalias@libc.org>,
        linux-api <linux-api@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ben Maurer <bmaurer@fb.com>, Dave Watson <davejwatson@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul <paulmck@linux.vnet.ibm.com>, Paul Turner <pjt@google.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>
Subject: Re: [PATCH glibc 5/9] glibc: Perform rseq(2) registration at C startup and thread creation (v17)
References: <20200326155633.18236-1-mathieu.desnoyers@efficios.com>
        <20200326155633.18236-6-mathieu.desnoyers@efficios.com>
        <87ees9z417.fsf@mid.deneb.enyo.de>
        <284293396.70630.1588005648556.JavaMail.zimbra@efficios.com>
Date:   Mon, 27 Apr 2020 18:54:04 +0200
In-Reply-To: <284293396.70630.1588005648556.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Mon, 27 Apr 2020 12:40:48 -0400
        (EDT)")
Message-ID: <87zhawvphv.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers:

>>> +#include <sys/syscall.h>
>>> +#include <stdint.h>
>>> +#include <kernel-features.h>
>>> +#include <sys/rseq.h>
>>> +
>>> +__thread struct rseq __rseq_abi = {
>>> +  .cpu_id = RSEQ_CPU_ID_UNINITIALIZED,
>>> +};
>> 
>> { should go onto its own line.
>
> OK
>
>> I'd also add attribute_tls_model_ie,
>> also it's implied by the declaration in the header.
>
> This contradicts feedback I received from Szabolcs Nagy in September 2019:
>
> https://public-inbox.org/libc-alpha/c58d4d6e-f22a-f5d9-e23a-5bd72cec1a86@arm.com/
>
> "note that libpthread.so is built with -ftls-model=initial-exec
>
> (and if it wasn't then you'd want to put the attribute on the
> declaration in the internal header file, not on the definition,
> so the actual tls accesses generate the right code)"
>
> In the context of his feedback, __rseq_abi was defined within nptl/pthread_create.c.
> It is now defined in sysdeps/unix/sysv/linux/rseq-sym.c, which is built into the
> csu which AFAIU ends up in libc.so. His comment still applies though, because
> libc.so is also built with -ftls-model=initial-exec.
>
> So should I apply the "initial-exec" TLS model only to the __rseq_abi
> declaration, or is it preferred to apply it to both the declaration
> and the definition ?

I do not have a strong preference here.  Technically, the declaration
in the header file should be enough.

>>> diff --git a/sysdeps/unix/sysv/linux/sys/rseq.h
>>> b/sysdeps/unix/sysv/linux/sys/rseq.h
>>> new file mode 100644
>>> index 0000000000..503dce4cac
>>> --- /dev/null
>>> +++ b/sysdeps/unix/sysv/linux/sys/rseq.h
>>> @@ -0,0 +1,186 @@
>> 
>> I think there is some value in making this header compatible with
>> inclusion from the assembler (including constants for the relevant
>> struct offsets), but that can be a later change.
>
> Agreed. By "later", do you mean before merging the patch, between
> merge of the patch and next glibc release, or for a subsequent glibc
> release ?

It can happen some time after merging the patch, preferably for this
release.  But I don't think it's release-critical.

>>> +/* struct rseq_cs is aligned on 4 * 8 bytes to ensure it is always
>>> +   contained within a single cache-line. It is usually declared as
>>> +   link-time constant data.  */
>>> +struct rseq_cs
>>> +  {
>>> +    /* Version of this structure.  */
>>> +    uint32_t version;
>>> +    /* enum rseq_cs_flags.  */
>>> +    uint32_t flags;
>>> +    uint64_t start_ip;
>>> +    /* Offset from start_ip.  */
>>> +    uint64_t post_commit_offset;
>>> +    uint64_t abort_ip;
>>> +} __attribute__((aligned(4 * sizeof(uint64_t))));
>> 
>> The comment is wrong.  32-byte alignment does not put struct rseq_cs
>> on its own cache line on many (most?) CPUs.  Not using the constant 32
>> looks like unnecessary obfuscation to me.
>
> There is a difference between "being contained within a single cache-line"
> and "being the only structure in a cache-line". The objective here is the
> former.

Fair enough.

> I agree that the constant 32 may be clearer here. I will change to align(32).

With a space, please. 8-)

>>> +/* struct rseq is aligned on 4 * 8 bytes to ensure it is always
>>> +   contained within a single cache-line.
>>> +
>>> +   A single struct rseq per thread is allowed.  */
>>> +struct rseq
>>> +  {
>>> +    /* Restartable sequences cpu_id_start field. Updated by the
>>> +       kernel. Read by user-space with single-copy atomicity
>>> +       semantics. This field should only be read by the thread which
>>> +       registered this data structure. Aligned on 32-bit. Always
>> 
>> What does “Aligned on 32-bit” mean in this context?  Do you mean to
>> reference 32-*byte* alignment here?
>
> No. I really mean 32-bit (4-byte). Being aligned on 32-byte guarantees that
> this field is aligned at least on 4-byte. This is required by single-copy
> atomicity semantics.
>
> Should I update this comment to state "Aligned on 4-byte" instead ?

I think this is implied by all Linux ABIs.  And the explicit alignment
specification for struct rseq makes the alignment 32 bytes.

>>> +    /* Restartable sequences rseq_cs field.
>>> +
>>> +       Contains NULL when no critical section is active for the current
>>> +       thread, or holds a pointer to the currently active struct rseq_cs.
>>> +
>>> +       Updated by user-space, which sets the address of the currently
>>> +       active rseq_cs at the beginning of assembly instruction sequence
>>> +       block, and set to NULL by the kernel when it restarts an assembly
>>> +       instruction sequence block, as well as when the kernel detects that
>>> +       it is preempting or delivering a signal outside of the range
>>> +       targeted by the rseq_cs. Also needs to be set to NULL by user-space
>>> +       before reclaiming memory that contains the targeted struct rseq_cs.
>>> +
>>> +       Read and set by the kernel. Set by user-space with single-copy
>>> +       atomicity semantics. This field should only be updated by the
>>> +       thread which registered this data structure. Aligned on 64-bit.  */
>>> +    union {
>>> +      uint64_t ptr64;
>>> +#ifdef __LP64__
>>> +      uint64_t ptr;
>>> +#else
>>> +      struct {
>>> +#if (defined(__BYTE_ORDER) && (__BYTE_ORDER == __BIG_ENDIAN)) ||
>>> defined(__BIG_ENDIAN)
>>> +        uint32_t padding; /* Initialized to zero.  */
>>> +        uint32_t ptr32;
>>> +#else /* LITTLE */
>>> +        uint32_t ptr32;
>>> +        uint32_t padding; /* Initialized to zero.  */
>>> +#endif /* ENDIAN */
>>> +      } ptr;
>>> +#endif
>>> +    } rseq_cs;
>> 
>> Are these conditionals correct for x32?
>
> Let's see. With x86 gcc:
>
> -m64: (__x86_64__ && __LP64__)
> -m32: (__i386__)
> -mx32: (__x86_64__ && __ILP32__)
>
> So with "#ifdef __LP64__" we specifically target 64-bit pointers. The rest
> falls into the "else" case, which expects 32-bit pointers. Considering that
> x32 has 32-bit pointers, I don't see any issue here.

Does the kernel have a separate 32-bit entry point for rseq on x32?
If not, it will expect the 64-bit struct layout.

> We don't mind that user-space uses that pointer, but we never want the kernel
> to touch that pointer rather than the 32/64-bit-aware fields. One possibility
> would be to do:
>
>     union
>       {
>         uint64_t ptr64;
> #ifdef __LP64__
>         uint64_t ptr;
> #else
>         struct
>           {
> #if (defined (__BYTE_ORDER) && (__BYTE_ORDER == __BIG_ENDIAN)) || defined (__BIG_ENDIAN)
>             uint32_t padding; /* Initialized to zero.  */
>             uint32_t ptr32;
> #else /* LITTLE */
>             uint32_t ptr32;
>             uint32_t padding; /* Initialized to zero.  */
> #endif /* ENDIAN */
>           } ptr;
> #endif
>
> #ifndef __KERNEL__
>      const struct rseq_cs *uptr;
> #endif
>       } rseq_cs;
>
> in the union, so only user-space can see that field. Thoughts ?

I think this depends on where the x32 question lands.
