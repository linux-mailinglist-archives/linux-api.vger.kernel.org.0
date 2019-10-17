Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D726DA82F
	for <lists+linux-api@lfdr.de>; Thu, 17 Oct 2019 11:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405341AbfJQJV1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 17 Oct 2019 05:21:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52407 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731152AbfJQJV1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 17 Oct 2019 05:21:27 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iL1xv-0004OU-Aq; Thu, 17 Oct 2019 11:21:03 +0200
Date:   Thu, 17 Oct 2019 11:20:56 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andrei Vagin <avagin@gmail.com>
cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Adrian Reber <adrian@lisas.de>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCHv7 01/33] ns: Introduce Time Namespace
In-Reply-To: <20191016233342.GA3075@gmail.com>
Message-ID: <alpine.DEB.2.21.1910171039500.1824@nanos.tec.linutronix.de>
References: <20191011012341.846266-1-dima@arista.com> <20191011012341.846266-2-dima@arista.com> <80af93da-d497-81de-2a2a-179bb3bc852d@arm.com> <alpine.DEB.2.21.1910161230070.2046@nanos.tec.linutronix.de> <20191016233342.GA3075@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Andrei!

On Wed, 16 Oct 2019, Andrei Vagin wrote:
> On Wed, Oct 16, 2019 at 12:39:11PM +0200, Thomas Gleixner wrote:
> > Nah.
> > 
> > config TIME_NS
> > 	bool "TIME namespace"
> > 	depends on GENERIC_VDSO_TIME_NS
> 
> I was thinking to fix this by the same way with a small difference.
> 
> If GENERIC_GETTIMEOFDAY isn't set, it should be safe to allow enabling
> TIME_NS. In this case, clock_gettime works via system call and we don't
> have arch-specific code in this case. Does this sound reasonable?
> 
>         depends on (!GENERIC_GETTIMEOFDAY || GENERIC_VDSO_TIME_NS)

No, that's wrong. If GENERIC_GETTIMEOFDAY is not set, then the architecture
still might have its own VDSO implementation and we agreed in Vancouver a
year ago that we are not going to support per architecture time namespace
VDSO implementations.

So if at all then you want:

   depends on HAVE_GENERIC_VDSO && (!GENERIC_GETTIMEOFDAY || GENERIC_VDSO_TIME_NS)

But that's crap, really.

The reason why HAVE_GENERIC_VDSO and GENERIC_GETTIMEOFDAY exist as separate
config items is not a functional issue. It's there to ease the migration to
the generic VDSO implementation. Having generic VDSO in production without
implementing GENERIC_GETTIMEOFDAY does not make any sense at all.

The architectures which implement VDSO are:

    arm, arm64, mips, nds32, powerpc, riscv, s390, sparc, x86, um

arm64, mips, x86 use the generic VDSO. Patches for arm are floating
around. UM is special as it just traps into the syscalls. No idea about the
rest. Vincenzo might know.

The bad news is that we have no information (except on arm which has a
config switch for VDSO) whether an architecture provides VDSO support or
not.

So unless you add something like

   config HAS_VDSO
   	  bool

which is selected by all architectures which provide VDSO support, the only
sane solution is to depend on GENERIC_VDSO_TIME_NS.

TBH, I would not even bother. The architectures which matter and are going
to use time namespaces already support VDSO and they need to move to the
generic implementation anyway as we discussed and agreed on in Vancouver.

Providing time name spaces for the non VDSO archs is a purely academic
exercise.

Thanks,

	tglx
