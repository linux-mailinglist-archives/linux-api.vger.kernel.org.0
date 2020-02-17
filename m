Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 853BB161DDE
	for <lists+linux-api@lfdr.de>; Tue, 18 Feb 2020 00:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgBQX3u (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 17 Feb 2020 18:29:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34977 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgBQX3u (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 17 Feb 2020 18:29:50 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j3ppQ-0001U1-Uu; Tue, 18 Feb 2020 00:29:29 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 4D4DA100292; Tue, 18 Feb 2020 00:29:27 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        "Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>
Cc:     Dmitry Safonov <dima@arista.com>, Andrei Vagin <avagin@openvz.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers <containers@lists.linux-foundation.org>,
        criu@openvz.org, Linux API <linux-api@vger.kernel.org>,
        x86@kernel.org, Andrei Vagin <avagin@gmail.com>
Subject: Re: Time Namespaces: CLONE_NEWTIME and clone3()?
In-Reply-To: <20200217230331.he6p5bs766zp6smx@wittgenstein>
Date:   Tue, 18 Feb 2020 00:29:27 +0100
Message-ID: <874kvossh4.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Christian Brauner <christian.brauner@ubuntu.com> writes:
> On Mon, Feb 17, 2020 at 10:47:53PM +0100, Michael Kerrisk (man-pages) wrote:
>> Actually, I think the alternative you propose just here is better. I
>> imagine there are times when one will want to create multiple
>> namespaces with a single call to clone3(), including a time namespace.
>> I think this should be allowed by the API. And, otherwise, clone3()
>> becomes something of a second-class citizen for creating namespaces.
>> (I don't really get the "less invasive" argument. Implementing this is
>> just a piece of kernel to code to make user-space's life a bit simpler
>> and more consistent.)
>
> I don't particularly mind either way. If there's actual users that need
> to set it at clone3() time then we can extend it. So I'd like to hear
> what Adrian, Dmitry, and Thomas think since they are well-versed how
> this will be used in the wild. I'm weary of exposing a whole new uapi
> struct and extending clone3() without any real use-case but I'm happy to
> if there is!

I really have no clue. I merily helped getting this in shape without
creating havoc for timekeeping and VDSO. I have to punt to the container
wizards.

Thanks,

        tglx
