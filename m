Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB5134D568
	for <lists+linux-api@lfdr.de>; Mon, 29 Mar 2021 18:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhC2Qsa (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Mar 2021 12:48:30 -0400
Received: from albireo.enyo.de ([37.24.231.21]:45770 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229630AbhC2QsR (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 29 Mar 2021 12:48:17 -0400
Received: from [172.17.203.2] (port=58345 helo=deneb.enyo.de)
        by albireo.enyo.de ([172.17.140.2]) with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1lQv3d-0006Ik-Dr; Mon, 29 Mar 2021 16:48:05 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1lQv3d-000688-9F; Mon, 29 Mar 2021 18:48:05 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Len Brown via Libc-alpha <libc-alpha@sourceware.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, Len Brown <lenb@kernel.org>,
        Rich Felker <dalias@libc.org>,
        Linux API <linux-api@vger.kernel.org>,
        "Bae\, Chang Seok" <chang.seok.bae@intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kyle Huey <me@kylehuey.com>, Andy Lutomirski <luto@kernel.org>,
        Keno Fischer <keno@juliacomputing.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
References: <CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_WRXtDSAGcbG8N+gtdQ@mail.gmail.com>
        <CALCETrUBC34NSHj3eLScYtHJk_7ZHOVJZVPkdLUXemPEiyA_uA@mail.gmail.com>
        <CAJvTdKm8aQPwQMXFQWgVb5dfJ88ds3d0=uHOyWeueUqfya9Nsw@mail.gmail.com>
        <YF8B3M9qihZzCf3n@kroah.com>
        <CAJvTdK=QbPRtZ9zPgu8c9tqxOtaG3apo7u4BBTXP0--qVWA5ig@mail.gmail.com>
        <CAJvTdKkKhCFpaWm1hb8r3GHx10KBRQvpJNTtYPSAc6m28A7sQA@mail.gmail.com>
Date:   Mon, 29 Mar 2021 18:48:05 +0200
In-Reply-To: <CAJvTdKkKhCFpaWm1hb8r3GHx10KBRQvpJNTtYPSAc6m28A7sQA@mail.gmail.com>
        (Len Brown via Libc-alpha's message of "Mon, 29 Mar 2021 12:38:59
        -0400")
Message-ID: <87eefxucsa.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Len Brown via Libc-alpha:

>> In particular, the library may use instructions that main() doesn't know exist.
>
> And so I'll ask my question another way.
>
> How is it okay to change the value of XCR0 during the run time of a
> program?
>
> I submit that it is not, and that is a deal-killer for a
> request/release API.
>
> eg.  main() doesn't know that the math library wants to use AMX, and
> neither does the threading library.  So main() doesn't know to call
> the API before either library is invoked.  The threading library
> starts up and creates user-space threads based on the initial value
> from XCR0.  Then the math library calls the API, which adds bits to
> XCRO, and then the user-space context switch in the threading
> library corrupts data because the new XCR0 size doesn't match the
> initial size.

I agree that this doesn't quite work.  (Today, it's not the thread
library, but the glibc dynamic loader trampoline.)

I disagree that CPU feature enablement has been a failure.  I think we
are pretty good at enabling new CPU features on older operating
systems, not just bleeding edge mainline kernels.  Part of that is
that anything but the kernel stays out of the way, and most features
are available directly via inline assembly (you can even use .byte
hacks if you want).  There is no need to switch to new userspace
libraries, compile out-of-tree kernel drivers that have specific
firmware requirements, and so on.

If the operations that need a huge context can be made idempotent,
with periodic checkpoints, it might be possible to avoid saving the
context completely by some rseq-like construct.
