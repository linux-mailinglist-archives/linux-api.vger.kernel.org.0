Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9841D18B162
	for <lists+linux-api@lfdr.de>; Thu, 19 Mar 2020 11:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgCSKaN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 19 Mar 2020 06:30:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51109 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbgCSKaN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Mar 2020 06:30:13 -0400
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jEsR2-00065s-3p; Thu, 19 Mar 2020 10:29:56 +0000
Date:   Thu, 19 Mar 2020 11:29:55 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Adrian Reber <areber@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: clone3: allow creation of time namespace with offset
Message-ID: <20200319102955.i7slokibkkysz6g6@wittgenstein>
References: <20200317083043.226593-1-areber@redhat.com>
 <CAK8P3a2-qQhpRdF0+iVrpp=vEvgwtndQL89CUm_QzoW2QYX1Jw@mail.gmail.com>
 <20200319081137.GC223854@dcbz.redhat.com>
 <CAK8P3a18YySozk6P77JpS58Hbtz=QQmLKw+PrzXbdOwtOQQuJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a18YySozk6P77JpS58Hbtz=QQmLKw+PrzXbdOwtOQQuJA@mail.gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Mar 19, 2020 at 09:16:43AM +0100, Arnd Bergmann wrote:
> On Thu, Mar 19, 2020 at 9:11 AM Adrian Reber <areber@redhat.com> wrote:
> 
> > With Arnd's idea of only using nanoseconds, timens_offset would then
> > contain something like this:
> >
> > struct timens_offset {
> >         __aligned_s64 monotonic_offset_ns;
> >         __aligned_s64 boottime_offset_ns;
> > };
> >
> > I kind of prefer adding boottime and monotonic directly to struct clone_args
> >
> >         __aligned_u64 tls;
> >         __aligned_u64 set_tid;
> >         __aligned_u64 set_tid_size;
> > +       __aligned_s64 monotonic_offset_ns;
> > +       __aligned_s64 boottime_offset_ns;
> >  };
> 
> I would also prefer the second approach using two 64-bit integers
> instead of a pointer, as it keeps the interface simpler to implement
> and simpler to interpret by other tools.

Why I don't like has two reasons. There's the scenario where we have
added new extensions after the new boottime member and then we introduce
another offset. Then you'd be looking at:

__aligned_u64 tls;
__aligned_u64 set_tid;
__aligned_u64 set_tid_size;
+ __aligned_s64 monotonic_offset_ns;
+ __aligned_s64 boottime_offset_ns;
__aligned_s64 something_1
__aligned_s64 anything_2
+ __aligned_s64 sometime_offset_ns

which bothers me just by looking at it. That's in addition to adding two
new members to the struct when most people will never set CLONE_NEWTIME.
We'll also likely have more features in the future that will want to
pass down more info than we want to directly expose in struct
clone_args, e.g. for a long time I have been thinking about adding a
struct for CLONE_NEWUSER that allows you to specify the id mappings you
want the new user namespace to get. We surely don't want to force all
new info into the uppermost struct. So I'm not convinced we should here.

Christian
