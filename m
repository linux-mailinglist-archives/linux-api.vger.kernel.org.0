Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0A21C19ED
	for <lists+linux-api@lfdr.de>; Fri,  1 May 2020 17:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbgEAPm4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 1 May 2020 11:42:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35472 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728812AbgEAPm4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 1 May 2020 11:42:56 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jUXoR-00037R-U2; Fri, 01 May 2020 15:42:52 +0000
Date:   Fri, 1 May 2020 17:42:51 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Jann Horn <jannh@google.com>, linux-api@vger.kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [PATCH v2 1/4] capability: add ns_capable_cred()
Message-ID: <20200501154251.j4iuz42tntnjcvaa@wittgenstein>
References: <20200430165717.1001605-1-christian.brauner@ubuntu.com>
 <87y2qczvz9.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y2qczvz9.fsf@x220.int.ebiederm.org>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Apr 30, 2020 at 01:09:30PM -0500, Eric W. Biederman wrote:
> Christian Brauner <christian.brauner@ubuntu.com> writes:
> 
> > Add a simple capability helper which makes it possible to determine
> > whether a set of creds is ns capable wrt to the passed in credentials.
> > This is not something exciting it's just a more pleasant wrapper around
> > security_capable() by allowing ns_capable_common() to ake a const struct
> > cred argument. In ptrace_has_cap() for example, we're using
> > security_capable() directly. ns_capable_cred() will be used in the next
> > patch to check against the target credentials the caller is going to
> > switch to.
> 
> Given that this is to suppot setns.  I don't understand the
> justification for this.
> 
> Is it your intention to use the reduced permissions that you get
> when you install a user namespace?

Indeed.

> 
> Why do you want to use the reduced permissions when installing multiple
> namespaces at once?

The intention is to use the target credentials we are going to install
when setns() hits the point of no return. The target permissions are
either the permissions of the caller or the reduced permissions if
CLONE_NEWUSER has been requested. This has multiple reasons.

The most obvious reason imho is that all other namespaces have an owning
user namespace. Attaching to any other namespace requires the attacher
to be privileged over the owning user namespace of that namespace.
Consequently, all our current install handlers for every namespace we
have check whether we are privileged in the owning user namespace of
that user namespace. So in order to attach to any of those namespaces -
especially when attaching as an unprivileged user - requires that we are
attached to the user namespace first. (That's especially useful given
that most users especially container runtimes will unshare all
namespaces. Doing it this way we can not just have attach privileged
users attach to their containers but also unprivileged users to their
containers in one shot.)

A few other points about this. If one looks at clone(CLONE_NEW*) or
unshare(CLONE_NEW*) then the ordering and permissions checking is the
same way. All permissions checks are performed against the reduced
permissions, i.e. if CLONE_NEWUSER is specified you check privilege
against the reduced permissions too otherwise you wouldn't be able to
spawn into a complete set of new namespaces as an unprivileged user.

This logic is also expressed in how setns() is already used in
userspace. Any container runtime will attach to the user namespace first,
so all subsequent calls to attach to other namespaces perform the checks
against the reduced permissions. It also has to be that way because of
fully unprivileged containers.

To put it another way, if we were to always perform the permission checks
against the current permissions (i.e. no matter if CLONE_NEWUSER is
specified or not) then we'd never be able to attach to a set of
namespaces at once as an unprivileged user.
We also really want to be able to express both semantics:
1. setns(flags & ~CLONE_NEWUSER) --> attach to all namespaces with my
   current permission level
2. setns(flags | CLONE_NEWUSER) attach to all namespaces with the target
   permission level
It feels weird if both 1 and 2 would mean the exact same thing given
that the user namespace has an owernship relation with all the other
namespaces.

Christian
