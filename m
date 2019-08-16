Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6ED8FAA3
	for <lists+linux-api@lfdr.de>; Fri, 16 Aug 2019 08:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfHPGLX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 16 Aug 2019 02:11:23 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45501 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfHPGLX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 16 Aug 2019 02:11:23 -0400
Received: by mail-pf1-f195.google.com with SMTP id w26so2568023pfq.12;
        Thu, 15 Aug 2019 23:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u5QFzKs9EouNBUdCd/txfgG7E0X1z5XpdSBjeEfpSEM=;
        b=c2zbIDyIVj1iW7+tUnzaac7nsenJZffpHk90d9cb9PKMrzZ/vjFbhDGbrylrQ4iKkf
         0hKPpEEk53ahXbILPJfaW0E9BCM/fYJLkKg0SlgBeuIVs8p0o6Aje9Yks4GPI7qXl4k0
         Y0ECSv7PDrdL4FAAh7PG8ZESG/El1TlL9vuM2ySQnt9H+ZO/C3mX29F8A9EkS79BH7nl
         bhMCo21nbLVDXjVz6AwGBdaLmJ0GmtXWDOreWb74Y0TQcY7fVfOpXmkhp6YDoyeY5Vnc
         2hR7SCz1YeNOy7c0ZZkXPSkFnJgFD2co0j36ht0Kqutlr7IIzgkuIW6AKZaqkSbguLEj
         0Xwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u5QFzKs9EouNBUdCd/txfgG7E0X1z5XpdSBjeEfpSEM=;
        b=OWXBQFLHcdqV0iK9dpZAMv5Gau8/kg98xkBDkhdPcajAj0epFKJtTyQeDf8hro8Ywe
         TkFTxBjfL2TMbzTQ92By91cPkiylIWYHSboYWqjI/0KhSMpfdzwkSciT6UP7OUsa/RNR
         O+IXuX3U60L+pb1qMK7aIwmCXv6LEl5d3OJi7xw9w4QEAm9aKz9OUMV85wonOtKQj2Sz
         HksFU8qmweHTkt0FFx76BHOVpTSEuknINpQe0b7YQVetWvV87MXT2/QQ81WTyBWuaxem
         zecOCbjV0wLNN93gl/6HAMWLj+gWjVMi5LfkRcW8830qlfHWIXn8g8SGaf73TJzguS4K
         /THA==
X-Gm-Message-State: APjAAAWx1P1BH2XyLmSwoc0NN2x+rGV9FnyfUPk5ZzSD5I5DXzXykTbp
        nk0vV8hfXVP4xUhoBLeKk9w=
X-Google-Smtp-Source: APXvYqzi6ymOwZymBozhUKmlen1H4ZYcmqwcOP8oVrdY6Swzyu+6rvWsWDFqBYvAZAHsMC7CKnWl0Q==
X-Received: by 2002:a62:58c4:: with SMTP id m187mr9125055pfb.147.1565935882162;
        Thu, 15 Aug 2019 23:11:22 -0700 (PDT)
Received: from gmail.com (c-73-140-212-29.hsd1.wa.comcast.net. [73.140.212.29])
        by smtp.gmail.com with ESMTPSA id x128sm5567282pfd.52.2019.08.15.23.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 23:11:21 -0700 (PDT)
Date:   Thu, 15 Aug 2019 23:11:19 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
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
Message-ID: <20190816061119.GA14312@gmail.com>
References: <20190815163836.2927-1-dima@arista.com>
 <20190815163836.2927-2-dima@arista.com>
 <alpine.DEB.2.21.1908151908230.1908@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1908151908230.1908@nanos.tec.linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Aug 15, 2019 at 07:19:12PM +0200, Thomas Gleixner wrote:
> Dmitry,
> 
> On Thu, 15 Aug 2019, Dmitry Safonov wrote:
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 420567d1519a..97b7737f5aba 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -12898,6 +12898,8 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
> >  S:	Maintained
> >  F:	fs/timerfd.c
> >  F:	include/linux/timer*
> > +F:	include/linux/time_namespace.h
> > +F:	kernel/time_namespace.c
> 
> Shouldn't this be kernel/time/namespace.c so all that stuff is lumped
> together. No strong opinion though.

Sure, we can move this in kernel/time. I don't remember why I decided to
place it in kernel/.

> 
> > +++ b/kernel/time_namespace.c
> > +static struct ucounts *inc_time_namespaces(struct user_namespace *ns)
> > +{
> > +	return inc_ucount(ns, current_euid(), UCOUNT_TIME_NAMESPACES);
> > +}
> > +
> > +static void dec_time_namespaces(struct ucounts *ucounts)
> > +{
> > +	dec_ucount(ucounts, UCOUNT_TIME_NAMESPACES);
> > +}
> > +
> > +static struct time_namespace *create_time_ns(void)
> > +{
> > +	struct time_namespace *time_ns;
> > +
> > +	time_ns = kmalloc(sizeof(struct time_namespace), GFP_KERNEL);
> 
> Shouldn't this use kzalloc()? There are tons of members in that struct.

I don't think so. All of other members are initialized in clone_time_ns.
Maybe we don't need this helper. When I wrote this code, I looked at
kernel/utsname.c. I will think what we can do here to make this code
more clear.

> 
> > +	if (time_ns) {
> > +		kref_init(&time_ns->kref);
> > +		time_ns->initialized = false;
> 
> And you spare this one.

This one should be initialized in clone_time_ns too.
> 
> > +	}
> > +	return time_ns;
> > +}
> > +
> > +/*
> > + * Clone a new ns copying @old_ns, setting refcount to 1
> > + * @old_ns: namespace to clone
> > + * Return the new ns or ERR_PTR.
> 
> If you use kernel-doc style then please use te proper syntax
> 
> /*
>  * clone_time_ns - Clone a time namespace
>  * @old_ns:	Namespace to clone
>  *
>  * Clone @old_ns and set the clone refcount to 1
>  *
>  * Return: The new namespace or ERR_PTR.
>  */

Will fix. Thanks!

> 
> > + */
> > +static struct time_namespace *clone_time_ns(struct user_namespace *user_ns,
> > +					  struct time_namespace *old_ns)
> > +{
> > +	struct time_namespace *ns;
> > +	struct ucounts *ucounts;
> > +	int err;
> > +
> > +	err = -ENOSPC;
> > +	ucounts = inc_time_namespaces(user_ns);
> > +	if (!ucounts)
> > +		goto fail;
> > +
> > +	err = -ENOMEM;
> > +	ns = create_time_ns();
> > +	if (!ns)
> > +		goto fail_dec;
> > +
> > +	err = ns_alloc_inum(&ns->ns);
> > +	if (err)
> > +		goto fail_free;
> > +
> > +	ns->ucounts = ucounts;
> > +	ns->ns.ops = &timens_operations;
> > +	ns->user_ns = get_user_ns(user_ns);
> > +	return ns;
> > +
> > +fail_free:
> > +	kfree(ns);
> > +fail_dec:
> > +	dec_time_namespaces(ucounts);
> > +fail:
> > +	return ERR_PTR(err);
> > +}
> > +
> > +/*
> > + * Add a reference to old_ns, or clone it if @flags specify CLONE_NEWTIME.
> > + * In latter case, changes to the time of this process won't be seen by parent,
> > + * and vice versa.
> 
> Ditto

Will fix.

> 
> > + */
> > +struct time_namespace *copy_time_ns(unsigned long flags,
> > +	struct user_namespace *user_ns, struct time_namespace *old_ns)
> > +{
> > +	if (!(flags & CLONE_NEWTIME))
> > +		return get_time_ns(old_ns);
> > +
> > +	return clone_time_ns(user_ns, old_ns);
> > +}
> > +
> > +void free_time_ns(struct kref *kref)
> > +{
> > +	struct time_namespace *ns;
> > +
> > +	ns = container_of(kref, struct time_namespace, kref);
> > +	dec_time_namespaces(ns->ucounts);
> > +	put_user_ns(ns->user_ns);
> > +	ns_free_inum(&ns->ns);
> > +	kfree(ns);
> > +}
> > +
> > +static struct time_namespace *to_time_ns(struct ns_common *ns)
> > +{
> > +	return container_of(ns, struct time_namespace, ns);
> > +}
> > +
> > +static struct ns_common *timens_get(struct task_struct *task)
> > +{
> > +	struct time_namespace *ns = NULL;
> > +	struct nsproxy *nsproxy;
> > +
> > +	task_lock(task);
> > +	nsproxy = task->nsproxy;
> > +	if (nsproxy) {
> > +		ns = nsproxy->time_ns;
> > +		get_time_ns(ns);
> > +	}
> > +	task_unlock(task);
> > +
> > +	return ns ? &ns->ns : NULL;
> > +}
> > +
> > +static struct ns_common *timens_for_children_get(struct task_struct *task)
> > +{
> > +	struct time_namespace *ns = NULL;
> > +	struct nsproxy *nsproxy;
> > +
> > +	task_lock(task);
> > +	nsproxy = task->nsproxy;
> > +	if (nsproxy) {
> > +		ns = nsproxy->time_ns_for_children;
> > +		get_time_ns(ns);
> > +	}
> > +	task_unlock(task);
> > +
> > +	return ns ? &ns->ns : NULL;
> > +}
> > +
> > +static void timens_put(struct ns_common *ns)
> > +{
> > +	put_time_ns(to_time_ns(ns));
> > +}
> > +
> > +static int timens_install(struct nsproxy *nsproxy, struct ns_common *new)
> > +{
> > +	struct time_namespace *ns = to_time_ns(new);
> > +
> > +	if (!current_is_single_threaded())
> > +		return -EUSERS;
> > +
> > +	if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN) ||
> > +	    !ns_capable(current_user_ns(), CAP_SYS_ADMIN))
> > +		return -EPERM;
> > +
> > +	get_time_ns(ns);
> > +	get_time_ns(ns);
> 
> Why is this a double get?

Because we change nsproxy->time_ns and nsproxy->time_ns_for_children.

Probably, I need to reorgonize the code this way:

	get_time_ns(ns);
	put_time_ns(nsproxy->time_ns);
	nsproxy->time_ns = ns;

	get_time_ns(ns);
	put_time_ns(nsproxy->time_ns_for_children);
	nsproxy->time_ns_for_children = ns;
> 
> > +	put_time_ns(nsproxy->time_ns);
> > +	put_time_ns(nsproxy->time_ns_for_children);
> > +	nsproxy->time_ns = ns;
> > +	nsproxy->time_ns_for_children = ns;
> > +	ns->initialized = true;
> > +	return 0;
> > +}
> > +
> > +int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk)
> > +{
> > +	struct ns_common *nsc = &nsproxy->time_ns_for_children->ns;
> > +	struct time_namespace *ns = to_time_ns(nsc);
> > +
> > +	if (nsproxy->time_ns == nsproxy->time_ns_for_children)
> > +		return 0;
> > +
> > +	get_time_ns(ns);
> > +	put_time_ns(nsproxy->time_ns);
> > +	nsproxy->time_ns = ns;
> > +	ns->initialized = true;
> 
> Isn't that one initialized already?

When we discussed time namespaces last year, we decided that clock
offsets can be set only before any task enters a namespace.

When a namespace is created, ns->initialized is set to false. When a
task enters the namespace, ns->initialized is set to true.

Namespace clock offsets can be changed only if ns->initialized is false.

A new task can be forked to a specified time namespace or it can call
setns, so we set ns->initialized to true in timens_on_fork and
timens_install.

> 
> > +
> > +	return 0;
> > +}
> > +
> > +static struct user_namespace *timens_owner(struct ns_common *ns)
> > +{
> > +	return to_time_ns(ns)->user_ns;
> > +}
> > +
> > +const struct proc_ns_operations timens_operations = {
> > +	.name		= "time",
> > +	.type		= CLONE_NEWTIME,
> > +	.get		= timens_get,
> > +	.put		= timens_put,
> > +	.install	= timens_install,
> > +	.owner		= timens_owner,
> > +};
> > +
> > +const struct proc_ns_operations timens_for_children_operations = {
> > +	.name		= "time_for_children",
> > +	.type		= CLONE_NEWTIME,
> > +	.get		= timens_for_children_get,
> > +	.put		= timens_put,
> > +	.install	= timens_install,
> > +	.owner		= timens_owner,
> > +};
> > +
> > +struct time_namespace init_time_ns = {
> > +	.kref = KREF_INIT(3),
> > +	.user_ns = &init_user_ns,
> > +	.ns.inum = PROC_TIME_INIT_INO,
> > +	.ns.ops = &timens_operations,
> > +};
> 
> Inconsisten formatting. The above static initializers are nicely
> tabular. This on not.

Will fix. Thanks.

Thanks,
Andrei
> 
> Thanks,
> 
> 	tglx
