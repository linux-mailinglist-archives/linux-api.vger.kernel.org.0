Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4910C19271C
	for <lists+linux-api@lfdr.de>; Wed, 25 Mar 2020 12:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgCYL1P (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 25 Mar 2020 07:27:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51282 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbgCYL1P (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Mar 2020 07:27:15 -0400
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jH4BR-0007uT-JQ; Wed, 25 Mar 2020 11:26:53 +0000
Date:   Wed, 25 Mar 2020 12:26:52 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Andrei Vagin <avagin@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: clone3: allow creation of time namespace with offset
Message-ID: <20200325112652.sx66bhad7cqdsatm@wittgenstein>
References: <20200317083043.226593-1-areber@redhat.com>
 <CAK8P3a2-qQhpRdF0+iVrpp=vEvgwtndQL89CUm_QzoW2QYX1Jw@mail.gmail.com>
 <20200319081137.GC223854@dcbz.redhat.com>
 <CAK8P3a18YySozk6P77JpS58Hbtz=QQmLKw+PrzXbdOwtOQQuJA@mail.gmail.com>
 <20200319102955.i7slokibkkysz6g6@wittgenstein>
 <20200320183355.GA118769@gmail.com>
 <20200324160945.orcm75avj2ol3eop@wittgenstein>
 <20200324162546.GG358599@dcbz.redhat.com>
 <20200324175649.fqkwiuvs2drk26ln@wittgenstein>
 <20200325075836.GK358599@dcbz.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200325075836.GK358599@dcbz.redhat.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Mar 25, 2020 at 08:58:36AM +0100, Adrian Reber wrote:
> On Tue, Mar 24, 2020 at 06:56:49PM +0100, Christian Brauner wrote:
> > On Tue, Mar 24, 2020 at 05:25:46PM +0100, Adrian Reber wrote:
> > > On Tue, Mar 24, 2020 at 05:09:45PM +0100, Christian Brauner wrote:
> > > > On Fri, Mar 20, 2020 at 11:33:55AM -0700, Andrei Vagin wrote:
> > > > > On Thu, Mar 19, 2020 at 11:29:55AM +0100, Christian Brauner wrote:
> > > > > > On Thu, Mar 19, 2020 at 09:16:43AM +0100, Arnd Bergmann wrote:
> > > > > > > On Thu, Mar 19, 2020 at 9:11 AM Adrian Reber <areber@redhat.com> wrote:
> > > > > > > 
> > > > > > > > With Arnd's idea of only using nanoseconds, timens_offset would then
> > > > > > > > contain something like this:
> > > > > > > >
> > > > > > > > struct timens_offset {
> > > > > > > >         __aligned_s64 monotonic_offset_ns;
> > > > > > > >         __aligned_s64 boottime_offset_ns;
> > > > > > > > };
> > > > > > > >
> > > > > > > > I kind of prefer adding boottime and monotonic directly to struct clone_args
> > > > > > > >
> > > > > > > >         __aligned_u64 tls;
> > > > > > > >         __aligned_u64 set_tid;
> > > > > > > >         __aligned_u64 set_tid_size;
> > > > > > > > +       __aligned_s64 monotonic_offset_ns;
> > > > > > > > +       __aligned_s64 boottime_offset_ns;
> > > > > > > >  };
> > > > > > > 
> > > > > > > I would also prefer the second approach using two 64-bit integers
> > > > > > > instead of a pointer, as it keeps the interface simpler to implement
> > > > > > > and simpler to interpret by other tools.
> > > > > > 
> > > > > > Why I don't like has two reasons. There's the scenario where we have
> > > > > > added new extensions after the new boottime member and then we introduce
> > > > > > another offset. Then you'd be looking at:
> > > > > > 
> > > > > > __aligned_u64 tls;
> > > > > > __aligned_u64 set_tid;
> > > > > > __aligned_u64 set_tid_size;
> > > > > > + __aligned_s64 monotonic_offset_ns;
> > > > > > + __aligned_s64 boottime_offset_ns;
> > > > > > __aligned_s64 something_1
> > > > > > __aligned_s64 anything_2
> > > > > > + __aligned_s64 sometime_offset_ns
> > > > > > 
> > > > > > which bothers me just by looking at it. That's in addition to adding two
> > > > > > new members to the struct when most people will never set CLONE_NEWTIME.
> > > > > > We'll also likely have more features in the future that will want to
> > > > > > pass down more info than we want to directly expose in struct
> > > > > > clone_args, e.g. for a long time I have been thinking about adding a
> > > > > > struct for CLONE_NEWUSER that allows you to specify the id mappings you
> > > > > > want the new user namespace to get. We surely don't want to force all
> > > > > > new info into the uppermost struct. So I'm not convinced we should here.
> > > > > 
> > > > > I think here we can start thinking about a netlink-like interface.
> > > > 
> > > > I think netlink is just not a great model for an API and I would not
> > > > want us to go down that route.
> > > > 
> > > > I kept thinking about this for a bit and I think that we will end up
> > > > growing more namespace-related functionality. So one thing that came to
> > > > my mind is the following layout:
> > > > 
> > > > struct {
> > > > 	struct {
> > > > 		__s64 monotonic;
> > > > 		__s64 boot;
> > > > 	} time;
> > > > } namespaces;
> > > > 
> > > > struct _clone_args {
> > > > 	__aligned_u64 flags;
> > > > 	__aligned_u64 pidfd;
> > > > 	__aligned_u64 child_tid;
> > > > 	__aligned_u64 parent_tid;
> > > > 	__aligned_u64 exit_signal;
> > > > 	__aligned_u64 stack;
> > > > 	__aligned_u64 stack_size;
> > > > 	__aligned_u64 tls;
> > > > 	__aligned_u64 set_tid;
> > > > 	__aligned_u64 set_tid_size;
> > > > 	__aligned_u64 namespaces;
> > > > 	__aligned_u64 namespaces_size;
> > > > };
> > > > 
> > > > Then when we end up adding id mapping support for CLONE_NEWUSER we can
> > > > extend this with:
> > > > 
> > > > struct {
> > > > 	struct {
> > > > 		__aligned_u64 monotonic;
> > > > 		__aligned_u64 boot;
> > 
> > s/__aligned_u64/__s64/g
> > 
> > Sorry, leftover from my first draft.
> > 
> > > > 	} time;
> > > > 
> > > > 	struct {
> > > > 		/* id mapping members */
> > > > 	} user;
> > > > } namespaces;
> > > > 
> > > > Thoughts? Other ideas?
> > > 
> > > Works for me.
> > > 
> > > If we add the user namespace id mappings and then at some point a third
> > > element for the time namespace appears it would also start to be mixed.
> > > Just as you mentioned that a few mails ago.
> > 
> > I think you misunderstand me or I'm misunderstanding you. That new time
> > namespace member would go into struct time {} so
> > 
> > struct {
> > 	struct {
> > 		__s64 monotonic;
> > 		__s64 boot;
> > 		__s64 someothertime;
> > 	} time;
> > 
> > 	struct {
> > 		/* id mapping members */
> > 	} user;
> > } namespaces;
> 
> My question was about how does the kernel know how 'struct namespaces'
> is structured. How can an older kernel (which only is aware of two
> clocks) deal with a, like in this example, third clock. Will the size
> '__aligned_u64 namespaces_size' be used for versioning?

Yes, that would be the idea.

I don't want to give the impression that I think this is the best
solution. It's one solution that I think is feasible. But if we have
something better that is also future proof I'm happy to hear ideas.

Christian
