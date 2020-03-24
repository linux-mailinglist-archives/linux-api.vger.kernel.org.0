Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4236D19163C
	for <lists+linux-api@lfdr.de>; Tue, 24 Mar 2020 17:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgCXQ0A (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Mar 2020 12:26:00 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:33933 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727773AbgCXQ0A (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 24 Mar 2020 12:26:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585067158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rGlE89xXzndU6kY68rNgDRjOZUQD2MAALUVCdfVBatk=;
        b=gXgWuCyfNYMPaJKugEapOo0oXAECFkpcvIL4wnyEqDz8vnCZa9Uqpnidk5JTqPKA1QACBQ
        bCd6DBjej70RRt4fvpulImife5+FuRkBlJm+RUCggefbtEArdVoIa0nV2KNgE10tsBi8JE
        SvApYvULc6Brw61sVpZxTD4M/hPW7UE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-8kk1b4IFMBSkHBDS9EvLCQ-1; Tue, 24 Mar 2020 12:25:56 -0400
X-MC-Unique: 8kk1b4IFMBSkHBDS9EvLCQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2BC913F8;
        Tue, 24 Mar 2020 16:25:54 +0000 (UTC)
Received: from dcbz.redhat.com (ovpn-112-139.ams2.redhat.com [10.36.112.139])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D0E6A5D9C5;
        Tue, 24 Mar 2020 16:25:48 +0000 (UTC)
Date:   Tue, 24 Mar 2020 17:25:46 +0100
From:   Adrian Reber <areber@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
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
Message-ID: <20200324162546.GG358599@dcbz.redhat.com>
References: <20200317083043.226593-1-areber@redhat.com>
 <CAK8P3a2-qQhpRdF0+iVrpp=vEvgwtndQL89CUm_QzoW2QYX1Jw@mail.gmail.com>
 <20200319081137.GC223854@dcbz.redhat.com>
 <CAK8P3a18YySozk6P77JpS58Hbtz=QQmLKw+PrzXbdOwtOQQuJA@mail.gmail.com>
 <20200319102955.i7slokibkkysz6g6@wittgenstein>
 <20200320183355.GA118769@gmail.com>
 <20200324160945.orcm75avj2ol3eop@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324160945.orcm75avj2ol3eop@wittgenstein>
X-Operating-System: Linux (5.5.8-200.fc31.x86_64)
X-Load-Average: 3.46 2.63 2.29
X-Unexpected: The Spanish Inquisition
X-GnuPG-Key: gpg --recv-keys D3C4906A
X-Url:  <http://lisas.de/~adrian/>
Organization: Red Hat
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Mar 24, 2020 at 05:09:45PM +0100, Christian Brauner wrote:
> On Fri, Mar 20, 2020 at 11:33:55AM -0700, Andrei Vagin wrote:
> > On Thu, Mar 19, 2020 at 11:29:55AM +0100, Christian Brauner wrote:
> > > On Thu, Mar 19, 2020 at 09:16:43AM +0100, Arnd Bergmann wrote:
> > > > On Thu, Mar 19, 2020 at 9:11 AM Adrian Reber <areber@redhat.com> wrote:
> > > > 
> > > > > With Arnd's idea of only using nanoseconds, timens_offset would then
> > > > > contain something like this:
> > > > >
> > > > > struct timens_offset {
> > > > >         __aligned_s64 monotonic_offset_ns;
> > > > >         __aligned_s64 boottime_offset_ns;
> > > > > };
> > > > >
> > > > > I kind of prefer adding boottime and monotonic directly to struct clone_args
> > > > >
> > > > >         __aligned_u64 tls;
> > > > >         __aligned_u64 set_tid;
> > > > >         __aligned_u64 set_tid_size;
> > > > > +       __aligned_s64 monotonic_offset_ns;
> > > > > +       __aligned_s64 boottime_offset_ns;
> > > > >  };
> > > > 
> > > > I would also prefer the second approach using two 64-bit integers
> > > > instead of a pointer, as it keeps the interface simpler to implement
> > > > and simpler to interpret by other tools.
> > > 
> > > Why I don't like has two reasons. There's the scenario where we have
> > > added new extensions after the new boottime member and then we introduce
> > > another offset. Then you'd be looking at:
> > > 
> > > __aligned_u64 tls;
> > > __aligned_u64 set_tid;
> > > __aligned_u64 set_tid_size;
> > > + __aligned_s64 monotonic_offset_ns;
> > > + __aligned_s64 boottime_offset_ns;
> > > __aligned_s64 something_1
> > > __aligned_s64 anything_2
> > > + __aligned_s64 sometime_offset_ns
> > > 
> > > which bothers me just by looking at it. That's in addition to adding two
> > > new members to the struct when most people will never set CLONE_NEWTIME.
> > > We'll also likely have more features in the future that will want to
> > > pass down more info than we want to directly expose in struct
> > > clone_args, e.g. for a long time I have been thinking about adding a
> > > struct for CLONE_NEWUSER that allows you to specify the id mappings you
> > > want the new user namespace to get. We surely don't want to force all
> > > new info into the uppermost struct. So I'm not convinced we should here.
> > 
> > I think here we can start thinking about a netlink-like interface.
> 
> I think netlink is just not a great model for an API and I would not
> want us to go down that route.
> 
> I kept thinking about this for a bit and I think that we will end up
> growing more namespace-related functionality. So one thing that came to
> my mind is the following layout:
> 
> struct {
> 	struct {
> 		__s64 monotonic;
> 		__s64 boot;
> 	} time;
> } namespaces;
> 
> struct _clone_args {
> 	__aligned_u64 flags;
> 	__aligned_u64 pidfd;
> 	__aligned_u64 child_tid;
> 	__aligned_u64 parent_tid;
> 	__aligned_u64 exit_signal;
> 	__aligned_u64 stack;
> 	__aligned_u64 stack_size;
> 	__aligned_u64 tls;
> 	__aligned_u64 set_tid;
> 	__aligned_u64 set_tid_size;
> 	__aligned_u64 namespaces;
> 	__aligned_u64 namespaces_size;
> };
> 
> Then when we end up adding id mapping support for CLONE_NEWUSER we can
> extend this with:
> 
> struct {
> 	struct {
> 		__aligned_u64 monotonic;
> 		__aligned_u64 boot;
> 	} time;
> 
> 	struct {
> 		/* id mapping members */
> 	} user;
> } namespaces;
> 
> Thoughts? Other ideas?

Works for me.

If we add the user namespace id mappings and then at some point a third
element for the time namespace appears it would also start to be mixed.
Just as you mentioned that a few mails ago.

> > > __aligned_u64 set_tid_size;
> > > + __aligned_s64 monotonic_offset_ns;
> > > + __aligned_s64 boottime_offset_ns;
> > > __aligned_s64 something_1
> > > __aligned_s64 anything_2
> > > + __aligned_s64 sometime_offset_ns

If we can live with something like this in the namespaces struct you
proposed, it works for me.

		Adrian

