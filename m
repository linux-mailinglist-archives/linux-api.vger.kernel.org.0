Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5DE27D5D2
	for <lists+linux-api@lfdr.de>; Thu,  1 Aug 2019 08:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730486AbfHAGsi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 1 Aug 2019 02:48:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34108 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730472AbfHAGsh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 1 Aug 2019 02:48:37 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ht4sm-00078d-HJ; Thu, 01 Aug 2019 08:48:12 +0200
Date:   Thu, 1 Aug 2019 08:48:10 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     Dmitry Safonov <dima@arista.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        criu@openvz.org, Linux API <linux-api@vger.kernel.org>,
        X86 ML <x86@kernel.org>
Subject: Re: [PATCHv5 28/37] x86/vdso: Enable static branches for the timens
 vdso
In-Reply-To: <CALCETrXL6pzDoHfn9Niw_CxNX-_W3=yotDYuqK+kxPhOLofmNA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1908010841500.1788@nanos.tec.linutronix.de>
References: <20190729215758.28405-1-dima@arista.com> <20190729215758.28405-29-dima@arista.com> <CALCETrXL6pzDoHfn9Niw_CxNX-_W3=yotDYuqK+kxPhOLofmNA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, 31 Jul 2019, Andy Lutomirski wrote:
> On Mon, Jul 29, 2019 at 2:58 PM Dmitry Safonov <dima@arista.com> wrote:
> > As it has been discussed on timens RFC, adding a new conditional branch
> > `if (inside_time_ns)` on VDSO for all processes is undesirable.
> >
> > Addressing those problems, there are two versions of VDSO's .so:
> > for host tasks (without any penalty) and for processes inside of time
> > namespace with clk_to_ns() that subtracts offsets from host's time.
> >
> > The timens code in vdso looks like this:
> >
> > if (timens_static_branch_unlikely()) {
> >        clk_to_ns(clk, ts);
> > }
> 
> I'm confused.  Now we effectively have *three* versions: the vDSO
> without timens, and vDSO with timens but with it switched off, and the
> vDSO with timens on.  This seems like too much.

The problem is that if you have a single VDSO, then omce one process joins
a time namespace _ALL_ other processes get an extra conditional with at
least one extra  cache line as a bonus.

This has been discussed at Plumbers last year and the agreement was to
create VDSO plain (no namespace support) and VDSO extra (namespace
support).

The performance hit of the conditional + one etra cache line for tasks
which do not use a time name space is measurable.

That also avoids the whole mess of dealing with the static branch being
flipped. The time name space property is determined on fork/exec _before_
anything can touch the VDSO and depending on it the approriate version of
the VDSO is loaded.

Thanks,

	tglx
