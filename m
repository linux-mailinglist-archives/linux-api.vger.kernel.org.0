Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBFD82B6C31
	for <lists+linux-api@lfdr.de>; Tue, 17 Nov 2020 18:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgKQRs1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 17 Nov 2020 12:48:27 -0500
Received: from albireo.enyo.de ([37.24.231.21]:47592 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730171AbgKQRs0 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 17 Nov 2020 12:48:26 -0500
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kf55X-0005cw-8T; Tue, 17 Nov 2020 17:48:19 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1kf55U-0000Uk-2v; Tue, 17 Nov 2020 18:48:16 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Will Deacon <will@kernel.org>, linux-api@vger.kernel.org,
        libc-alpha@sourceware.org
Subject: Re: [PATCH v2] arm64: Introduce prctl(PR_PAC_{SET,GET}_ENABLED_KEYS)
References: <20201014055106.25164-1-pcc@google.com>
Date:   Tue, 17 Nov 2020 18:48:16 +0100
In-Reply-To: <20201014055106.25164-1-pcc@google.com> (Peter Collingbourne's
        message of "Tue, 13 Oct 2020 22:51:06 -0700")
Message-ID: <87blfv6fj3.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Peter Collingbourne:

> This prctl allows the user program to control which PAC keys are enabled
> in a particular task. The main reason why this is useful is to enable a
> userspace ABI that uses PAC to sign and authenticate function pointers
> and other pointers exposed outside of the function, while still allowing
> binaries conforming to the ABI to interoperate with legacy binaries that
> do not sign or authenticate pointers.
>
> The idea is that a dynamic loader or early startup code would issue
> this prctl very early after establishing that a process may load legacy
> binaries, but before executing any PAC instructions.

I thought that the silicon did not support this?

What exactly does this switch on and off?  The signing itself (so that
the bits are zero again), or just the verification?

I do not know how easy it will be to adjust the glibc dynamic linker
to this because I expect it to use PAC instructions itself.  (It is an
interesting target, I suppose, so this makes sense to me.)  The loader
code used for initial process setup and later dlopen is the same.
Worst case, we could compile the loader twice.

There is also an issue with LD_AUDIT, where we run user-supplied code
(which might be PAC-compatible) before loading code that is not.  I
guess we could disable PAC by default in LD_AUDIT mode (which is
unusual, no relation to the kernel audit subsystem).
