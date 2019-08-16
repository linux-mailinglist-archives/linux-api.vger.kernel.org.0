Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7A1F8FB1D
	for <lists+linux-api@lfdr.de>; Fri, 16 Aug 2019 08:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfHPGfC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 16 Aug 2019 02:35:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41388 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfHPGfC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 16 Aug 2019 02:35:02 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hyVor-0003Lr-4G; Fri, 16 Aug 2019 08:34:37 +0200
Date:   Fri, 16 Aug 2019 08:34:35 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andrei Vagin <avagin@gmail.com>
cc:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
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
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCHv6 01/36] ns: Introduce Time Namespace
In-Reply-To: <20190816061119.GA14312@gmail.com>
Message-ID: <alpine.DEB.2.21.1908160828490.1908@nanos.tec.linutronix.de>
References: <20190815163836.2927-1-dima@arista.com> <20190815163836.2927-2-dima@arista.com> <alpine.DEB.2.21.1908151908230.1908@nanos.tec.linutronix.de> <20190816061119.GA14312@gmail.com>
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

Andrei,

On Thu, 15 Aug 2019, Andrei Vagin wrote:
> On Thu, Aug 15, 2019 at 07:19:12PM +0200, Thomas Gleixner wrote:
> > > +static int timens_install(struct nsproxy *nsproxy, struct ns_common *new)
> > > +{
> > > +	struct time_namespace *ns = to_time_ns(new);
> > > +
> > > +	if (!current_is_single_threaded())
> > > +		return -EUSERS;
> > > +
> > > +	if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN) ||
> > > +	    !ns_capable(current_user_ns(), CAP_SYS_ADMIN))
> > > +		return -EPERM;
> > > +
> > > +	get_time_ns(ns);
> > > +	get_time_ns(ns);
> > 
> > Why is this a double get?
> 
> Because we change nsproxy->time_ns and nsproxy->time_ns_for_children.
> 
> Probably, I need to reorgonize the code this way:
> 
> 	get_time_ns(ns);
> 	put_time_ns(nsproxy->time_ns);
> 	nsproxy->time_ns = ns;
> 
> 	get_time_ns(ns);
> 	put_time_ns(nsproxy->time_ns_for_children);
> 	nsproxy->time_ns_for_children = ns;

That's better. A few comments about refcounting might be useful as well.
 
> > > +	put_time_ns(nsproxy->time_ns);
> > > +	put_time_ns(nsproxy->time_ns_for_children);
> > > +	nsproxy->time_ns = ns;
> > > +	nsproxy->time_ns_for_children = ns;
> > > +	ns->initialized = true;
> > > +	return 0;
> > > +}
> > > +
> > > +int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk)
> > > +{
> > > +	struct ns_common *nsc = &nsproxy->time_ns_for_children->ns;
> > > +	struct time_namespace *ns = to_time_ns(nsc);
> > > +
> > > +	if (nsproxy->time_ns == nsproxy->time_ns_for_children)
> > > +		return 0;

Doesn't this need to take a refcount on fork? Maybe not, but see below.

> > > +
> > > +	get_time_ns(ns);
> > > +	put_time_ns(nsproxy->time_ns);
> > > +	nsproxy->time_ns = ns;
> > > +	ns->initialized = true;
> > 
> > Isn't that one initialized already?
> 
> When we discussed time namespaces last year, we decided that clock
> offsets can be set only before any task enters a namespace.
> 
> When a namespace is created, ns->initialized is set to false. When a
> task enters the namespace, ns->initialized is set to true.

Right. I'm probably just hopelessly confused by this nsproxy->time_ns
vs. nsproxy->time_ns_for_children->ns thing.
 
> Namespace clock offsets can be changed only if ns->initialized is false.
> 
> A new task can be forked to a specified time namespace or it can call
> setns, so we set ns->initialized to true in timens_on_fork and
> timens_install.

Some comments explaining that logic above would be really helpful.

Thanks,

	tglx
